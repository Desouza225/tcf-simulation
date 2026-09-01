import { useState, useEffect } from 'react';
import { supabase } from '@/db/supabase';
import { useAuth } from '@/contexts/AuthContext';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Skeleton } from '@/components/ui/skeleton';
import {
  LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Legend,
} from 'recharts';
import {
  Users, ChevronDown, ChevronUp, ToggleLeft, ToggleRight,
  Clock, CheckCircle2, TrendingUp, Ban,
} from 'lucide-react';
import { cn } from '@/lib/utils';
import {
  AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent,
  AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle,
  AlertDialogTrigger,
} from '@/components/ui/alert-dialog';
import { toast } from 'sonner';
import type { Profile, SessionExamen, NiveauCECRL } from '@/types/index';
import { CECRL_COLORS, EPREUVE_LABELS, pctToCECRL } from '@/types/index';

interface EpreuveStats {
  label: string;
  moyenneExamen: number | null;
  moyenneEntrainement: number | null;
}

interface DerniereNoteEpreuve {
  score: number;
  niveau?: NiveauCECRL | null;
  date: string;
  mode: 'entrainement' | 'examen_blanc';
}

interface EtudiantStats {
  profile: Profile;
  sessions: SessionExamen[];
  sessionsTotal: number;
  examsBlancs: number;
  correctionsEnAttente: number;
  dernierScore: number | null;
  dernierScoreMode: 'entrainement' | 'examen_blanc' | null;
  dernierNiveau: NiveauCECRL | null;
  scoreMoyen: number | null;
  progression: number | null;
  niveauGlobal: NiveauCECRL | null;
  parEpreuve: EpreuveStats[];
  dernieresNotes: {
    co: DerniereNoteEpreuve | null;
    ce: DerniereNoteEpreuve | null;
    ee: DerniereNoteEpreuve | null;
    eo: DerniereNoteEpreuve | null;
  };
}

const SCORE_MAX = 699;

// Calcule la moyenne des scores non-nuls d'une liste de valeurs
function avg(vals: (number | null | undefined)[]): number | null {
  const clean = vals.filter((v): v is number => v !== null && v !== undefined);
  return clean.length ? Math.round(clean.reduce((a, b) => a + b, 0) / clean.length) : null;
}

// Score moyen d'une session d'entraînement (QCM + productions) sur 699
function sessionEntrainementScore(s: SessionExamen): number | null {
  const vals = [s.score_oral, s.score_ecrit, s.score_expression_ecrite, s.score_expression_orale].filter(
    (v): v is number => v !== null && v !== undefined
  );
  return vals.length ? Math.round(vals.reduce((a, b) => a + b, 0) / vals.length) : null;
}

function scoreColor(score: number | null): string {
  if (score === null) return 'text-muted-foreground';
  if (score >= 500) return 'text-success';
  if (score >= 300) return 'text-warning';
  return 'text-destructive';
}

