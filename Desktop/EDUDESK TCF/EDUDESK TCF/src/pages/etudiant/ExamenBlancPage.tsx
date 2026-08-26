import { useState, useEffect, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { supabase, fetchAllQuestions } from '@/db/supabase';
import { useAuth } from '@/contexts/AuthContext';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Progress } from '@/components/ui/progress';
import { Alert, AlertDescription } from '@/components/ui/alert';
import {
  Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter,
} from '@/components/ui/dialog';
import {
  Play, Pause, Mic, MicOff, Square, Clock, ChevronRight,
  Headphones, FileText, PenLine, Loader2, AlertTriangle,
  Lock, CheckCircle2, XCircle, Trophy, RotateCcw, Upload, Info,
} from 'lucide-react';
import { toast } from 'sonner';
import type { Question, Tache, EpreuveType, NiveauCECRL } from '@/types/index';
import { EPREUVE_LABELS, CECRL_COLORS, CECRL_DESCRIPTIONS, pctToCECRL } from '@/types/index';

const EPREUVES_ORDER: EpreuveType[] = ['comprehension_oral', 'comprehension_ecrit', 'expression_ecrite', 'expression_orale'];
const DUREES: Record<EpreuveType, number> = {
  comprehension_oral: 35 * 60,
  comprehension_ecrit: 60 * 60,
  expression_ecrite: 60 * 60,
  expression_orale: 0,
};

// Ordre de difficulté croissante pour le tirage de l'examen blanc
const NIVEAU_ORDER: NiveauCECRL[] = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

