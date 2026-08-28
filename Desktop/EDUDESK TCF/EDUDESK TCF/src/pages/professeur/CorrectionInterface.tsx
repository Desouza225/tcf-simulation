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
  const [tache, setTache] = useState<{ consigne: string; duree_secondes: number | null; reference?: string | null } | null>(null);
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

      // Durée EE récupérée via la jointure
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

        // 1. Si une référence existe, chercher d'abord par référence dans `taches`
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

        // 2. Si non trouvé par référence, chercher dans `taches` par epreuve + numero_tache
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
            // Fallback dans `questions`
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

        // 3. Fallback avec consigne type officielle TCF si rien n'est trouvé
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
              consigne: `Tâche ${numTache} — Expression orale\nPrésentez votre point de vue et argumentez à l'oral sur le sujet proposé.`,
              duree_secondes: numTache === 1 ? 120 : 270,
              reference: ref || `EO_T${numTache}`,
            };
          }
        }

        setTache(foundTache);
      }

      // Session productions en parallèle dès qu'on a session_id + epreuve
      if (prodData?.session_id && prodData?.epreuve) {
        await loadSessionProductions(prodData.session_id, prodData.epreuve);
      }
      setLoading(false);
    };
    load();
  }, [id, loadSessionProductions]);

  /**
   * Recalcule et synchronise les scores globaux et par épreuve de la session.
   * Gère de manière cohérente les tâches 'corrige' ET 'refuse' (note 0).
   */
  const calculateAndSyncSession = async (
    sessionId: string,
    currentProdId: string,
    currentStatut: 'corrige' | 'refuse',
    currentScore: number
  ) => {
    const { data: allProds, error: prodsErr } = await supabase
      .from('productions')
      .select('id, epreuve, score, statut_correction, numero_tache')
      .eq('session_id', sessionId);

    if (prodsErr || !allProds) {
      console.error('Erreur récupération productions session:', prodsErr);
      return;
    }

    // Prods mises à jour en mémoire avec la production courante
    const prodsUpdated = allProds.map(p =>
      p.id === currentProdId ? { ...p, statut_correction: currentStatut, score: currentScore } : p
    );

    const prodsEE = prodsUpdated.filter(p => p.epreuve === 'expression_ecrite');
    const prodsEO = prodsUpdated.filter(p => p.epreuve === 'expression_orale');

    // Une tâche est considérée terminée si elle est corrigée ou refusée (note 0)
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

    // Récupérer la session existante pour les scores QCM (oral / écrit) et scores existants
    const { data: sess } = await supabase
      .from('sessions_examen')
      .select('id, mode, score_oral, score_ecrit, score_expression_ecrite, score_expression_orale')
      .eq('id', sessionId)
      .maybeSingle();

    // Vérifier si toutes les productions d'expression nécessaires sont terminées
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
      const { error: sessUpdateErr } = await supabase
        .from('sessions_examen')
        .update(sessionUpdate)
        .eq('id', sessionId);

      if (sessUpdateErr) {
        console.error('Erreur mise à jour session:', sessUpdateErr);
      }
    }
  };

  const handleSubmit = async () => {
    if (!production || !id) return;
    setSubmitting(true);

    try {
      // 1. Sauvegarder la correction sur la production
      const { error } = await supabase.from('productions').update({
        statut_correction: 'corrige',
        score: scoreTotal,
        commentaire: commentaire || null,
        grille_notation: notes,
        raison_refus: null,
        corrige_at: new Date().toISOString(),
      }).eq('id', id);

      if (error) {
        console.error('Erreur sauvegarde production:', error);
        toast.error(error.message || 'Erreur lors de la soumission. Veuillez réessayer.');
        setSubmitting(false);
        return;
      }

      // 2. Mettre à jour la session avec recalcul complet
      const sessionId = production.session_id;
      if (sessionId) {
        await calculateAndSyncSession(sessionId, id, 'corrige', scoreTotal);
      }

      // 3. Notifier l'étudiant
      if (production.etudiant_id) {
        const epreuveLabel = production.epreuve === 'expression_ecrite' ? 'expression écrite' : 'expression orale';
        try {
          await supabase.from('notifications').insert({
            utilisateur_id: production.etudiant_id,
            titre: 'Correction disponible',
            message: `Votre ${epreuveLabel} — Tâche ${production.numero_tache} a été corrigée (${scoreTotal}/${maxTotal} pts).`,
            lien: '/etudiant/historique',
          });
        } catch { /* Notification non-bloquante */ }
      }

      toast.success(
        production.statut_correction === 'corrige'
          ? 'Correction mise à jour avec succès !'
          : 'Correction soumise et étudiant notifié !'
      );
      if (production.session_id && production.epreuve) {
        await loadSessionProductions(production.session_id, production.epreuve);
      }
      navigate('/professeur/corrections');
    } catch (err: any) {
      console.error('Exception soumission:', err);
      toast.error(err?.message || 'Erreur lors de la soumission de la correction.');
    } finally {
      setSubmitting(false);
    }
  };

  // Refus de correction : marque la production comme refusée, supprime l'audio et notifie l'étudiant
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

      // 2. Marquer comme refusée avec score=0
      const { error } = await supabase.from('productions').update({
        statut_correction: 'refuse',
        score: 0,
        audio_url: null,
        contenu_texte: null,
        raison_refus: raisonRefus.trim() || null,
        corrige_at: new Date().toISOString(),
      }).eq('id', id);

      if (error) {
        console.error('Erreur refus production:', error);
        toast.error(error.message || 'Erreur lors du refus. Veuillez réessayer.');
        setRefusing(false);
        return;
      }

      // 3. Mettre à jour la session avec recalcul complet
      const sessionId = production.session_id;
      if (sessionId) {
        await calculateAndSyncSession(sessionId, id, 'refuse', 0);
      }

      // 4. Notifier l'étudiant
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
        } catch { /* Notification non-bloquante */ }
      }

      toast.success('Production refusée — note 0 enregistrée et étudiant notifié.');
      if (production.session_id && production.epreuve) {
        await loadSessionProductions(production.session_id, production.epreuve);
      }
      navigate('/professeur/corrections');
    } catch (err: any) {
      console.error('Exception refus:', err);
      toast.error(err?.message || 'Erreur lors du refus.');
    } finally {
      setRefusing(false);
    }
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
        <div className="min-w-0 flex-1">
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
        {production.statut_correction === 'refuse' && <Badge variant="destructive" className="shrink-0">Refusé</Badge>}
        {production.statut_correction === 'en_attente' && <Badge variant="outline" className="text-amber-600 border-amber-500/40 bg-amber-500/10 shrink-0">En attente</Badge>}
      </div>

      {/* Sujet officiel de la tâche */}
      {tache && (
        <Card className="h-full border-primary/20 bg-primary/5 shadow-sm">
          <CardHeader className="pb-3 border-b border-primary/10">
            <CardTitle className="text-sm md:text-base font-semibold text-primary flex items-center gap-2 flex-wrap">
              <FileText className="w-4 h-4 shrink-0 text-primary" />
              <span>Sujet — {production.epreuve === 'expression_ecrite' ? 'Expression Écrite' : 'Expression Orale'} Tâche {production.numero_tache}</span>
              {(production.reference || tache.reference) && (
                <Badge variant="outline" className="text-xs font-mono font-medium border-primary/40 bg-primary/10 text-primary">
                  Réf : {production.reference || tache.reference}
                </Badge>
              )}
              {tache.duree_secondes && (
                <span className="ml-auto text-xs font-normal text-muted-foreground bg-background/80 px-2 py-0.5 rounded-full border border-border">
                  ⏱ {Math.floor(tache.duree_secondes / 60)} min{tache.duree_secondes % 60 > 0 ? ` ${tache.duree_secondes % 60}s` : ''}
                </span>
              )}
            </CardTitle>
          </CardHeader>
          <CardContent className="pt-3">
            <p className="text-sm text-foreground leading-relaxed text-pretty whitespace-pre-wrap font-normal">
              {tache.consigne}
            </p>
          </CardContent>
        </Card>
      )}

      {/* Production de l'étudiant */}
      <Card className="h-full">
        <CardHeader>
          <CardTitle className="text-base text-balance flex items-center justify-between">
            <span>Production de l'étudiant</span>
            {production.statut_correction === 'refuse' && (
              <Badge variant="destructive" className="text-xs">Production refusée</Badge>
            )}
          </CardTitle>
        </CardHeader>
        <CardContent>
          {production.audio_url && (
            <AudioPlayerCorrection
              url={production.audio_url}
              label={`Tâche ${production.numero_tache} — Expression orale`}
            />
          )}
          {production.contenu_texte && (
            <div className="bg-muted/50 rounded-lg p-4 space-y-2 border border-border">
              <p className="text-sm text-foreground whitespace-pre-wrap text-pretty leading-relaxed">{production.contenu_texte}</p>
              <p className="text-xs text-muted-foreground text-right font-mono">
                {production.contenu_texte.split(/\s+/).filter(Boolean).length} mots
              </p>
            </div>
          )}
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
              <p className="text-sm text-muted-foreground text-pretty">
                Enregistrement audio supprimé automatiquement 10 jours après la correction. Les notes et commentaires sont conservés.
              </p>
            </div>
          )}
          {!production.audio_url && !production.contenu_texte && production.statut_correction === 'en_attente' && (
            <div className="flex items-center gap-3 p-4 bg-destructive/5 border border-destructive/20 rounded-lg">
              <Mic className="w-5 h-5 text-destructive shrink-0" />
              <p className="text-sm text-destructive">Aucun contenu ou enregistrement disponible pour cette tâche.</p>
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
                const isCurrent = p.id === id;
                const isRefuse = p.statut_correction === 'refuse' && !isCurrent;
                const isCorrigee = p.statut_correction === 'corrige' && p.score !== null;
                const scoreAffiche = isCurrent ? scoreTotal : (p.score ?? 0);
                const niv = (isCorrigee || (isCurrent && Object.keys(notes).length > 0)) && !isRefuse
                  ? tacheToNiveau(scoreAffiche, max)
                  : null;

                return (
                  <div key={p.id} className={cn(
                    'flex items-center justify-between gap-3 p-3 rounded-lg border',
                    isCurrent ? 'bg-primary/5 border-primary/30' : 'bg-muted/30 border-border'
                  )}>
                    <div className="flex items-center gap-2 min-w-0">
                      <span className={cn('text-sm font-medium', isCurrent ? 'text-primary' : 'text-foreground')}>
                        Tâche {p.numero_tache}
                      </span>
                      {isCurrent && <Badge variant="outline" className="text-xs text-primary border-primary/40">en cours</Badge>}
                    </div>
                    <div className="flex items-center gap-2 shrink-0">
                      {p.statut_correction === 'refuse' && !isCurrent ? (
                        <Badge variant="destructive" className="text-xs">Refusée (0/{max})</Badge>
                      ) : niv ? (
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
                <div className="pt-2 border-t border-border flex items-center justify-between gap-3 flex-wrap">
                  <div>
                    <p className="font-semibold text-sm text-foreground">
                      {toutes ? 'Score total de l\'épreuve' : `Cumul (${terminees.length}/${sessionProductions.length} tâches)`}
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
        <Button
          className="w-full gap-2"
          onClick={handleSubmit}
          disabled={submitting || refusing}
        >
          {submitting ? (
            <><Loader2 className="w-4 h-4 mr-2 animate-spin" />Envoi en cours...</>
          ) : production.statut_correction === 'corrige' ? (
            <><CheckCircle className="w-4 h-4 mr-2" />Mettre à jour la correction</>
          ) : production.statut_correction === 'refuse' ? (
            <><CheckCircle className="w-4 h-4 mr-2" />Corriger à nouveau (annuler le refus)</>
          ) : (
            <><CheckCircle className="w-4 h-4 mr-2" />Valider et envoyer la correction</>
          )}
        </Button>

        {/* Bouton refus */}
        <AlertDialog>
          <AlertDialogTrigger asChild>
            <Button
              variant="outline"
              className="w-full gap-2 border-destructive/40 text-destructive hover:bg-destructive/5 hover:text-destructive"
              disabled={submitting || refusing}
            >
              <XCircle className="w-4 h-4" />
              {production.statut_correction === 'refuse' ? 'Modifier le motif de refus' : 'Refuser cette production (Note 0)'}
            </Button>
          </AlertDialogTrigger>
          <AlertDialogContent className="max-w-[calc(100%-2rem)] md:max-w-lg">
            <AlertDialogHeader>
              <AlertDialogTitle>Refuser la production</AlertDialogTitle>
              <AlertDialogDescription className="text-pretty">
                La production recevra la note 0. L'enregistrement audio éventuel sera supprimé.
                L'étudiant sera notifié du motif de refus.
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
              <AlertDialogCancel onClick={() => setRaisonRefus(production.raison_refus || '')}>Annuler</AlertDialogCancel>
              <AlertDialogAction
                onClick={handleRefuse}
                className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
              >
                {refusing ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" />Refus en cours…</> : 'Confirmer le refus'}
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </div>
  );
}
