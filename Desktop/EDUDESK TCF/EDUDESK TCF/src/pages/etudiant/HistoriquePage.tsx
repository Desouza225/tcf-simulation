import { useState, useEffect } from 'react';
import { supabase } from '@/db/supabase';
import { useAuth } from '@/contexts/AuthContext';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Legend } from 'recharts';
import type { SessionExamen, NiveauCECRL, Production } from '@/types/index';
import {
  CECRL_COLORS,
  EPREUVE_LABELS,
  pctToCECRL,
  scoreEeToCECRL,
  scoreEeToCECRLLabel,
  CECRL_DESCRIPTIONS,
} from '@/types/index';
import { Trophy, TrendingUp, ChevronDown, ChevronUp, Clock, CheckCircle2, MessageSquare, FileText, Mic, BookOpen, GraduationCap } from 'lucide-react';
import { cn } from '@/lib/utils';

const MAX_EE = 20;
const MAX_EO = 18;

interface SessionAvecProductions extends SessionExamen {
  productions?: Production[];
}

function scoreToNiveau(score: number): NiveauCECRL {
  return pctToCECRL(Math.round((score / 699) * 100));
}

function ScoreBar({ label, score }: { label: string; score: number | null }) {
  const pct = score !== null ? Math.round((score / 699) * 100) : null;
  const niveau = score !== null ? scoreToNiveau(score) : null;
  return (
    <div className="space-y-1">
      <div className="flex items-center justify-between text-xs gap-2 flex-wrap">
        <span className="text-muted-foreground truncate pr-2">{label}</span>
        <div className="flex items-center gap-1.5 shrink-0">
          {niveau && (
            <Badge style={{ backgroundColor: CECRL_COLORS[niveau] }} className="text-white text-xs py-0 h-4">
              {niveau}
            </Badge>
          )}
          <span className="font-semibold text-foreground">
            {score !== null ? `${score}/699` : '—'}
          </span>
        </div>
      </div>
      <div className="h-1.5 bg-muted rounded-full overflow-hidden">
        {pct !== null && (
          <div
            className="h-full rounded-full bg-primary transition-all"
            style={{ width: `${pct}%` }}
          />
        )}
      </div>
    </div>
  );
}

