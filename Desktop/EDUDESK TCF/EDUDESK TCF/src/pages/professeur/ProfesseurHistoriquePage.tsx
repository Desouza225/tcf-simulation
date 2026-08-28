import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { supabase } from '@/db/supabase';
import { useAuth } from '@/contexts/AuthContext';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { FileText, Mic, CheckCircle, XCircle, BarChart3 } from 'lucide-react';
import type { Production, Profile, NiveauCECRL } from '@/types/index';
import { pctToCECRL, CECRL_COLORS, CECRL_DESCRIPTIONS, EPREUVE_LABELS } from '@/types/index';
import { cn } from '@/lib/utils';

const MAX_EE = 20;
const MAX_EO = 18;

interface SessionGroup {
  sessionId: string;
  sessionDate: string;
  sessionMode: 'entrainement' | 'examen_blanc' | null;
  etudiant?: Profile;
  epreuves: { epreuve: string; productions: (Production & { etudiant?: Profile })[] }[];
}

function groupBySession(
  prods: (Production & { etudiant?: Profile; session?: { id: string; created_at: string; mode?: string } })[]
): SessionGroup[] {
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
  return Array.from(map.values()).sort((a, b) => new Date(b.sessionDate).getTime() - new Date(a.sessionDate).getTime());
}

