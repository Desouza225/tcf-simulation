import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { supabase } from '@/db/supabase';
import { useAuth } from '@/contexts/AuthContext';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { ClipboardList, CheckCircle, FileText, Mic } from 'lucide-react';
import type { Production, Profile, NiveauCECRL } from '@/types/index';
import { pctToCECRL, CECRL_COLORS, CECRL_DESCRIPTIONS, EPREUVE_LABELS } from '@/types/index';
import { cn } from '@/lib/utils';

const MAX_EE = 20;
const MAX_EO = 18;

function getTaskNiveau(prod: Production): NiveauCECRL | null {
  if (prod.score === null) return null;
  const max = prod.epreuve === 'expression_ecrite' ? MAX_EE : MAX_EO;
  return pctToCECRL(Math.round((prod.score / max) * 100));
}

interface EpreuveGroup {
  epreuve: string;
  productions: (Production & { etudiant?: Profile })[];
}
interface SessionGroup {
  sessionId: string;
  sessionDate: string;
  sessionMode: 'entrainement' | 'examen_blanc' | null;
  etudiant?: Profile;
  epreuves: EpreuveGroup[];
}

function groupBySession(prods: (Production & { etudiant?: Profile, session?: { id: string; created_at: string; mode?: string } })[]): SessionGroup[] {
  const map = new Map<string, SessionGroup>();
  for (const p of prods) {
    const sid = p.session_id;
    const date = p.session?.created_at ?? p.created_at;
    const mode = (p.session?.mode as 'entrainement' | 'examen_blanc') ?? null;
    if (!map.has(sid)) map.set(sid, { sessionId: sid, sessionDate: date, sessionMode: mode, etudiant: p.etudiant, epreuves: [] });
    const sg = map.get(sid)!;
    let eg = sg.epreuves.find(e => e.epreuve === p.epreuve);
    if (!eg) { eg = { epreuve: p.epreuve, productions: [] }; sg.epreuves.push(eg); }
    eg.productions.push(p);
  }
  return Array.from(map.values());
}

