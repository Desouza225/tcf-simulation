import { useState, useEffect, useCallback } from 'react';
import { Link } from 'react-router-dom';
import { supabase } from '@/db/supabase';
import { useAuth } from '@/contexts/AuthContext';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { Skeleton } from '@/components/ui/skeleton';
import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { ClipboardList, CheckCircle, FileText, Mic, User, RefreshCw, Search, Clock, Sparkles, ArrowUpDown } from 'lucide-react';
import type { Production, Profile, NiveauCECRL } from '@/types/index';
import {
  pctToCECRL,
  scoreEeToCECRL,
  scoreEeToCECRLLabel,
  scoreEoToCECRL,
  scoreEoToCECRLLabel,
  CECRL_COLORS,
  CECRL_DESCRIPTIONS,
  EPREUVE_LABELS,
} from '@/types/index';
import { cn } from '@/lib/utils';

const MAX_EE = 20;
const MAX_EO = 20;

function getTaskNiveau(prod: Production): { code: NiveauCECRL; label: string } | null {
  if (prod.score === null) return null;
  if (prod.epreuve === 'expression_ecrite') {
    return {
      code: scoreEeToCECRL(prod.score),
      label: scoreEeToCECRLLabel(prod.score),
    };
  }
  return {
    code: scoreEoToCECRL(prod.score),
    label: scoreEoToCECRLLabel(prod.score),
  };
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

function groupBySession(prods: (Production & { etudiant?: Profile; session?: { id: string; created_at: string; mode?: string } })[]): SessionGroup[] {
  const map = new Map<string, SessionGroup>();
  for (const p of prods) {
    const sid = p.session_id || `standalone_${p.id}`;
    const date = p.session?.created_at ?? p.created_at;
    const mode = (p.session?.mode as 'entrainement' | 'examen_blanc') ?? 'entrainement';
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
  const [refreshing, setRefreshing] = useState(false);
  const [search, setSearch] = useState('');
  const [sortOrder, setSortOrder] = useState<'ancien_dabord' | 'recent_dabord'>('ancien_dabord');
  const [activeTab, setActiveTab] = useState<'tout' | 'examen_blanc' | 'entrainement'>('tout');

  const loadData = useCallback(async (isSilent = false) => {
    if (!user) return;
    if (!isSilent) setRefreshing(true);

    try {
      // 1. Charger toutes les productions en attente accessibles
      const { data, error } = await supabase
        .from('productions')
        .select('*, etudiant:profiles!etudiant_id(*), session:sessions_examen!session_id(id, created_at, mode)')
        .eq('statut_correction', 'en_attente')
        .order('created_at', { ascending: true });

      let all: any[] = [];
      if (error || !data) {
        // Fallback sans jointure explicite
        const { data: fallbackData } = await supabase
          .from('productions')
          .select('*')
          .eq('statut_correction', 'en_attente')
          .order('created_at', { ascending: true });

        if (fallbackData && fallbackData.length > 0) {
          const uIds = [...new Set(fallbackData.map(p => p.etudiant_id).filter(Boolean))];
          const sIds = [...new Set(fallbackData.map(p => p.session_id).filter(Boolean))];
          const [etudRes, sessRes] = await Promise.all([
            supabase.from('profiles').select('*').in('id', uIds),
            supabase.from('sessions_examen').select('id, created_at, mode').in('id', sIds),
          ]);
          const etudMap = new Map((etudRes.data || []).map(e => [e.id, e]));
          const sessMap = new Map((sessRes.data || []).map(s => [s.id, s]));
          all = fallbackData.map(p => ({
            ...p,
            etudiant: etudMap.get(p.etudiant_id),
            session: sessMap.get(p.session_id),
          }));
        }
      } else {
        all = data;
      }

      const groups = groupBySession(all);
      // Tri par défaut : anciennes d'abord (FIFO - priorité aux premiers arrivés)
      groups.sort((a, b) => {
        const timeA = new Date(a.sessionDate).getTime();
        const timeB = new Date(b.sessionDate).getTime();
        return sortOrder === 'ancien_dabord' ? timeA - timeB : timeB - timeA;
      });

      setPendingGroups(groups);
      setPendingCount(all.length);
    } catch (err) {
      console.error('Erreur chargement file de corrections:', err);
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  }, [user, sortOrder]);

  useEffect(() => {
    if (!user) return;
    loadData();

    // Abonnement temps réel aux nouvelles productions et modifications
    const channel = supabase
      .channel('prof-corrections-live')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'productions' }, () => {
        loadData(true);
      })
      .subscribe();

    // Rafraîchissement automatique toutes les 15 secondes
    const interval = setInterval(() => {
      loadData(true);
    }, 15000);

    return () => {
      supabase.removeChannel(channel);
      clearInterval(interval);
    };
  }, [user, loadData]);

  // Filtrer selon l'onglet actif et la recherche
  const filteredGroups = pendingGroups.filter(sg => {
    if (activeTab === 'examen_blanc' && sg.sessionMode !== 'examen_blanc') return false;
    if (activeTab === 'entrainement' && sg.sessionMode !== 'entrainement' && sg.sessionMode !== null) return false;

    if (search.trim()) {
      const q = search.toLowerCase();
      const nomComplet = `${sg.etudiant?.prenom || ''} ${sg.etudiant?.nom || ''}`.toLowerCase();
      const email = (sg.etudiant?.email || '').toLowerCase();
      return nomComplet.includes(q) || email.includes(q);
    }
    return true;
  });

  const countByMode = {
    tout: pendingGroups.length,
    examen_blanc: pendingGroups.filter(g => g.sessionMode === 'examen_blanc').length,
    entrainement: pendingGroups.filter(g => g.sessionMode === 'entrainement' || g.sessionMode === null).length,
  };

  const getWaitingStatus = (dateStr: string) => {
    const diffHours = Math.round((Date.now() - new Date(dateStr).getTime()) / (1000 * 60 * 60));
    if (diffHours >= 48) {
      const days = Math.floor(diffHours / 24);
      return {
        badge: (
          <Badge variant="destructive" className="text-[10px] py-0 h-4 font-semibold">
            Prioritaire · {days}j d'attente
          </Badge>
        ),
      };
    }
    if (diffHours >= 24) {
      return {
        badge: (
          <Badge className="bg-amber-500/20 text-amber-600 border-amber-500/30 text-[10px] py-0 h-4">
            En attente depuis {diffHours}h
          </Badge>
        ),
      };
    }
    return {
      badge: (
        <Badge variant="outline" className="text-[10px] py-0 h-4 text-muted-foreground">
          Reçu il y a {diffHours <= 1 ? 'moins d\'1h' : `${diffHours}h`}
        </Badge>
      ),
    };
  };

  const renderSessionGroup = (sg: SessionGroup) => {
    const totalTaches = sg.epreuves.reduce((n, eg) => n + eg.productions.length, 0);
    const waiting = getWaitingStatus(sg.sessionDate);

    return (
      <Card key={sg.sessionId} className="h-full border-border shadow-sm transition-all hover:border-primary/40">
        <CardHeader className="pb-3 border-b border-border/50 bg-muted/20">
          <div className="flex items-start justify-between gap-3 flex-wrap">
            <div className="min-w-0 flex-1">
              <CardTitle className="text-base font-bold text-foreground text-balance flex items-center gap-2">
                <User className="w-4 h-4 text-primary shrink-0" />
                <span>{sg.etudiant?.prenom || 'Étudiant'} {sg.etudiant?.nom || ''}</span>
                {waiting.badge}
              </CardTitle>
              <div className="flex items-center gap-2 mt-1 flex-wrap">
                <Badge className={cn('text-xs py-0 h-4 shrink-0 font-medium',
                  sg.sessionMode === 'examen_blanc' ? 'bg-[#C8102E] text-white' : 'bg-[#1B365D] text-white'
                )}>
                  {sg.sessionMode === 'examen_blanc' ? 'Examen blanc' : 'Entraînement'}
                </Badge>
                <p className="text-xs text-muted-foreground flex items-center gap-1">
                  <Clock className="w-3 h-3" />
                  Soumis le{' '}
                  {new Date(sg.sessionDate).toLocaleDateString('fr-FR', {
                    day: 'numeric',
                    month: 'short',
                    year: 'numeric',
                    hour: '2-digit',
                    minute: '2-digit',
                  })}
                  {' · '}{totalTaches} tâche{totalTaches > 1 ? 's' : ''}
                </p>
              </div>
            </div>
          </div>
        </CardHeader>

        <CardContent className="pt-3 space-y-4">
          {sg.epreuves.map(eg => {
            const isEE = eg.epreuve === 'expression_ecrite';
            const max = isEE ? MAX_EE : MAX_EO;
            const scored = eg.productions.filter(p => p.score !== null);
            const somme = scored.reduce((s, p) => s + (p.score ?? 0), 0);
            const epDone = eg.productions.every(p => p.statut_correction === 'corrige');
            const scoreMoyen = scored.length > 0 ? somme / scored.length : 0;
            const niveauEpreuveCode: NiveauCECRL | null = epDone && scored.length > 0
              ? isEE
                ? scoreEeToCECRL(scoreMoyen)
                : scoreEoToCECRL(scoreMoyen)
              : null;
            const niveauEpreuveLabel: string | null = epDone && scored.length > 0
              ? isEE
                ? scoreEeToCECRLLabel(scoreMoyen)
                : scoreEoToCECRLLabel(scoreMoyen)
              : null;

            return (
              <div key={eg.epreuve} className="space-y-2">
                <div className="flex items-center gap-2 flex-wrap">
                  {isEE
                    ? <FileText className="w-3.5 h-3.5 text-primary shrink-0" />
                    : <Mic className="w-3.5 h-3.5 text-primary shrink-0" />
                  }
                  <span className="text-xs font-semibold text-foreground">
                    {EPREUVE_LABELS[eg.epreuve as keyof typeof EPREUVE_LABELS] || eg.epreuve}
                  </span>
                  {niveauEpreuveCode && niveauEpreuveLabel && (
                    <Badge style={{ backgroundColor: CECRL_COLORS[niveauEpreuveCode] }} className="text-white text-xs py-0 h-4">
                      {niveauEpreuveLabel} — {CECRL_DESCRIPTIONS[niveauEpreuveCode]}
                    </Badge>
                  )}
                </div>

                <div className="space-y-1.5 pl-5">
                  {eg.productions.map(prod => {
                    const niveau = prod.statut_correction === 'corrige' ? getTaskNiveau(prod) : null;
                    const words = prod.contenu_texte ? prod.contenu_texte.split(/\s+/).filter(Boolean).length : 0;
                    return (
                      <div key={prod.id} className="flex items-center justify-between gap-3 px-3 py-2 rounded-lg bg-muted/30 border border-border hover:border-primary/40 transition-colors">
                        <div className="min-w-0 flex-1">
                          <div className="flex items-center gap-2 flex-wrap">
                            <p className="text-sm font-semibold text-foreground">Tâche {prod.numero_tache}</p>
                            {prod.reference && (
                              <Badge variant="outline" className="text-[10px] font-mono border-primary/30 text-primary py-0 h-4">
                                {prod.reference}
                              </Badge>
                            )}
                            {isEE && words > 0 && (
                              <span className="text-xs text-muted-foreground font-mono">({words} mots)</span>
                            )}
                          </div>

                          {prod.statut_correction === 'corrige' && prod.score !== null && (
                            <div className="flex items-center gap-1.5 mt-0.5 flex-wrap">
                              <span className="text-xs text-success font-medium">{prod.score} / {max} pts</span>
                              {niveau && (
                                <Badge style={{ backgroundColor: CECRL_COLORS[niveau.code] }} className="text-white text-xs py-0 h-4">
                                  {niveau.label}
                                </Badge>
                              )}
                            </div>
                          )}
                        </div>

                        <Button size="sm" variant="default" asChild className="shrink-0 shadow-xs">
                          <Link to={`/professeur/corrections/${prod.id}`}>Évaluer & Corriger</Link>
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
    <div className="max-w-4xl mx-auto space-y-6 fade-in pb-12">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-foreground text-balance">File de corrections</h1>
          <p className="text-muted-foreground mt-1">
            {loading ? '—' : pendingCount} tâche{pendingCount !== 1 ? 's' : ''} en attente réparties sur {loading ? '—' : pendingGroups.length} séance{pendingGroups.length !== 1 ? 's' : ''}
          </p>
        </div>
        <Button
          variant="outline"
          size="sm"
          onClick={() => loadData()}
          disabled={refreshing}
          className="self-start sm:self-center gap-2"
        >
          <RefreshCw className={`w-3.5 h-3.5 ${refreshing ? 'animate-spin' : ''}`} />
          <span>Actualiser</span>
        </Button>
      </div>

      {/* Barre de recherche et tri */}
      <div className="space-y-3">
        <div className="flex flex-col sm:flex-row gap-2">
          <div className="relative flex-1">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
            <Input
              value={search}
              onChange={e => setSearch(e.target.value)}
              placeholder="Rechercher un étudiant par nom, prénom ou email..."
              className="pl-9"
            />
          </div>

          <Button
            type="button"
            variant="outline"
            size="sm"
            onClick={() => setSortOrder(s => s === 'ancien_dabord' ? 'recent_dabord' : 'ancien_dabord')}
            className="h-9 gap-2 text-xs font-medium shrink-0 self-stretch sm:self-auto"
            title="Inverser l'ordre de priorité"
          >
            <ArrowUpDown className="w-3.5 h-3.5 text-primary" />
            <span>
              {sortOrder === 'ancien_dabord'
                ? 'Ordre : Plus anciennes d\'abord (Priorité)'
                : 'Ordre : Plus récentes d\'abord'}
            </span>
          </Button>
        </div>

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
      </div>

      {loading ? (
        <div className="space-y-3">{[1, 2, 3].map(i => <Skeleton key={i} className="h-24 w-full bg-muted" />)}</div>
      ) : filteredGroups.length === 0 ? (
        <Card className="h-full">
          <CardContent className="p-12 text-center">
            <CheckCircle className="w-12 h-12 text-success/30 mx-auto mb-4" />
            <p className="text-muted-foreground">
              {search.trim()
                ? 'Aucune correction trouvée pour cette recherche.'
                : activeTab === 'tout'
                ? 'Aucune correction en attente. Excellent travail !'
                : 'Aucune correction en attente pour cette catégorie.'}
            </p>
          </CardContent>
        </Card>
      ) : (
        <div className="space-y-3">{filteredGroups.map(sg => renderSessionGroup(sg))}</div>
      )}

      {/* Lien vers l'historique des corrections */}
      {!loading && (
        <div className="text-center pt-2">
          <Button variant="outline" asChild>
            <Link to="/professeur/historique">
              <ClipboardList className="w-4 h-4 mr-2" />Voir l'historique des corrections effectuées
            </Link>
          </Button>
        </div>
      )}
    </div>
  );
}
