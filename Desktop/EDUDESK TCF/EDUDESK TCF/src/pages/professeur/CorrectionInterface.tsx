import { useState, useEffect, useCallback, useRef } from 'react';
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
import {
  Play, Pause, Loader2, ChevronLeft, CheckCircle, Mic,
  BarChart2, XCircle, FileText, User, Clock, CheckCircle2,
  Volume2, FastForward
} from 'lucide-react';
import { toast } from 'sonner';
import type { Production, Profile, NiveauCECRL } from '@/types/index';
import { pctToCECRL, CECRL_COLORS, CECRL_DESCRIPTIONS } from '@/types/index';
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

function getWordTarget(numTache: number) {
  if (numTache === 1) return { min: 60, max: 120, label: '60 à 120 mots' };
  if (numTache === 2) return { min: 120, max: 150, label: '120 à 150 mots' };
  return { min: 120, max: 180, label: '120 à 180 mots' };
}

function AudioPlayerCorrection({ url, label }: { url: string; label?: string }) {
  const ref = useRef<HTMLAudioElement>(null);
  const [playing, setPlaying] = useState(false);
  const [error, setError] = useState(false);
  const [playbackRate, setPlaybackRate] = useState<number>(1);
  const [duration, setDuration] = useState<number>(0);
  const [currentTime, setCurrentTime] = useState<number>(0);

  const toggleRate = () => {
    const rates = [1, 1.25, 1.5];
    const nextIdx = (rates.indexOf(playbackRate) + 1) % rates.length;
    const nextRate = rates[nextIdx];
    setPlaybackRate(nextRate);
    if (ref.current) ref.current.playbackRate = nextRate;
  };

  const formatTime = (secs: number) => {
    const m = Math.floor(secs / 60);
    const s = Math.floor(secs % 60);
    return `${m}:${s.toString().padStart(2, '0')}`;
  };

  return (
    <div className="flex flex-col gap-2 p-4 bg-muted/60 border border-border rounded-xl">
      <div className="flex items-center gap-3">
        <button
          onClick={() => {
            if (ref.current) {
              playing ? ref.current.pause() : ref.current.play();
              setPlaying(!playing);
            }
          }}
          disabled={error}
          className="w-10 h-10 rounded-full bg-primary flex items-center justify-center text-primary-foreground shrink-0 shadow-sm hover:opacity-90 transition-opacity disabled:opacity-40"
        >
          {playing ? <Pause className="w-5 h-5" /> : <Play className="w-5 h-5 ml-0.5" />}
        </button>

        <div className="flex-1 min-w-0">
          <div className="flex items-center justify-between text-xs text-muted-foreground mb-1">
            <span className="font-medium text-foreground flex items-center gap-1.5">
              <Volume2 className="w-3.5 h-3.5 text-primary" />
              {error ? '⚠ Enregistrement indisponible' : (label || 'Enregistrement audio du candidat')}
            </span>
            <span>
              {formatTime(currentTime)} / {duration > 0 ? formatTime(duration) : '--:--'}
            </span>
          </div>

          <input
            type="range"
            min={0}
            max={duration || 100}
            value={currentTime}
            onChange={e => {
              const val = Number(e.target.value);
              setCurrentTime(val);
              if (ref.current) ref.current.currentTime = val;
            }}
            className="w-full h-1.5 bg-muted-foreground/20 rounded-lg appearance-none cursor-pointer accent-primary"
          />
        </div>

        <Button
          type="button"
          variant="outline"
          size="sm"
          onClick={toggleRate}
          className="h-8 px-2 text-xs font-mono shrink-0 gap-1 border-border"
          title="Modifier la vitesse de lecture"
        >
          <FastForward className="w-3 h-3" />
          {playbackRate}x
        </Button>
      </div>

      <audio
        ref={ref}
        src={url}
        onLoadedMetadata={e => setDuration(e.currentTarget.duration || 0)}
        onTimeUpdate={e => setCurrentTime(e.currentTarget.currentTime || 0)}
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
  const [tache, setTache] = useState<{ consigne: string; duree_secondes: number | null; reference?: string | null } | null>(null);
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [refusing, setRefusing] = useState(false);
  const [raisonRefus, setRaisonRefus] = useState('');
  const [notes, setNotes] = useState<Record<string, number>>({});
  const [commentaire, setCommentaire] = useState('');
  const [sessionProductions, setSessionProductions] = useState<Production[]>([]);
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
      if (prodData?.raison_refus) setRaisonRefus(prodData.raison_refus);

      if (prodData?.epreuve === 'expression_ecrite') {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        setDureeEE((prodData as any).session?.duree_expression_ecrite ?? null);
      }

      // ─── Chargement du sujet exact de la tâche ─────────────────────────────
      if (prodData?.epreuve && prodData?.numero_tache) {
        const epreuve = prodData.epreuve;
        const numTache = prodData.numero_tache;
        const ref = prodData.reference;

        let foundTache: { consigne: string; duree_secondes: number | null; reference?: string | null } | null = null;

        // 1. Chercher par référence dans `taches`
        if (ref) {
          const { data: tByRef } = await supabase
            .from('taches')
            .select('consigne, duree_secondes, reference')
            .eq('epreuve', epreuve)
            .eq('reference', ref)
            .limit(1)
            .maybeSingle();

          if (tByRef?.consigne) {
            foundTache = tByRef;
          } else {
            // Chercher dans `questions` par reference
            const { data: qByRef } = await supabase
              .from('questions')
              .select('texte, reference')
              .eq('epreuve', epreuve)
              .eq('reference', ref)
              .limit(1)
              .maybeSingle();

            if (qByRef?.texte) {
              foundTache = { consigne: qByRef.texte, duree_secondes: null, reference: qByRef.reference || ref };
            }
          }
        }

        // 2. Si non trouvé par référence, chercher par epreuve + numero_tache
        if (!foundTache) {
          const { data: tByNum } = await supabase
            .from('taches')
            .select('consigne, duree_secondes, reference')
            .eq('epreuve', epreuve)
            .eq('numero_tache', numTache)
            .eq('actif', true)
            .limit(1);

          if (Array.isArray(tByNum) && tByNum.length > 0 && tByNum[0].consigne) {
            foundTache = tByNum[0];
          } else {
            const { data: qByNum } = await supabase
              .from('questions')
              .select('texte, reference')
              .eq('epreuve', epreuve)
              .in('tache', [`tache_${numTache}`, String(numTache)])
              .limit(1);

            if (Array.isArray(qByNum) && qByNum.length > 0 && qByNum[0].texte) {
              foundTache = { consigne: qByNum[0].texte, duree_secondes: null, reference: qByNum[0].reference || null };
            }
          }
        }

        // 3. Fallback officiel
        if (!foundTache) {
          if (epreuve === 'expression_ecrite') {
            if (numTache === 1) {
              foundTache = {
                consigne: "Tâche 1 — Rédaction d'un message / courriel (60 à 120 mots)\nRédigez un message court pour transmettre des informations, donner des nouvelles ou inviter une personne.",
                duree_secondes: null,
                reference: ref || 'EE_T1',
              };
            } else if (numTache === 2) {
              foundTache = {
                consigne: "Tâche 2 — Article ou lettre de compte-rendu (120 à 150 mots)\nRacontez une expérience vécue, décrivez un événement et donnez vos impressions ou recommandations.",
                duree_secondes: null,
                reference: ref || 'EE_T2',
              };
            } else {
              foundTache = {
                consigne: "Tâche 3 — Synthèse de deux documents d'opinion et prise de position argumentée (120 à 180 mots)\n1. Première partie : Dégagez le problème commun et présentez les opinions exprimées dans chacun des documents.\n2. Seconde partie : Prenez position sur le sujet en argumentant avec des exemples personnels.",
                duree_secondes: null,
                reference: ref || 'EE_T3',
              };
            }
          } else {
            foundTache = {
              consigne: numTache === 1
                ? "Tâche 1 — Entretien sans préparation (environ 2 minutes)\nPrésentez-vous, parlez de votre quotidien, de vos activités et de vos projets personnels ou professionnels."
                : numTache === 2
                  ? "Tâche 2 — Exercice en interaction (2 min préparation • 3 min 30 échange)\nPosez une dizaine de questions à votre examinateur pour obtenir des renseignements détaillés."
                  : "Tâche 3 — Expression d'un point de vue (environ 4 minutes 30)\nPrésentez votre point de vue argumenté et illustré sur le thème de société proposé.",
              duree_secondes: numTache === 1 ? 120 : numTache === 2 ? 330 : 270,
              reference: ref || `EO_T${numTache}`,
            };
          }
        }

        setTache(foundTache);
      }

      if (prodData?.session_id && prodData?.epreuve) {
        await loadSessionProductions(prodData.session_id, prodData.epreuve);
      }
      setLoading(false);
    };
    load();
  }, [id, loadSessionProductions]);

  /**
   * Recalcul de secours client-side au cas où la RPC n'est pas disponible
   */
  const calculateAndSyncSessionFallback = async (
    sessionId: string,
    currentProdId: string,
    currentStatut: 'corrige' | 'refuse',
    currentScore: number
  ) => {
    try {
      const { data: allProds } = await supabase
        .from('productions')
        .select('id, epreuve, score, statut_correction, numero_tache')
        .eq('session_id', sessionId);

      if (!allProds) return;

      const prodsUpdated = allProds.map(p =>
        p.id === currentProdId ? { ...p, statut_correction: currentStatut, score: currentScore } : p
      );

      const prodsEE = prodsUpdated.filter(p => p.epreuve === 'expression_ecrite');
      const prodsEO = prodsUpdated.filter(p => p.epreuve === 'expression_orale');
      const isDone = (p: { statut_correction: string }) => p.statut_correction === 'corrige' || p.statut_correction === 'refuse';

      const allEEDone = prodsEE.length > 0 && prodsEE.every(isDone);
      const allEODone = prodsEO.length > 0 && prodsEO.every(isDone);

      const sessionUpdate: Record<string, unknown> = {};

      if (allEEDone) {
        const sommeEE = prodsEE.reduce((s, p) => s + (p.score ?? 0), 0);
        const maxEE = MAX_EE * prodsEE.length;
        sessionUpdate.score_expression_ecrite = maxEE > 0 ? Math.round((sommeEE / maxEE) * 699) : 0;
      }

      if (allEODone) {
        const sommeEO = prodsEO.reduce((s, p) => s + (p.score ?? 0), 0);
        const maxEO = MAX_EO * prodsEO.length;
        sessionUpdate.score_expression_orale = maxEO > 0 ? Math.round((sommeEO / maxEO) * 699) : 0;
      }

      const { data: sess } = await supabase
        .from('sessions_examen')
        .select('id, mode, score_oral, score_ecrit, score_expression_ecrite, score_expression_orale')
        .eq('id', sessionId)
        .maybeSingle();

      const expressionProds = prodsUpdated.filter(
        p => p.epreuve === 'expression_ecrite' || p.epreuve === 'expression_orale'
      );
      const toutesExpressionDone = expressionProds.length > 0 && expressionProds.every(isDone);

      if (toutesExpressionDone) {
        const scoreEEFinal = sessionUpdate.score_expression_ecrite ?? sess?.score_expression_ecrite ?? null;
        const scoreEOFinal = sessionUpdate.score_expression_orale ?? sess?.score_expression_orale ?? null;

        const scores: number[] = [];
        if (sess?.score_oral !== null && sess?.score_oral !== undefined) scores.push(sess.score_oral);
        if (sess?.score_ecrit !== null && sess?.score_ecrit !== undefined) scores.push(sess.score_ecrit);
        if (scoreEEFinal !== null && scoreEEFinal !== undefined) scores.push(scoreEEFinal as number);
        if (scoreEOFinal !== null && scoreEOFinal !== undefined) scores.push(scoreEOFinal as number);

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
    } catch (e) {
      console.warn('Fallback calculate session non bloquant:', e);
    }
  };

  const handleSubmit = async () => {
    if (!production || !id) return;
    setSubmitting(true);

    try {
      // 1. Tenter la soumission via la RPC atomique
      const { data: rpcRes, error: rpcErr } = await supabase.rpc('submit_professeur_correction', {
        p_production_id: id,
        p_score: scoreTotal,
        p_grille_notation: notes,
        p_commentaire: commentaire || null,
        p_raison_refus: null,
        p_statut: 'corrige',
      });

      if (!rpcErr && rpcRes?.success) {
        toast.success(
          production.statut_correction === 'corrige'
            ? 'Correction mise à jour avec succès !'
            : 'Correction validée et étudiant notifié !'
        );
        navigate('/professeur/corrections');
        return;
      }

      // 2. Fallback direct si la RPC n'est pas encore enregistrée
      console.warn('RPC submit_professeur_correction indisponible, exécution via fallback direct:', rpcErr);

      const { error: prodUpdateErr } = await supabase.from('productions').update({
        statut_correction: 'corrige',
        score: scoreTotal,
        commentaire: commentaire || null,
        grille_notation: notes,
        raison_refus: null,
        corrige_at: new Date().toISOString(),
        professeur_id: user?.id || production.professeur_id || null,
      }).eq('id', id);

      if (prodUpdateErr) {
        console.error('Erreur sauvegarde production directe:', prodUpdateErr);
        toast.error(prodUpdateErr.message || 'Erreur lors de la soumission de la correction.');
        return;
      }

      if (production.session_id) {
        await calculateAndSyncSessionFallback(production.session_id, id, 'corrige', scoreTotal);
      }

      if (production.etudiant_id) {
        const epreuveLabel = production.epreuve === 'expression_ecrite' ? 'expression écrite' : 'expression orale';
        try {
          await supabase.from('notifications').insert({
            utilisateur_id: production.etudiant_id,
            titre: 'Correction disponible',
            message: `Votre ${epreuveLabel} — Tâche ${production.numero_tache} a été corrigée (${scoreTotal}/${maxTotal} pts).`,
            lien: '/etudiant/historique',
          });
        } catch { /* non-bloquant */ }
      }

      toast.success(
        production.statut_correction === 'corrige'
          ? 'Correction mise à jour avec succès !'
          : 'Correction soumise et étudiant notifié !'
      );
      navigate('/professeur/corrections');
    } catch (err: any) {
      console.error('Exception soumission:', err);
      toast.error(err?.message || 'Erreur lors de la soumission de la correction.');
    } finally {
      setSubmitting(false);
    }
  };

  const handleRefuse = async () => {
    if (!production || !id) return;
    setRefusing(true);

    try {
      // 1. Supprimer l'audio du storage si présent
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

      // 2. Tenter le refus via la RPC atomique
      const { data: rpcRes, error: rpcErr } = await supabase.rpc('submit_professeur_correction', {
        p_production_id: id,
        p_score: 0,
        p_grille_notation: notes,
        p_commentaire: null,
        p_raison_refus: raisonRefus.trim() || 'Production refusée par l\'enseignant.',
        p_statut: 'refuse',
      });

      if (!rpcErr && rpcRes?.success) {
        toast.success('Production refusée — note 0 enregistrée et étudiant notifié.');
        navigate('/professeur/corrections');
        return;
      }

      // 3. Fallback direct
      console.warn('RPC submit_professeur_correction refus indisponible, fallback direct:', rpcErr);

      const { error: prodErr } = await supabase.from('productions').update({
        statut_correction: 'refuse',
        score: 0,
        audio_url: null,
        contenu_texte: null,
        raison_refus: raisonRefus.trim() || null,
        corrige_at: new Date().toISOString(),
        professeur_id: user?.id || production.professeur_id || null,
      }).eq('id', id);

      if (prodErr) {
        console.error('Erreur refus production directe:', prodErr);
        toast.error(prodErr.message || 'Erreur lors du refus.');
        return;
      }

      if (production.session_id) {
        await calculateAndSyncSessionFallback(production.session_id, id, 'refuse', 0);
      }

      if (production.etudiant_id) {
        const epreuveLabel = production.epreuve === 'expression_ecrite' ? 'Expression écrite' : 'Expression orale';
        try {
          await supabase.from('notifications').insert({
            utilisateur_id: production.etudiant_id,
            titre: 'Production refusée — Note 0',
            message: raisonRefus.trim()
              ? `Votre ${epreuveLabel} — Tâche ${production.numero_tache} a été refusée (note : 0/20). Motif : ${raisonRefus.trim()}`
              : `Votre ${epreuveLabel} — Tâche ${production.numero_tache} a été refusée par votre professeur. Note attribuée : 0/20.`,
            lien: '/etudiant/historique',
          });
        } catch { /* non-bloquant */ }
      }

      toast.success('Production refusée — note 0 enregistrée et étudiant notifié.');
      navigate('/professeur/corrections');
    } catch (err: any) {
      console.error('Exception refus:', err);
      toast.error(err?.message || 'Erreur lors du refus.');
    } finally {
      setRefusing(false);
    }
  };

  if (loading) return (
    <div className="max-w-4xl mx-auto space-y-4">
      {[1, 2, 3].map(i => <Skeleton key={i} className="h-24 w-full bg-muted" />)}
    </div>
  );

  if (!production) return (
    <div className="max-w-2xl mx-auto text-center py-12">
      <p className="text-muted-foreground">Production introuvable.</p>
      <Button variant="ghost" asChild className="mt-4"><Link to="/professeur/corrections">Retour aux corrections</Link></Button>
    </div>
  );

  const wordCount = production.contenu_texte
    ? production.contenu_texte.split(/\s+/).filter(Boolean).length
    : 0;

  const targetWords = getWordTarget(production.numero_tache);
  const isWordTargetRespected = wordCount >= targetWords.min && wordCount <= targetWords.max;

  return (
    <div className="max-w-4xl mx-auto space-y-6 fade-in pb-12">
      {/* En-tête avec informations candidat et statut */}
      <div className="flex items-start md:items-center justify-between gap-4 flex-wrap bg-card p-4 rounded-xl border border-border shadow-sm">
        <div className="flex items-center gap-3 min-w-0 flex-1">
          <Button variant="ghost" size="icon" asChild className="shrink-0">
            <Link to="/professeur/corrections"><ChevronLeft className="w-5 h-5" /></Link>
          </Button>
          <div className="min-w-0 flex-1">
            <div className="flex items-center gap-2 flex-wrap">
              <h1 className="text-lg md:text-xl font-bold text-foreground truncate">
                {production.epreuve === 'expression_ecrite' ? 'Expression Écrite' : 'Expression Orale'} — Tâche {production.numero_tache}
              </h1>
              {(production.reference || tache?.reference) && (
                <Badge variant="outline" className="text-xs font-mono font-semibold border-primary/40 bg-primary/5 text-primary">
                  {production.reference || tache?.reference}
                </Badge>
              )}
            </div>

            <div className="flex items-center gap-3 text-xs md:text-sm text-muted-foreground mt-1 flex-wrap">
              <span className="flex items-center gap-1 font-medium text-foreground">
                <User className="w-3.5 h-3.5 text-primary" />
                {etudiant?.prenom} {etudiant?.nom} ({etudiant?.email || 'Étudiant'})
              </span>
              {production.epreuve === 'expression_ecrite' && dureeEE !== null && (
                <span className="inline-flex items-center gap-1 bg-muted px-2 py-0.5 rounded-md font-mono text-xs font-medium text-foreground">
                  <Clock className="w-3 h-3 text-muted-foreground" />
                  Temps passé : {String(Math.floor(dureeEE / 60)).padStart(2, '0')}:{String(dureeEE % 60).padStart(2, '0')}
                </span>
              )}
            </div>
          </div>
        </div>

        <div className="flex items-center gap-2 shrink-0">
          {production.statut_correction === 'corrige' && <Badge className="bg-success text-success-foreground">Corrigé</Badge>}
          {production.statut_correction === 'refuse' && <Badge variant="destructive">Refusé</Badge>}
          {production.statut_correction === 'en_attente' && (
            <Badge variant="outline" className="text-amber-600 border-amber-500/40 bg-amber-500/10">
              En attente de notation
            </Badge>
          )}
        </div>
      </div>

      {/* Sélecteur rapide de tâches de la session */}
      {sessionProductions.length > 1 && (
        <div className="flex items-center gap-2 p-2 bg-muted/40 rounded-lg border border-border overflow-x-auto">
          <span className="text-xs font-medium text-muted-foreground whitespace-nowrap pl-2">
            Tâches de la séance :
          </span>
          <div className="flex items-center gap-1.5 min-w-0">
            {sessionProductions.map(p => {
              const isCurrent = p.id === id;
              const isCorrigee = p.statut_correction === 'corrige';
              const isRefusee = p.statut_correction === 'refuse';
              return (
                <Link
                  key={p.id}
                  to={`/professeur/corrections/${p.id}`}
                  className={cn(
                    'px-3 py-1.5 rounded-md text-xs font-medium transition-colors flex items-center gap-1.5 whitespace-nowrap border',
                    isCurrent
                      ? 'bg-primary text-primary-foreground border-primary shadow-sm'
                      : isCorrigee
                        ? 'bg-success/10 text-success border-success/30 hover:bg-success/20'
                        : isRefusee
                          ? 'bg-destructive/10 text-destructive border-destructive/30 hover:bg-destructive/20'
                          : 'bg-card text-foreground border-border hover:border-primary/40'
                  )}
                >
                  {isCorrigee && <CheckCircle2 className="w-3 h-3" />}
                  {isRefusee && <XCircle className="w-3 h-3" />}
                  Tâche {p.numero_tache}
                  {p.reference && <span className="opacity-70 font-mono text-[10px]">({p.reference})</span>}
                </Link>
              );
            })}
          </div>
        </div>
      )}

      {/* ─── BLOC SUJET ET RÉDACTION / ENREGISTREMENT ─── */}
      <div className="grid grid-cols-1 gap-6">
        {/* 1. SUJET OFFICIEL DE LA TÂCHE */}
        <Card className="border-primary/30 bg-primary/5 shadow-sm overflow-hidden">
          <CardHeader className="pb-3 border-b border-primary/10 bg-primary/10">
            <div className="flex items-center justify-between gap-2 flex-wrap">
              <CardTitle className="text-sm md:text-base font-bold text-primary flex items-center gap-2">
                <FileText className="w-4 h-4 text-primary shrink-0" />
                <span>Sujet de l'épreuve — Tâche {production.numero_tache}</span>
              </CardTitle>

              <div className="flex items-center gap-2">
                {production.epreuve === 'expression_ecrite' ? (
                  <Badge variant="outline" className="text-xs bg-background/80 border-primary/30 text-primary font-medium">
                    Recommandé : {targetWords.label}
                  </Badge>
                ) : (
                  tache?.duree_secondes && (
                    <Badge variant="outline" className="text-xs bg-background/80 border-primary/30 text-primary font-medium">
                      ⏱ {Math.floor(tache.duree_secondes / 60)} min{tache.duree_secondes % 60 > 0 ? ` ${tache.duree_secondes % 60}s` : ''}
                    </Badge>
                  )
                )}
              </div>
            </div>
          </CardHeader>
          <CardContent className="pt-4">
            <div className="text-sm md:text-base text-foreground leading-relaxed whitespace-pre-wrap font-normal select-text">
              {tache?.consigne || "Consigne de la tâche en cours de chargement..."}
            </div>
          </CardContent>
        </Card>

        {/* 2. PRODUCTION DU CANDIDAT (RÉDACTION OU AUDIO) */}
        <Card className="border-border shadow-sm overflow-hidden">
          <CardHeader className="pb-3 border-b border-border bg-muted/30">
            <div className="flex items-center justify-between gap-2 flex-wrap">
              <CardTitle className="text-sm md:text-base font-bold text-foreground flex items-center gap-2">
                {production.epreuve === 'expression_ecrite' ? (
                  <>
                    <FileText className="w-4 h-4 text-primary shrink-0" />
                    <span>Rédaction du candidat</span>
                  </>
                ) : (
                  <>
                    <Mic className="w-4 h-4 text-primary shrink-0" />
                    <span>Enregistrement oral du candidat</span>
                  </>
                )}
              </CardTitle>

              {production.epreuve === 'expression_ecrite' && production.contenu_texte && (
                <div className="flex items-center gap-2">
                  <Badge
                    variant="outline"
                    className={cn(
                      'text-xs font-mono font-medium',
                      isWordTargetRespected
                        ? 'border-success/40 bg-success/10 text-success'
                        : wordCount < targetWords.min
                          ? 'border-amber-500/40 bg-amber-500/10 text-amber-600 dark:text-amber-400'
                          : 'border-blue-500/40 bg-blue-500/10 text-blue-600 dark:text-blue-400'
                    )}
                  >
                    {wordCount} mots {isWordTargetRespected ? '✓ (Dans la cible)' : wordCount < targetWords.min ? `⚠️ (< ${targetWords.min})` : `(> ${targetWords.max})`}
                  </Badge>
                </div>
              )}
            </div>
          </CardHeader>

          <CardContent className="pt-4">
            {/* Audio EO */}
            {production.audio_url && (
              <AudioPlayerCorrection
                url={production.audio_url}
                label={`Tâche ${production.numero_tache} — Expression orale (${etudiant?.prenom || 'Candidat'})`}
              />
            )}

            {/* Texte EE */}
            {production.contenu_texte && (
              <div className="bg-muted/30 rounded-xl p-5 border border-border select-text">
                <p className="text-base text-foreground leading-relaxed whitespace-pre-wrap font-sans font-normal text-pretty">
                  {production.contenu_texte}
                </p>
                <div className="mt-4 pt-3 border-t border-border/60 flex items-center justify-between text-xs text-muted-foreground font-mono">
                  <span>Caractères : {production.contenu_texte.length}</span>
                  <span className={isWordTargetRespected ? "font-semibold text-success" : "font-semibold text-amber-600"}>
                    Total : {wordCount} mot{wordCount > 1 ? 's' : ''} (Cible : {targetWords.label})
                  </span>
                </div>
              </div>
            )}

            {/* Cas sans contenu / audio supprimé / refusé */}
            {!production.audio_url && !production.contenu_texte && production.statut_correction === 'refuse' && (
              <div className="flex items-center gap-3 p-4 bg-destructive/5 border border-destructive/20 rounded-lg">
                <XCircle className="w-5 h-5 text-destructive shrink-0" />
                <div>
                  <p className="text-sm font-medium text-destructive">Cette production a été refusée (Note : 0/20).</p>
                  {production.raison_refus && (
                    <p className="text-xs text-muted-foreground mt-1">Motif : {production.raison_refus}</p>
                  )}
                </div>
              </div>
            )}

            {!production.audio_url && !production.contenu_texte && production.statut_correction === 'corrige' && (
              <div className="flex items-center gap-3 p-4 bg-muted/40 border border-border rounded-lg">
                <Mic className="w-5 h-5 text-muted-foreground shrink-0" />
                <p className="text-sm text-muted-foreground">
                  Enregistrement audio supprimé automatiquement 10 jours après la correction. Les notes et commentaires sont conservés.
                </p>
              </div>
            )}

            {!production.audio_url && !production.contenu_texte && production.statut_correction === 'en_attente' && (
              <div className="flex items-center gap-3 p-4 bg-destructive/5 border border-destructive/20 rounded-lg">
                <Mic className="w-5 h-5 text-destructive shrink-0" />
                <p className="text-sm text-destructive">Aucun contenu ou enregistrement audio transmis pour cette tâche.</p>
              </div>
            )}
          </CardContent>
        </Card>
      </div>

      {/* ─── GRILLE DE NOTATION OFFICIELLE TCF ─── */}
      <Card className="shadow-sm">
        <CardHeader>
          <CardTitle className="text-base flex items-center justify-between flex-wrap gap-2">
            <span>Grille d'évaluation officielle TCF</span>
            <div className="flex items-center gap-2">
              {niveauTache && (
                <Badge style={{ backgroundColor: CECRL_COLORS[niveauTache] }} className="text-white text-xs font-semibold">
                  Niveau {niveauTache} — {CECRL_DESCRIPTIONS[niveauTache]}
                </Badge>
              )}
              <span className="text-sm font-bold text-foreground">{scoreTotal} / {maxTotal}</span>
            </div>
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          {grille.map(item => (
            <div key={item.critere} className="flex items-center gap-3 flex-wrap p-2.5 rounded-lg hover:bg-muted/30 transition-colors border border-transparent hover:border-border">
              <Label className="flex-1 text-sm font-medium min-w-48 text-foreground">
                {item.critere}
              </Label>
              <div className="flex items-center gap-2 shrink-0">
                <Input
                  type="number"
                  min={0}
                  max={item.max}
                  value={notes[item.critere] ?? ''}
                  onChange={e => {
                    const val = e.target.value === '' ? 0 : Math.min(item.max, Math.max(0, Number(e.target.value)));
                    setNotes(prev => ({ ...prev, [item.critere]: val }));
                  }}
                  className="w-16 text-center font-bold font-mono text-base"
                />
                <span className="text-sm text-muted-foreground w-8">/ {item.max}</span>
              </div>
            </div>
          ))}

          <div className="pt-4 border-t border-border flex items-center justify-between gap-3 flex-wrap">
            <div>
              <p className="font-bold text-base text-foreground">Score total de la tâche</p>
              <p className="text-xs text-muted-foreground">Somme des points attribués aux critères</p>
            </div>
            <div className="flex items-center gap-3">
              {niveauTache && (
                <Badge style={{ backgroundColor: CECRL_COLORS[niveauTache] }} className="text-white text-sm px-3 py-1">
                  Niveau {niveauTache}
                </Badge>
              )}
              <span className="font-bold text-2xl text-foreground tabular-nums">
                {scoreTotal} <span className="text-sm text-muted-foreground font-normal">/ {maxTotal}</span>
              </span>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* ─── RÉSULTATS DE LA SÉANCE COMPLETE POUR L'ÉPREUVE ─── */}
      {sessionProductions.length > 0 && (
        <Card className="border-primary/20 bg-primary/3 shadow-sm">
          <CardHeader className="pb-3">
            <CardTitle className="text-base flex items-center gap-2 text-foreground">
              <BarChart2 className="w-4 h-4 text-primary shrink-0" />
              Récapitulatif de la séance — {production?.epreuve === 'expression_ecrite' ? 'Expression Écrite' : 'Expression Orale'}
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            <div className="space-y-2">
              {sessionProductions.map(p => {
                const max = p.epreuve === 'expression_ecrite' ? MAX_EE : MAX_EO;
                const isCurrent = p.id === id;
                const isRefuse = p.statut_correction === 'refuse' && !isCurrent;
                const isCorrigee = p.statut_correction === 'corrige' && p.score !== null;
                const scoreAffiche = isCurrent ? scoreTotal : (p.score ?? 0);
                const niv = (isCorrigee || (isCurrent && Object.keys(notes).length > 0)) && !isRefuse
                  ? tacheToNiveau(scoreAffiche, max)
                  : null;

                return (
                  <div
                    key={p.id}
                    className={cn(
                      'flex items-center justify-between gap-3 p-3 rounded-lg border transition-all',
                      isCurrent ? 'bg-primary/10 border-primary/40 shadow-xs' : 'bg-muted/30 border-border'
                    )}
                  >
                    <div className="flex items-center gap-2 min-w-0">
                      <span className={cn('text-sm font-semibold', isCurrent ? 'text-primary' : 'text-foreground')}>
                        Tâche {p.numero_tache}
                      </span>
                      {isCurrent && <Badge variant="outline" className="text-[10px] text-primary border-primary/40">en cours de notation</Badge>}
                    </div>

                    <div className="flex items-center gap-2 shrink-0">
                      {p.statut_correction === 'refuse' && !isCurrent ? (
                        <Badge variant="destructive" className="text-xs">Refusée (0/{max})</Badge>
                      ) : niv ? (
                        <>
                          <Badge style={{ backgroundColor: CECRL_COLORS[niv] }} className="text-white text-xs">
                            {niv}
                          </Badge>
                          <span className="text-sm font-bold text-foreground tabular-nums">
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

            {/* Cumul de l'épreuve */}
            {(() => {
              const max = production?.epreuve === 'expression_ecrite' ? MAX_EE : MAX_EO;
              const prodsWithScore = sessionProductions.map(p => {
                if (p.id === id) return { ...p, score: scoreTotal, statut_correction: 'corrige' as const };
                return p;
              });
              const terminees = prodsWithScore.filter(p => p.statut_correction === 'corrige' || p.statut_correction === 'refuse');
              if (terminees.length === 0) return null;
              const somme = terminees.reduce((s, p) => s + (p.score ?? 0), 0);
              const maxTotal_ = max * terminees.length;
              const pct = maxTotal_ > 0 ? Math.round((somme / maxTotal_) * 100) : 0;
              const niveauEpreuve = pctToCECRL(pct);
              const toutes = terminees.length === sessionProductions.length;
              return (
                <div className="pt-3 border-t border-border flex items-center justify-between gap-3 flex-wrap">
                  <div>
                    <p className="font-semibold text-sm text-foreground">
                      {toutes ? 'Score total de l\'épreuve' : `Cumul partiel (${terminees.length}/${sessionProductions.length} tâches)`}
                    </p>
                    <p className="text-xs text-muted-foreground">{pct}% de réussite</p>
                  </div>
                  <div className="flex items-center gap-2">
                    <Badge style={{ backgroundColor: CECRL_COLORS[niveauEpreuve] }} className="text-white font-semibold">
                      Niveau {niveauEpreuve} — {CECRL_DESCRIPTIONS[niveauEpreuve]}
                    </Badge>
                    <span className="font-bold text-xl text-foreground tabular-nums">{somme} / {maxTotal_}</span>
                  </div>
                </div>
              );
            })()}
          </CardContent>
        </Card>
      )}

      {/* ─── COMMENTAIRES DU PROFESSEUR ─── */}
      <Card className="shadow-sm">
        <CardHeader className="pb-3">
          <CardTitle className="text-base">Commentaires et conseils personnalisés</CardTitle>
        </CardHeader>
        <CardContent>
          <Textarea
            placeholder="Rédigez vos retours détaillés pour le candidat (points forts, axes d'amélioration, conseils lexicaux et grammaticaux)..."
            className="min-h-32 text-base leading-relaxed"
            value={commentaire}
            onChange={e => setCommentaire(e.target.value)}
          />
        </CardContent>
      </Card>

      {/* ─── ACTIONS : VALIDER OU REFUSER ─── */}
      <div className="flex flex-col sm:flex-row gap-3 pt-2">
        <Button
          size="lg"
          className="flex-1 gap-2 shadow-md"
          onClick={handleSubmit}
          disabled={submitting || refusing}
        >
          {submitting ? (
            <><Loader2 className="w-5 h-5 animate-spin" />Envoi de la correction en cours...</>
          ) : production.statut_correction === 'corrige' ? (
            <><CheckCircle className="w-5 h-5" />Mettre à jour la correction</>
          ) : production.statut_correction === 'refuse' ? (
            <><CheckCircle className="w-5 h-5" />Corriger à nouveau (annuler le refus)</>
          ) : (
            <><CheckCircle className="w-5 h-5" />Valider et envoyer la correction</>
          )}
        </Button>

        {/* Bouton de refus */}
        <AlertDialog>
          <AlertDialogTrigger asChild>
            <Button
              size="lg"
              variant="outline"
              className="gap-2 border-destructive/40 text-destructive hover:bg-destructive/5 hover:text-destructive shrink-0"
              disabled={submitting || refusing}
            >
              <XCircle className="w-5 h-5" />
              {production.statut_correction === 'refuse' ? 'Modifier le refus' : 'Refuser la production (Note 0)'}
            </Button>
          </AlertDialogTrigger>
          <AlertDialogContent className="max-w-[calc(100%-2rem)] md:max-w-lg">
            <AlertDialogHeader>
              <AlertDialogTitle>Refuser la production du candidat</AlertDialogTitle>
              <AlertDialogDescription className="text-pretty">
                La production recevra la note 0. L'enregistrement audio éventuel sera supprimé.
                L'étudiant sera notifié du motif de refus afin de pouvoir recommencer.
              </AlertDialogDescription>
            </AlertDialogHeader>
            <div className="space-y-2 py-2">
              <Label className="text-sm font-medium">Motif du refus (indiqué à l'étudiant)</Label>
              <Textarea
                placeholder="Ex : enregistrement inaudible, sujet hors contexte, texte incomplet..."
                className="min-h-24 text-sm"
                value={raisonRefus}
                onChange={e => setRaisonRefus(e.target.value)}
              />
            </div>
            <AlertDialogFooter>
              <AlertDialogCancel onClick={() => setRaisonRefus(production.raison_refus || '')}>Annuler</AlertDialogCancel>
              <AlertDialogAction
                onClick={handleRefuse}
                className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
              >
                {refusing ? <><Loader2 className="w-4 h-4 animate-spin mr-2" />Refus en cours...</> : 'Confirmer le refus'}
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </div>
  );
}