export default function HistoriquePage() {
  const { user } = useAuth();
  const [examSessions, setExamSessions] = useState<SessionAvecProductions[]>([]);
  const [trainSessions, setTrainSessions] = useState<SessionAvecProductions[]>([]);
  const [loading, setLoading] = useState(true);
  const [expanded, setExpanded] = useState<string | null>(null);
  const [loadingProds, setLoadingProds] = useState<string | null>(null);

  useEffect(() => {
    if (!user) return;
    // Charger les deux modes en parallèle
    Promise.all([
      supabase
        .from('sessions_examen')
        .select('*')
        .eq('etudiant_id', user.id)
        .eq('mode', 'examen_blanc')
        .eq('statut', 'termine')
        .order('created_at', { ascending: false }),
      supabase
        .from('sessions_examen')
        .select('*')
        .eq('etudiant_id', user.id)
        .eq('mode', 'entrainement')
        .eq('statut', 'termine')
        .order('created_at', { ascending: false }),
    ]).then(([examRes, trainRes]) => {
      setExamSessions(Array.isArray(examRes.data) ? examRes.data : []);
      setTrainSessions(Array.isArray(trainRes.data) ? trainRes.data : []);
      setLoading(false);
    });
  }, [user]);

  // Charger les productions d'une session (examen ou entraînement)
  const toggleExpand = async (sessionId: string, mode: 'examen_blanc' | 'entrainement') => {
    if (expanded === sessionId) { setExpanded(null); return; }
    setExpanded(sessionId);
    const list = mode === 'examen_blanc' ? examSessions : trainSessions;
    const setter = mode === 'examen_blanc' ? setExamSessions : setTrainSessions;
    const session = list.find(s => s.id === sessionId);
    if (session?.productions) return;
    setLoadingProds(sessionId);
    const { data } = await supabase
      .from('productions')
      .select('*')
      .eq('session_id', sessionId)
      .order('epreuve')
      .order('numero_tache');
    setter(prev =>
      prev.map(s => s.id === sessionId ? { ...s, productions: Array.isArray(data) ? data : [] } : s)
    );
    setLoadingProds(null);
  };

  // Onglet actif : pilote le graphique ET la liste
  const [activeTab, setActiveTab] = useState<'examen_blanc' | 'entrainement' | 'tout'>('examen_blanc');

  // Graphique de progression : données selon l'onglet actif
  // — examen_blanc : barres rouges (#C8102E)
  // — entrainement : barres bleues (#1B365D)
  // — tout : les deux séries superposées avec leurs couleurs respectives
  const examChartData = examSessions
    .filter(s => s.score_global !== null)
    .slice(0, 10)
    .reverse()
    .map((s, i) => ({
      name: `E${i + 1}`,
      scoreExamen: s.score_global,
      date: new Date(s.created_at).toLocaleDateString('fr-FR', { day: '2-digit', month: 'short' }),
    }));

  const trainChartData = trainSessions
    .filter(s =>
      s.score_oral !== null || s.score_ecrit !== null ||
      s.score_expression_ecrite !== null || s.score_expression_orale !== null
    )
    .slice(0, 10)
    .reverse()
    .map((s, i) => ({
      name: `T${i + 1}`,
      date: new Date(s.created_at).toLocaleDateString('fr-FR', { day: '2-digit', month: 'short' }),
      compOrale: s.score_oral ?? undefined,
      compEcrite: s.score_ecrit ?? undefined,
      exprEcrite: s.score_expression_ecrite ?? undefined,
      exprOrale: s.score_expression_orale ?? undefined,
    }));

  // Onglet "Tout" : fusionner les deux séries sur un axe temporel commun
  const toutChartData = (() => {
    const combined = [
      ...examSessions
        .filter(s => s.score_global !== null)
        .map(s => ({ ts: new Date(s.created_at).getTime(), scoreExamen: s.score_global as number, scoreEntrainement: undefined as number | undefined, date: new Date(s.created_at).toLocaleDateString('fr-FR', { day: '2-digit', month: 'short' }) })),
      ...trainSessions
        .filter(s => s.score_global !== null)
        .map(s => ({ ts: new Date(s.created_at).getTime(), scoreExamen: undefined as number | undefined, scoreEntrainement: s.score_global as number, date: new Date(s.created_at).toLocaleDateString('fr-FR', { day: '2-digit', month: 'short' }) })),
    ];
    return combined.sort((a, b) => a.ts - b.ts).slice(-20);
  })();

  const activeChartData =
    activeTab === 'examen_blanc' ? examChartData :
    activeTab === 'entrainement' ? trainChartData :
    toutChartData;

  const showChart =
    activeTab === 'tout'
      ? toutChartData.length > 1
      : activeTab === 'examen_blanc'
        ? examChartData.length > 1
        : trainChartData.length > 1;

  // Rendu d'une carte session (partagé examen blanc + entraînement)
  const renderSession = (session: SessionAvecProductions, mode: 'examen_blanc' | 'entrainement') => {
    const isExam = mode === 'examen_blanc';
    const isExpanded = expanded === session.id;
    const expressionsScored =
      session.score_expression_ecrite !== null &&
      session.score_expression_orale !== null;
    // Une session est corrigée si correction_complete est vrai OU si toutes les expressions
    // ont été traitées (score attribué — y compris 0 pour les refus) + score_global calculé
    const allExpressionsHandled = session.productions
      ? session.productions
          .filter(p => p.epreuve === 'expression_ecrite' || p.epreuve === 'expression_orale')
          .every(p => p.statut_correction === 'corrige' || p.statut_correction === 'refuse')
      : false;
    const corrige = session.correction_complete ||
      ((expressionsScored || allExpressionsHandled) && session.score_global !== null);

    // Couleurs distinctives : rouge brique pour examen blanc, bleu marine pour entraînement
    const accentColor = isExam ? '#C8102E' : '#1B365D';
    const accentBg = isExam ? 'bg-[#C8102E]/8 border-[#C8102E]/25' : 'bg-[#1B365D]/8 border-[#1B365D]/25';

    return (
      <Card
        key={session.id}
        className={cn(
          'h-full transition-shadow cursor-pointer',
          isExam ? 'hover:border-[#C8102E]/40' : 'hover:border-[#1B365D]/40',
          isExpanded && 'shadow-md'
        )}
        onClick={() => toggleExpand(session.id, mode)}
      >
        <CardContent className="p-4">
          {/* Ligne résumé */}
          <div className="flex items-start justify-between gap-3">
            <div className="min-w-0 flex-1">
              <div className="flex items-center gap-2 flex-wrap mb-1">
                {/* Badge type de session avec couleur distinctive */}
                <Badge
                  className="text-xs py-0 h-5 shrink-0 text-white"
                  style={{ backgroundColor: accentColor }}
                >
                  {isExam
                    ? <><GraduationCap className="w-3 h-3 mr-1 inline-block" />Examen blanc</>
                    : <><BookOpen className="w-3 h-3 mr-1 inline-block" />Entraînement</>
                  }
                </Badge>
              </div>
              <p className="font-semibold text-foreground text-balance text-sm">
                {new Date(session.created_at).toLocaleDateString('fr-FR', {
                  day: 'numeric', month: 'long', year: 'numeric',
                })}
              </p>
              {isExam ? (
                corrige ? (
                  <div className="flex flex-wrap items-center gap-2 mt-1">
                    <CheckCircle2 className="w-3.5 h-3.5 text-success shrink-0" />
                    <span className="text-xs text-success font-medium">Corrigé</span>
                    <span className="text-xs text-muted-foreground">·</span>
                    <span className="text-xs font-bold text-foreground">
                      Score global : {session.score_global}/699
                    </span>
                  </div>
                ) : (
                  <div className="flex items-center gap-1.5 mt-1">
                    <Clock className="w-3.5 h-3.5 text-muted-foreground shrink-0" />
                    <span className="text-xs text-muted-foreground">En attente de correction</span>
                  </div>
                )
              ) : (
                // Entraînement : afficher les scores QCM si disponibles
                session.score_oral !== null || session.score_ecrit !== null ? (
                  <div className="flex items-center gap-1.5 mt-1">
                    <CheckCircle2 className="w-3.5 h-3.5 text-success shrink-0" />
                    <span className="text-xs text-muted-foreground">
                      {[
                        session.score_oral !== null && `Oral: ${session.score_oral}/699`,
                        session.score_ecrit !== null && `Écrit: ${session.score_ecrit}/699`,
                      ].filter(Boolean).join(' · ')}
                    </span>
                  </div>
                ) : (
                  <div className="flex items-center gap-1.5 mt-1">
                    <Clock className="w-3.5 h-3.5 text-muted-foreground shrink-0" />
                    <span className="text-xs text-muted-foreground">Séance terminée</span>
                  </div>
                )
              )}
            </div>
            <div className="flex items-center gap-2 shrink-0">
              {isExam && (session.niveau_cecrl || corrige) ? (
                <Badge
                  style={session.niveau_cecrl
                    ? { backgroundColor: CECRL_COLORS[session.niveau_cecrl as NiveauCECRL] }
                    : { backgroundColor: 'hsl(var(--muted))' }}
                  className="text-white text-xs"
                >
                  {session.niveau_cecrl ?? 'Corrigé'}
                </Badge>
              ) : isExam ? (
                <Badge variant="outline" className="text-xs">En attente</Badge>
              ) : null}
              {isExpanded
                ? <ChevronUp className="w-4 h-4 text-muted-foreground" />
                : <ChevronDown className="w-4 h-4 text-muted-foreground" />
              }
            </div>
          </div>

          {/* Détail expandé */}
          {isExpanded && (
            <div
              className={cn('mt-4 border-t pt-4 space-y-5', accentBg, 'rounded-b-lg -mx-4 -mb-4 px-4 pb-4')}
              onClick={e => e.stopPropagation()}
            >
              {/* Scores examen blanc */}
              {isExam && corrige && (
                <div className="space-y-3">
                  <p className="text-xs font-semibold text-muted-foreground uppercase tracking-wide">
                    Résultats par épreuve
                  </p>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                    <div className="bg-muted/40 rounded-lg p-3 space-y-2.5">
                      <ScoreBar label={EPREUVE_LABELS.comprehension_oral} score={session.score_oral} />
                      <ScoreBar label={EPREUVE_LABELS.comprehension_ecrit} score={session.score_ecrit} />
                      <ScoreBar label={EPREUVE_LABELS.expression_ecrite} score={session.score_expression_ecrite} />
                      <ScoreBar label={EPREUVE_LABELS.expression_orale} score={session.score_expression_orale} />
                    </div>
                    <div className="flex flex-col items-center justify-center bg-primary/5 border border-primary/20 rounded-lg p-4">
                      <p className="text-xs text-muted-foreground mb-1">Score global</p>
                      <p className="text-3xl font-bold text-foreground">{session.score_global}</p>
                      <p className="text-sm text-muted-foreground">/699</p>
                      {session.niveau_cecrl && (
                        <Badge
                          className="mt-2 text-white"
                          style={{ backgroundColor: CECRL_COLORS[session.niveau_cecrl as NiveauCECRL] }}
                        >
                          Niveau {session.niveau_cecrl}
                        </Badge>
                      )}
                    </div>
                  </div>
                </div>
              )}

              {/* Productions (expression écrite/orale) */}
              {loadingProds === session.id ? (
                <div className="space-y-2">
                  {[1, 2].map(i => <Skeleton key={i} className="h-16 w-full bg-muted" />)}
                </div>
              ) : session.productions && session.productions.length > 0 ? (
                <div className="space-y-4">
                  <div className="flex items-center justify-between gap-2 flex-wrap">
                    <p className="text-xs font-semibold text-muted-foreground uppercase tracking-wide">
                      Détail des productions
                    </p>
                    {/* Durée passée sur l'expression écrite */}
                    {session.duree_expression_ecrite !== null && session.duree_expression_ecrite !== undefined && (
                      <span className="inline-flex items-center gap-1 text-xs bg-muted px-2 py-0.5 rounded-full font-mono text-muted-foreground">
                        <Clock className="w-3 h-3 shrink-0" />
                        {String(Math.floor(session.duree_expression_ecrite / 60)).padStart(2, '0')}:{String(session.duree_expression_ecrite % 60).padStart(2, '0')} sur l'épreuve
                      </span>
                    )}
                  </div>
                  {(['expression_ecrite', 'expression_orale'] as const).map(ep => {
                    const prods = session.productions!.filter(p => p.epreuve === ep);
                    if (prods.length === 0) return null;
                    const isEE = ep === 'expression_ecrite';
                    const max = isEE ? MAX_EE : MAX_EO;
                    const scored = prods.filter(p => p.score !== null);
                    const allDone = prods.every(p =>
                      p.statut_correction === 'corrige' || p.statut_correction === 'refuse'
                    );
                    const scoreMoyen = scored.length > 0 ? scored.reduce((s, p) => s + (p.score ?? 0), 0) / scored.length : 0;
                    const niveauEpreuveCode: NiveauCECRL | null = allDone && scored.length > 0
                      ? isEE
                        ? scoreEeToCECRL(scoreMoyen)
                        : pctToCECRL(Math.round((scored.reduce((s, p) => s + (p.score ?? 0), 0) / (max * scored.length)) * 100))
                      : null;
                    const niveauEpreuveLabel: string | null = allDone && scored.length > 0
                      ? isEE
                        ? scoreEeToCECRLLabel(scoreMoyen)
                        : niveauEpreuveCode
                      : null;
                    return (
                      <div key={ep} className="space-y-2">
                        <div className="flex items-center gap-2 flex-wrap">
                          {isEE
                            ? <FileText className="w-4 h-4 text-primary shrink-0" />
                            : <Mic className="w-4 h-4 text-primary shrink-0" />
                          }
                          <span className="text-xs font-semibold text-foreground">{EPREUVE_LABELS[ep]}</span>
                          {niveauEpreuveCode && niveauEpreuveLabel && (
                            <Badge style={{ backgroundColor: CECRL_COLORS[niveauEpreuveCode] }} className="text-white text-xs py-0 h-4">
                              {niveauEpreuveLabel} — {CECRL_DESCRIPTIONS[niveauEpreuveCode]}
                            </Badge>
                          )}
                        </div>
                        {prods.map(prod => {
                          const niveauCode: NiveauCECRL | null = prod.score !== null
                            ? isEE
                              ? scoreEeToCECRL(prod.score)
                              : pctToCECRL(Math.round((prod.score / max) * 100))
                            : null;
                          const niveauLabel: string | null = prod.score !== null
                            ? isEE
                              ? scoreEeToCECRLLabel(prod.score)
                              : niveauCode
                            : null;
                          // Audio supprimé 10j après correction (audio_url null + prod corrigée expression orale)
                          const audioSupprime =
                            ep === 'expression_orale' &&
                            prod.audio_url === null &&
                            prod.statut_correction === 'corrige';
                          const isRefuse = prod.statut_correction === 'refuse';
                          return (
                            <div key={prod.id} className={cn(
                              'bg-muted/30 rounded-lg p-3 space-y-1.5 ml-6',
                              isRefuse && 'bg-destructive/5 border border-destructive/20'
                            )}>
                              <div className="flex items-center justify-between gap-2 flex-wrap">
                                <span className="text-xs font-medium text-foreground">Tâche {prod.numero_tache}</span>
                                {isRefuse ? (
                                  <div className="flex items-center gap-1.5 shrink-0">
                                    <Badge variant="destructive" className="text-xs shrink-0">Refusée</Badge>
                                    <Badge variant="outline" className="text-xs shrink-0 text-destructive border-destructive/40">0 / {max} pts</Badge>
                                  </div>
                                ) : prod.score !== null && (
                                  <div className="flex items-center gap-1.5 shrink-0">
                                    {niveauCode && niveauLabel && (
                                      <Badge style={{ backgroundColor: CECRL_COLORS[niveauCode] }} className="text-white text-xs py-0 h-4 font-semibold">
                                        {niveauLabel}
                                      </Badge>
                                    )}
                                    <Badge variant="outline" className="text-xs shrink-0 font-medium font-mono">
                                      {prod.score} / {max} pts
                                    </Badge>
                                  </div>
                                )}
                              </div>
                              {/* Motif du refus */}
                              {isRefuse && (
                                <p className="text-xs text-destructive text-pretty">
                                  {prod.raison_refus
                                    ? `Motif : ${prod.raison_refus}`
                                    : 'Cette production a été refusée par votre professeur. Vous pouvez en soumettre une nouvelle.'}
                                </p>
                              )}
                              {/* Production écrite — affichée pour relecture même après correction */}
                              {!isRefuse && ep === 'expression_ecrite' && prod.contenu_texte && (
                                <details className="group">
                                  <summary className="cursor-pointer text-xs text-primary font-medium list-none flex items-center gap-1 select-none">
                                    <FileText className="w-3.5 h-3.5 shrink-0" />
                                    <span className="group-open:hidden">Voir ma production</span>
                                    <span className="hidden group-open:inline">Masquer ma production</span>
                                    <span className="ml-auto font-mono text-muted-foreground font-normal">
                                      {prod.contenu_texte.split(/\s+/).filter(Boolean).length} mots
                                    </span>
                                  </summary>
                                  <div className="mt-2 bg-background border border-border rounded-md p-3">
                                    <p className="text-xs text-foreground whitespace-pre-wrap text-pretty leading-relaxed">
                                      {prod.contenu_texte}
                                    </p>
                                  </div>
                                </details>
                              )}
                              {/* Note audio supprimé */}
                              {audioSupprime && (
                                <div className="flex items-center gap-1.5 text-xs text-muted-foreground italic">
                                  <Mic className="w-3.5 h-3.5 shrink-0" />
                                  Enregistrement audio supprimé automatiquement 10 jours après la correction.
                                </div>
                              )}
                              {/* Lecteur audio : disponible après correction, avant suppression automatique */}
                              {!isRefuse && ep === 'expression_orale' && prod.audio_url && prod.statut_correction === 'corrige' && (
                                <div className="mt-1">
                                  <p className="text-xs text-muted-foreground mb-1 flex items-center gap-1">
                                    <Mic className="w-3 h-3 shrink-0" />
                                    Votre enregistrement (disponible 10 jours après correction)
                                  </p>
                                  <audio
                                    controls
                                    src={prod.audio_url}
                                    className="w-full h-8 rounded"
                                    style={{ minWidth: 0, maxWidth: '100%' }}
                                  />
                                </div>
                              )}
                              {!isRefuse && prod.commentaire ? (
                                <div className="flex gap-2">
                                  <MessageSquare className="w-3.5 h-3.5 text-primary shrink-0 mt-0.5" />
                                  <p className="text-xs text-muted-foreground text-pretty leading-relaxed">{prod.commentaire}</p>
                                </div>
                              ) : !isRefuse && (
                                <p className="text-xs text-muted-foreground italic">Aucun commentaire</p>
                              )}
                            </div>
                          );
                        })}
                      </div>
                    );
                  })}
                </div>
              ) : isExam && !corrige ? (
                <div className="flex items-center gap-2 p-3 bg-muted/30 border border-border rounded-lg">
                  <Clock className="w-4 h-4 text-muted-foreground shrink-0" />
                  <p className="text-sm text-muted-foreground text-pretty">
                    Votre professeur n'a pas encore corrigé cet examen. Vous serez notifié dès que la correction sera disponible.
                  </p>
                </div>
              ) : null}
            </div>
          )}
        </CardContent>
      </Card>
    );
  };

  return (
    <div className="max-w-4xl mx-auto space-y-6 fade-in">
      <div>
        <h1 className="text-2xl font-bold text-foreground text-balance">Historique des sessions</h1>
        <p className="text-muted-foreground mt-1">Suivez votre progression dans le temps</p>
      </div>

      {/* Légende des couleurs — adaptée à l'onglet actif */}
      <div className="flex items-center gap-4 flex-wrap">
        {activeTab !== 'entrainement' && (
          <div className="flex items-center gap-1.5">
            <span className="inline-block w-3 h-3 rounded-sm bg-[#C8102E]" />
            <span className="text-xs text-muted-foreground">Examen blanc</span>
          </div>
        )}
        {activeTab === 'tout' && (
          <div className="flex items-center gap-1.5">
            <span className="inline-block w-3 h-3 rounded-sm bg-[#1B365D]" />
            <span className="text-xs text-muted-foreground">Entraînement (global)</span>
          </div>
        )}
        {activeTab === 'entrainement' && (
          <>
            <div className="flex items-center gap-1.5">
              <span className="inline-block w-3 h-3 rounded-sm bg-[#0EA5E9]" />
              <span className="text-xs text-muted-foreground">Compréhension orale</span>
            </div>
            <div className="flex items-center gap-1.5">
              <span className="inline-block w-3 h-3 rounded-sm bg-[#8B5CF6]" />
              <span className="text-xs text-muted-foreground">Compréhension écrite</span>
            </div>
            <div className="flex items-center gap-1.5">
              <span className="inline-block w-3 h-3 rounded-sm bg-[#10B981]" />
              <span className="text-xs text-muted-foreground">Expression écrite</span>
            </div>
            <div className="flex items-center gap-1.5">
              <span className="inline-block w-3 h-3 rounded-sm bg-[#F59E0B]" />
              <span className="text-xs text-muted-foreground">Expression orale</span>
            </div>
          </>
        )}
      </div>

      {showChart && (
        <Card className="h-full">
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-balance">
              <TrendingUp className="w-5 h-5 text-primary" />
              Progression des scores —{' '}
              {activeTab === 'examen_blanc' ? 'Examens blancs' : activeTab === 'entrainement' ? 'Entraînements' : 'Tout'}
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="w-full min-w-0 overflow-hidden h-52">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={activeChartData}>
                  <CartesianGrid strokeDasharray="3 3" stroke="hsl(var(--border))" />
                  <XAxis dataKey="date" tick={{ fontSize: 11 }} />
                  <YAxis domain={[0, 699]} tick={{ fontSize: 11 }} />
                  <Tooltip
                    contentStyle={{ background: 'hsl(var(--card))', border: '1px solid hsl(var(--border))', borderRadius: '6px' }}
                    formatter={(v, key) => {
                      const labels: Record<string, string> = {
                        scoreExamen: 'Examen blanc',
                        scoreEntrainement: 'Entraînement (global)',
                        compOrale: 'Compréhension orale',
                        compEcrite: 'Compréhension écrite',
                        exprEcrite: 'Expression écrite',
                        exprOrale: 'Expression orale',
                      };
                      return [`${v}/699`, labels[key as string] ?? key];
                    }}
                  />
                  {/* Légende toujours visible pour entraînement (multi-séries) et tout */}
                  {(activeTab === 'entrainement' || activeTab === 'tout') && (
                    <Legend layout="horizontal" wrapperStyle={{ paddingTop: 8, fontSize: 11 }} />
                  )}

                  {/* Onglet examen_blanc : 1 barre rouge */}
                  {activeTab === 'examen_blanc' && (
                    <Bar dataKey="scoreExamen" name="Examen blanc" fill="#C8102E" radius={[4, 4, 0, 0]} maxBarSize={40} />
                  )}

                  {/* Onglet tout : 2 barres rouge + bleu */}
                  {activeTab === 'tout' && (
                    <Bar dataKey="scoreExamen" name="Examen blanc" fill="#C8102E" radius={[4, 4, 0, 0]} maxBarSize={32} />
                  )}
                  {activeTab === 'tout' && (
                    <Bar dataKey="scoreEntrainement" name="Entraînement" fill="#1B365D" radius={[4, 4, 0, 0]} maxBarSize={32} />
                  )}

                  {/* Onglet entraînement : 4 barres distinctes par épreuve */}
                  {activeTab === 'entrainement' && (
                    <Bar dataKey="compOrale" name="Compréhension orale" fill="#0EA5E9" radius={[4, 4, 0, 0]} maxBarSize={24} />
                  )}
                  {activeTab === 'entrainement' && (
                    <Bar dataKey="compEcrite" name="Compréhension écrite" fill="#8B5CF6" radius={[4, 4, 0, 0]} maxBarSize={24} />
                  )}
                  {activeTab === 'entrainement' && (
                    <Bar dataKey="exprEcrite" name="Expression écrite" fill="#10B981" radius={[4, 4, 0, 0]} maxBarSize={24} />
                  )}
                  {activeTab === 'entrainement' && (
                    <Bar dataKey="exprOrale" name="Expression orale" fill="#F59E0B" radius={[4, 4, 0, 0]} maxBarSize={24} />
                  )}
                </BarChart>
              </ResponsiveContainer>
            </div>
          </CardContent>
        </Card>
      )}

      {/* Onglets Examen blanc / Entraînement / Tout */}
      <Tabs value={activeTab} onValueChange={(v) => setActiveTab(v as typeof activeTab)}>
        <TabsList className="grid w-full grid-cols-3">
          <TabsTrigger value="examen_blanc" className="gap-1.5 text-xs md:text-sm">
            <GraduationCap className="w-4 h-4 shrink-0" />
            <span className="truncate">Examens blancs</span>
            {!loading && examSessions.length > 0 && (
              <span className="ml-0.5 opacity-70">({examSessions.length})</span>
            )}
          </TabsTrigger>
          <TabsTrigger value="entrainement" className="gap-1.5 text-xs md:text-sm">
            <BookOpen className="w-4 h-4 shrink-0" />
            <span className="truncate">Entraînements</span>
            {!loading && trainSessions.length > 0 && (
              <span className="ml-0.5 opacity-70">({trainSessions.length})</span>
            )}
          </TabsTrigger>
          <TabsTrigger value="tout" className="gap-1.5 text-xs md:text-sm">
            <TrendingUp className="w-4 h-4 shrink-0" />
            <span className="truncate">Tout</span>
            {!loading && (examSessions.length + trainSessions.length) > 0 && (
              <span className="ml-0.5 opacity-70">({examSessions.length + trainSessions.length})</span>
            )}
          </TabsTrigger>
        </TabsList>

        {/* Onglet Examens blancs */}
        <TabsContent value="examen_blanc" className="mt-4">
          {loading ? (
            <div className="space-y-3">{[1, 2, 3].map(i => <Skeleton key={i} className="h-24 w-full bg-muted" />)}</div>
          ) : examSessions.length === 0 ? (
            <Card className="h-full">
              <CardContent className="p-12 text-center">
                <Trophy className="w-12 h-12 text-muted-foreground/30 mx-auto mb-4" />
                <p className="text-muted-foreground">Vous n'avez pas encore passé d'examen blanc.</p>
              </CardContent>
            </Card>
          ) : (
            <div className="space-y-3">
              {examSessions.map(s => renderSession(s, 'examen_blanc'))}
            </div>
          )}
        </TabsContent>

        {/* Onglet Entraînements */}
        <TabsContent value="entrainement" className="mt-4">
          {loading ? (
            <div className="space-y-3">{[1, 2, 3].map(i => <Skeleton key={i} className="h-24 w-full bg-muted" />)}</div>
          ) : trainSessions.length === 0 ? (
            <Card className="h-full">
              <CardContent className="p-12 text-center">
                <BookOpen className="w-12 h-12 text-muted-foreground/30 mx-auto mb-4" />
                <p className="text-muted-foreground">Vous n'avez pas encore fait de séance d'entraînement.</p>
              </CardContent>
            </Card>
          ) : (
            <div className="space-y-3">
              {trainSessions.map(s => renderSession(s, 'entrainement'))}
            </div>
          )}
        </TabsContent>

        {/* Onglet Tout (examen blanc + entraînement, triés par date décroissante) */}
        <TabsContent value="tout" className="mt-4">
          {loading ? (
            <div className="space-y-3">{[1, 2, 3].map(i => <Skeleton key={i} className="h-24 w-full bg-muted" />)}</div>
          ) : examSessions.length === 0 && trainSessions.length === 0 ? (
            <Card className="h-full">
              <CardContent className="p-12 text-center">
                <TrendingUp className="w-12 h-12 text-muted-foreground/30 mx-auto mb-4" />
                <p className="text-muted-foreground">Aucune session terminée pour le moment.</p>
              </CardContent>
            </Card>
          ) : (
            <div className="space-y-3">
              {[
                ...examSessions.map(s => ({ session: s, mode: 'examen_blanc' as const })),
                ...trainSessions.map(s => ({ session: s, mode: 'entrainement' as const })),
              ]
                .sort((a, b) => new Date(b.session.created_at).getTime() - new Date(a.session.created_at).getTime())
                .map(({ session, mode }) => renderSession(session, mode))}
            </div>
          )}
        </TabsContent>
      </Tabs>
    </div>
  );
}