export default function CorrectionsPage() {
  const { user } = useAuth();
  const [pendingGroups, setPendingGroups] = useState<SessionGroup[]>([]);
  const [pendingCount, setPendingCount] = useState(0);
  const [loading, setLoading] = useState(true);
  const [activeTab, setActiveTab] = useState<'tout' | 'examen_blanc' | 'entrainement'>('tout');

  useEffect(() => {
    if (!user) return;
    supabase
      .from('productions')
      .select('*, etudiant:profiles!etudiant_id(*), session:sessions_examen!session_id(id, created_at, mode)')
      .eq('professeur_id', user.id)
      .eq('statut_correction', 'en_attente')
      .order('epreuve')
      .order('numero_tache')
      .then(async ({ data, error }) => {
        let all: any[] = [];
        if (error || !data) {
          const fallback = await supabase
            .from('productions')
            .select('*')
            .eq('professeur_id', user.id)
            .eq('statut_correction', 'en_attente')
            .order('epreuve')
            .order('numero_tache');
          if (fallback.data && fallback.data.length > 0) {
            const etudIds = [...new Set(fallback.data.map(p => p.etudiant_id).filter(Boolean))];
            const sessionIds = [...new Set(fallback.data.map(p => p.session_id).filter(Boolean))];
            const [etudRes, sessRes] = await Promise.all([
              supabase.from('profiles').select('*').in('id', etudIds),
              supabase.from('sessions_examen').select('id, created_at, mode').in('id', sessionIds),
            ]);
            const etudMap = new Map((etudRes.data || []).map(e => [e.id, e]));
            const sessMap = new Map((sessRes.data || []).map(s => [s.id, s]));
            all = fallback.data.map(p => ({
              ...p,
              etudiant: etudMap.get(p.etudiant_id),
              session: sessMap.get(p.session_id),
            }));
          }
        } else {
          all = data;
        }
        // Trier par date de session croissante (plus anciens en haut, plus récents en bas)
        const groups = groupBySession(all);
        groups.sort((a, b) => new Date(a.sessionDate).getTime() - new Date(b.sessionDate).getTime());
        setPendingGroups(groups);
        setPendingCount(all.length);
        setLoading(false);
      });
  }, [user]);

  // Filtrer selon l'onglet actif
  const filteredGroups = pendingGroups.filter(sg => {
    if (activeTab === 'tout') return true;
    if (activeTab === 'examen_blanc') return sg.sessionMode === 'examen_blanc';
    if (activeTab === 'entrainement') return sg.sessionMode === 'entrainement' || sg.sessionMode === null;
    return true;
  });

  const countByMode = {
    tout: pendingGroups.length,
    examen_blanc: pendingGroups.filter(g => g.sessionMode === 'examen_blanc').length,
    entrainement: pendingGroups.filter(g => g.sessionMode === 'entrainement' || g.sessionMode === null).length,
  };

  const renderSessionGroup = (sg: SessionGroup) => {
    const totalTaches = sg.epreuves.reduce((n, eg) => n + eg.productions.length, 0);

    return (
      <Card key={sg.sessionId} className="h-full">
        <CardHeader className="pb-3">
          <div className="flex items-start justify-between gap-3 flex-wrap">
            <div className="min-w-0 flex-1">
              <CardTitle className="text-base font-bold text-foreground text-balance">
                {sg.etudiant?.prenom} {sg.etudiant?.nom}
              </CardTitle>
              <div className="flex items-center gap-2 mt-1 flex-wrap">
                <Badge className={cn('text-xs py-0 h-4 shrink-0',
                  sg.sessionMode === 'examen_blanc' ? 'bg-[#C8102E] text-white' : 'bg-[#1B365D] text-white'
                )}>
                  {sg.sessionMode === 'examen_blanc' ? 'Examen blanc' : 'Entraînement'}
                </Badge>
                <p className="text-xs text-muted-foreground">
                  Séance du{' '}
                  {new Date(sg.sessionDate).toLocaleDateString('fr-FR', { day: 'numeric', month: 'long', year: 'numeric' })}
                  {' · '}{totalTaches} tâche{totalTaches > 1 ? 's' : ''}
                </p>
              </div>
            </div>
          </div>
        </CardHeader>

        <CardContent className="pt-0 space-y-4">
          {sg.epreuves.map(eg => {
            const isEE = eg.epreuve === 'expression_ecrite';
            const max = isEE ? MAX_EE : MAX_EO;
            const scored = eg.productions.filter(p => p.score !== null);
            const somme = scored.reduce((s, p) => s + (p.score ?? 0), 0);
            const epDone = eg.productions.every(p => p.statut_correction === 'corrige');
            const niveauEpreuve = epDone && scored.length > 0
              ? pctToCECRL(Math.round((somme / (max * scored.length)) * 100))
              : null;

            return (
              <div key={eg.epreuve} className="space-y-2">
                <div className="flex items-center gap-2 flex-wrap">
                  {isEE
                    ? <FileText className="w-3.5 h-3.5 text-primary shrink-0" />
                    : <Mic className="w-3.5 h-3.5 text-primary shrink-0" />
                  }
                  <span className="text-xs font-semibold text-foreground">
                    {EPREUVE_LABELS[eg.epreuve as keyof typeof EPREUVE_LABELS]}
                  </span>
                  {niveauEpreuve && (
                    <Badge style={{ backgroundColor: CECRL_COLORS[niveauEpreuve] }} className="text-white text-xs py-0 h-4">
                      {niveauEpreuve} — {CECRL_DESCRIPTIONS[niveauEpreuve]}
                    </Badge>
                  )}
                </div>
                <div className="space-y-1.5 pl-5">
                  {eg.productions.map(prod => {
                    const niveau = prod.statut_correction === 'corrige' ? getTaskNiveau(prod) : null;
                    return (
                      <div key={prod.id} className="flex items-center justify-between gap-3 px-3 py-2 rounded-lg bg-muted/40 border border-border">
                        <div className="min-w-0 flex-1">
                          <p className="text-sm font-medium text-foreground">Tâche {prod.numero_tache}</p>
                          {prod.statut_correction === 'corrige' && prod.score !== null && (
                            <div className="flex items-center gap-1.5 mt-0.5 flex-wrap">
                              <span className="text-xs text-success font-medium">{prod.score} / {max} pts</span>
                              {niveau && (
                                <Badge style={{ backgroundColor: CECRL_COLORS[niveau] }} className="text-white text-xs py-0 h-4">{niveau}</Badge>
                              )}
                            </div>
                          )}
                        </div>
                        <Button size="sm" variant="default" asChild className="shrink-0">
                          <Link to={`/professeur/corrections/${prod.id}`}>Corriger</Link>
                        </Button>
                      </div>
                    );
                  })}
                </div>
              </div>
            );
          })}
        </CardContent>
      </Card>
    );
  };

  return (
    <div className="max-w-3xl mx-auto space-y-6 fade-in">
      <div>
        <h1 className="text-2xl font-bold text-foreground text-balance">File de corrections</h1>
        <p className="text-muted-foreground mt-1">
          {loading ? '—' : pendingCount} tâche{pendingCount !== 1 ? 's' : ''} en attente de correction
        </p>
      </div>

      {/* Onglets de filtrage */}
      {!loading && (
        <Tabs value={activeTab} onValueChange={v => setActiveTab(v as typeof activeTab)}>
          <TabsList className="w-full">
            <TabsTrigger value="tout" className="flex-1 gap-1.5">
              Tout
              {countByMode.tout > 0 && (
                <Badge variant="secondary" className="text-xs h-4 py-0 px-1.5">{countByMode.tout}</Badge>
              )}
            </TabsTrigger>
            <TabsTrigger value="examen_blanc" className="flex-1 gap-1.5">
              Examens blancs
              {countByMode.examen_blanc > 0 && (
                <Badge variant="secondary" className="text-xs h-4 py-0 px-1.5">{countByMode.examen_blanc}</Badge>
              )}
            </TabsTrigger>
            <TabsTrigger value="entrainement" className="flex-1 gap-1.5">
              Entraînements
              {countByMode.entrainement > 0 && (
                <Badge variant="secondary" className="text-xs h-4 py-0 px-1.5">{countByMode.entrainement}</Badge>
              )}
            </TabsTrigger>
          </TabsList>
        </Tabs>
      )}

      {loading ? (
        <div className="space-y-3">{[1, 2, 3].map(i => <Skeleton key={i} className="h-24 w-full bg-muted" />)}</div>
      ) : filteredGroups.length === 0 ? (
        <Card className="h-full">
          <CardContent className="p-12 text-center">
            <CheckCircle className="w-12 h-12 text-success/30 mx-auto mb-4" />
            <p className="text-muted-foreground">
              {activeTab === 'tout'
                ? 'Aucune correction en attente. Excellent travail !'
                : `Aucune correction en attente pour cette catégorie.`}
            </p>
          </CardContent>
        </Card>
      ) : (
        <div className="space-y-3">{filteredGroups.map(sg => renderSessionGroup(sg))}</div>
      )}

      {/* Lien vers l'historique des corrections */}
      {!loading && (
        <div className="text-center">
          <Button variant="outline" asChild>
            <Link to="/professeur/historique">
              <ClipboardList className="w-4 h-4 mr-2" />Voir l'historique des corrections
            </Link>
          </Button>
        </div>
      )}
    </div>
  );
}
