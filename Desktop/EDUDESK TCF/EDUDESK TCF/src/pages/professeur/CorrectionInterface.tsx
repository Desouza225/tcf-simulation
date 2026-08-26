import { useState, useEffect, useCallback } from 'react';
import { Link, useParams, useNavigate } from 'react-router-dom';
import { supabase } from '@/db/supabase';
import { useAuth } from '@/contexts/AuthContext';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Textarea } from '@/components/ui/textarea';
import { Label } from '@/components/ui/label';
import { Input } from '@/components/ui/input';
import { Skeleton } from '@/components/ui/skeleton';
import {
  AlertDialog, AlertDialogAction, AlertDialogCancel,
  AlertDialogContent, AlertDialogDescription, AlertDialogFooter,
  AlertDialogHeader, AlertDialogTitle, AlertDialogTrigger,
} from '@/components/ui/alert-dialog';
import { Play, Pause, Loader2, ChevronLeft, CheckCircle, Mic, BarChart2, XCircle, FileText } from 'lucide-react';
import { toast } from 'sonner';
import type { Production, Profile, NiveauCECRL } from '@/types/index';
import { pctToCECRL, CECRL_COLORS, CECRL_DESCRIPTIONS } from '@/types/index';
import { useRef } from 'react';
import { cn } from '@/lib/utils';

// Max points par grille (TCF officiel)
const MAX_EE = 20; // 4+4+4+8
const MAX_EO = 18; // 3+3+3+3+3+3

function scoreToNiveau(score: number): NiveauCECRL {
  if (score >= 549) return 'C2';
  if (score >= 499) return 'C1';
  if (score >= 406) return 'B2';
  if (score >= 301) return 'B1';
  if (score >= 226) return 'A2';
  return 'A1';
}

/** Convertit un score brut de tâche en niveau CECRL */
function tacheToNiveau(score: number, max: number): NiveauCECRL {
  return pctToCECRL(Math.round((score / max) * 100));
}

// Grille de notation TCF officielle
const GRILLE_EXPRESSION_ECRITE = [
  { critere: 'Adéquation de la production', max: 4 },
  { critere: 'Capacité à interagir', max: 4 },
  { critere: 'Cohérence et cohésion', max: 4 },
  { critere: 'Compétence linguistique', max: 8 },
];
const GRILLE_EXPRESSION_ORALE = [
  { critere: 'Capacité à interagir', max: 3 },
  { critere: 'Cohérence du discours', max: 3 },
  { critere: 'Compétence sociolinguistique', max: 3 },
  { critere: 'Étendue du vocabulaire', max: 3 },
  { critere: 'Maîtrise du vocabulaire', max: 3 },
  { critere: 'Maîtrise des structures grammaticales', max: 3 },
];

function AudioPlayerCorrection({ url, label }: { url: string; label?: string }) {
  const ref = useRef<HTMLAudioElement>(null);
  const [playing, setPlaying] = useState(false);
  const [error, setError] = useState(false);
  return (
    <div className="flex items-center gap-3 p-3 bg-muted rounded-lg">
      <button
        onClick={() => {
          if (ref.current) {
            playing ? ref.current.pause() : ref.current.play();
            setPlaying(!playing);
          }
        }}
        disabled={error}
        className="w-9 h-9 rounded-full bg-primary flex items-center justify-center text-primary-foreground shrink-0 disabled:opacity-40"
      >
        {playing ? <Pause className="w-4 h-4" /> : <Play className="w-4 h-4" />}
      </button>
      <span className="text-sm text-muted-foreground flex-1">
        {error ? '⚠ Enregistrement indisponible' : (label || 'Écouter l\'enregistrement audio')}
      </span>
      <audio
        ref={ref}
        src={url}
        onEnded={() => setPlaying(false)}
        onError={() => { setError(true); setPlaying(false); }}
      />
    </div>
  );
}

