import { useState, useEffect, useRef } from 'react';
import { useSearchParams } from 'react-router-dom';
import { supabase, fetchAllQuestions } from '@/db/supabase';
import { useAuth } from '@/contexts/AuthContext';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Progress } from '@/components/ui/progress';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { Skeleton } from '@/components/ui/skeleton';
import {
  Headphones, FileText, PenLine, Mic, Play, Pause,
  CheckCircle2, XCircle, ChevronLeft, ChevronRight,
  BookOpen, Clock, Loader2, Trophy, Square, AlertTriangle,
  Send, Info,
} from 'lucide-react';
import { toast } from 'sonner';
import type { Question, Tache, EpreuveType, NiveauCECRL } from '@/types/index';
import { EPREUVE_LABELS, CECRL_COLORS, CECRL_DESCRIPTIONS, pctToCECRL } from '@/types/index';

const QCM_SESSION_SIZE = 20;
const MAX_PENDING = 2; // Limite d'épreuves en attente de correction

const NIVEAU_ORDER: NiveauCECRL[] = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

const EPREUVE_ICONS: Record<EpreuveType, React.ComponentType<{ className?: string }>> = {
  comprehension_oral: Headphones,
  comprehension_ecrit: FileText,
  expression_ecrite: PenLine,
  expression_orale: Mic,
};

function shuffle<T>(arr: T[]): T[] {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

function selectAlternatingQuestions(all: Question[]): Question[] {
  const byNiveau: Record<string, Question[]> = {};
  for (const q of all) {
    const key = q.niveau || 'null';
    if (!byNiveau[key]) byNiveau[key] = [];
    byNiveau[key].push(q);
  }
  Object.keys(byNiveau).forEach(k => { byNiveau[k] = shuffle(byNiveau[k]); });
  const orderedKeys = [
    ...NIVEAU_ORDER.filter(n => byNiveau[n]?.length),
    ...(byNiveau['null']?.length ? ['null'] : []),
  ];
  if (orderedKeys.length === 0) return shuffle(all).slice(0, QCM_SESSION_SIZE);
  const result: Question[] = [];
  const cursors: Record<string, number> = {};
  orderedKeys.forEach(k => { cursors[k] = 0; });
  let ki = 0;
  while (result.length < QCM_SESSION_SIZE) {
    const key = orderedKeys[ki % orderedKeys.length];
    const pool = byNiveau[key];
    if (cursors[key] < pool.length) { result.push(pool[cursors[key]]); cursors[key]++; }
    ki++;
    if (ki > QCM_SESSION_SIZE * orderedKeys.length) break;
  }
  return result.slice(0, QCM_SESSION_SIZE);
}

function AudioPlayer({ url }: { url: string }) {
  const audioRef = useRef<HTMLAudioElement>(null);
  const [playing, setPlaying] = useState(true);
  const [progress, setProgress] = useState(0);
  const toggle = () => {
    if (!audioRef.current) return;
    if (playing) audioRef.current.pause(); else audioRef.current.play();
    setPlaying(!playing);
  };
  return (
    <div className="flex items-center gap-3 p-3 bg-muted rounded-lg">
      <button onClick={toggle} className="w-9 h-9 rounded-full bg-primary flex items-center justify-center text-primary-foreground shrink-0">
        {playing ? <Pause className="w-4 h-4" /> : <Play className="w-4 h-4" />}
      </button>
      <div className="flex-1 min-w-0"><Progress value={progress} className="h-1.5" /></div>
      <audio ref={audioRef} src={url} autoPlay
        onTimeUpdate={e => { const a = e.currentTarget; setProgress((a.currentTime / a.duration) * 100); }}
        onEnded={() => setPlaying(false)} />
    </div>
  );
}

function TimerDisplay({ seconds }: { seconds: number }) {
  const mins = Math.floor(seconds / 60).toString().padStart(2, '0');
  const secs = (seconds % 60).toString().padStart(2, '0');
  const isLow = seconds < 30;
  return (
    <div className={`flex items-center gap-2 px-3 py-1.5 rounded-md font-mono text-lg font-bold ${isLow ? 'bg-destructive/10 text-destructive' : 'bg-muted text-foreground'}`}>
      <Clock className="w-4 h-4" />{mins}:{secs}
    </div>
  );
}

// ─── Composant enregistrement audio ─────────────────────────────────────────
interface AudioRecorderProps {
  tacheNum: number;
  onRecorded: (tacheNum: number, blob: Blob) => void;
  disabled?: boolean;
  initialRecorded?: boolean;
}

function AudioRecorder({ tacheNum, onRecorded, disabled, initialRecorded = false }: AudioRecorderProps) {
  const [recording, setRecording] = useState(false);
  // initialRecorded synchronise l'état avec le blob parent (évite "Ré-enregistrer" sur tâche vierge)
  const [hasRecording, setHasRecording] = useState(initialRecorded);
  const [duration, setDuration] = useState(0);
  const mediaRecorderRef = useRef<MediaRecorder | null>(null);
  const chunksRef = useRef<Blob[]>([]);
  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null);

  const startRecording = async () => {
    try {
      const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
      // Compression maximale : Opus 16 kbps mono (≈ 120 KB/min)
      const mimeType = MediaRecorder.isTypeSupported('audio/webm;codecs=opus')
        ? 'audio/webm;codecs=opus' : 'audio/webm';
      const mr = new MediaRecorder(stream, { mimeType, audioBitsPerSecond: 16000 });
      chunksRef.current = [];
      mr.ondataavailable = e => { if (e.data.size > 0) chunksRef.current.push(e.data); };
      mr.onstop = () => {
        const blob = new Blob(chunksRef.current, { type: mimeType });
        stream.getTracks().forEach(t => t.stop());
        onRecorded(tacheNum, blob);
        setHasRecording(true);
        setRecording(false);
      };
      mr.start(1000);
      mediaRecorderRef.current = mr;
      setRecording(true);
      setDuration(0);
      timerRef.current = setInterval(() => setDuration(d => d + 1), 1000);
    } catch {
      toast.error("Impossible d'accéder au microphone. Vérifiez les permissions.");
    }
  };

  const stopRecording = () => {
    if (timerRef.current) clearInterval(timerRef.current);
    if (mediaRecorderRef.current?.state !== 'inactive') {
      mediaRecorderRef.current?.stop();
    }
  };

  const mins = Math.floor(duration / 60).toString().padStart(2, '0');
  const secs = (duration % 60).toString().padStart(2, '0');

  return (
    <div className="space-y-2">
      {!recording ? (
        <Button onClick={startRecording} disabled={disabled} className="w-full gap-2" variant={hasRecording ? 'outline' : 'default'}>
          <Mic className="w-4 h-4" />
          {hasRecording ? 'Ré-enregistrer la tâche' : 'Démarrer l\'enregistrement'}
        </Button>
      ) : (
        <Button variant="destructive" onClick={stopRecording} className="w-full gap-2">
          <div className="w-2 h-2 rounded-full bg-white animate-pulse" />
          <Square className="w-4 h-4" />
          Arrêter — {mins}:{secs}
        </Button>
      )}
      {hasRecording && !recording && (
        <p className="text-xs text-success flex items-center gap-1.5">
          <CheckCircle2 className="w-3.5 h-3.5 shrink-0" /> Enregistrement prêt à l'envoi
        </p>
      )}
    </div>
  );
}

