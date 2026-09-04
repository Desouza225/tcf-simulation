import { useState, useEffect, useCallback, useRef } from 'react';
import { Link, useParams, useNavigate } from 'react-router-dom';
import { supabase } from '@/db/supabase';
import { useAuth } from '@/contexts/AuthContext';
import { resolvePlayableAudioUrl, fetchAudioBlobUrl, getAudioClaritySetting, attachAudioClarityProcessor } from '@/lib/audioProcessing';
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
  Volume2, FastForward, HelpCircle, Info, Sparkles, BookOpen,
  Check, Award, Download, RotateCcw,
} from 'lucide-react';
import { toast } from 'sonner';
import type { Production, Profile, NiveauCECRL } from '@/types/index';
import {
  pctToCECRL,
  scoreEeToCECRL,
  scoreEeToCECRLLabel,
  scoreEoToCECRL,
  scoreEoToCECRLLabel,
  CONVERSION_CECRL_EXPRESSION_ECRITE,
  CONVERSION_CECRL_EXPRESSION_ORALE,
  CECRL_COLORS,
  CECRL_DESCRIPTIONS,
} from '@/types/index';
import { cn } from '@/lib/utils';

// Max points par grille (TCF officiel)
const MAX_EE = 20; // 8+8+4
const MAX_EO = 20; // 8+8+4 (Critères linguistiques 8 + pragmatiques 8 + sociolinguistiques 4)

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

export interface CritereGrille {
  nom: string;
  points_max: number;
  description: string;
  aideDepartage?: string;
}

export interface DimensionGrille {
  nom: string;
  points_max: number;
  description?: string;
  criteres: CritereGrille[];
}

// Grille officielle Expression Écrite TCF Canada (3 dimensions, 20 points au total)
export const GRILLE_EXPRESSION_ECRITE_DIMENSIONS: DimensionGrille[] = [
  {
    nom: 'Compétence linguistique',
    points_max: 8,
    description: 'Étendue et maîtrise du vocabulaire, correction grammaticale, orthographe et ponctuation.',
    criteres: [
      {
        nom: 'Étendue du lexique',
        points_max: 2,
        description: 'Vocabulaire varié, précis, adapté au sujet. Évite les répétitions excessives.',
      },
      {
        nom: 'Maîtrise du lexique',
        points_max: 2,
        description: 'Choix des mots appropriés au contexte et au registre.',
      },
      {
        nom: 'Correction grammaticale',
        points_max: 2,
        description: 'Conjugaison correcte, accords (sujet-verbe, nom-adjectif), structures de phrases variées.',
      },
      {
        nom: 'Orthographe et ponctuation',
        points_max: 2,
        description: 'Orthographe lexicale et grammaticale correcte. Ponctuation appropriée.',
      },
    ],
  },
  {
    nom: 'Compétence pragmatique',
    points_max: 8,
    description: 'Respect de la consigne, cohérence textuelle, connecteurs logiques et développement des idées.',
    criteres: [
      {
        nom: 'Respect de la consigne',
        points_max: 3,
        description: 'Réponse complète à la tâche demandée. Nombre de mots respecté (±10%). Format approprié (message, article, lettre).',
      },
      {
        nom: 'Cohérence et cohésion',
        points_max: 3,
        description: 'Clarté structurelle : organisation logique du texte (paragraphes, plan visible), connecteurs (d\'abord, ensuite, cependant, donc), idées enchaînées sans rupture ni contradiction.',
        aideDepartage: '1. Le texte est-il bien construit formellement (paragraphes, connecteurs, enchaînement) ? → Cohérence et cohésion.',
      },
      {
        nom: 'Développement thématique',
        points_max: 2,
        description: 'Idées développées avec exemples, arguments ou explications. Pas de hors-sujet.',
      },
    ],
  },
  {
    nom: 'Compétence sociolinguistique',
    points_max: 4,
    description: 'Adaptation du registre au destinataire et clarté de l\'intention communicative.',
    criteres: [
      {
        nom: 'Registre de langue et adéquation',
        points_max: 2,
        description: 'Le ton, le style et les formules correspondent au destinataire (ami, collègue, administration).',
      },
      {
        nom: 'Clarté de la communication',
        points_max: 2,
        description: 'Clarté communicative : même si le texte est bien structuré, le destinataire comprend-il immédiatement l\'intention (informer, convaincre, demander, expliquer) et ce qu\'on attend de lui ?',
        aideDepartage: '2. Une fois cette structure lue, le lecteur sait-il concrètement quoi faire ou penser ? → Clarté de la communication.',
      },
    ],
  },
];