/** Mélange aléatoire (Fisher-Yates) */
function shuffle<T>(arr: T[]): T[] {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

/**
 * Sélectionne les questions en ordre de difficulté croissante.
 * Au sein de chaque niveau, les questions sont tirées aléatoirement.
 * Les questions sans niveau sont placées au début.
 */
function selectByAscendingDifficulty(all: Question[], limit: number): Question[] {
  const byNiveau: Record<string, Question[]> = {};
  for (const q of all) {
    const key = q.niveau || 'null';
    if (!byNiveau[key]) byNiveau[key] = [];
    byNiveau[key].push(q);
  }
  // Mélanger chaque groupe
  Object.keys(byNiveau).forEach(k => { byNiveau[k] = shuffle(byNiveau[k]); });

  // Concaténer : sans niveau d'abord, puis par difficulté croissante
  const result: Question[] = [
    ...(byNiveau['null'] || []),
    ...NIVEAU_ORDER.flatMap(n => byNiveau[n] || []),
  ];
  return result.slice(0, limit);
}

function TimerBig({ seconds, total }: { seconds: number; total: number }) {
  const mins = Math.floor(seconds / 60).toString().padStart(2, '0');
  const secs = (seconds % 60).toString().padStart(2, '0');
  const pct = total > 0 ? (seconds / total) * 100 : 100;
  const isLow = seconds < 60;
  return (
    <div className="flex flex-col items-center gap-2">
      <div className={`text-4xl font-mono font-bold ${isLow ? 'text-destructive' : 'text-foreground'}`}>
        {mins}:{secs}
      </div>
      <Progress value={pct} className={`h-2 w-48 ${isLow ? '[&>div]:bg-destructive' : ''}`} />
    </div>
  );
}

function AudioPlayerSimple({ url }: { url: string }) {
  const ref = useRef<HTMLAudioElement>(null);
  const [playing, setPlaying] = useState(true);
  return (
    <div className="flex items-center gap-3 p-3 bg-muted rounded-lg">
      <button
        onClick={() => { if (ref.current) { if (playing) ref.current.pause(); else ref.current.play(); setPlaying(!playing); } }}
        className="w-9 h-9 rounded-full bg-primary flex items-center justify-center text-primary-foreground shrink-0"
      >
        {playing ? <Pause className="w-4 h-4" /> : <Play className="w-4 h-4" />}
      </button>
      <span className="text-sm text-muted-foreground">Audio de la question</span>
      <audio ref={ref} src={url} autoPlay onEnded={() => setPlaying(false)} />
    </div>
  );
}

interface QcmResult {
  epreuve: EpreuveType;
  questions: Question[];
  reponses: Record<string, string>; // question.id → choix.id
  correct: number;
  total: number;
}

export default function ExamenBlancPage() {
  const { user } = useAuth();
  const navigate = useNavigate();

  // Gate : vérifier si l'examen blanc est activé pour cet étudiant
  const [gateChecking, setGateChecking] = useState(true);
  const [examActif, setExamActif] = useState(false);

  // Correction 4 — Reprise d'examen interrompu
  const [resumeModal, setResumeModal] = useState(false);
  const [existingSessionId, setExistingSessionId] = useState<string | null>(null);
  const [existingEpreuve, setExistingEpreuve] = useState<EpreuveType | null>(null);
  const [abandonLoading, setAbandonLoading] = useState(false);

  const [phase, setPhase] = useState<'intro' | 'exam' | 'qcm_results' | 'finished'>('intro');
  const [epreuveIdx, setEpreuveIdx] = useState(0);
  const [sessionId, setSessionId] = useState<string | null>(null);
  const [questions, setQuestions] = useState<Question[]>([]);
  const [taches, setTaches] = useState<Tache[]>([]);
  const [currentQ, setCurrentQ] = useState(0);
  const [reponses, setReponses] = useState<Record<string, string>>({});
  const [texteReponses, setTexteReponses] = useState<Record<number, string>>({});
  const [timer, setTimer] = useState(0);
  const [timerActive, setTimerActive] = useState(false);
  const [loading, setLoading] = useState(false);
  // Résultats QCM pour les 2 premières épreuves
  const [qcmResults, setQcmResults] = useState<QcmResult[]>([]);
  // Audio recording — Correction 2 : blobs conservés pour retry
  const [recording, setRecording] = useState(false);
  const [audioBlobs, setAudioBlobs] = useState<Record<number, Blob>>({});
  const [taskTimer, setTaskTimer] = useState(0);
  const [taskTimerActive, setTaskTimerActive] = useState(false);
  const [currentTaskIdx, setCurrentTaskIdx] = useState(0);
  // Correction 2 — Upload progress + échecs avec retry
  const [uploadProgress, setUploadProgress] = useState<Record<number, number>>({});
  const [failedUploads, setFailedUploads] = useState<Record<number, boolean>>({});
  const [retrying, setRetrying] = useState<Record<number, boolean>>({});
  const mediaRecorderRef = useRef<MediaRecorder | null>(null);
  const chunksRef = useRef<Blob[]>([]);

  const currentEpreuve = EPREUVES_ORDER[epreuveIdx];

  // Vérification du droit d'accès
  useEffect(() => {
    if (!user) return;
    supabase
      .from('profiles')
      .select('examen_blanc_actif')
      .eq('id', user.id)
      .maybeSingle()
      .then(({ data }) => {
        setExamActif(data?.examen_blanc_actif === true);
        setGateChecking(false);
      });
  }, [user]);

  // Correction 1 : signaler qu'un examen est en cours via sessionStorage
  useEffect(() => {
    if (phase === 'exam') {
      sessionStorage.setItem('exam_en_cours', 'true');
    } else {
      sessionStorage.removeItem('exam_en_cours');
    }
    return () => { sessionStorage.removeItem('exam_en_cours'); };
  }, [phase]);

  useEffect(() => {
    if (!timerActive) return;
    if (timer <= 0) { handleEpreuveEnd(); return; }
    const t = setInterval(() => setTimer(s => s > 0 ? s - 1 : 0), 1000);
    return () => clearInterval(t);
  }, [timerActive, timer]);

  useEffect(() => {
    if (!taskTimerActive) return;
    if (taskTimer <= 0) { stopRecording(); return; }
    const t = setInterval(() => setTaskTimer(s => s > 0 ? s - 1 : 0), 1000);
    return () => clearInterval(t);
  }, [taskTimerActive, taskTimer]);

  // Correction 4 — Vérifier si une session en cours existe avant de démarrer
  const handleStartExamClick = async () => {
    if (!user) return;
    const { data: existing } = await supabase
      .from('sessions_examen')
      .select('id, epreuve_actuelle')
      .eq('etudiant_id', user.id)
      .eq('mode', 'examen_blanc')
      .eq('statut', 'en_cours')
      .maybeSingle();

    if (existing) {
      setExistingSessionId(existing.id);
      setExistingEpreuve(existing.epreuve_actuelle);
      setResumeModal(true);
    } else {
      await startExam();
    }
  };

  const handleResumeExam = async () => {
    if (!existingSessionId || !existingEpreuve) return;
    setResumeModal(false);
    setLoading(true);
    const idx = EPREUVES_ORDER.indexOf(existingEpreuve);
    const resumeIdx = idx >= 0 ? idx : 0;
    setSessionId(existingSessionId);
    setEpreuveIdx(resumeIdx);
    await loadEpreuve(resumeIdx);
    setPhase('exam');
    setLoading(false);
  };

  const handleAbandonAndRestart = async () => {
    if (!existingSessionId) return;
    setAbandonLoading(true);
    await supabase
      .from('sessions_examen')
      .update({ statut: 'abandonne' })
      .eq('id', existingSessionId);
    setExistingSessionId(null);
    setExistingEpreuve(null);
    setResumeModal(false);
    setAbandonLoading(false);
    await startExam();
  };

  const startExam = async () => {
    if (!user) return;
    setLoading(true);
    const { data: session } = await supabase.from('sessions_examen').insert({
      etudiant_id: user.id, mode: 'examen_blanc',
      epreuve_actuelle: EPREUVES_ORDER[0], statut: 'en_cours',
    }).select().maybeSingle();
    setSessionId(session?.id || null);
    await loadEpreuve(0);
    setPhase('exam');
    setLoading(false);
  };

  const loadEpreuve = async (idx: number) => {
    const epreuve = EPREUVES_ORDER[idx];
    setCurrentQ(0);
    setReponses({});
    setTimer(DUREES[epreuve]);
    setTimerActive(epreuve !== 'expression_orale');

    if (epreuve === 'expression_ecrite' || epreuve === 'expression_orale') {
      const requiredNums = epreuve === 'expression_ecrite' ? [1, 2, 3] : [1, 3];
      const selectedTaches: Tache[] = [];

      for (const num of requiredNums) {
        const { data: pool } = await supabase
          .from('taches')
          .select('*')
          .eq('epreuve', epreuve)
          .eq('numero_tache', num)
          .eq('actif', true);

        if (Array.isArray(pool) && pool.length > 0) {
          const randomIndex = Math.floor(Math.random() * pool.length);
          selectedTaches.push(pool[randomIndex]);
        }
      }

      setTaches(selectedTaches);

      if (epreuve === 'expression_orale' && selectedTaches.length > 0) {
        setCurrentTaskIdx(0);
        setTaskTimer(selectedTaches[0].duree_secondes || 120);
      }
    } else {
      // Tirage ordonné par difficulté croissante — avec limite adaptée
      const all = await fetchAllQuestions<Question>(epreuve);
      const limit = epreuve === 'comprehension_oral' ? 39 : 39;
      setQuestions(selectByAscendingDifficulty(all, limit));
    }
  };

  const handleEpreuveEnd = async () => {
    setTimerActive(false);
    setTaskTimerActive(false);
    if (recording) await stopRecording();

    // Sauvegarder & calculer QCM
    if ((currentEpreuve === 'comprehension_oral' || currentEpreuve === 'comprehension_ecrit') && sessionId) {
      const reps = questions.map(q => ({
        session_id: sessionId,
        question_id: q.id,
        reponse_choisie: reponses[q.id] || null,
        est_correcte: reponses[q.id] === q.bonne_reponse,
      }));
      if (reps.length > 0) await supabase.from('reponses_qcm').insert(reps);

      const correct = questions.filter(q => reponses[q.id] === q.bonne_reponse).length;
      setQcmResults(prev => [...prev, {
        epreuve: currentEpreuve,
        questions,
        reponses,
        correct,
        total: questions.length,
      }]);

      // Mettre à jour le score QCM dans la session
      const scoreField = currentEpreuve === 'comprehension_oral' ? 'score_oral' : 'score_ecrit';
      const scoreSur699 = Math.round((correct / questions.length) * 699);
      if (sessionId) {
        await supabase.from('sessions_examen').update({ [scoreField]: scoreSur699 }).eq('id', sessionId);
      }
    }

    // Sauvegarder expression écrite
    if (currentEpreuve === 'expression_ecrite' && sessionId) {
      const dureeEE = DUREES['expression_ecrite'] - timer;
      const { data: attribution } = await supabase.from('attributions').select('professeur_id').eq('etudiant_id', user!.id).maybeSingle();
      for (const tache of taches) {
        if (!texteReponses[tache.numero_tache]?.trim()) continue;
        await supabase.from('productions').insert({
          session_id: sessionId, etudiant_id: user!.id, epreuve: 'expression_ecrite',
          numero_tache: tache.numero_tache, reference: tache.reference || null,
          contenu_texte: texteReponses[tache.numero_tache],
          statut_correction: 'en_attente', professeur_id: attribution?.professeur_id || null,
        });
      }
      // Enregistrer la durée passée sur l'épreuve
      await supabase.from('sessions_examen')
        .update({ duree_expression_ecrite: dureeEE > 0 ? dureeEE : null })
        .eq('id', sessionId);
    }

    if (epreuveIdx < EPREUVES_ORDER.length - 1) {
      const nextIdx = epreuveIdx + 1;
      setEpreuveIdx(nextIdx);
      await loadEpreuve(nextIdx);
    } else {
      if (sessionId) {
        await supabase.from('sessions_examen').update({ statut: 'termine', termine_at: new Date().toISOString() }).eq('id', sessionId);
      }
      setPhase('finished');
    }
  };

  const startRecording = async (tache: Tache) => {
    try {
      const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
      // Correction 2 — codec Opus 32 kbps : réduit la taille à ~2-4 MB pour 4 min
      const mimeType = MediaRecorder.isTypeSupported('audio/webm;codecs=opus')
        ? 'audio/webm;codecs=opus'
        : 'audio/webm';
      const mr = new MediaRecorder(stream, { mimeType, audioBitsPerSecond: 32000 });
      chunksRef.current = [];
      mr.ondataavailable = e => { if (e.data.size > 0) chunksRef.current.push(e.data); };
      mr.onstop = () => {
        const blob = new Blob(chunksRef.current, { type: mimeType });
        setAudioBlobs(prev => ({ ...prev, [tache.numero_tache]: blob }));
        // Effacer l'échec précédent si l'étudiant ré-enregistre
        setFailedUploads(prev => { const n = { ...prev }; delete n[tache.numero_tache]; return n; });
        stream.getTracks().forEach(t => t.stop());
      };
      mr.start(1000); // chunks d'1 seconde
      mediaRecorderRef.current = mr;
      setRecording(true);
      setTaskTimer(tache.duree_secondes || 120);
      setTaskTimerActive(true);
    } catch {
      toast.error("Impossible d'accéder au microphone.");
    }
  };

  const stopRecording = async () => {
    setRecording(false);
    setTaskTimerActive(false);
    if (mediaRecorderRef.current?.state !== 'inactive') {
      mediaRecorderRef.current?.stop();
    }
  };

  // Correction 2 — Upload d'un seul blob avec progress + retry sans redemander l'enregistrement
  const uploadAudioBlob = async (tacheNum: number, blob: Blob): Promise<string | null> => {
    if (!sessionId || !user) return null;
    const fileName = `audio/${user.id}/${sessionId}/tache_${tacheNum}.webm`;
    setUploadProgress(prev => ({ ...prev, [tacheNum]: 0 }));
    const { data: uploaded, error: uploadError } = await supabase.storage
      .from('productions-audio')
      .upload(fileName, blob, { upsert: true, contentType: 'audio/webm' });
    if (uploaded) {
      setUploadProgress(prev => ({ ...prev, [tacheNum]: 100 }));
      setFailedUploads(prev => { const n = { ...prev }; delete n[tacheNum]; return n; });
      const { data: urlData } = supabase.storage.from('productions-audio').getPublicUrl(fileName);
      return urlData.publicUrl;
    } else {
      console.error(`Erreur upload audio tâche ${tacheNum}:`, uploadError?.message);
      setFailedUploads(prev => ({ ...prev, [tacheNum]: true }));
      setUploadProgress(prev => { const n = { ...prev }; delete n[tacheNum]; return n; });
      return null;
    }
  };

  // Correction 2 — Réessayer un upload sans perdre l'enregistrement
  const retryUpload = async (tacheNum: number) => {
    const blob = audioBlobs[tacheNum];
    if (!blob) { toast.error("Enregistrement introuvable. Veuillez ré-enregistrer."); return; }
    setRetrying(prev => ({ ...prev, [tacheNum]: true }));
    const url = await uploadAudioBlob(tacheNum, blob);
    setRetrying(prev => ({ ...prev, [tacheNum]: false }));
    if (url) {
      toast.success(`Tâche ${tacheNum} : audio envoyé avec succès.`);
    } else {
      toast.error(`Tâche ${tacheNum} : échec du renvoi. Réessayez dans quelques secondes.`);
    }
  };

  const submitOrale = async () => {
    if (!sessionId || !user) return;
    setLoading(true);
    const { data: attribution } = await supabase.from('attributions').select('professeur_id').eq('etudiant_id', user.id).maybeSingle();

    for (const tache of taches) {
      const blob = audioBlobs[tache.numero_tache];
      let audioUrl: string | null = null;
      if (blob) {
        audioUrl = await uploadAudioBlob(tache.numero_tache, blob);
        if (!audioUrl) {
          toast.error(`Tâche ${tache.numero_tache} : upload échoué. Utilisez "Réessayer" pour renvoyer l'audio.`);
        }
      }
      await supabase.from('productions').insert({
        session_id: sessionId, etudiant_id: user.id, epreuve: 'expression_orale',
        numero_tache: tache.numero_tache, reference: tache.reference || null, audio_url: audioUrl,
        statut_correction: 'en_attente', professeur_id: attribution?.professeur_id || null,
      });
    }

    await supabase.from('sessions_examen').update({ statut: 'termine', termine_at: new Date().toISOString() }).eq('id', sessionId);
    setLoading(false);
    setPhase('finished');
  };

  // ─── Gate : chargement ───────────────────────────────────────────────────────
  if (gateChecking) {
    return (
      <div className="flex items-center justify-center min-h-64">
        <Loader2 className="w-8 h-8 animate-spin text-muted-foreground" />
      </div>
    );
  }

  // ─── Gate : accès refusé ─────────────────────────────────────────────────────
  if (!examActif) {
    return (
      <div className="max-w-lg mx-auto text-center space-y-6 py-12 fade-in">
        <div className="w-16 h-16 rounded-full bg-muted flex items-center justify-center mx-auto">
          <Lock className="w-8 h-8 text-muted-foreground" />
        </div>
        <h1 className="text-2xl font-bold text-balance">Accès non activé</h1>
        <p className="text-muted-foreground text-pretty">
          Votre accès à l'examen blanc n'est pas encore activé. Veuillez contacter votre professeur ou votre administrateur pour l'activer.
        </p>
        <Button variant="outline" onClick={() => navigate('/etudiant')}>Retour au tableau de bord</Button>
      </div>
    );
  }

  // ─── Résultats QCM immédiats (après CO + CE) ─────────────────────────────────
  if (phase === 'qcm_results') {
    return (
      <div className="max-w-3xl mx-auto space-y-6 fade-in">
        <div className="text-center space-y-2">
          <h1 className="text-2xl font-bold text-balance">Résultats QCM</h1>
          <p className="text-muted-foreground text-pretty">
            Résultats des épreuves de compréhension — en attente de la correction des expressions par votre professeur.
          </p>
        </div>

        {qcmResults.map(result => {
          const pct = Math.round((result.correct / result.total) * 100);
          const niveau = pctToCECRL(pct);
          const niveauColor = CECRL_COLORS[niveau];
          const niveauDesc = CECRL_DESCRIPTIONS[niveau];
          return (
            <Card key={result.epreuve} className="h-full">
              <CardHeader>
                <CardTitle className="text-base text-balance flex items-center gap-2">
                  {result.epreuve === 'comprehension_oral' ? <Headphones className="w-4 h-4" /> : <FileText className="w-4 h-4" />}
                  {EPREUVE_LABELS[result.epreuve]}
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                {/* Les 3 indicateurs */}
                <div className="grid grid-cols-3 gap-3">
                  <div className="bg-muted/40 rounded-lg p-3 text-center">
                    <p className="text-2xl font-bold text-primary leading-tight">
                      {result.correct}<span className="text-sm text-muted-foreground font-normal">/{result.total}</span>
                    </p>
                    <p className="text-xs text-muted-foreground mt-0.5">Bonnes réponses</p>
                  </div>
                  <div className="bg-muted/40 rounded-lg p-3 text-center">
                    <p className="text-2xl font-bold text-foreground leading-tight">
                      {pct}<span className="text-sm text-muted-foreground font-normal">%</span>
                    </p>
                    <p className="text-xs text-muted-foreground mt-0.5">Taux de réussite</p>
                  </div>
                  <div className="bg-muted/40 rounded-lg p-3 text-center">
                    <p className="text-2xl font-bold leading-tight" style={{ color: niveauColor }}>{niveau}</p>
                    <p className="text-xs text-muted-foreground mt-0.5">{niveauDesc}</p>
                  </div>
                </div>
                {/* Barre de progression CECRL */}
                <div className="space-y-1.5">
                  <div className="flex justify-between text-xs text-muted-foreground">
                    <span>A1</span><span>A2</span><span>B1</span><span>B2</span><span>C1</span><span>C2</span>
                  </div>
                  <div className="relative h-2.5 bg-muted rounded-full overflow-hidden">
                    <div className="h-full rounded-full transition-all duration-700"
                      style={{ width: `${pct}%`, backgroundColor: niveauColor }} />
                  </div>
                  <p className="text-xs font-medium text-center" style={{ color: niveauColor }}>
                    Niveau estimé : <strong>{niveau}</strong> — {niveauDesc}
                  </p>
                </div>
                {/* Détail par question */}
                <div className="space-y-1 max-h-48 overflow-y-auto">
                  {result.questions.map((q, i) => {
                    const given = result.reponses[q.id];
                    const isCorrect = given === q.bonne_reponse;
                    const correctLabel = q.choix?.find(c => c.id === q.bonne_reponse)?.texte;
                    return (
                      <div key={q.id} className={`flex items-start gap-2 p-2 rounded-md text-xs ${isCorrect ? 'bg-success/5' : 'bg-destructive/5'}`}>
                        {isCorrect
                          ? <CheckCircle2 className="w-3.5 h-3.5 text-success shrink-0 mt-0.5" />
                          : <XCircle className="w-3.5 h-3.5 text-destructive shrink-0 mt-0.5" />
                        }
                        <div className="flex-1 min-w-0">
                          <p className="text-foreground truncate">Q{i + 1}{q.niveau ? ` (${q.niveau})` : ''} — {q.texte?.slice(0, 60) || '(audio/image)'}</p>
                          {!isCorrect && (
                            <p className="text-destructive">Bonne réponse : {q.bonne_reponse}. {correctLabel}</p>
                          )}
                        </div>
                      </div>
                    );
                  })}
                </div>
              </CardContent>
            </Card>
          );
        })}

        <Alert className="border-primary/30 bg-primary/5">
          <AlertTriangle className="h-4 w-4 text-primary" />
          <AlertDescription className="text-pretty">
            Les résultats définitifs (Expression Écrite et Expression Orale) seront disponibles après correction par votre professeur.
          </AlertDescription>
        </Alert>
        <Button onClick={() => navigate('/etudiant')} className="w-full">
          Retour au tableau de bord
        </Button>
      </div>
    );
  }

  // ─── Fin d'examen ─────────────────────────────────────────────────────────────
  if (phase === 'finished') {
    return (
      <div className="max-w-lg mx-auto text-center space-y-6 py-12 fade-in">
        <div className="w-20 h-20 rounded-full bg-success/15 flex items-center justify-center mx-auto">
          <Trophy className="w-10 h-10 text-success" />
        </div>
        <h1 className="text-2xl font-bold text-balance">Examen blanc terminé !</h1>

        {qcmResults.length > 0 && (
          <div className="space-y-3 text-left">
            {qcmResults.map(r => {
              const p = Math.round((r.correct / r.total) * 100);
              const niv = pctToCECRL(p);
              const col = CECRL_COLORS[niv];
              const desc = CECRL_DESCRIPTIONS[niv];
              return (
                <Card key={r.epreuve} className="h-full">
                  <CardContent className="p-4 space-y-3">
                    <p className="text-sm font-semibold text-foreground text-balance">{EPREUVE_LABELS[r.epreuve]}</p>
                    <div className="grid grid-cols-3 gap-2 text-center">
                      <div>
                        <p className="text-xl font-bold text-primary leading-tight">
                          {r.correct}<span className="text-sm text-muted-foreground font-normal">/{r.total}</span>
                        </p>
                        <p className="text-xs text-muted-foreground">Fraction</p>
                      </div>
                      <div>
                        <p className="text-xl font-bold text-foreground leading-tight">
                          {p}<span className="text-sm text-muted-foreground font-normal">%</span>
                        </p>
                        <p className="text-xs text-muted-foreground">Réussite</p>
                      </div>
                      <div>
                        <p className="text-xl font-bold leading-tight" style={{ color: col }}>{niv}</p>
                        <p className="text-xs text-muted-foreground">{desc}</p>
                      </div>
                    </div>
                    <div className="relative h-2 bg-muted rounded-full overflow-hidden">
                      <div className="h-full rounded-full" style={{ width: `${p}%`, backgroundColor: col }} />
                    </div>
                  </CardContent>
                </Card>
              );
            })}
          </div>
        )}

        <p className="text-muted-foreground text-pretty">
          Vos réponses aux épreuves d'expression ont été soumises. Votre professeur va les corriger et vous recevrez une notification.
        </p>
        <Button onClick={() => navigate('/etudiant')}>Retour au tableau de bord</Button>
      </div>
    );
  }

  // ─── Phase intro ─────────────────────────────────────────────────────────────
  if (phase === 'intro') return (
    <div className="max-w-2xl mx-auto space-y-6 fade-in">
      {/* Correction 4 — Modale reprise d'examen interrompu */}
      <Dialog open={resumeModal} onOpenChange={setResumeModal}>
        <DialogContent className="max-w-[calc(100%-2rem)] md:max-w-lg">
          <DialogHeader>
            <DialogTitle className="text-balance">Examen blanc en cours</DialogTitle>
          </DialogHeader>
          <p className="text-sm text-muted-foreground text-pretty">
            Tu as un examen blanc en cours
            {existingEpreuve ? ` (arrêté à l'épreuve : ${EPREUVE_LABELS[existingEpreuve]})` : ''}.
            Veux-tu le reprendre là où tu t'es arrêté ?
          </p>
          <DialogFooter className="flex-col sm:flex-row gap-2">
            <Button
              variant="outline"
              onClick={handleAbandonAndRestart}
              disabled={abandonLoading}
              className="w-full sm:w-auto"
            >
              {abandonLoading ? <Loader2 className="w-4 h-4 mr-2 animate-spin" /> : null}
              Abandonner et recommencer
            </Button>
            <Button onClick={handleResumeExam} className="w-full sm:w-auto">
              Reprendre l'examen
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <h1 className="text-2xl font-bold text-foreground text-balance">Examen Blanc TCF Canada</h1>
      <Alert className="border-primary/30 bg-primary/5">
        <AlertTriangle className="h-4 w-4 text-primary" />
        <AlertDescription className="text-pretty">
          Cet examen simule les conditions réelles du TCF Canada avec minuteurs automatiques. Les questions de compréhension sont tirées aléatoirement par difficulté croissante.
        </AlertDescription>
      </Alert>
      <Card className="h-full">
        <CardHeader><CardTitle className="text-balance">Déroulement de l'examen</CardTitle></CardHeader>
        <CardContent className="space-y-3">
          {EPREUVES_ORDER.map((ep, i) => (
            <div key={ep} className="flex items-center gap-3 p-3 rounded-lg bg-muted/50">
              <Badge className="bg-primary text-primary-foreground w-6 h-6 rounded-full flex items-center justify-center p-0 shrink-0">{i + 1}</Badge>
              <div className="min-w-0">
                <p className="font-medium text-sm text-foreground">{EPREUVE_LABELS[ep]}</p>
                <p className="text-xs text-muted-foreground">
                  {ep === 'comprehension_oral' && '35 min — QCM aléatoires, difficulté croissante, résultats immédiats'}
                  {ep === 'comprehension_ecrit' && '60 min — 39 questions QCM, difficulté croissante, résultats immédiats'}
                  {ep === 'expression_ecrite' && '60 min — 3 tâches de rédaction (correction professeur)'}
                  {ep === 'expression_orale' && 'Tâche 1 (2 min) + Tâche 3 (4 min 30s) — Tâche 2 non incluse (interaction)'}
                </p>
              </div>
            </div>
          ))}
        </CardContent>
      </Card>
      {/* Correction 4 — handleStartExamClick vérifie d'abord si une session en cours existe */}
      <Button size="lg" className="w-full" onClick={handleStartExamClick} disabled={loading}>
        {loading ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" />Préparation...</> : "Commencer l'examen blanc"}
      </Button>
    </div>
  );

  // ─── Phase examen ─────────────────────────────────────────────────────────────
  const epreuveLabel = EPREUVE_LABELS[currentEpreuve];

  // Expression orale
  if (currentEpreuve === 'expression_orale') {
    const tache = taches[currentTaskIdx];
    const isLastTask = currentTaskIdx === taches.length - 1;
    return (
      <div className="max-w-2xl mx-auto space-y-6 fade-in">
        <div className="flex items-center justify-between gap-4 flex-wrap">
          <div>
            <p className="text-sm text-muted-foreground">Épreuve {epreuveIdx + 1}/4</p>
            <h1 className="text-xl font-bold text-foreground text-balance">{epreuveLabel}</h1>
          </div>
          {taskTimerActive && tache && <TimerBig seconds={taskTimer} total={tache.duree_secondes || 120} />}
        </div>
      <Alert className="border-blue-500/30 bg-blue-500/5">
        <Info className="h-4 w-4 text-blue-600 dark:text-blue-400 shrink-0" />
        <AlertDescription className="text-pretty text-sm text-foreground">
          <span className="font-semibold">La Tâche 2 n'est pas incluse dans cet exercice.</span>{' '}
          Il s'agit d'un exercice en interaction avec un examinateur, qui ne peut pas être simulé en autonomie.
          Seules les <strong>Tâches 1 et 3</strong> sont pratiquées ici.
        </AlertDescription>
      </Alert>
      {tache && (
          <Card className="h-full">
            <CardHeader>
              <CardTitle className="text-base text-balance">
                Tâche {tache.numero_tache} — {tache.duree_secondes ? `${Math.floor(tache.duree_secondes / 60)} min${tache.duree_secondes % 60 > 0 ? ` ${tache.duree_secondes % 60}s` : ''}` : ''}
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <p className="text-sm text-foreground bg-muted/50 rounded-lg p-4 leading-relaxed text-pretty">{tache.consigne}</p>
              <div className="flex gap-3">
                {audioBlobs[tache.numero_tache] && !failedUploads[tache.numero_tache] ? (
                  // Enregistrement validé : lecture seule, pas de second enregistrement
                  <div className="flex-1 flex items-center gap-2 px-4 py-2.5 rounded-md bg-success/10 border border-success/30">
                    <Mic className="w-4 h-4 text-success shrink-0" />
                    <span className="text-sm text-success font-medium">Enregistrement sauvegardé ✓</span>
                  </div>
                ) : !recording ? (
                  <Button onClick={() => startRecording(tache)} className="flex-1 gap-2">
                    <Mic className="w-4 h-4" /> Démarrer l'enregistrement
                  </Button>
                ) : (
                  <Button variant="destructive" onClick={stopRecording} className="flex-1 gap-2">
                    <div className="w-2 h-2 rounded-full bg-white record-pulse" />
                    <Square className="w-4 h-4" /> Arrêter l'enregistrement
                  </Button>
                )}
              </div>
              {/* Correction 2 — Barre de progression upload */}
              {uploadProgress[tache.numero_tache] !== undefined && (
                <div className="space-y-1">
                  <div className="flex items-center justify-between text-xs text-muted-foreground">
                    <span className="flex items-center gap-1"><Upload className="w-3 h-3" /> Envoi en cours…</span>
                    <span>{uploadProgress[tache.numero_tache]}%</span>
                  </div>
                  <Progress value={uploadProgress[tache.numero_tache]} className="h-1.5" />
                </div>
              )}
              {/* Correction 2 — Bouton Réessayer si l'upload a échoué */}
              {failedUploads[tache.numero_tache] && (
                <div className="flex items-center gap-3 p-3 rounded-md bg-destructive/5 border border-destructive/20">
                  <p className="text-sm text-destructive flex-1">Échec d'envoi — votre enregistrement est conservé.</p>
                  <Button
                    size="sm"
                    variant="outline"
                    disabled={retrying[tache.numero_tache]}
                    onClick={() => retryUpload(tache.numero_tache)}
                    className="shrink-0"
                  >
                    {retrying[tache.numero_tache]
                      ? <Loader2 className="w-3 h-3 animate-spin" />
                      : <><RotateCcw className="w-3 h-3 mr-1" />Réessayer</>}
                  </Button>
                </div>
              )}
            </CardContent>
          </Card>
        )}
        <div className="flex gap-3">
          {!isLastTask ? (
            <Button className="flex-1" onClick={() => { stopRecording(); setCurrentTaskIdx(i => i + 1); setTaskTimerActive(false); }}>
              Tâche suivante <ChevronRight className="w-4 h-4 ml-1" />
            </Button>
          ) : (
            <Button className="flex-1" onClick={submitOrale} disabled={loading}>
              {loading ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" />Envoi...</> : 'Terminer et soumettre'}
            </Button>
          )}
        </div>
      </div>
    );
  }

  // Expression écrite
  if (currentEpreuve === 'expression_ecrite') {
    return (
      <div className="max-w-3xl mx-auto space-y-4 fade-in">
        {/* Bandeau sticky : chronomètre visible quand l'étudiant scrolle entre les tâches */}
        <div className="sticky top-0 z-20 bg-background/95 backdrop-blur-sm border-b border-border pb-3 -mx-4 px-4 md:-mx-6 md:px-6">
          <div className="flex items-center justify-between gap-4 pt-2 flex-wrap">
            <div>
              <p className="text-sm text-muted-foreground">Épreuve {epreuveIdx + 1}/4</p>
              <h1 className="text-lg font-bold text-foreground text-balance">{epreuveLabel}</h1>
            </div>
            <TimerBig seconds={timer} total={DUREES[currentEpreuve]} />
          </div>
        </div>
        {taches.map(tache => (
          <Card key={tache.id} className="h-full">
            <CardHeader>
              <CardTitle className="text-base text-balance flex items-center justify-between gap-2 flex-wrap">
                <span>Tâche {tache.numero_tache}</span>
                {tache.reference && (
                  <Badge variant="outline" className="text-xs font-mono font-medium border-primary/40 bg-primary/5 text-primary">
                    {tache.reference}
                  </Badge>
                )}
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              <p className="text-sm text-foreground bg-muted/50 rounded-lg p-4 text-pretty whitespace-pre-wrap leading-relaxed">{tache.consigne}</p>
              <textarea
                className="w-full min-h-28 text-base px-3 py-2 rounded-md border border-input bg-background resize-y focus:outline-none focus:ring-2 focus:ring-ring"
                placeholder="Rédigez votre réponse..."
                autoComplete="off"
                autoCorrect="off"
                autoCapitalize="off"
                spellCheck={false}
                value={texteReponses[tache.numero_tache] || ''}
                onChange={e => setTexteReponses(prev => ({ ...prev, [tache.numero_tache]: e.target.value }))}
                onPaste={e => e.preventDefault()}
                onDrop={e => e.preventDefault()}
              />
              <p className="text-xs text-muted-foreground text-right">
                {texteReponses[tache.numero_tache]?.split(/\s+/).filter(Boolean).length || 0} mots
              </p>
            </CardContent>
          </Card>
        ))}
        <Button className="w-full" onClick={handleEpreuveEnd}>
          Soumettre et passer à l'épreuve suivante <ChevronRight className="w-4 h-4 ml-1" />
        </Button>
      </div>
    );
  }

  // QCM (compréhension orale / écrite)
  const question = questions[currentQ];
  return (
    <div className="max-w-2xl mx-auto space-y-4 fade-in">
      <div className="flex items-center justify-between gap-4 flex-wrap">
        <div>
          <p className="text-sm text-muted-foreground">Épreuve {epreuveIdx + 1}/4 — Question {currentQ + 1}/{questions.length}</p>
          <h1 className="text-xl font-bold text-foreground text-balance">{epreuveLabel}</h1>
        </div>
        <TimerBig seconds={timer} total={DUREES[currentEpreuve]} />
      </div>
      <div className="flex items-center gap-2">
        <Progress value={questions.length ? ((currentQ + 1) / questions.length) * 100 : 0} className="h-2 flex-1" />
        {/* Le niveau de difficulté est masqué pendant la simulation */}
      </div>
      {question && (
        <Card className="h-full">
          <CardContent className="p-6 space-y-4">
            {question.audio_url && <AudioPlayerSimple url={question.audio_url} />}
            {question.image_url && (
              <div className="rounded-lg overflow-hidden max-h-48">
                <img src={question.image_url} alt="" className="w-full h-full object-cover" />
              </div>
            )}
            {question.texte && <p className="text-sm text-foreground leading-relaxed text-pretty whitespace-pre-wrap">{question.texte}</p>}
            <div className="space-y-2 pt-2">
              {question.choix?.map(choix => (
                <button key={choix.id}
                  onClick={() => setReponses(prev => ({ ...prev, [question.id]: choix.id }))}
                  className={[
                    'w-full text-left px-4 py-3 rounded-md border text-sm transition-colors flex items-start gap-3',
                    reponses[question.id] === choix.id
                      ? 'border-primary bg-primary/10'
                      : 'border-border bg-card hover:border-primary/50 hover:bg-primary/5',
                  ].join(' ')}
                >
                  <span className="font-semibold text-muted-foreground shrink-0 w-5">{choix.id}.</span>
                  <span className="flex-1 text-pretty">{choix.texte}</span>
                </button>
              ))}
            </div>
          </CardContent>
        </Card>
      )}
      <div className="flex gap-3">
        {currentQ < questions.length - 1 ? (
          <Button className="flex-1" onClick={() => setCurrentQ(i => i + 1)}>
            Question suivante <ChevronRight className="w-4 h-4 ml-1" />
          </Button>
        ) : (
          <Button className="flex-1" onClick={handleEpreuveEnd}>
            Terminer cette épreuve <ChevronRight className="w-4 h-4 ml-1" />
          </Button>
        )}
      </div>
    </div>
  );
}