// ─── Card bloquée : limite atteinte ─────────────────────────────────────────
function LimiteAtteintCard({ epreuve, onBack }: { epreuve: EpreuveType; onBack: () => void }) {
  const label = epreuve === 'expression_ecrite' ? 'Expression Écrite' : 'Expression Orale';
  return (
    <div className="max-w-2xl mx-auto space-y-6 fade-in">
      <div className="flex items-center gap-3">
        <Button variant="ghost" size="icon" onClick={onBack}><ChevronLeft className="w-5 h-5" /></Button>
        <h1 className="text-xl font-bold text-foreground text-balance">{label} — Entraînement</h1>
      </div>
      <Card className="h-full border-warning/40 bg-warning/5">
        <CardContent className="p-6 space-y-4">
          <div className="flex items-start gap-3">
            <AlertTriangle className="w-6 h-6 text-warning shrink-0 mt-0.5" />
            <div className="space-y-2">
              <h3 className="font-semibold text-foreground text-balance">
                {MAX_PENDING} épreuves en attente de correction
              </h3>
              <p className="text-sm text-muted-foreground text-pretty">
                Vous avez déjà <strong>{MAX_PENDING} épreuves de {label.toLowerCase()}</strong> en attente de correction par votre professeur.
                Vous ne pouvez pas soumettre de nouvelle épreuve tant que votre professeur n'en a pas corrigé au moins une.
              </p>
              <p className="text-sm text-muted-foreground text-pretty">
                Consultez votre <strong>historique</strong> pour suivre l'avancement des corrections.
              </p>
            </div>
          </div>
        </CardContent>
      </Card>
      <Button variant="outline" className="w-full" onClick={onBack}>
        <ChevronLeft className="w-4 h-4 mr-2" /> Choisir une autre épreuve
      </Button>
    </div>
  );
}