// Grille officielle Expression Orale TCF Canada (3 dimensions, 20 points au total)
export const GRILLE_EXPRESSION_ORALE_DIMENSIONS: DimensionGrille[] = [
  {
    nom: 'Critères linguistiques',
    points_max: 8,
    description: 'Étendue et maîtrise du lexique, correction grammaticale, aisance et fluidité, prononciation et intonation.',
    criteres: [
      {
        nom: 'Étendue et maîtrise du lexique',
        points_max: 2,
        description: 'Vocabulaire varié et précis. Capacité à utiliser des expressions idiomatiques et à contourner les mots inconnus.',
      },
      {
        nom: 'Correction grammaticale',
        points_max: 2,
        description: 'Conjugaison correcte, accords (sujet-verbe, nom-adjectif), structures de phrases variées (simples, complexes, subordonnées).',
      },
      {
        nom: 'Aisance et fluidité',
        points_max: 2,
        description: 'Débit naturel, peu d\'hésitations (« euh… », silences longs), capacité à parler en continu sans bloquer.',
      },
      {
        nom: 'Prononciation et intonation',
        points_max: 2,
        description: 'Articulation claire, prononciation correcte des sons français (nasales, u/ou, é/è), intonation naturelle.',
      },
    ],
  },
  {
    nom: 'Critères pragmatiques',
    points_max: 8,
    description: 'Capacité à interagir, structuration du discours, cohérence et développement thématique.',
    criteres: [
      {
        nom: 'Capacité à interagir',
        points_max: 2,
        description: 'Saluer, poser des questions adaptées, relancer, prendre son tour de parole, répondre aux questions de l\'examinateur.',
      },
      {
        nom: 'Structuration du discours',
        points_max: 3,
        description: 'Organisation logique (introduction, développement, conclusion). Utilisation de connecteurs oraux (d\'abord, ensuite, cependant, donc, en résumé).',
      },
      {
        nom: 'Cohérence et développement thématique',
        points_max: 3,
        description: 'Les idées s\'enchaînent logiquement. Le sujet est développé avec des exemples, des arguments ou des explications. Pas de hors-sujet.',
      },
    ],
  },
  {
    nom: 'Critères sociolinguistiques',
    points_max: 4,
    description: 'Adéquation à la situation de communication et registre adapté.',
    criteres: [
      {
        nom: 'Adéquation à la situation de communication',
        points_max: 4,
        description: 'Le ton, le style et le registre correspondent à la tâche (entretien formel T1, jeu de rôle quotidien T2, présentation argumentée T3). Formules de politesse adaptées.',
      },
    ],
  },
];

function getWordTarget(numTache: number) {
  if (numTache === 1) return { min: 60, max: 120, label: '60 à 120 mots' };
  if (numTache === 2) return { min: 120, max: 150, label: '120 à 150 mots' };
  return { min: 120, max: 180, label: '120 à 180 mots' };
}