export default function EtudiantsListePage() {
  const { user } = useAuth();
  const [etudiants, setEtudiants] = useState<EtudiantStats[]>([]);
  const [loading, setLoading] = useState(true);
  const [expanded, setExpanded] = useState<string | null>(null);
  const [toggling, setToggling] = useState<string | null>(null);
  const [blocking, setBlocking] = useState<string | null>(null);

  useEffect(() => {
    if (!user) return;
    const load = async () => {
      // Récupérer uniquement les étudiants attribués à ce professeur
      let profiles: Profile[] = [];
      const { data: attributions, error: attrError } = await supabase
        .from('attributions')
        .select('etudiant:profiles!etudiant_id(*)')
        .eq('professeur_id', user.id);

      if (attrError || !attributions) {
        // Fallback en 2 requêtes
        const { data: rawAttr } = await supabase
          .from('attributions')
          .select('etudiant_id')
          .eq('professeur_id', user.id);
        if (rawAttr && rawAttr.length > 0) {
          const ids = rawAttr.map(a => a.etudiant_id);
          const { data: stdProfiles } = await supabase
            .from('profiles')
            .select('*')
            .in('id', ids);
          profiles = Array.isArray(stdProfiles) ? stdProfiles : [];
        }
      } else {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        profiles = (attributions || []).map((a: any) => a.etudiant as Profile).filter(Boolean);
      }

      const enriched = await Promise.all(
        profiles.map(async (profile: Profile) => {
          const [sessionsRes, pendingRes] = await Promise.all([
            supabase
              .from('sessions_examen')
              .select('*')
              .eq('etudiant_id', profile.id)
              .order('created_at', { ascending: false })
              .limit(50),
            supabase
              .from('productions')
              .select('id', { count: 'exact' })
              .eq('etudiant_id', profile.id)
              .eq('statut_correction', 'en_attente'),
          ]);

          const sessions: SessionExamen[] = Array.isArray(sessionsRes.data) ? sessionsRes.data : [];
          const examSessions = sessions.filter(s => s.mode === 'examen_blanc' && s.statut === 'termine');
          const trainSessions = sessions.filter(s => s.mode === 'entrainement' && s.statut === 'termine');
          const scored = examSessions.filter(s => s.score_global !== null);
          const scores = scored.map(s => s.score_global as number);
          const scoreMoyen = avg(scores);

          // Dernier score général (qu'il vienne d'un examen blanc ou d'un entraînement)
          const dernierScoreSession = sessions.find(s => s.statut === 'termine' && (s.score_global !== null || sessionEntrainementScore(s) !== null));
          const dernierScore = dernierScoreSession
            ? (dernierScoreSession.score_global ?? sessionEntrainementScore(dernierScoreSession))
            : null;
          const dernierScoreMode = (dernierScoreSession?.mode as 'entrainement' | 'examen_blanc') ?? null;
          const dernierNiveau = dernierScoreSession?.niveau_cecrl
            ? (dernierScoreSession.niveau_cecrl as NiveauCECRL)
            : (dernierScore !== null ? pctToCECRL(Math.round((dernierScore / SCORE_MAX) * 100)) : null);

          const progression = scores.length >= 2 ? scores[0] - scores[1] : null;

          // Moyennes par épreuve — séparées par mode
          const epreuves: Array<{ label: string; examKey: keyof SessionExamen; trainKey: keyof SessionExamen }> = [
            { label: EPREUVE_LABELS.comprehension_oral,  examKey: 'score_oral',              trainKey: 'score_oral' },
            { label: EPREUVE_LABELS.comprehension_ecrit, examKey: 'score_ecrit',             trainKey: 'score_ecrit' },
            { label: EPREUVE_LABELS.expression_ecrite,   examKey: 'score_expression_ecrite', trainKey: 'score_expression_ecrite' },
            { label: EPREUVE_LABELS.expression_orale,    examKey: 'score_expression_orale',  trainKey: 'score_expression_orale' },
          ];
          const parEpreuve: EpreuveStats[] = epreuves.map(e => ({
            label: e.label,
            moyenneExamen: avg(examSessions.map(s => s[e.examKey] as number | null)),
            moyenneEntrainement: avg(trainSessions.map(s => s[e.trainKey] as number | null)),
          }));

          // Dernières notes individuelles par épreuve
          const sCO = sessions.find(s => s.score_oral !== null && s.statut === 'termine');
          const sCE = sessions.find(s => s.score_ecrit !== null && s.statut === 'termine');
          const sEE = sessions.find(s => s.score_expression_ecrite !== null && s.statut === 'termine');
          const sEO = sessions.find(s => s.score_expression_orale !== null && s.statut === 'termine');

          const dernieresNotes = {
            co: sCO ? { score: sCO.score_oral!, niveau: pctToCECRL(Math.round((sCO.score_oral! / SCORE_MAX) * 100)), date: sCO.created_at, mode: sCO.mode } : null,
            ce: sCE ? { score: sCE.score_ecrit!, niveau: pctToCECRL(Math.round((sCE.score_ecrit! / SCORE_MAX) * 100)), date: sCE.created_at, mode: sCE.mode } : null,
            ee: sEE ? { score: sEE.score_expression_ecrite!, niveau: pctToCECRL(Math.round((sEE.score_expression_ecrite! / SCORE_MAX) * 100)), date: sEE.created_at, mode: sEE.mode } : null,
            eo: sEO ? { score: sEO.score_expression_orale!, niveau: pctToCECRL(Math.round((sEO.score_expression_orale! / SCORE_MAX) * 100)), date: sEO.created_at, mode: sEO.mode } : null,
          };

          // Niveau global CECRL basé sur toutes les sessions (examen + entraînement)
          const allScores: number[] = [];
          sessions.forEach(s => {
            if (s.mode === 'examen_blanc' && s.score_global !== null) {
              allScores.push(s.score_global as number);
            } else {
              const sc = sessionEntrainementScore(s);
              if (sc !== null) allScores.push(sc);
            }
          });
          const globalAvg = avg(allScores);
          const niveauGlobal: NiveauCECRL | null = globalAvg !== null
            ? pctToCECRL(Math.round((globalAvg / SCORE_MAX) * 100))
            : null;

          return {
            profile,
            sessions,
            sessionsTotal: sessions.length,
            examsBlancs: examSessions.length,
            correctionsEnAttente: pendingRes.count || 0,
            dernierScore,
            dernierScoreMode,
            dernierNiveau,
            scoreMoyen,
            progression,
            niveauGlobal,
            parEpreuve,
            dernieresNotes,
          } as EtudiantStats;
        })
      );
      setEtudiants(enriched);
      setLoading(false);
    };
    load();
  }, [user]);

  const toggleExamenBlanc = async (etudiantId: string, current: boolean) => {
    setToggling(etudiantId);
    const { error } = await supabase
      .from('profiles')
      .update({ examen_blanc_actif: !current })
      .eq('id', etudiantId);
    if (error) {
      toast.error('Erreur lors de la mise à jour.');
    } else {
      setEtudiants(prev =>
        prev.map(e =>
          e.profile.id === etudiantId
            ? { ...e, profile: { ...e.profile, examen_blanc_actif: !current } }
            : e
        )
      );
      toast.success(!current ? 'Examen blanc activé ✓' : 'Examen blanc désactivé');
    }
    setToggling(null);
  };

  const toggleBloque = async (etudiantId: string, current: boolean) => {
    setBlocking(etudiantId);
    const { error } = await supabase
      .from('profiles')
      .update({ bloque: !current })
      .eq('id', etudiantId);
    if (error) {
      toast.error('Erreur lors de la mise à jour du statut de blocage.');
    } else {
      setEtudiants(prev =>
        prev.map(e =>
          e.profile.id === etudiantId
            ? { ...e, profile: { ...e.profile, bloque: !current } }
            : e
        )
      );
      toast.success(!current ? 'Compte étudiant bloqué.' : 'Compte étudiant débloqué ✓');
    }
    setBlocking(null);
  };

  if (loading) return (
    <div className="max-w-3xl mx-auto space-y-4">
      <Skeleton className="h-8 w-64 bg-muted" />
      {[1, 2, 3].map(i => <Skeleton key={i} className="h-20 w-full bg-muted" />)}
    </div>
  );

  const pendingTotal = etudiants.reduce((s, e) => s + e.correctionsEnAttente, 0);

  return (
    <div className="max-w-3xl mx-auto space-y-6 fade-in">
      {/* En-tête */}
      <div>
        <h1 className="text-2xl font-bold text-foreground text-balance">Mes étudiants</h1>
        <p className="text-muted-foreground mt-1">
          {etudiants.length} étudiant{etudiants.length > 1 ? 's' : ''} attribué{etudiants.length > 1 ? 's' : ''}
        </p>
      </div>

      {/* Résumé rapide */}
      {etudiants.length > 0 && (
        <div className="grid grid-cols-3 gap-3">
          <Card className="h-full">
            <CardContent className="p-4 flex items-center gap-3">
              <div className="w-8 h-8 rounded-lg bg-primary/10 flex items-center justify-center shrink-0">
                <Users className="w-4 h-4 text-primary" />
              </div>
              <div className="min-w-0">
                <p className="text-lg font-bold text-foreground">{etudiants.length}</p>
                <p className="text-xs text-muted-foreground">Étudiants</p>
              </div>
            </CardContent>
          </Card>
          <Card className="h-full">
            <CardContent className="p-4 flex items-center gap-3">
              <div className="w-8 h-8 rounded-lg bg-success/10 flex items-center justify-center shrink-0">
                <ToggleRight className="w-4 h-4 text-success" />
              </div>
              <div className="min-w-0">
                <p className="text-lg font-bold text-foreground">
                  {etudiants.filter(e => e.profile.examen_blanc_actif).length}
                </p>
                <p className="text-xs text-muted-foreground">Exam blanc activé</p>
              </div>
            </CardContent>
          </Card>
          <Card className="h-full">
            <CardContent className="p-4 flex items-center gap-3">
              <div className="w-8 h-8 rounded-lg bg-destructive/10 flex items-center justify-center shrink-0">
                <Clock className="w-4 h-4 text-destructive" />
              </div>
              <div className="min-w-0">
                <p className="text-lg font-bold text-foreground">{pendingTotal}</p>
                <p className="text-xs text-muted-foreground">Corrections en attente</p>
              </div>
            </CardContent>
          </Card>        </div>
      )}

      {/* Liste des étudiants */}
      {etudiants.length === 0 ? (
        <Card className="h-full">
          <CardContent className="p-12 text-center">
            <Users className="w-12 h-12 text-muted-foreground/30 mx-auto mb-4" />
            <p className="text-muted-foreground">Aucun étudiant ne vous a été attribué pour le moment.</p>
          </CardContent>
        </Card>
      ) : (
        <div className="space-y-2">
          {etudiants.map(({
            profile, sessions, sessionsTotal, examsBlancs,
            correctionsEnAttente, dernierScore, dernierNiveau,
            scoreMoyen, progression, niveauGlobal, parEpreuve,
          }) => {
            const isExpanded = expanded === profile.id;
            const examActif = profile.examen_blanc_actif;
            const estBloque = profile.bloque;

            // Deux séries pour le graphique — examen blanc et entraînement
            type ChartPoint = { date: string; examen?: number; entrainement?: number };
            const chartMap: Record<string, ChartPoint> = {};
            sessions
              .filter(s => s.statut === 'termine')
              .forEach(s => {
                const date = new Date(s.created_at).toLocaleDateString('fr-FR', { day: '2-digit', month: 'short' });
                if (!chartMap[s.created_at]) chartMap[s.created_at] = { date };
                if (s.mode === 'examen_blanc' && s.score_global !== null) {
                  chartMap[s.created_at].examen = s.score_global as number;
                } else if (s.mode === 'entrainement') {
                  const sc = sessionEntrainementScore(s);
                  if (sc !== null) chartMap[s.created_at].entrainement = sc;
                }
              });
            const chartData = Object.entries(chartMap)
              .sort(([a], [b]) => new Date(a).getTime() - new Date(b).getTime())
              .slice(-10)
              .map(([, v]) => v);

            return (
              <Card key={profile.id} className={cn('h-full transition-shadow', isExpanded && 'shadow-md')}>
                <CardContent className="p-4">
                  <div className="flex flex-col gap-2">
                    {/* Ligne 1 : avatar + nom complet + email + dernière connexion */}
                    <div className="flex items-center gap-3 min-w-0">
                      <div className={cn(
                        'w-10 h-10 rounded-full flex items-center justify-center shrink-0',
                        estBloque ? 'bg-destructive/15' : 'bg-primary/15'
                      )}>
                        <span className={cn('text-sm font-semibold', estBloque ? 'text-destructive' : 'text-primary')}>
                          {profile.prenom?.[0]}{profile.nom?.[0]}
                        </span>
                      </div>
                      <div className="min-w-0 flex-1">
                        <div className="flex items-center gap-2 flex-wrap">
                          <p className="font-semibold text-foreground">{profile.prenom} {profile.nom}</p>
                          {niveauGlobal && (
                            <Badge
                              style={{ backgroundColor: CECRL_COLORS[niveauGlobal] }}
                              className="text-white text-xs shrink-0"
                              title="Niveau CECRL global (tous modes confondus)"
                            >
                              {niveauGlobal}
                            </Badge>
                          )}
                          {estBloque && (
                            <Badge variant="destructive" className="text-xs gap-1 shrink-0">
                              <Ban className="w-3 h-3" /> Bloqué
                            </Badge>
                          )}
                        </div>
                        <p className="text-xs text-muted-foreground truncate">{profile.email}</p>
                        {profile.last_active_at && (
                          <p className="text-xs text-muted-foreground/70 mt-0.5 flex items-center gap-1">
                            <Clock className="w-3 h-3 shrink-0" />
                            {new Date(profile.last_active_at).toLocaleString('fr-FR', {
                              day: '2-digit', month: 'short', year: 'numeric',
                              hour: '2-digit', minute: '2-digit',
                            })}
                          </p>
                        )}
                      </div>
                      {/* Expand/Collapse ancré en haut à droite */}
                      <Button
                        variant="ghost"
                        size="icon"
                        className="shrink-0"
                        onClick={() => setExpanded(isExpanded ? null : profile.id)}
                      >
                        {isExpanded ? <ChevronUp className="w-4 h-4" /> : <ChevronDown className="w-4 h-4" />}
                      </Button>
                    </div>

                    {/* Ligne 2 : stats + contrôles (ne touchent jamais au nom) */}
                    <div className="flex items-center gap-2 flex-wrap pl-13">
                      {/* Score */}
                      <div className="text-center">
                        <p className={cn('text-sm font-bold', scoreColor(dernierScore))}>
                          {dernierScore !== null ? `${dernierScore}/699` : '—'}
                        </p>
                        <p className="text-xs text-muted-foreground">Dernier score</p>
                      </div>

                      {/* Progression */}
                      {progression !== null && (
                        <div className="text-center">
                          <p className={cn('text-sm font-bold', progression >= 0 ? 'text-success' : 'text-destructive')}>
                            {progression >= 0 ? '+' : ''}{progression}
                          </p>
                          <p className="text-xs text-muted-foreground">Évolution</p>
                        </div>
                      )}

                      {/* Niveau CECRL */}
                      {dernierNiveau && (
                        <Badge style={{ backgroundColor: CECRL_COLORS[dernierNiveau] }} className="text-white shrink-0">
                          {dernierNiveau}
                        </Badge>
                      )}

                      {/* Corrections en attente */}
                      {correctionsEnAttente > 0 && (
                        <Badge variant="destructive" className="text-xs shrink-0">
                          {correctionsEnAttente} en attente
                        </Badge>
                      )}

                      {/* Toggle examen blanc */}
                      <Button
                        variant="outline"
                        size="sm"
                        className={cn(
                          'gap-1.5 shrink-0 text-xs h-8',
                          examActif
                            ? 'border-success/50 text-success hover:bg-success/10'
                            : 'border-muted-foreground/30 text-muted-foreground hover:bg-muted'
                        )}
                        onClick={() => toggleExamenBlanc(profile.id, examActif)}
                        disabled={toggling === profile.id}
                      >
                        {examActif
                          ? <ToggleRight className="w-3.5 h-3.5" />
                          : <ToggleLeft className="w-3.5 h-3.5" />
                        }
                        <span>Examen blanc</span>
                      </Button>

                      {/* Bouton Bloquer / Débloquer */}
                      <AlertDialog>
                        <AlertDialogTrigger asChild>
                          <Button
                            variant="outline"
                            size="sm"
                            disabled={blocking === profile.id}
                            className={cn(
                              'gap-1.5 shrink-0 text-xs h-8',
                              estBloque
                                ? 'border-success/50 text-success hover:bg-success/10'
                                : 'border-destructive/40 text-destructive hover:bg-destructive/10'
                            )}
                          >
                            {estBloque
                              ? <><CheckCircle2 className="w-3.5 h-3.5" /><span className="hidden sm:inline">Débloquer</span></>
                              : <><Ban className="w-3.5 h-3.5" /><span className="hidden sm:inline">Bloquer</span></>
                            }
                          </Button>
                        </AlertDialogTrigger>
                        <AlertDialogContent className="max-w-[calc(100%-2rem)] md:max-w-lg">
                          <AlertDialogHeader>
                            <AlertDialogTitle className="text-balance">
                              {estBloque ? 'Débloquer' : 'Bloquer'} {profile.prenom} {profile.nom} ?
                            </AlertDialogTitle>
                            <AlertDialogDescription className="text-pretty">
                              {estBloque
                                ? 'L\'étudiant pourra de nouveau se connecter et accéder à la plateforme.'
                                : 'L\'étudiant sera immédiatement déconnecté et ne pourra plus accéder à la plateforme.'}
                            </AlertDialogDescription>
                          </AlertDialogHeader>
                          <AlertDialogFooter>
                            <AlertDialogCancel>Annuler</AlertDialogCancel>
                            <AlertDialogAction
                              onClick={() => toggleBloque(profile.id, estBloque)}
                              className={estBloque
                                ? 'bg-success text-white hover:bg-success/90'
                                : 'bg-destructive text-destructive-foreground hover:bg-destructive/90'}
                            >
                              {estBloque ? 'Débloquer' : 'Bloquer'}
                            </AlertDialogAction>
                          </AlertDialogFooter>
                        </AlertDialogContent>
                      </AlertDialog>
                    </div>
                  </div>

                  {/* Détail expandé */}
                  {isExpanded && (
                    <div className="mt-4 space-y-4 border-t border-border pt-4">
                      {/* Statut examen blanc */}
                      <div className={cn(
                        'flex items-center gap-3 p-3 rounded-lg border',
                        examActif ? 'bg-success/5 border-success/20' : 'bg-muted/30 border-border'
                      )}>
                        {examActif
                          ? <ToggleRight className="w-5 h-5 text-success shrink-0" />
                          : <ToggleLeft className="w-5 h-5 text-muted-foreground shrink-0" />
                        }
                        <div className="flex-1 min-w-0">
                          <p className={cn('text-sm font-medium', examActif ? 'text-success' : 'text-muted-foreground')}>
                            Examen blanc {examActif ? 'activé' : 'désactivé'}
                          </p>
                          <p className="text-xs text-muted-foreground text-pretty">
                            {examActif
                              ? "Cet étudiant peut accéder à l'examen blanc TCF Canada."
                              : "Cliquez sur le bouton pour activer l'accès à l'examen blanc."}
                          </p>
                        </div>
                        <Button
                          size="sm"
                          variant={examActif ? 'outline' : 'default'}
                          className={cn('shrink-0', examActif && 'border-destructive/40 text-destructive hover:bg-destructive/10')}
                          onClick={() => toggleExamenBlanc(profile.id, examActif)}
                          disabled={toggling === profile.id}
                        >
                          {toggling === profile.id ? 'En cours...' : examActif ? 'Désactiver' : 'Activer'}
                        </Button>
                      </div>

                      {/* Statistiques globales */}
                      <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
                        {[
                          { label: 'Sessions totales', value: sessionsTotal },
                          { label: 'Examens blancs', value: examsBlancs },
                          { label: 'Score moyen', value: scoreMoyen !== null ? `${scoreMoyen}/699` : '—' },
                          {
                            label: dernierScoreMode === 'examen_blanc' ? 'Dernier exam blanc' : 'Dernier score',
                            value: dernierScore !== null ? `${dernierScore}/699` : '—'
                          },
                        ].map(stat => (
                          <div key={stat.label} className="bg-muted/50 rounded-lg p-3 text-center">
                            <p className="text-base font-bold text-foreground">{stat.value}</p>
                            <p className="text-xs text-muted-foreground">{stat.label}</p>
                          </div>
                        ))}
                      </div>

                      {/* Dernières notes par épreuve */}
                      <div className="space-y-2">
                        <p className="text-xs font-medium text-muted-foreground uppercase tracking-wide">
                          Dernières notes obtenues par épreuve
                        </p>
                        <div className="grid grid-cols-2 sm:grid-cols-4 gap-2">
                          {[
                            { key: 'co', label: 'Compr. Orale', item: dernieresNotes.co },
                            { key: 'ce', label: 'Compr. Écrite', item: dernieresNotes.ce },
                            { key: 'ee', label: 'Expr. Écrite', item: dernieresNotes.ee },
                            { key: 'eo', label: 'Expr. Orale', item: dernieresNotes.eo },
                          ].map(({ key, label, item }) => (
                            <div key={key} className="bg-muted/40 border border-border/60 rounded-lg p-2.5 flex flex-col justify-between">
                              <div>
                                <p className="text-xs text-muted-foreground font-medium truncate">{label}</p>
                                <p className={cn('text-base font-bold mt-0.5', scoreColor(item?.score ?? null))}>
                                  {item ? `${item.score}/699` : '—'}
                                </p>
                              </div>
                              {item ? (
                                <div className="mt-1.5 flex items-center justify-between gap-1 text-[10px] text-muted-foreground">
                                  {item.niveau && (
                                    <Badge style={{ backgroundColor: CECRL_COLORS[item.niveau] }} className="text-white text-[10px] h-4 px-1">
                                      {item.niveau}
                                    </Badge>
                                  )}
                                  <span className="truncate">
                                    {new Date(item.date).toLocaleDateString('fr-FR', { day: '2-digit', month: 'short' })}
                                  </span>
                                </div>
                              ) : (
                                <p className="text-[10px] text-muted-foreground/60 mt-1">Non évalué</p>
                              )}
                            </div>
                          ))}
                        </div>
                      </div>

                      {/* Moyennes par épreuve — séparées entraînement / examen blanc */}
                      <div className="space-y-2">
                        <p className="text-xs font-medium text-muted-foreground uppercase tracking-wide">
                          Moyennes par épreuve
                        </p>
                        <div className="overflow-x-auto">
                          <table className="w-full text-xs min-w-[320px]">
                            <thead>
                              <tr className="border-b border-border">
                                <th className="text-left py-1.5 pr-3 font-medium text-muted-foreground whitespace-nowrap">Épreuve</th>
                                <th className="text-center py-1.5 px-2 font-medium whitespace-nowrap" style={{ color: 'hsl(var(--chart-1))' }}>Entraînement</th>
                                <th className="text-center py-1.5 pl-2 font-medium whitespace-nowrap" style={{ color: 'hsl(var(--chart-2))' }}>Examen blanc</th>
                              </tr>
                            </thead>
                            <tbody>
                              {parEpreuve.map(e => (
                                <tr key={e.label} className="border-b border-border/50 last:border-0">
                                  <td className="py-1.5 pr-3 text-muted-foreground whitespace-nowrap">{e.label}</td>
                                  <td className={cn('py-1.5 px-2 text-center font-mono font-semibold whitespace-nowrap', scoreColor(e.moyenneEntrainement))}>
                                    {e.moyenneEntrainement !== null ? `${e.moyenneEntrainement}/699` : '—'}
                                  </td>
                                  <td className={cn('py-1.5 pl-2 text-center font-mono font-semibold whitespace-nowrap', scoreColor(e.moyenneExamen))}>
                                    {e.moyenneExamen !== null ? `${e.moyenneExamen}/699` : '—'}
                                  </td>
                                </tr>
                              ))}
                            </tbody>
                          </table>
                        </div>
                      </div>

                      {/* Graphique de progression — 2 courbes */}
                      {chartData.length > 0 && (
                        <div>
                          <p className="text-xs font-medium text-muted-foreground mb-2 uppercase tracking-wide">
                            Progression des scores
                          </p>
                          <div className="w-full min-w-0 overflow-hidden h-44">
                            <ResponsiveContainer width="100%" height="100%">
                              <LineChart data={chartData}>
                                <CartesianGrid strokeDasharray="3 3" stroke="hsl(var(--border))" />
                                <XAxis dataKey="date" tick={{ fontSize: 11 }} />
                                <YAxis domain={[0, SCORE_MAX]} tick={{ fontSize: 11 }} />
                                <Tooltip
                                  contentStyle={{
                                    background: 'hsl(var(--card))',
                                    border: '1px solid hsl(var(--border))',
                                    borderRadius: '6px',
                                    fontSize: 12,
                                  }}
                                  formatter={(v: number, name: string) => [
                                    `${v}/699`,
                                    name === 'examen' ? 'Examen blanc' : 'Entraînement',
                                  ]}
                                />
                                <Legend
                                  layout="horizontal"
                                  wrapperStyle={{ paddingTop: 8, fontSize: 11 }}
                                  formatter={(v) => v === 'examen' ? 'Examen blanc' : 'Entraînement'}
                                />
                                <Line
                                  type="monotone"
                                  dataKey="examen"
                                  stroke="hsl(var(--chart-2))"
                                  strokeWidth={2}
                                  dot={{ fill: 'hsl(var(--chart-2))', r: 3 }}
                                  activeDot={{ r: 5 }}
                                  connectNulls
                                />
                                <Line
                                  type="monotone"
                                  dataKey="entrainement"
                                  stroke="hsl(var(--chart-1))"
                                  strokeWidth={2}
                                  strokeDasharray="4 3"
                                  dot={{ fill: 'hsl(var(--chart-1))', r: 3 }}
                                  activeDot={{ r: 5 }}
                                  connectNulls
                                />
                              </LineChart>
                            </ResponsiveContainer>
                          </div>
                        </div>
                      )}

                      {/* Corrections */}
                      {correctionsEnAttente > 0 ? (
                        <div className="flex items-center gap-2 p-3 bg-destructive/5 border border-destructive/20 rounded-md">
                          <Clock className="w-4 h-4 text-destructive shrink-0" />
                          <p className="text-sm text-destructive">
                            {correctionsEnAttente} production{correctionsEnAttente > 1 ? 's' : ''} en attente de correction
                          </p>
                        </div>
                      ) : examsBlancs > 0 ? (
                        <div className="flex items-center gap-2 p-3 bg-success/5 border border-success/20 rounded-md">
                          <CheckCircle2 className="w-4 h-4 text-success shrink-0" />
                          <p className="text-sm text-success">Toutes les productions sont corrigées</p>
                        </div>
                      ) : (
                        <div className="flex items-center gap-2 p-3 bg-muted/30 border border-border rounded-md">
                          <TrendingUp className="w-4 h-4 text-muted-foreground shrink-0" />
                          <p className="text-sm text-muted-foreground">Aucun examen blanc passé pour le moment</p>
                        </div>
                      )}
                    </div>
                  )}
                </CardContent>
              </Card>
            );
          })}
        </div>
      )}
    </div>
  );
}