// ─── Page principale ─────────────────────────────────────────────────────────
export default function EntrainementPage() {
  const [searchParams] = useSearchParams();
  const [selectedEpreuve, setSelectedEpreuve] = useState<EpreuveType | null>(
    (searchParams.get('epreuve') as EpreuveType) || null
  );
  const [questions, setQuestions] = useState<Question[]>([]);
  const [taches, setTaches] = useState<Tache[]>([]);
  const [currentIdx, setCurrentIdx] = useState(0);
  const [reponses, setReponses] = useState<Record<number, string>>({});
  const [sessionDone, setSessionDone] = useState(false);
  const [texteReponses, setTexteReponses] = useState<Record<number, string>>({});
  const [audioBlobs, setAudioBlobs] = useState<Record<number, Blob>>({});
  const [timerSeconds, setTimerSeconds] = useState(120);
  const [timerActive, setTimerActive] = useState(false);
  const [loading, setLoading] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [checkingLimit, setCheckingLimit] = useState(false);
  // null = pas encore vérifié, number = count actuel
  const [pendingCount, setPendingCount] = useState<Record<string, number>>({});
  const [sessionKey, setSessionKey] = useState(0);
  // Chronomètre expression écrite (informatif, sans timeout)
  const [eeElapsed, setEeElapsed] = useState(0);
  const eeTimerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const { user } = useAuth();

  useEffect(() => {
    if (!selectedEpreuve) return;
    loadContent(selectedEpreuve);
  }, [selectedEpreuve, sessionKey]);

  useEffect(() => {
    if (!timerActive || timerSeconds <= 0) return;
    const interval = setInterval(() => setTimerSeconds(s => s > 0 ? s - 1 : 0), 1000);
    return () => clearInterval(interval);
  }, [timerActive, timerSeconds]);

  // Chronomètre expression écrite : démarre à l'entrée, s'arrête à la sortie/soumission
  useEffect(() => {
    if (selectedEpreuve === 'expression_ecrite') {
      setEeElapsed(0);
      eeTimerRef.current = setInterval(() => setEeElapsed(e => e + 1), 1000);
    } else {
      if (eeTimerRef.current) { clearInterval(eeTimerRef.current); eeTimerRef.current = null; }
    }
    return () => { if (eeTimerRef.current) { clearInterval(eeTimerRef.current); eeTimerRef.current = null; } };
  }, [selectedEpreuve]);

  // Vérifier la limite avant d'afficher l'épreuve d'expression
  const checkAndSelectEpreuve = async (epreuve: EpreuveType) => {
    if (epreuve !== 'expression_ecrite' && epreuve !== 'expression_orale') {
      setSelectedEpreuve(epreuve);
      return;
    }
    if (!user) return;
    setCheckingLimit(true);
    const { data, error } = await supabase.rpc('count_pending_expression_entrainement', {
      p_etudiant_id: user.id,
      p_epreuve: epreuve,
    });
    setCheckingLimit(false);
    if (error) {
      toast.error('Erreur lors de la vérification. Veuillez réessayer.');
      return;
    }
    const count = data as number ?? 0;
    setPendingCount(prev => ({ ...prev, [epreuve]: count }));
    setSelectedEpreuve(epreuve);
  };

  const loadContent = async (epreuve: EpreuveType) => {
    setLoading(true);
    setCurrentIdx(0);
    setReponses({});
    setSessionDone(false);
    setAudioBlobs({});
    if (epreuve === 'expression_ecrite' || epreuve === 'expression_orale') {
      const { data: tachesData } = await supabase
        .from('taches')
        .select('*')
        .eq('epreuve', epreuve)
        .eq('actif', true)
        .order('numero_tache');

      let list = Array.isArray(tachesData) ? tachesData : [];

      // Fallback vers la table questions si taches est vide
      if (list.length === 0) {
        const { data: qData } = await supabase
          .from('questions')
          .select('*')
          .eq('epreuve', epreuve)
          .eq('actif', true);

        if (Array.isArray(qData) && qData.length > 0) {
          list = qData.map((q, idx) => ({
            id: q.id,
            epreuve: q.epreuve,
            numero_tache: q.ordre || idx + 1,
            reference: q.reference || null,
            consigne: q.texte || '',
            duree_secondes: null,
            actif: true,
            cree_par: q.cree_par || null,
            created_at: q.created_at || new Date().toISOString(),
          }));
        }
      }

      // Sélectionner 1 sujet au hasard pour chaque numéro de tâche
      const byNum: Record<number, Tache[]> = {};
      list.forEach(t => {
        if (!byNum[t.numero_tache]) byNum[t.numero_tache] = [];
        byNum[t.numero_tache].push(t);
      });
      const selectedTaches: Tache[] = [];
      const requiredNums = epreuve === 'expression_ecrite' ? [1, 2, 3] : [1, 3];
      requiredNums.forEach(num => {
        const pool = byNum[num];
        if (pool && pool.length > 0) {
          const randomIndex = Math.floor(Math.random() * pool.length);
          selectedTaches.push(pool[randomIndex]);
        } else if (list.some(t => t.numero_tache === num)) {
          selectedTaches.push(list.find(t => t.numero_tache === num)!);
        }
      });

      setTaches(selectedTaches.length > 0 ? selectedTaches : list);
    } else {
      const all = await fetchAllQuestions<Question>(epreuve);
      setQuestions(shuffle(all).slice(0, QCM_SESSION_SIZE));
    }
    setLoading(false);
  };

  const handleAnswer = (choixId: string) => {
    if (reponses[currentIdx] !== undefined) return;
    setReponses(prev => ({ ...prev, [currentIdx]: choixId }));
  };

  const nextQuestion = () => {
    if (currentIdx < questions.length - 1) setCurrentIdx(prev => prev + 1);
    else setSessionDone(true);
  };

  const handleRecorded = (tacheNum: number, blob: Blob) => {
    setAudioBlobs(prev => ({ ...prev, [tacheNum]: blob }));
  };

  // Soumettre expression écrite
  const submitExpressionEcrite = async () => {
    if (!user || !selectedEpreuve) return;
    setSubmitting(true);
    // Figer le chronomètre et capturer la durée
    if (eeTimerRef.current) { clearInterval(eeTimerRef.current); eeTimerRef.current = null; }
    const dureeCapturee = eeElapsed;
    try {
      const { data: session } = await supabase.from('sessions_examen').insert({
        etudiant_id: user.id, mode: 'entrainement',
        epreuve_actuelle: selectedEpreuve, statut: 'termine',
        termine_at: new Date().toISOString(),
        duree_expression_ecrite: dureeCapturee > 0 ? dureeCapturee : null,
      }).select().maybeSingle();
      const { data: attribution } = await supabase.from('attributions').select('professeur_id').eq('etudiant_id', user.id).maybeSingle();
      for (const tache of taches) {
        const texte = texteReponses[tache.numero_tache];
        if (!texte?.trim()) continue;
        await supabase.from('productions').insert({
          session_id: session?.id, etudiant_id: user.id,
          epreuve: selectedEpreuve, numero_tache: tache.numero_tache,
          reference: tache.reference || null,
          contenu_texte: texte, statut_correction: 'en_attente',
          professeur_id: attribution?.professeur_id || null,
        });
      }
      toast.success('Vos réponses ont été envoyées à votre professeur pour correction !');
      setSelectedEpreuve(null);
      setPendingCount({});
    } catch {
      toast.error('Erreur lors de la soumission. Veuillez réessayer.');
    } finally {
      setSubmitting(false);
    }
  };

  // Soumettre expression orale avec enregistrements audio compressés
  const submitExpressionOrale = async () => {
    if (!user) return;
    const hasAny = taches.some(t => audioBlobs[t.numero_tache]);
    if (!hasAny) {
      toast.error("Veuillez enregistrer au moins une tâche avant de soumettre.");
      return;
    }
    setSubmitting(true);
    try {
      const { data: session, error: sessionError } = await supabase.from('sessions_examen').insert({
        etudiant_id: user.id, mode: 'entrainement',
        epreuve_actuelle: 'expression_orale', statut: 'termine',
        termine_at: new Date().toISOString(),
      }).select().maybeSingle();

      if (sessionError || !session) throw new Error('Impossible de créer la session.');

      const { data: attribution } = await supabase.from('attributions').select('professeur_id').eq('etudiant_id', user.id).maybeSingle();

      for (const tache of taches) {
        const blob = audioBlobs[tache.numero_tache];
        let audioUrl: string | null = null;

        if (blob) {
          // Upload vers productions-audio avec chemin organisé
          const fileName = `audio/${user.id}/entrainement/${session.id}/tache_${tache.numero_tache}.webm`;
          const { data: uploaded, error: uploadError } = await supabase.storage
            .from('productions-audio')
            .upload(fileName, blob, { upsert: true, contentType: 'audio/webm' });

          if (uploaded) {
            const { data: urlData } = supabase.storage.from('productions-audio').getPublicUrl(fileName);
            audioUrl = urlData.publicUrl;
          } else {
            console.error(`Upload tâche ${tache.numero_tache}:`, uploadError?.message);
            toast.error(`Tâche ${tache.numero_tache} : échec de l'envoi audio. La tâche sera soumise sans audio.`);
          }
        }

        await supabase.from('productions').insert({
          session_id: session.id, etudiant_id: user.id,
          epreuve: 'expression_orale', numero_tache: tache.numero_tache,
          reference: tache.reference || null,
          audio_url: audioUrl, statut_correction: 'en_attente',
          professeur_id: attribution?.professeur_id || null,
        });
      }

      toast.success('Vos enregistrements ont été envoyés à votre professeur pour correction !');
      setSelectedEpreuve(null);
      setPendingCount({});
    } catch (err) {
      toast.error('Erreur lors de la soumission. Veuillez réessayer.');
      console.error(err);
    } finally {
      setSubmitting(false);
    }
  };

  // ─── Sélection épreuve ───────────────────────────────────────────────────────
  if (!selectedEpreuve) {
    return (
      <div className="max-w-3xl mx-auto space-y-6 fade-in">
        <div>
          <h1 className="text-2xl font-bold text-foreground text-balance">Mode Entraînement</h1>
          <p className="text-muted-foreground mt-1">Choisissez une épreuve pour commencer</p>
        </div>
        {checkingLimit && (
          <div className="flex items-center gap-2 text-sm text-muted-foreground">
            <Loader2 className="w-4 h-4 animate-spin" /> Vérification en cours…
          </div>
        )}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {(Object.keys(EPREUVE_LABELS) as EpreuveType[]).map(epreuve => {
            const Icon = EPREUVE_ICONS[epreuve];
            return (
              <Card
                key={epreuve}
                className="cursor-pointer hover:border-primary/50 hover:shadow-md transition-all h-full"
                onClick={() => checkAndSelectEpreuve(epreuve)}
              >
                <CardContent className="p-6 flex items-start gap-4 h-full">
                  <div className="w-12 h-12 rounded-lg bg-primary/10 flex items-center justify-center shrink-0">
                    <Icon className="w-6 h-6 text-primary" />
                  </div>
                  <div className="min-w-0 flex-1">
                    <h3 className="font-semibold text-foreground text-balance">{EPREUVE_LABELS[epreuve]}</h3>
                    <p className="text-sm text-muted-foreground mt-1 text-pretty">
                      {epreuve === 'comprehension_oral' && `${QCM_SESSION_SIZE} questions QCM aléatoires avec audio et images`}
                      {epreuve === 'comprehension_ecrit' && `${QCM_SESSION_SIZE} questions QCM aléatoires basées sur des textes`}
                      {epreuve === 'expression_ecrite' && '3 tâches de rédaction — correction professeur'}
                      {epreuve === 'expression_orale' && 'Tâches 1 & 3 — enregistrement audio (Tâche 2 non incluse : interaction)'}
                    </p>
                  </div>
                </CardContent>
              </Card>
            );
          })}
        </div>
      </div>
    );
  }

  if (loading) {
    return (
      <div className="max-w-2xl mx-auto space-y-4">
        <Skeleton className="h-8 w-48 bg-muted" />
        <Skeleton className="h-64 w-full bg-muted" />
      </div>
    );
  }

  // ─── Limite atteinte ─────────────────────────────────────────────────────────
  if (
    (selectedEpreuve === 'expression_ecrite' || selectedEpreuve === 'expression_orale') &&
    (pendingCount[selectedEpreuve] ?? 0) >= MAX_PENDING
  ) {
    return <LimiteAtteintCard epreuve={selectedEpreuve} onBack={() => setSelectedEpreuve(null)} />;
  }

  // ─── Expression écrite ───────────────────────────────────────────────────────
  if (selectedEpreuve === 'expression_ecrite') {
    return (
      <div className="max-w-3xl mx-auto space-y-6 fade-in">
        {/* Bandeau sticky : toujours visible même quand l'étudiant scrolle entre les tâches */}
        <div className="sticky top-0 z-20 bg-background/95 backdrop-blur-sm border-b border-border pb-3 -mx-4 px-4 md:-mx-6 md:px-6">
          <div className="flex items-center gap-3 pt-2">
            <Button variant="ghost" size="icon" onClick={() => setSelectedEpreuve(null)}>
              <ChevronLeft className="w-5 h-5" />
            </Button>
            <div className="flex-1 min-w-0 flex items-center justify-between gap-3 flex-wrap">
              <h1 className="text-xl font-bold text-foreground text-balance">Expression Écrite — Entraînement</h1>
              {/* Chronomètre informatif — double taille, toujours visible */}
              <div className="flex items-center gap-2 px-5 py-2.5 rounded-lg bg-muted border border-border font-mono text-xl font-bold text-foreground shrink-0 tabular-nums">
                <Clock className="w-5 h-5 text-muted-foreground" />
                {String(Math.floor(eeElapsed / 60)).padStart(2, '0')}:{String(eeElapsed % 60).padStart(2, '0')}
              </div>
            </div>
          </div>
        </div>

        <Alert className="border-primary/30 bg-primary/5">
          <AlertDescription className="text-pretty">
            Rédigez vos réponses pour chaque tâche. Vos productions seront envoyées à votre professeur pour correction.
          </AlertDescription>
        </Alert>
        {taches.length === 0 && (
          <Card><CardContent className="p-8 text-center text-muted-foreground">Aucune tâche disponible pour cette épreuve.</CardContent></Card>
        )}
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
            <CardContent className="space-y-4">
              <p className="text-sm text-foreground bg-muted/50 rounded-lg p-4 text-pretty whitespace-pre-wrap leading-relaxed">{tache.consigne}</p>
              <textarea
                className="w-full min-h-32 text-base px-3 py-2 rounded-md border border-input bg-background resize-y focus:outline-none focus:ring-2 focus:ring-ring"
                placeholder="Rédigez votre réponse ici..."
                autoComplete="off" autoCorrect="off" autoCapitalize="off" spellCheck={false}
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
        {taches.length > 0 && (
          <Button onClick={submitExpressionEcrite} disabled={submitting} className="w-full gap-2">
            {submitting
              ? <><Loader2 className="w-4 h-4 animate-spin" />Envoi en cours…</>
              : <><Send className="w-4 h-4" />Envoyer pour correction</>
            }
          </Button>
        )}
      </div>
    );
  }

  // ─── Expression orale ─────────────────────────────────────────────────────────
  if (selectedEpreuve === 'expression_orale') {
    const tache = taches[currentIdx];
    const allRecorded = taches.length > 0 && taches.every(t => audioBlobs[t.numero_tache]);
    const anyRecorded = taches.some(t => audioBlobs[t.numero_tache]);

    return (
      <div className="max-w-2xl mx-auto space-y-6 fade-in">
        <div className="flex items-center gap-3">
          <Button variant="ghost" size="icon" onClick={() => setSelectedEpreuve(null)}>
            <ChevronLeft className="w-5 h-5" />
          </Button>
          <div className="flex-1 min-w-0">
            <h1 className="text-xl font-bold text-foreground text-balance">Expression Orale — Entraînement</h1>
            <p className="text-sm text-muted-foreground">
              {taches.filter(t => audioBlobs[t.numero_tache]).length}/{taches.length} tâche{taches.length > 1 ? 's' : ''} enregistrée{taches.length > 1 ? 's' : ''}
            </p>
          </div>
        </div>

        <Alert className="border-blue-500/30 bg-blue-500/5">
          <Info className="h-4 w-4 text-blue-600 dark:text-blue-400 shrink-0" />
          <AlertDescription className="text-pretty text-sm text-foreground">
            <span className="font-semibold">La Tâche 2 n'est pas incluse dans cet exercice.</span>{' '}
            Il s'agit d'un exercice en interaction avec un examinateur, qui ne peut pas être simulé en autonomie.
            Seules les <strong>Tâches 1 et 3</strong> sont pratiquées ici.
          </AlertDescription>
        </Alert>

        <Alert className="border-primary/30 bg-primary/5">
          <Mic className="h-4 w-4 text-primary" />
          <AlertDescription className="text-pretty text-sm">
            Lisez la consigne, puis enregistrez votre réponse. L'audio est compressé avant envoi.
            Vos enregistrements sont transmis à votre professeur pour correction.
          </AlertDescription>
        </Alert>

        {taches.length === 0 && (
          <Card><CardContent className="p-8 text-center text-muted-foreground">Aucune tâche disponible.</CardContent></Card>
        )}

        {/* Navigation entre tâches */}
        {taches.length > 1 && (
          <div className="flex gap-2">
            {taches.map((t, i) => (
              <button
                key={t.id}
                onClick={() => { setCurrentIdx(i); setTimerActive(false); }}
                className={[
                  'flex-1 py-2 rounded-md text-sm font-medium border transition-colors',
                  i === currentIdx
                    ? 'border-primary bg-primary/10 text-primary'
                    : audioBlobs[t.numero_tache]
                      ? 'border-success/40 bg-success/5 text-success'
                      : 'border-border bg-card text-muted-foreground hover:border-primary/40',
                ].join(' ')}
              >
                {audioBlobs[t.numero_tache] ? <CheckCircle2 className="w-3.5 h-3.5 inline mr-1" /> : null}
                Tâche {t.numero_tache}
              </button>
            ))}
          </div>
        )}

        {tache && (
          <Card className="h-full">
            <CardHeader>
              <div className="flex items-center justify-between gap-3 flex-wrap">
                <CardTitle className="text-base text-balance">
                  Tâche {tache.numero_tache}
                  {tache.duree_secondes && (
                    <span className="text-sm font-normal text-muted-foreground ml-2">
                      — {Math.floor(tache.duree_secondes / 60)} min{tache.duree_secondes % 60 > 0 ? ` ${tache.duree_secondes % 60}s` : ''}
                    </span>
                  )}
                </CardTitle>
                <TimerDisplay seconds={timerActive ? timerSeconds : (tache.duree_secondes || 120)} />
              </div>
            </CardHeader>
            <CardContent className="space-y-4">
              <p className="text-sm text-foreground bg-muted/50 rounded-lg p-4 leading-relaxed text-pretty">
                {tache.consigne}
              </p>

              {/* Minuteur de préparation */}
              <div className="flex gap-2">
                {!timerActive ? (
                  <Button variant="outline" size="sm" onClick={() => { setTimerSeconds(tache.duree_secondes || 120); setTimerActive(true); }} className="gap-1.5">
                    <Clock className="w-3.5 h-3.5" /> Démarrer minuteur
                  </Button>
                ) : (
                  <Button variant="outline" size="sm" onClick={() => setTimerActive(false)} className="gap-1.5">
                    <Pause className="w-3.5 h-3.5" /> Arrêter minuteur
                  </Button>
                )}
              </div>

              {/* Enregistrement audio */}
              <div className="border border-border rounded-lg p-4 space-y-3 bg-muted/20">
                <p className="text-xs font-semibold text-muted-foreground uppercase tracking-wide">
                  Enregistrement audio
                </p>
                <AudioRecorder
                  key={tache.numero_tache}
                  tacheNum={tache.numero_tache}
                  onRecorded={handleRecorded}
                  disabled={submitting}
                  initialRecorded={!!audioBlobs[tache.numero_tache]}
                />
              </div>
            </CardContent>
          </Card>
        )}

        {/* Navigation tâches */}
        {taches.length > 1 && (
          <div className="flex gap-3">
            <Button variant="outline" disabled={currentIdx === 0} onClick={() => { setCurrentIdx(i => i - 1); setTimerActive(false); }} className="flex-1">
              <ChevronLeft className="w-4 h-4 mr-1" /> Précédente
            </Button>
            <Button disabled={currentIdx === taches.length - 1} onClick={() => { setCurrentIdx(i => i + 1); setTimerActive(false); }} className="flex-1">
              Suivante <ChevronRight className="w-4 h-4 ml-1" />
            </Button>
          </div>
        )}

        {/* Bouton soumettre */}
        {taches.length > 0 && (
          <Button
            onClick={submitExpressionOrale}
            disabled={submitting || !anyRecorded}
            className="w-full gap-2"
          >
            {submitting
              ? <><Loader2 className="w-4 h-4 animate-spin" />Envoi en cours…</>
              : allRecorded
                ? <><Send className="w-4 h-4" />Envoyer toutes les tâches pour correction</>
                : <><Send className="w-4 h-4" />Envoyer les tâches enregistrées ({taches.filter(t => audioBlobs[t.numero_tache]).length}/{taches.length})</>
            }
          </Button>
        )}
      </div>
    );
  }

  // ─── Résultats QCM ────────────────────────────────────────────────────────────
  if (sessionDone) {
    const correct = questions.filter((q, i) => reponses[i] === q.bonne_reponse).length;
    const pct = Math.round((correct / questions.length) * 100);
    const niveau = pctToCECRL(pct);
    const niveauColor = CECRL_COLORS[niveau];
    const niveauDesc = CECRL_DESCRIPTIONS[niveau];
    return (
      <div className="max-w-2xl mx-auto space-y-6 fade-in">
        <div className="text-center space-y-3 py-6">
          <div className="w-20 h-20 rounded-full bg-primary/15 flex items-center justify-center mx-auto">
            <Trophy className="w-10 h-10 text-primary" />
          </div>
          <h1 className="text-2xl font-bold text-balance">Résultats de la séance</h1>
          <p className="text-muted-foreground text-pretty">{EPREUVE_LABELS[selectedEpreuve]}</p>
        </div>
        <div className="grid grid-cols-3 gap-3">
          <Card className="h-full">
            <CardContent className="p-4 text-center space-y-1">
              <p className="text-3xl font-bold text-primary leading-tight">
                {correct}<span className="text-base text-muted-foreground font-normal">/{questions.length}</span>
              </p>
              <p className="text-xs text-muted-foreground">Bonnes réponses</p>
            </CardContent>
          </Card>
          <Card className="h-full">
            <CardContent className="p-4 text-center space-y-1">
              <p className="text-3xl font-bold text-foreground leading-tight">
                {pct}<span className="text-base text-muted-foreground font-normal">%</span>
              </p>
              <p className="text-xs text-muted-foreground">Taux de réussite</p>
            </CardContent>
          </Card>
          <Card className="h-full">
            <CardContent className="p-4 text-center space-y-1">
              <p className="text-3xl font-bold leading-tight" style={{ color: niveauColor }}>{niveau}</p>
              <p className="text-xs text-muted-foreground">{niveauDesc}</p>
            </CardContent>
          </Card>
        </div>
        <div className="space-y-2">
          <div className="flex items-center justify-between text-xs text-muted-foreground">
            <span>A1</span><span>A2</span><span>B1</span><span>B2</span><span>C1</span><span>C2</span>
          </div>
          <div className="relative h-3 bg-muted rounded-full overflow-hidden">
            <div className="h-full rounded-full transition-all duration-700" style={{ width: `${pct}%`, backgroundColor: niveauColor }} />
          </div>
          <p className="text-center text-sm font-medium" style={{ color: niveauColor }}>
            Niveau estimé : <strong>{niveau}</strong> — {niveauDesc}
          </p>
        </div>
        <div className="space-y-2">
          <p className="text-sm font-medium text-muted-foreground uppercase tracking-wide">Détail des réponses</p>
          {questions.map((q, i) => {
            const given = reponses[i];
            const isCorrect = given === q.bonne_reponse;
            const chosenLabel = q.choix?.find(c => c.id === given)?.texte;
            const correctLabel = q.choix?.find(c => c.id === q.bonne_reponse)?.texte;
            return (
              <Card key={q.id} className={`h-full border-l-4 ${isCorrect ? 'border-l-success' : 'border-l-destructive'}`}>
                <CardContent className="p-4 space-y-1">
                  <div className="flex items-start gap-2">
                    {isCorrect
                      ? <CheckCircle2 className="w-4 h-4 text-success shrink-0 mt-0.5" />
                      : <XCircle className="w-4 h-4 text-destructive shrink-0 mt-0.5" />
                    }
                    <div className="flex-1 min-w-0">
                      <p className="text-sm text-foreground text-pretty line-clamp-2">
                        Q{i + 1}{q.niveau && ` (${q.niveau})`} — {q.texte || '(question audio/image)'}
                      </p>
                      {!isCorrect && (
                        <div className="mt-1 space-y-0.5">
                          <p className="text-xs text-destructive">Votre réponse : {given ? `${given}. ${chosenLabel}` : 'Non répondue'}</p>
                          <p className="text-xs text-success">Bonne réponse : {q.bonne_reponse}. {correctLabel}</p>
                        </div>
                      )}
                      {q.explication && <p className="text-xs text-muted-foreground mt-1 text-pretty">{q.explication}</p>}
                    </div>
                  </div>
                </CardContent>
              </Card>
            );
          })}
        </div>
        <div className="flex gap-3">
          <Button variant="outline" className="flex-1" onClick={() => setSessionKey(k => k + 1)}>Nouvelle séance</Button>
          <Button className="flex-1" onClick={() => setSelectedEpreuve(null)}>Choisir une autre épreuve</Button>
        </div>
      </div>
    );
  }

  // ─── QCM en cours ─────────────────────────────────────────────────────────────
  const question = questions[currentIdx];
  const answered = reponses[currentIdx] !== undefined;

  if (questions.length === 0) {
    return (
      <div className="max-w-2xl mx-auto">
        <div className="flex items-center gap-3 mb-6">
          <Button variant="ghost" size="icon" onClick={() => setSelectedEpreuve(null)}>
            <ChevronLeft className="w-5 h-5" />
          </Button>
          <h1 className="text-xl font-bold">{EPREUVE_LABELS[selectedEpreuve]}</h1>
        </div>
        <Card><CardContent className="p-8 text-center text-muted-foreground">Aucune question disponible pour cette épreuve.</CardContent></Card>
      </div>
    );
  }

  return (
    <div className="max-w-2xl mx-auto space-y-4 fade-in">
      <div className="flex items-center gap-3">
        <Button variant="ghost" size="icon" onClick={() => setSelectedEpreuve(null)}>
          <ChevronLeft className="w-5 h-5" />
        </Button>
        <div className="flex-1 min-w-0">
          <h1 className="text-lg font-bold text-foreground truncate">{EPREUVE_LABELS[selectedEpreuve]}</h1>
          <p className="text-sm text-muted-foreground">Question {currentIdx + 1} / {questions.length}</p>
        </div>
        {/* Le niveau de difficulté est masqué pendant la simulation conformément aux spécifications */}
      </div>
      <Progress value={((currentIdx + 1) / questions.length) * 100} className="h-2" />
      <Card className="h-full">
        <CardContent className="p-6 space-y-4">
          {question?.audio_url && <AudioPlayer url={question.audio_url} />}
          {question?.image_url && (
            <div className="rounded-lg overflow-hidden max-h-48">
              <img src={question.image_url} alt="Question" className="w-full h-full object-cover" />
            </div>
          )}
          {question?.texte && (
            <p className="text-sm text-foreground leading-relaxed text-pretty whitespace-pre-wrap">{question.texte}</p>
          )}
          <div className="space-y-2 pt-2">
            {question?.choix?.map(choix => {
              const isSelected = reponses[currentIdx] === choix.id;
              const isCorrect = choix.id === question.bonne_reponse;
              let cls = 'border-border bg-card';
              if (answered) {
                if (isCorrect) cls = 'border-success bg-success/10';
                else if (isSelected && !isCorrect) cls = 'border-destructive bg-destructive/10';
              } else if (isSelected) cls = 'border-primary bg-primary/10';
              return (
                <button
                  key={choix.id}
                  onClick={() => handleAnswer(choix.id)}
                  disabled={answered}
                  className={['w-full text-left px-4 py-3 rounded-md border text-sm transition-colors flex items-start gap-3',
                    !answered && 'hover:border-primary/50 hover:bg-primary/5', cls].filter(Boolean).join(' ')}
                >
                  <span className="font-semibold text-muted-foreground shrink-0 w-5">{choix.id}.</span>
                  <span className="flex-1 text-pretty">{choix.texte}</span>
                  {answered && isCorrect && <CheckCircle2 className="w-4 h-4 text-success shrink-0 mt-0.5" />}
                  {answered && isSelected && !isCorrect && <XCircle className="w-4 h-4 text-destructive shrink-0 mt-0.5" />}
                </button>
              );
            })}
          </div>
          {answered && question?.explication && (
            <Alert className="border-primary/30 bg-primary/5">
              <BookOpen className="h-4 w-4 text-primary" />
              <AlertDescription className="text-pretty text-sm">{question.explication}</AlertDescription>
            </Alert>
          )}
        </CardContent>
      </Card>
      {answered && (
        <Button className="w-full" onClick={nextQuestion}>
          {currentIdx === questions.length - 1
            ? <><Trophy className="w-4 h-4 mr-2" />Voir mes résultats</>
            : <>Question suivante <ChevronRight className="w-4 h-4 ml-1" /></>
          }
        </Button>
      )}
    </div>
  );
}