function AudioPlayerCorrection({ url, label }: { url: string; label?: string }) {
  const ref = useRef<HTMLAudioElement>(null);
  const [playableUrl, setPlayableUrl] = useState<string>('');
  const [loadingAudio, setLoadingAudio] = useState(true);
  const [playing, setPlaying] = useState(false);
  const [error, setError] = useState(false);
  const [playbackRate, setPlaybackRate] = useState<number>(1);
  const [duration, setDuration] = useState<number>(0);
  const [currentTime, setCurrentTime] = useState<number>(0);

  // Résolution robuste de l'URL au montage ou changement d'URL
  const initAudio = useCallback(async () => {
    if (!url) {
      setError(true);
      setLoadingAudio(false);
      return;
    }
    setLoadingAudio(true);
    setError(false);
    try {
      const resolved = await resolvePlayableAudioUrl(url);
      setPlayableUrl(resolved || url);
    } catch (err) {
      console.warn('Erreur resolvePlayableAudioUrl:', err);
      setPlayableUrl(url);
    } finally {
      setLoadingAudio(false);
    }
  }, [url]);

  useEffect(() => {
    initAudio();
  }, [initAudio]);

  const toggleRate = () => {
    const rates = [1, 1.25, 1.5];
    const nextIdx = (rates.indexOf(playbackRate) + 1) % rates.length;
    const nextRate = rates[nextIdx];
    setPlaybackRate(nextRate);
    if (ref.current) ref.current.playbackRate = nextRate;
  };

  const handleTogglePlay = async () => {
    if (!ref.current) return;
    if (playing) {
      ref.current.pause();
      setPlaying(false);
    } else {
      try {
        const clarityEnabled = await getAudioClaritySetting();
        attachAudioClarityProcessor(ref.current, clarityEnabled);
        await ref.current.play();
        setPlaying(true);
      } catch (err) {
        console.warn('Erreur play:', err);
      }
    }
  };

  // En cas d'erreur de lecture directe sur <audio>, tentative de secours immédiat via téléchargement binaire du blob
  const handleAudioError = async () => {
    console.warn('Erreur de lecture audio standard, tentative de secours via téléchargement binaire...');
    try {
      const blobUrl = await fetchAudioBlobUrl(url);
      if (blobUrl && blobUrl !== playableUrl) {
        setPlayableUrl(blobUrl);
        setError(false);
        return;
      }
    } catch (err) {
      console.error('Échec du fallback audio:', err);
    }
    setError(true);
    setPlaying(false);
  };

  const formatTime = (secs: number) => {
    const m = Math.floor(secs / 60);
    const s = Math.floor(secs % 60);
    return `${m}:${s.toString().padStart(2, '0')}`;
  };

  return (
    <div className="flex flex-col gap-3 p-4 bg-muted/60 border border-border rounded-xl">
      <div className="flex items-center gap-3">
        <button
          onClick={handleTogglePlay}
          disabled={error || loadingAudio || !playableUrl}
          className="w-10 h-10 rounded-full bg-primary flex items-center justify-center text-primary-foreground shrink-0 shadow-sm hover:opacity-90 transition-opacity disabled:opacity-40"
        >
          {loadingAudio ? (
            <Loader2 className="w-4 h-4 animate-spin" />
          ) : playing ? (
            <Pause className="w-5 h-5" />
          ) : (
            <Play className="w-5 h-5 ml-0.5" />
          )}
        </button>

        <div className="flex-1 min-w-0">
          <div className="flex items-center justify-between text-xs text-muted-foreground mb-1">
            <span className="font-medium text-foreground flex items-center gap-1.5 truncate">
              <Volume2 className="w-3.5 h-3.5 text-primary shrink-0" />
              {loadingAudio
                ? 'Chargement de l\'audio...'
                : error
                ? '⚠ Échec de lecture directe'
                : (label || 'Enregistrement audio du candidat')}
            </span>
            <span className="shrink-0 font-mono">
              {formatTime(currentTime)} / {duration > 0 ? formatTime(duration) : '--:--'}
            </span>
          </div>

          <input
            type="range"
            min={0}
            max={duration || 100}
            value={currentTime}
            disabled={error || loadingAudio}
            onChange={e => {
              const val = Number(e.target.value);
              setCurrentTime(val);
              if (ref.current) ref.current.currentTime = val;
            }}
            className="w-full h-1.5 bg-muted-foreground/20 rounded-lg appearance-none cursor-pointer accent-primary disabled:opacity-40"
          />
        </div>

        <div className="flex items-center gap-1 shrink-0">
          <Button
            type="button"
            variant="outline"
            size="sm"
            onClick={toggleRate}
            disabled={error || loadingAudio}
            className="h-8 px-2 text-xs font-mono shrink-0 gap-1 border-border"
            title="Modifier la vitesse de lecture"
          >
            <FastForward className="w-3 h-3" />
            {playbackRate}x
          </Button>

          {playableUrl && (
            <Button
              type="button"
              variant="ghost"
              size="sm"
              asChild
              className="h-8 px-2 text-xs shrink-0 text-muted-foreground hover:text-foreground"
              title="Télécharger / Ouvrir l'audio"
            >
              <a href={playableUrl} target="_blank" rel="noreferrer" download={`enregistrement_${Date.now()}.webm`}>
                <Download className="w-3.5 h-3.5" />
              </a>
            </Button>
          )}
        </div>
      </div>

      {error && (
        <div className="flex items-center justify-between gap-3 p-2.5 bg-destructive/10 border border-destructive/20 rounded-lg text-xs text-destructive">
          <span>Impossible de lire l'audio directement dans le navigateur.</span>
          <div className="flex items-center gap-2 shrink-0">
            <Button
              type="button"
              size="sm"
              variant="outline"
              onClick={() => handleAudioError()}
              className="h-7 text-xs gap-1 border-destructive/30 hover:bg-destructive/15"
            >
              <RotateCcw className="w-3 h-3" /> Réessayer
            </Button>
            {playableUrl && (
              <Button
                type="button"
                size="sm"
                variant="default"
                asChild
                className="h-7 text-xs gap-1"
              >
                <a href={playableUrl} target="_blank" rel="noreferrer" download>
                  <Download className="w-3 h-3" /> Télécharger
                </a>
              </Button>
            )}
          </div>
        </div>
      )}

      {playableUrl && (
        <audio
          ref={ref}
          src={playableUrl}
          crossOrigin="anonymous"
          onLoadedMetadata={e => {
            setError(false);
            setDuration(e.currentTarget.duration || 0);
          }}
          onTimeUpdate={e => setCurrentTime(e.currentTarget.currentTime || 0)}
          onEnded={() => setPlaying(false)}
          onError={handleAudioError}
        />
      )}
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
  const isEE = production?.epreuve === 'expression_ecrite';
  const dimensions = isEE ? GRILLE_EXPRESSION_ECRITE_DIMENSIONS : GRILLE_EXPRESSION_ORALE_DIMENSIONS;
  const maxTotal = isEE ? MAX_EE : MAX_EO;
  const scoreTotal = Math.round(Object.values(notes).reduce((a, b) => a + (Number(b) || 0), 0) * 100) / 100;
  
  const niveauTacheCode: NiveauCECRL | null = Object.keys(notes).length > 0
    ? (isEE ? scoreEeToCECRL(scoreTotal) : scoreEoToCECRL(scoreTotal))
    : null;
  const niveauTacheLabel: string | null = Object.keys(notes).length > 0
    ? (isEE ? scoreEeToCECRLLabel(scoreTotal) : scoreEoToCECRLLabel(scoreTotal))
    : null;

  const loadSessionProductions = useCallback(async (sessionId: string, epreuve: string) => {
    try {
      const { data } = await supabase
        .from('productions')
        .select('*')
        .eq('session_id', sessionId)
        .eq('epreuve', epreuve)
        .order('numero_tache', { ascending: true });
      if (data) setSessionProductions(data);
    } catch (e) {
      console.warn('Erreur loadSessionProductions:', e);
    }
  }, []);

  useEffect(() => {
    if (!id) return;
    const load = async () => {
      setLoading(true);
      try {
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

        if (prodData?.grille_notation) {
          try {
            const parsed = typeof prodData.grille_notation === 'string'
              ? JSON.parse(prodData.grille_notation)
              : prodData.grille_notation;
            if (parsed && typeof parsed === 'object' && !Array.isArray(parsed)) {
              const cleanNotes: Record<string, number> = {};
              Object.entries(parsed).forEach(([k, v]) => {
                const num = Number(v);
                if (!isNaN(num)) cleanNotes[k] = num;
              });
              setNotes(cleanNotes);
            }
          } catch (e) {
            console.warn('Erreur lecture grille_notation:', e);
          }
        }

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
            try {
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
            } catch (e) {
              console.warn('Erreur recherche tache par reference:', e);
            }
          }

          // 2. Si non trouvé par référence, chercher par epreuve + numero_tache
          if (!foundTache) {
            try {
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
            } catch (e) {
              console.warn('Erreur recherche tache par numero:', e);
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
          try {
            await loadSessionProductions(prodData.session_id, prodData.epreuve);
          } catch (e) {
            console.warn('Erreur chargement sessionProductions:', e);
          }
        }
      } catch (err) {
        console.error('Erreur chargement production interface:', err);
        toast.error('Erreur lors du chargement de la correction.');
      } finally {
        setLoading(false);
      }
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
      // 1. Tenter la soumission via la RPC atomique (prioritaire)
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

      console.warn('RPC submit_professeur_correction indisponible ou rejetée:', rpcErr);

      // 2. Fallback direct si la RPC n'est pas encore créée en base
      const { data: updatedRows, error: prodUpdateErr } = await supabase
        .from('productions')
        .update({
          statut_correction: 'corrige',
          score: scoreTotal,
          commentaire: commentaire || null,
          grille_notation: notes,
          raison_refus: null,
          corrige_at: new Date().toISOString(),
          professeur_id: user?.id || production.professeur_id || null,
        })
        .eq('id', id)
        .select();

      if (prodUpdateErr) {
        console.error('Erreur sauvegarde production directe:', prodUpdateErr);
        throw new Error(prodUpdateErr.message || 'Erreur lors de la soumission de la correction.');
      }

      if (!updatedRows || updatedRows.length === 0) {
        throw new Error(
          "Impossible de modifier cette ancienne production (sécurité RLS). Veuillez exécuter la migration SQL 00033 dans le SQL Editor de Supabase pour débloquer les droits d'écriture."
        );
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
      console.warn('RPC submit_professeur_correction refus indisponible:', rpcErr);

      const { data: refusedRows, error: prodErr } = await supabase
        .from('productions')
        .update({
          statut_correction: 'refuse',
          score: 0,
          audio_url: null,
          contenu_texte: null,
          raison_refus: raisonRefus.trim() || null,
          corrige_at: new Date().toISOString(),
          professeur_id: user?.id || production.professeur_id || null,
        })
        .eq('id', id)
        .select();

      if (prodErr) {
        console.error('Erreur refus production directe:', prodErr);
        throw new Error(prodErr.message || 'Erreur lors du refus.');
      }

      if (!refusedRows || refusedRows.length === 0) {
        throw new Error(
          "Impossible de refuser cette ancienne production (sécurité RLS). Veuillez exécuter la migration SQL 00033 dans le SQL Editor de Supabase pour débloquer les droits d'écriture."
        );
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

      {/* ─── GRILLE D'ÉVALUATION OFFICIELLE TCF CANADA ─── */}
      <Card className="shadow-sm border-border overflow-hidden">
        <CardHeader className="bg-muted/30 border-b border-border pb-4">
          <div className="flex items-center justify-between flex-wrap gap-3">
            <div>
              <CardTitle className="text-base md:text-lg flex items-center gap-2 font-bold text-foreground">
                <Award className="w-5 h-5 text-primary" />
                <span>
                  {isEE ? 'Grille d\'évaluation — Expression Écrite TCF Canada' : 'Grille d\'évaluation — Expression Orale TCF Canada'}
                </span>
              </CardTitle>
              <p className="text-xs text-muted-foreground mt-0.5">
                {isEE
                  ? 'Évaluez les 3 dimensions clés (20 points au total) avec conversion automatique en niveau CECRL.'
                  : 'Évaluez les 3 dimensions clés (20 points au total) avec conversion automatique en niveau CECRL selon la grille officielle.'}
              </p>
            </div>

            <div className="flex items-center gap-2.5">
              {niveauTacheLabel && niveauTacheCode && (
                <Badge
                  style={{ backgroundColor: CECRL_COLORS[niveauTacheCode] }}
                  className="text-white text-xs font-semibold px-2.5 py-1 shadow-xs"
                >
                  Niveau {niveauTacheLabel} {CECRL_DESCRIPTIONS[niveauTacheCode] ? `(${CECRL_DESCRIPTIONS[niveauTacheCode]})` : ''}
                </Badge>
              )}
              <div className="bg-background border border-border px-3 py-1 rounded-lg text-sm font-bold text-foreground font-mono">
                {scoreTotal} <span className="text-xs text-muted-foreground font-normal">/ {maxTotal} pts</span>
              </div>
            </div>
          </div>
        </CardHeader>

        <CardContent className="pt-5 space-y-6">
          {/* Règle de départage contextuelle pour l'Expression Écrite */}
          {isEE && (
            <div className="p-4 bg-amber-500/10 border border-amber-500/25 rounded-xl space-y-2 text-xs md:text-sm">
              <div className="flex items-center justify-between gap-2">
                <div className="flex items-center gap-2 font-semibold text-amber-900 dark:text-amber-300">
                  <HelpCircle className="w-4 h-4 text-amber-600 dark:text-amber-400 shrink-0" />
                  <span>Règle de départage : « Cohérence et cohésion » vs « Clarté de la communication »</span>
                </div>
                <Badge variant="outline" className="text-[10px] uppercase font-bold border-amber-500/40 text-amber-800 dark:text-amber-300 bg-amber-500/10">
                  Aide professeur
                </Badge>
              </div>
              <p className="text-foreground/90 leading-relaxed text-xs">
                <strong>1. Cohérence et cohésion :</strong> Le texte est-il bien construit formellement (paragraphes, connecteurs logiques, idées enchaînées sans rupture ni contradiction) ?<br />
                <strong>2. Clarté de la communication :</strong> Une fois cette structure lue, le lecteur sait-il concrètement quoi faire ou penser (intention claire et action attendue bien comprise) ?
              </p>
              <p className="text-[11px] text-muted-foreground italic border-t border-amber-500/20 pt-1.5 mt-1">
                💡 Exemple : Une lettre bien structurée en 3 paragraphes mais qui ne formule jamais clairement la demande aura une bonne note en « Cohérence » mais une note plus faible en « Clarté ».
              </p>
            </div>
          )}

          {/* Rappel visuel du contexte des 3 tâches pour l'Expression Orale */}
          {!isEE && (
            <div className="p-4 bg-primary/10 border border-primary/25 rounded-xl space-y-2.5 text-xs md:text-sm">
              <div className="flex items-center justify-between gap-2">
                <div className="flex items-center gap-2 font-semibold text-primary">
                  <Info className="w-4 h-4 text-primary shrink-0" />
                  <span>Rappel du contexte des 3 tâches — Expression Orale TCF Canada</span>
                </div>
                <Badge variant="outline" className="text-[10px] uppercase font-bold border-primary/40 text-primary bg-primary/10">
                  Repère professeur
                </Badge>
              </div>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-2.5 pt-1 text-xs">
                <div className={cn("p-2.5 rounded-lg border transition-all", production.numero_tache === 1 ? "bg-primary/15 border-primary font-medium ring-1 ring-primary/40" : "bg-card/80 border-border/80")}>
                  <div className="font-bold text-foreground flex items-center justify-between">
                    <span>T1 – Entretien dirigé</span>
                    <span className="text-[10px] font-mono text-muted-foreground">~2 min</span>
                  </div>
                  <p className="text-muted-foreground text-[11px] mt-1 leading-relaxed">
                    Parler de soi, de sa famille, de son environnement, de son parcours et de ses projets.
                  </p>
                </div>
                <div className={cn("p-2.5 rounded-lg border transition-all", production.numero_tache === 2 ? "bg-primary/15 border-primary font-medium ring-1 ring-primary/40" : "bg-card/80 border-border/80")}>
                  <div className="font-bold text-foreground flex items-center justify-between">
                    <span>T2 – Exercice d'interaction</span>
                    <span className="text-[10px] font-mono text-muted-foreground">~3 min 30</span>
                  </div>
                  <p className="text-muted-foreground text-[11px] mt-1 leading-relaxed">
                    Obtenir des informations via un jeu de rôle avec l'examinateur (2 min préparation).
                  </p>
                </div>
                <div className={cn("p-2.5 rounded-lg border transition-all", production.numero_tache === 3 ? "bg-primary/15 border-primary font-medium ring-1 ring-primary/40" : "bg-card/80 border-border/80")}>
                  <div className="font-bold text-foreground flex items-center justify-between">
                    <span>T3 – Point de vue argumenté</span>
                    <span className="text-[10px] font-mono text-muted-foreground">~4 min 30</span>
                  </div>
                  <p className="text-muted-foreground text-[11px] mt-1 leading-relaxed">
                    Argumenter spontanément et de manière structurée sur un thème de société.
                  </p>
                </div>
              </div>
              <p className="text-[11px] text-muted-foreground italic border-t border-primary/20 pt-1.5 mt-1">
                💡 La grille s'applique à la prestation globale du candidat et sert de repère structuré selon votre appréciation professionnelle.
              </p>
            </div>
          )}

          {/* Dimensions et critères */}
          <div className="space-y-6">
            {dimensions.map((dim, dimIdx) => {
              const dimScore = Math.round(
                dim.criteres.reduce((acc, c) => acc + (notes[c.nom] !== undefined ? Number(notes[c.nom]) : 0), 0) * 100
              ) / 100;

              return (
                <div
                  key={dim.nom}
                  className="rounded-xl border border-border bg-card p-4 md:p-5 space-y-4 shadow-2xs"
                >
                  {/* En-tête de dimension avec sous-total automatique */}
                  <div className="flex items-center justify-between gap-3 flex-wrap border-b border-border/80 pb-3">
                    <div className="flex items-center gap-2.5">
                      <span className="w-6 h-6 rounded-full bg-primary/10 text-primary text-xs font-bold flex items-center justify-center shrink-0">
                        {dimIdx + 1}
                      </span>
                      <div>
                        <h3 className="font-bold text-sm md:text-base text-foreground">
                          {dim.nom}
                        </h3>
                        {dim.description && (
                          <p className="text-xs text-muted-foreground">{dim.description}</p>
                        )}
                      </div>
                    </div>

                    <Badge
                      variant="outline"
                      className={cn(
                        'text-xs font-mono font-semibold px-2.5 py-1',
                        dimScore > 0 ? 'bg-primary/10 text-primary border-primary/30' : 'bg-muted text-muted-foreground'
                      )}
                    >
                      Sous-total : {dimScore} / {dim.points_max} pts
                    </Badge>
                  </div>

                  {/* Critères de la dimension */}
                  <div className="space-y-3.5">
                    {dim.criteres.map(c => {
                      const noteVal = notes[c.nom];
                      return (
                        <div
                          key={c.nom}
                          className="flex flex-col md:flex-row md:items-center justify-between gap-3 p-3 rounded-lg bg-muted/25 hover:bg-muted/45 transition-colors border border-border/50"
                        >
                          {/* Intitulé & description du critère */}
                          <div className="flex-1 min-w-0 pr-2 space-y-1">
                            <div className="flex items-center gap-2 flex-wrap">
                              <Label className="text-sm font-semibold text-foreground cursor-default">
                                {c.nom}
                              </Label>
                              {c.aideDepartage && (
                                <Badge
                                  variant="outline"
                                  className="text-[10px] py-0 h-4.5 bg-amber-500/10 text-amber-700 dark:text-amber-400 border-amber-500/30"
                                  title={c.aideDepartage}
                                >
                                  Départage
                                </Badge>
                              )}
                            </div>
                            <p className="text-xs text-muted-foreground leading-relaxed">
                              {c.description}
                            </p>
                            {c.aideDepartage && (
                              <p className="text-[11px] text-amber-700/90 dark:text-amber-400/90 font-medium">
                                ↳ {c.aideDepartage}
                              </p>
                            )}
                          </div>

                          {/* Champ de saisie de la note */}
                          <div className="flex items-center gap-2 shrink-0 self-end md:self-center">
                            <div className="flex items-center gap-1.5">
                              <Input
                                type="number"
                                step="0.5"
                                min={0}
                                max={c.points_max}
                                placeholder="0"
                                value={noteVal !== undefined ? noteVal : ''}
                                onChange={e => {
                                  const raw = e.target.value.replace(',', '.');
                                  if (raw === '') {
                                    const updated = { ...notes };
                                    delete updated[c.nom];
                                    setNotes(updated);
                                  } else {
                                    const num = parseFloat(raw);
                                    const val = isNaN(num) ? 0 : Math.min(c.points_max, Math.max(0, Math.round(num * 100) / 100));
                                    setNotes(prev => ({ ...prev, [c.nom]: val }));
                                  }
                                }}
                                className="w-20 text-center font-bold font-mono text-base bg-background h-9"
                              />
                              <span className="text-xs md:text-sm font-medium text-muted-foreground w-12">
                                / {c.points_max} pts
                              </span>
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </div>
              );
            })}
          </div>

          {/* Récapitulatif Total + CECRL Automatique */}
          <div className="pt-4 border-t border-border flex flex-col md:flex-row items-start md:items-center justify-between gap-4 bg-muted/30 p-4 rounded-xl">
            <div className="space-y-1">
              <div className="flex items-center gap-2">
                <span className="font-bold text-base text-foreground">Score total de la tâche</span>
                <Badge variant="outline" className="text-[10px] text-muted-foreground border-border">
                  Barème officiel / 20
                </Badge>
              </div>
              <p className="text-xs text-muted-foreground">
                Somme automatique des {dimensions.reduce((a, d) => a + d.criteres.length, 0)} critères de notation
              </p>
            </div>

            <div className="flex items-center gap-3 self-end md:self-auto flex-wrap">
              {niveauTacheLabel && niveauTacheCode && (
                <div className="flex items-center gap-2">
                  <span className="text-xs text-muted-foreground font-medium">Niveau CECRL :</span>
                  <Badge
                    style={{ backgroundColor: CECRL_COLORS[niveauTacheCode] }}
                    className="text-white text-sm px-3 py-1 font-bold shadow-xs"
                  >
                    {niveauTacheLabel}
                  </Badge>
                </div>
              )}
              <div className="bg-card border border-border px-4 py-1.5 rounded-lg shadow-xs">
                <span className="font-bold text-2xl text-foreground font-mono tabular-nums">
                  {scoreTotal}
                </span>
                <span className="text-sm text-muted-foreground font-normal ml-1">
                  / {maxTotal}
                </span>
              </div>
            </div>
          </div>

          {/* Barème de conversion CECRL officiel (Expression Écrite ou Expression Orale) */}
          <div className="p-3 bg-muted/20 border border-border/60 rounded-lg text-xs space-y-2">
            <span className="font-semibold text-foreground flex items-center gap-1.5">
              <BookOpen className="w-3.5 h-3.5 text-primary" />
              Tableau de conversion officiel {isEE ? 'Expression Écrite' : 'Expression Orale'} (Score /20 → Niveau CECRL) :
            </span>
            <div className="grid grid-cols-2 sm:grid-cols-4 md:grid-cols-7 gap-2 pt-1 font-mono text-[11px]">
              {(isEE ? CONVERSION_CECRL_EXPRESSION_ECRITE : CONVERSION_CECRL_EXPRESSION_ORALE).map(item => {
                const isCurrentRange = scoreTotal >= item.score_min && scoreTotal <= item.score_max && Object.keys(notes).length > 0;
                return (
                  <div
                    key={item.label}
                    className={cn(
                      'p-1.5 rounded border text-center transition-all',
                      isCurrentRange
                        ? 'border-primary bg-primary/10 text-primary font-bold ring-1 ring-primary'
                        : 'border-border/60 bg-card text-muted-foreground'
                    )}
                  >
                    <div className="font-semibold">{item.score_min} – {item.score_max} pts</div>
                    <div className="text-foreground font-bold">{item.label}</div>
                  </div>
                );
              })}
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
                const isEE_ = p.epreuve === 'expression_ecrite';
                const nivCode = (isCorrigee || (isCurrent && Object.keys(notes).length > 0)) && !isRefuse
                  ? (isEE_ ? scoreEeToCECRL(scoreAffiche) : scoreEoToCECRL(scoreAffiche))
                  : null;
                const nivLabel = (isCorrigee || (isCurrent && Object.keys(notes).length > 0)) && !isRefuse
                  ? (isEE_ ? scoreEeToCECRLLabel(scoreAffiche) : scoreEoToCECRLLabel(scoreAffiche))
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
                      ) : nivCode && nivLabel ? (
                        <>
                          <Badge style={{ backgroundColor: CECRL_COLORS[nivCode] }} className="text-white text-xs">
                            {nivLabel}
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
              const isEE_ = production?.epreuve === 'expression_ecrite';
              const scoreMoyen = somme / terminees.length;
              const pct = maxTotal_ > 0 ? Math.round((somme / maxTotal_) * 100) : 0;
              const niveauEpreuveCode = isEE_ ? scoreEeToCECRL(scoreMoyen) : scoreEoToCECRL(scoreMoyen);
              const niveauEpreuveLabel = isEE_ ? scoreEeToCECRLLabel(scoreMoyen) : scoreEoToCECRLLabel(scoreMoyen);
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
                    <Badge style={{ backgroundColor: CECRL_COLORS[niveauEpreuveCode] }} className="text-white font-semibold">
                      Niveau {niveauEpreuveLabel} — {CECRL_DESCRIPTIONS[niveauEpreuveCode]}
                    </Badge>
                    <span className="font-bold text-xl text-foreground tabular-nums">{somme} / {maxTotal_}</span>
                  </div>
                </div>
              );
            })()}
          </CardContent>
        </Card>
      )}

      {/* ─── COMMENTAIRE GLOBAL DU PROFESSEUR ─── */}
      <Card className="shadow-sm border-border">
        <CardHeader className="pb-3">
          <CardTitle className="text-base flex items-center gap-2">
            <FileText className="w-4 h-4 text-primary" />
            <span>Commentaire global du professeur</span>
          </CardTitle>
          <p className="text-xs text-muted-foreground">
            Laissez une appréciation générale sur la copie (points forts, axes d'amélioration, conseils pour le candidat).
          </p>
        </CardHeader>
        <CardContent>
          <Textarea
            placeholder="Rédigez votre appréciation globale pour l'étudiant..."
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