export default function ProfesseurHistoriquePage() {
  const { user } = useAuth();
  const [groups, setGroups] = useState<SessionGroup[]>([]);
  const [loading, setLoading] = useState(true);
  const [activeTab, setActiveTab] = useState<'tout' | 'examen_blanc' | 'entrainement'>('tout');

  useEffect(() => {
    if (!user) return;
    supabase
      .from('productions')
      .select('*, etudiant:profiles!etudiant_id(*), session:sessions_examen!session_id(id, created_at, mode)')
      .eq('professeur_id', user.id)
      .in('statut_correction', ['corrige', 'refuse'])
      .order('epreuve')
      .order('numero_tache')
      .then(async ({ data, error }) => {
        let all: any[] = [];
        if (error || !data) {
          const fallback = await supabase
            .from('productions')
            .select('*')
            .eq('professeur_id', user.id)
            .in('statut_correction', ['corrige', 'refuse'])
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
        setGroups(groupBySession(all));
        setLoading(false);
      });
  }, [user]);

  // Filtrer selon l'onglet actif
  const filteredGroups = groups.filter(sg => {
    if (activeTab === 'tout') return true;
    if (activeTab === 'examen_blanc') return sg.sessionMode === 'examen_blanc';
    if (activeTab === 'entrainement') return sg.sessionMode === 'entrainement' || sg.sessionMode === null;
    return true;
  });

  const countByMode = {
    tout: groups.length,
    examen_blanc: groups.filter(g => g.sessionMode === 'examen_blanc').length,
    entrainement: groups.filter(g => g.sessionMode === 'entrainement' || g.sessionMode === null).length,
  };

  const renderGroup = (sg: SessionGroup) => {
    const totalTaches = sg.epreuves.reduce((n, eg) => n + eg.productions.length, 0);
    const refusCount = sg.epreuves.reduce((n, eg) => n + eg.productions.filter(p => p.statut_correction === 'refuse').length, 0);
    const corrigeCount = sg.epreuves.reduce((n, eg) => n + eg.productions.filter(p => p.statut_correction === 'corrige').length, 0);

    return (
      <Card key={sg.sessionId} className="h-full">
        <CardHeader className="pb-3">
          <div className="flex items-start justify-between gap-3 flex-wrap">
            <div className="min-w-0 flex-1">
              <CardTitle className="text-base font-bold text-foreground text-balance">
                {sg.etudiant?.prenom} {sg.etudiant?.nom}
              </CardTitle>
              <div className="flex items-center gap-2 mt-1 flex-wrap">
                <Badge className={cn('text-xs py-0 h-4 shrink-0', sg.sessionMode === 'examen_blanc' ? 'bg-[#C8102E] text-white' : 'bg-[#1B365D] text-white')}>
                  {sg.sessionMode === 'examen_blanc' ? 'Examen blanc' : 'Entraînement'}
                </Badge>
                <p className="text-xs text-muted-foreground">
                  {new Date(sg.sessionDate).toLocaleDateString('fr-FR', { day: 'numeric', month: 'long', year: 'numeric' })}
                  {' · '}{totalTaches} tâche{totalTaches > 1 ? 's' : ''}
                </p>
              </div>
            </div>
            <div className="flex items-center gap-2 shrink-0 flex-wrap">
              {corrigeCount > 0 && (
                <Badge className="bg-success text-success-foreground text-xs">
                  <CheckCircle className="w-3 h-3 mr-1" />{corrigeCount} corrigé{corrigeCount > 1 ? 's' : ''}
                </Badge>
              )}
              {refusCount > 0 && (
                <Badge variant="destructive" className="text-xs">
                  <XCircle className="w-3 h-3 mr-1" />{refusCount} refusé{refusCount > 1 ? 's' : ''}
                </Badge>
              )}
            </div>
          </div>
        </CardHeader>

        <CardContent className="pt-0 space-y-4">
          {sg.epreuves.map(eg => {
            const isEE = eg.epreuve === 'expression_ecrite';
            const max = isEE ? MAX_EE : MAX_EO;
            const scored = eg.productions.filter(p => p.statut_correction === 'corrige' && p.score !== null);
            const niveauEpreuve: NiveauCECRL | null = scored.length > 0
              ? pctToCECRL(Math.round((scored.reduce((s, p) => s + (p.score ?? 0), 0) / (max * scored.length)) * 100))
              : null;

            return (
              <div key={eg.epreuve} className="space-y-2">
                <div className="flex items-center gap-2 flex-wrap">
                  {isEE ? <FileText className="w-3.5 h-3.5 text-primary shrink-0" /> : <Mic className="w-3.5 h-3.5 text-primary shrink-0" />}
                  <span className="text-xs font-semibold text-foreground">{EPREUVE_LABELS[eg.epreuve as keyof typeof EPREUVE_LABELS]}</span>
                  {niveauEpreuve && (
                    <Badge style={{ backgroundColor: CECRL_COLORS[niveauEpreuve] }} className="text-white text-xs py-0 h-4">
                      {niveauEpreuve} — {CECRL_DESCRIPTIONS[niveauEpreuve]}
                    </Badge>
                  )}
                </div>
                <div className="space-y-1.5 pl-5">
                  {eg.productions.map(prod => {
                    const isRefuse = prod.statut_correction === 'refuse';
                    const niveau: NiveauCECRL | null = prod.score !== null
                      ? pctToCECRL(Math.round((prod.score / max) * 100))
                      : null;
                    return (
                      <div key={prod.id} className={cn(
                        'flex items-center justify-between gap-3 px-3 py-2 rounded-lg border',
                        isRefuse ? 'bg-destructive/5 border-destructive/20' : 'bg-muted/40 border-border'
                      )}>
                        <div className="min-w-0 flex-1">
                          <p className="text-sm font-medium text-foreground">Tâche {prod.numero_tache}</p>
                          {isRefuse && prod.raison_refus && (
                            <p className="text-xs text-destructive text-pretty mt-0.5">Refus : {prod.raison_refus}</p>
                          )}
                          {!isRefuse && prod.score !== null && (
                            <div className="flex items-center gap-1.5 mt-0.5 flex-wrap">
                              <span className="text-xs text-success font-medium">{prod.score} / {max} pts</span>
                              {niveau && (
                                <Badge style={{ backgroundColor: CECRL_COLORS[niveau] }} className="text-white text-xs py-0 h-4">{niveau}</Badge>
                              )}
                            </div>
                          )}
                        </div>
                        <div className="flex items-center gap-2 shrink-0">
                          {isRefuse
                            ? <Badge variant="destructive" className="text-xs"><XCircle className="w-3 h-3 mr-1" />Refusée</Badge>
                            : <Badge className="bg-success text-success-foreground text-xs"><CheckCircle className="w-3 h-3 mr-1" />Corrigée</Badge>
                          }
                          <Button size="sm" variant="outline" asChild className="shrink-0">
                            <Link to={`/professeur/corrections/${prod.id}`}>Voir</Link>
                          </Button>
                        </div>
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
        <h1 className="text-2xl font-bold text-foreground text-balance">Historique des corrections</h1>
        <p className="text-muted-foreground mt-1">
          {loading ? '—' : `${groups.length} séance${groups.length > 1 ? 's' : ''} traitée${groups.length > 1 ? 's' : ''}`}
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
            <BarChart3 className="w-12 h-12 text-muted-foreground/30 mx-auto mb-4" />
            <p className="text-muted-foreground">
              {activeTab === 'tout'
                ? 'Aucune correction effectuée pour le moment.'
                : 'Aucune correction dans cette catégorie.'}
            </p>
          </CardContent>
        </Card>
      ) : (
        <div className="space-y-3">{filteredGroups.map(sg => renderGroup(sg))}</div>
      )}
    </div>
  );
}