export default function CorrectionInterface() {
  const { id } = useParams<{ id: string }>();
  const { user } = useAuth();
  const navigate = useNavigate();
  const [production, setProduction] = useState<Production | null>(null);
  const [etudiant, setEtudiant] = useState<Profile | null>(null);
  const [tache, setTache] = useState<{ consigne: string; duree_secondes: number | null } | null>(null);
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [refusing, setRefusing] = useState(false);
  const [raisonRefus, setRaisonRefus] = useState('');
  const [notes, setNotes] = useState<Record<string, number>>({});
  const [commentaire, setCommentaire] = useState('');
  const [sessionProductions, setSessionProductions] = useState<Production[]>([]);
  // Durée EE récupérée directement via la jointure session (évite une requête RLS séparée)
  const [dureeEE, setDureeEE] = useState<number | null>(null);

  const grille = production?.epreuve === 'expression_ecrite' ? GRILLE_EXPRESSION_ECRITE : GRILLE_EXPRESSION_ORALE;
  const maxTotal = grille.reduce((a, b) => a + b.max, 0);
  const scoreTotal = Object.values(notes).reduce((a, b) => a + b, 0);
  const niveauTache: NiveauCECRL | null = Object.keys(notes).length > 0 ? tacheToNiveau(scoreTotal, maxTotal) : null;

  const loadSessionProductions = useCallback(async (sessionId: string, epreuve: string) => {
    const { data } = await supabase
      .from('productions')
      .select('*')
      .eq('session_id', sessionId)
      .eq('epreuve', epreuve)
      .order('numero_tache');
    setSessionProductions(Array.isArray(data) ? data : []);
  }, []);

  useEffect(() => {
    if (!id) return;
    const load = async () => {
      // Joindre la session directement pour récupérer duree_expression_ecrite
      let prodData: any = null;
      const { data: prod, error: prodErr } = await supabase
        .from('productions')
        .select('*, etudiant:profiles!etudiant_id(*), session:sessions_examen!session_id(id, created_at, mode, duree_expression_ecrite)')
        .eq('id', id)
        .maybeSingle();

      if (prodErr || !prod) {
        const { data: rawProd } = await supabase
          .from('productions')
          .select('*')
          .eq('id', id)
          .maybeSingle();
        if (rawProd) {
          const [etudRes, sessRes] = await Promise.all([
            rawProd.etudiant_id ? supabase.from('profiles').select('*').eq('id', rawProd.etudiant_id).maybeSingle() : Promise.resolve({ data: null }),
            rawProd.session_id ? supabase.from('sessions_examen').select('id, created_at, mode, duree_expression_ecrite').eq('id', rawProd.session_id).maybeSingle() : Promise.resolve({ data: null }),
          ]);
          prodData = {
            ...rawProd,
            etudiant: etudRes.data,
            session: sessRes.data,
          };
        }
      } else {
        prodData = prod;
      }

      setProduction(prodData);
      if (prodData?.etudiant) setEtudiant(prodData.etudiant as unknown as Profile);
      if (prodData?.grille_notation) setNotes(prodData.grille_notation as Record<string, number>);
      if (prodData?.commentaire) setCommentaire(prodData.commentaire);

      // Durée EE récupérée via la jointure
      if (prodData?.epreuve === 'expression_ecrite') {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        setDureeEE((prodData as any).session?.duree_expression_ecrite ?? null);
      }

      // Charger la consigne de la tâche en parallèle
      if (prod?.epreuve && prod?.numero_tache) {
        supabase
          .from('taches')
          .select('consigne, duree_secondes, reference')
          .eq('epreuve', prod.epreuve)
          .eq('numero_tache', prod.numero_tache)
          .eq('actif', true)
          .maybeSingle()
          .then(({ data: t }) => setTache(t));
      }

      // Session productions en parallèle dès qu'on a session_id + epreuve
      if (prod?.session_id && prod?.epreuve) {
        await loadSessionProductions(prod.session_id, prod.epreuve);
      }
      setLoading(false);
    };
    load();
  }, [id, loadSessionProductions]);

  const handleSubmit = async () => {
    if (!production || !id) return;
    setSubmitting(true);

    // 1. Sauvegarder la correction sur la production
    const { error } = await supabase.from('productions').update({
      statut_correction: 'corrige',
      score: scoreTotal,
      commentaire: commentaire || null,
      grille_notation: notes,
      corrige_at: new Date().toISOString(),
    }).eq('id', id);

    if (error) {
      toast.error('Erreur lors de la soumission. Veuillez réessayer.');
      setSubmitting(false);
      return;
    }

    // 2. Récupérer toutes les productions de cette session pour vérifier si tout est corrigé
    const sessionId = production.session_id;
    const { data: allProds } = await supabase
      .from('productions')
      .select('id, epreuve, score, statut_correction, numero_tache')
      .eq('session_id', sessionId);

    const prods = Array.isArray(allProds) ? allProds : [];

    // Marquer la production courante comme corrigée localement pour le calcul
    const prodsUpdated = prods.map(p => p.id === id ? { ...p, statut_correction: 'corrige', score: scoreTotal } : p);

    // Seules les productions d'expression (EE / EO) nécessitent une correction professeur ;
    // les productions QCM (compréhension) sont notées automatiquement et n'ont pas de professeur_id.
    const expressionProds = prodsUpdated.filter(
      p => p.epreuve === 'expression_ecrite' || p.epreuve === 'expression_orale'
    );
    const toutesCorigees = expressionProds.length > 0 && expressionProds.every(p => p.statut_correction === 'corrige');

    // 3. Agréger les scores par épreuve et mettre à jour sessions_examen
    const prodsEE = prodsUpdated.filter(p => p.epreuve === 'expression_ecrite');
    const prodsEO = prodsUpdated.filter(p => p.epreuve === 'expression_orale');

    const allEECorrigees = prodsEE.length > 0 && prodsEE.every(p => p.statut_correction === 'corrige');
    const allEOCorrigees = prodsEO.length > 0 && prodsEO.every(p => p.statut_correction === 'corrige');

    const sessionUpdate: Record<string, unknown> = {};

    if (allEECorrigees && prodsEE.length > 0) {
      const sommeEE = prodsEE.reduce((s, p) => s + (p.score ?? 0), 0);
      const maxEE = MAX_EE * prodsEE.length;
      sessionUpdate.score_expression_ecrite = Math.round((sommeEE / maxEE) * 699);
    }
    if (allEOCorrigees && prodsEO.length > 0) {
      const sommeEO = prodsEO.reduce((s, p) => s + (p.score ?? 0), 0);
      const maxEO = MAX_EO * prodsEO.length;
      sessionUpdate.score_expression_orale = Math.round((sommeEO / maxEO) * 699);
    }

    if (toutesCorigees) {
      // Récupérer les scores auto (oral/écrit QCM) depuis sessions_examen
      const { data: sess } = await supabase
        .from('sessions_examen')
        .select('score_oral, score_ecrit')
        .eq('id', sessionId)
        .maybeSingle();

      const scores: number[] = [];
      if (sess?.score_oral !== null && sess?.score_oral !== undefined) scores.push(sess.score_oral);
      if (sess?.score_ecrit !== null && sess?.score_ecrit !== undefined) scores.push(sess.score_ecrit);
      if (sessionUpdate.score_expression_ecrite !== undefined) scores.push(sessionUpdate.score_expression_ecrite as number);
      if (sessionUpdate.score_expression_orale !== undefined) scores.push(sessionUpdate.score_expression_orale as number);

      if (scores.length > 0) {
        const scoreGlobal = Math.round(scores.reduce((a, b) => a + b, 0) / scores.length);
        sessionUpdate.score_global = scoreGlobal;
        sessionUpdate.niveau_cecrl = scoreToNiveau(scoreGlobal);
      }
      sessionUpdate.correction_complete = true;
    }

    if (Object.keys(sessionUpdate).length > 0) {
      await supabase.from('sessions_examen').update(sessionUpdate).eq('id', sessionId);
    }

    // 4. Notifier l'étudiant
    if (production.etudiant_id) {
      await supabase.from('notifications').insert({
        utilisateur_id: production.etudiant_id,
        titre: 'Correction disponible',
        message: toutesCorigees
          ? `Toutes vos productions ont été corrigées. Consultez vos résultats dans l'historique.`
          : `Votre ${production.epreuve === 'expression_ecrite' ? 'expression écrite' : 'expression orale'} — Tâche ${production.numero_tache} a été corrigée.`,
        lien: '/etudiant/historique',
      });
    }

    toast.success('Correction soumise et étudiant notifié !');
    await loadSessionProductions(production.session_id, production.epreuve);
    navigate('/professeur/corrections');
  };

  // Refus de correction : marque la production comme refusée, supprime l'audio et notifie l'étudiant
  const handleRefuse = async () => {
    if (!production || !id) return;
    setRefusing(true);

    // Supprimer l'audio du storage si présent
    if (production.audio_url) {
      try {
        const url = new URL(production.audio_url);
        const marker = '/productions-audio/';
        const idx = url.pathname.indexOf(marker);
        if (idx !== -1) {
          const path = url.pathname.slice(idx + marker.length);
          await supabase.storage.from('productions-audio').remove([path]);
        }
      } catch { /* URL invalide, on ignore */ }
    }

    // Marquer comme refusée avec score=0 (compté comme corrigé dans la session)
    const { error } = await supabase.from('productions').update({
      statut_correction: 'refuse',
      score: 0,
      audio_url: null,
      contenu_texte: null,
      raison_refus: raisonRefus.trim() || null,
      corrige_at: new Date().toISOString(),
    }).eq('id', id);

    if (error) {
      toast.error('Erreur lors du refus. Veuillez réessayer.');
      setRefusing(false);
      return;
    }

    // Vérifier si toutes les productions de la session sont corrigées/refusées
    const sessionId = production.session_id;
    const { data: allProds } = await supabase
      .from('productions')
      .select('id, epreuve, score, statut_correction, numero_tache')
      .eq('session_id', sessionId);

    if (allProds) {
      const done = allProds.every(p => p.statut_correction === 'corrige' || p.statut_correction === 'refuse');
      if (done) {
        const eeProds = allProds.filter(p => p.epreuve === 'expression_ecrite');
        const eoProds = allProds.filter(p => p.epreuve === 'expression_orale');
        const scoreEE = eeProds.length > 0 ? Math.round(eeProds.reduce((s, p) => s + (p.score ?? 0), 0) / eeProds.length) : null;
        const scoreEO = eoProds.length > 0 ? Math.round(eoProds.reduce((s, p) => s + (p.score ?? 0), 0) / eoProds.length) : null;
        await supabase.from('sessions_examen').update({
          score_expression_ecrite: scoreEE,
          score_expression_orale: scoreEO,
          correction_complete: true,
        }).eq('id', sessionId);
      }
    }

    // Notifier l'étudiant
    if (production.etudiant_id) {
      const epreuveLabel = production.epreuve === 'expression_ecrite' ? 'Expression écrite' : 'Expression orale';
      await supabase.from('notifications').insert({
        utilisateur_id: production.etudiant_id,
        titre: 'Production refusée — Note 0',
        message: raisonRefus.trim()
          ? `Votre ${epreuveLabel} — Tâche ${production.numero_tache} a été refusée (note : 0/20). Motif : ${raisonRefus.trim()}`
          : `Votre ${epreuveLabel} — Tâche ${production.numero_tache} a été refusée par votre professeur. Note attribuée : 0/20.`,
        lien: '/etudiant/historique',
      });
    }

    toast.success('Production refusée — note 0 attribuée et étudiant notifié.');
    navigate('/professeur/corrections');
  };

  if (loading) return (
    <div className="max-w-2xl mx-auto space-y-4">
      {[1,2,3].map(i => <Skeleton key={i} className="h-20 w-full bg-muted" />)}
    </div>
  );

  if (!production) return (
    <div className="max-w-2xl mx-auto text-center py-12">
      <p className="text-muted-foreground">Production introuvable.</p>
      <Button variant="ghost" asChild className="mt-4"><Link to="/professeur/corrections">Retour</Link></Button>
    </div>
  );

  return (
    <div className="max-w-3xl mx-auto space-y-6 fade-in">
      <div className="flex items-center gap-3">
        <Button variant="ghost" size="icon" asChild>
          <Link to="/professeur/corrections"><ChevronLeft className="w-5 h-5" /></Link>
        </Button>
        <div className="min-w-0">
          <h1 className="text-xl font-bold text-foreground text-balance">
            Correction — {production.epreuve === 'expression_ecrite' ? 'Expression écrite' : 'Expression orale'} Tâche {production.numero_tache}
          </h1>
          <p className="text-sm text-muted-foreground">
            Étudiant : {etudiant?.prenom} {etudiant?.nom}
          </p>
          {production.epreuve === 'expression_ecrite' && dureeEE !== null && (
            <div className="flex items-center gap-1.5 mt-1">
              <span className="inline-flex items-center gap-1.5 text-xs bg-muted border border-border px-2.5 py-1 rounded-full font-mono font-medium text-foreground">
                ⏱ Temps passé sur l'épreuve&nbsp;:{' '}
                <strong>{String(Math.floor(dureeEE / 60)).padStart(2, '0')}:{String(dureeEE % 60).padStart(2, '0')}</strong>
              </span>
            </div>
          )}
        </div>
        {production.statut_correction === 'corrige' && <Badge className="bg-success text-success-foreground shrink-0">Corrigé</Badge>}
      </div>

      {/* Sujet de la tâche */}
      {tache && (
        <Card className="h-full border-primary/20 bg-primary/5">
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-semibold text-primary flex items-center gap-2 flex-wrap">
              <FileText className="w-4 h-4 shrink-0" />
              <span>Sujet — Tâche {production.numero_tache}</span>
              {(production.reference || tache.reference) && (
                <Badge variant="outline" className="text-xs font-mono font-medium border-primary/40 bg-primary/10 text-primary">
                  Réf : {production.reference || tache.reference}
                </Badge>
              )}
              {tache.duree_secondes && (
                <span className="ml-auto text-xs font-normal text-muted-foreground">
                  {Math.floor(tache.duree_secondes / 60)} min
                  {tache.duree_secondes % 60 > 0 ? ` ${tache.duree_secondes % 60}s` : ''}
                </span>
              )}
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-sm text-foreground leading-relaxed text-pretty whitespace-pre-wrap">{tache.consigne}</p>
          </CardContent>
        </Card>
      )}

      {/* Production de l'étudiant */}
      <Card className="h-full">
        <CardHeader><CardTitle className="text-base text-balance">Production de l'étudiant</CardTitle></CardHeader>
        <CardContent>
          {production.audio_url && (
            <AudioPlayerCorrection
              url={production.audio_url}
              label={`Tâche ${production.numero_tache} — Expression orale`}
            />
          )}
          {production.contenu_texte && (
            <div className="bg-muted/50 rounded-lg p-4 space-y-2">
              <p className="text-sm text-foreground whitespace-pre-wrap text-pretty leading-relaxed">{production.contenu_texte}</p>
              <p className="text-xs text-muted-foreground text-right font-mono">
                {production.contenu_texte.split(/\s+/).filter(Boolean).length} mots
              </p>
            </div>
          )}
          {!production.audio_url && !production.contenu_texte && production.statut_correction === 'corrige' && (
            <div className="flex items-center gap-3 p-4 bg-muted/40 border border-border rounded-lg">
              <Mic className="w-5 h-5 text-muted-foreground shrink-0" />
              <p className="text-sm text-muted-foreground text-pretty">
                Enregistrement audio supprimé automatiquement 10 jours après la correction. Les notes et commentaires sont conservés.
              </p>
            </div>
          )}
          {!production.audio_url && !production.contenu_texte && production.statut_correction !== 'corrige' && (
            <div className="flex items-center gap-3 p-4 bg-destructive/5 border border-destructive/20 rounded-lg">
              <Mic className="w-5 h-5 text-destructive shrink-0" />
              <p className="text-sm text-destructive">Aucun enregistrement disponible pour cette tâche.</p>
            </div>
          )}
        </CardContent>
      </Card>

      {/* Grille de notation */}
      <Card className="h-full">
        <CardHeader>
          <CardTitle className="text-base flex items-center justify-between">
            <span className="text-balance">Grille de notation officielle TCF</span>
            <div className="flex items-center gap-2">
              {niveauTache && (
                <Badge style={{ backgroundColor: CECRL_COLORS[niveauTache] }} className="text-white text-xs">
                  {niveauTache} — {CECRL_DESCRIPTIONS[niveauTache]}
                </Badge>
              )}
              <span className="text-sm font-normal text-muted-foreground">{scoreTotal}/{maxTotal}</span>
            </div>
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          {grille.map(item => (
            <div key={item.critere} className="flex items-center gap-3 flex-wrap">
              <Label className="flex-1 text-sm font-normal min-w-48 text-balance">{item.critere}</Label>
              <div className="flex items-center gap-2 shrink-0">
                <Input
                  type="number"
                  min={0}
                  max={item.max}
                  value={notes[item.critere] ?? ''}
                  onChange={e => setNotes(prev => ({ ...prev, [item.critere]: Math.min(item.max, Math.max(0, Number(e.target.value))) }))}
                  className="w-16 text-center"
                />
                <span className="text-sm text-muted-foreground">/ {item.max}</span>
              </div>
            </div>
          ))}
          <div className="pt-3 border-t border-border flex items-center justify-between gap-3 flex-wrap">
            <span className="font-semibold text-foreground">Score total de la tâche</span>
            <div className="flex items-center gap-2">
              {niveauTache && (
                <Badge style={{ backgroundColor: CECRL_COLORS[niveauTache] }} className="text-white">
                  Niveau {niveauTache}
                </Badge>
              )}
              <span className="font-bold text-lg text-foreground">{scoreTotal} / {maxTotal}</span>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Récapitulatif de la séance pour cette épreuve */}
      {sessionProductions.length > 0 && (
        <Card className="h-full border-primary/20 bg-primary/3">
          <CardHeader>
            <CardTitle className="text-base flex items-center gap-2 text-balance">
              <BarChart2 className="w-4 h-4 text-primary shrink-0" />
              Résultats de la séance — {production?.epreuve === 'expression_ecrite' ? 'Expression Écrite' : 'Expression Orale'}
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            {/* Détail par tâche */}
            <div className="space-y-2">
              {sessionProductions.map(p => {
                const max = p.epreuve === 'expression_ecrite' ? MAX_EE : MAX_EO;
                const corrigee = p.statut_correction === 'corrige' && p.score !== null;
                // Utilise le score en cours si c'est la tâche courante et non encore sauvegardée
                const scoreAffiche = p.id === id && !corrigee ? scoreTotal : (p.score ?? null);
                const niv = corrigee || (p.id === id && Object.keys(notes).length > 0)
                  ? tacheToNiveau(scoreAffiche ?? 0, max)
                  : null;
                return (
                  <div key={p.id} className={cn(
                    'flex items-center justify-between gap-3 p-3 rounded-lg border',
                    p.id === id ? 'bg-primary/5 border-primary/30' : 'bg-muted/30 border-border'
                  )}>
                    <div className="flex items-center gap-2 min-w-0">
                      <span className={cn('text-sm font-medium', p.id === id ? 'text-primary' : 'text-foreground')}>
                        Tâche {p.numero_tache}
                      </span>
                      {p.id === id && <Badge variant="outline" className="text-xs text-primary border-primary/40">en cours</Badge>}
                    </div>
                    <div className="flex items-center gap-2 shrink-0">
                      {niv ? (
                        <>
                          <Badge style={{ backgroundColor: CECRL_COLORS[niv] }} className="text-white text-xs">
                            {niv}
                          </Badge>
                          <span className="text-sm font-semibold text-foreground">
                            {scoreAffiche} / {max}
                          </span>
                        </>
                      ) : (
                        <span className="text-xs text-muted-foreground italic">En attente</span>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>

            {/* Total de l'épreuve */}
            {(() => {
              const max = production?.epreuve === 'expression_ecrite' ? MAX_EE : MAX_EO;
              const prodsWithScore = sessionProductions.map(p => {
                if (p.id === id) return { ...p, score: scoreTotal, statut_correction: 'corrige' };
                return p;
              });
              const corrigees = prodsWithScore.filter(p => p.statut_correction === 'corrige' && p.score !== null);
              if (corrigees.length === 0) return null;
              const somme = corrigees.reduce((s, p) => s + (p.score ?? 0), 0);
              const maxTotal_ = max * corrigees.length;
              const pct = Math.round((somme / maxTotal_) * 100);
              const niveauEpreuve = pctToCECRL(pct);
              const toutes = corrigees.length === sessionProductions.length;
              return (
                <div className="pt-2 border-t border-border flex items-center justify-between gap-3 flex-wrap">
                  <div>
                    <p className="font-semibold text-sm text-foreground">
                      {toutes ? 'Score total de l\'épreuve' : `Cumul (${corrigees.length}/${sessionProductions.length} tâches)`}
                    </p>
                    <p className="text-xs text-muted-foreground">{pct}% de réussite</p>
                  </div>
                  <div className="flex items-center gap-2">
                    <Badge style={{ backgroundColor: CECRL_COLORS[niveauEpreuve] }} className="text-white">
                      Niveau {niveauEpreuve} — {CECRL_DESCRIPTIONS[niveauEpreuve]}
                    </Badge>
                    <span className="font-bold text-lg text-foreground">{somme} / {maxTotal_}</span>
                  </div>
                </div>
              );
            })()}
          </CardContent>
        </Card>
      )}

      {/* Commentaire */}
      <Card className="h-full">
        <CardHeader><CardTitle className="text-base text-balance">Commentaires et retours</CardTitle></CardHeader>
        <CardContent>
          <Textarea
            placeholder="Rédigez vos commentaires pour l'étudiant (points forts, axes d'amélioration, conseils...)."
            className="min-h-32 text-base"
            value={commentaire}
            onChange={e => setCommentaire(e.target.value)}
          />
        </CardContent>
      </Card>

      {/* Actions finales : Valider ou Refuser */}
      <div className="flex flex-col gap-3">
        <Button className="w-full" onClick={handleSubmit}
          disabled={submitting || refusing || production.statut_correction === 'corrige' || production.statut_correction === 'refuse'}>
          {submitting ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" />Envoi...</>
            : production.statut_correction === 'corrige' ? <><CheckCircle className="w-4 h-4 mr-2" />Déjà corrigé</>
            : production.statut_correction === 'refuse' ? <><XCircle className="w-4 h-4 mr-2" />Production refusée</>
            : 'Valider et envoyer la correction'}
        </Button>

        {/* Bouton refus — uniquement pour les productions en attente */}
        {production.statut_correction === 'en_attente' && (
          <AlertDialog>
            <AlertDialogTrigger asChild>
              <Button variant="outline" className="w-full gap-2 border-destructive/40 text-destructive hover:bg-destructive/5 hover:text-destructive"
                disabled={submitting || refusing}>
                <XCircle className="w-4 h-4" />Refuser cette production
              </Button>
            </AlertDialogTrigger>
            <AlertDialogContent className="max-w-[calc(100%-2rem)] md:max-w-lg">
              <AlertDialogHeader>
                <AlertDialogTitle>Refuser la production</AlertDialogTitle>
                <AlertDialogDescription className="text-pretty">
                  La production sera marquée comme refusée, l'enregistrement audio et le contenu texte seront supprimés.
                  L'étudiant sera notifié du refus et pourra soumettre une nouvelle production.
                </AlertDialogDescription>
              </AlertDialogHeader>
              <div className="space-y-2 py-2">
                <Label className="text-sm font-normal">Motif du refus (optionnel)</Label>
                <Textarea
                  placeholder="Ex : enregistrement inaudible, sujet hors contexte, contenu inapproprié…"
                  className="min-h-20 text-sm"
                  value={raisonRefus}
                  onChange={e => setRaisonRefus(e.target.value)}
                />
              </div>
              <AlertDialogFooter>
                <AlertDialogCancel onClick={() => setRaisonRefus('')}>Annuler</AlertDialogCancel>
                <AlertDialogAction
                  onClick={handleRefuse}
                  className="bg-destructive text-destructive-foreground hover:bg-destructive/90">
                  {refusing ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" />Refus en cours…</> : 'Confirmer le refus'}
                </AlertDialogAction>
              </AlertDialogFooter>
            </AlertDialogContent>
          </AlertDialog>
        )}
      </div>
    </div>
  );
}
