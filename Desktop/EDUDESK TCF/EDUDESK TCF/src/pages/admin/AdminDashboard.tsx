import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { supabase } from '@/db/supabase';
import { getAudioClaritySetting, setAudioClaritySetting } from '@/lib/audioProcessing';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Switch } from '@/components/ui/switch';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import { Users, ClipboardList, BookOpen, TrendingUp, UserCheck, Volume2, Sparkles, SlidersHorizontal, CheckCircle2 } from 'lucide-react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';
import { toast } from 'sonner';

export default function AdminDashboard() {
  const navigate = useNavigate();
  const [stats, setStats] = useState({
    totalEtudiants: 0, totalProfesseurs: 0, totalSessions: 0,
    totalQuestions: 0, correctionsEnAttente: 0,
  });
  const [loading, setLoading] = useState(true);
  const [sessionsParMois, setSessionsParMois] = useState<{ mois: string; sessions: number }[]>([]);
  const [audioClarity, setAudioClarity] = useState(true);
  const [updatingAudio, setUpdatingAudio] = useState(false);

  useEffect(() => {
    const load = async () => {
      const [etudiants, professeurs, sessions, questions, corrections, claritySetting] = await Promise.all([
        supabase.from('profiles').select('id', { count: 'exact' }).eq('role', 'etudiant'),
        supabase.from('profiles').select('id', { count: 'exact' }).eq('role', 'professeur'),
        supabase.from('sessions_examen').select('id', { count: 'exact' }),
        supabase.from('questions').select('id', { count: 'exact' }),
        supabase.from('productions').select('id', { count: 'exact' }).eq('statut_correction', 'en_attente'),
        getAudioClaritySetting(),
      ]);
      setStats({
        totalEtudiants: etudiants.count || 0,
        totalProfesseurs: professeurs.count || 0,
        totalSessions: sessions.count || 0,
        totalQuestions: questions.count || 0,
        correctionsEnAttente: corrections.count || 0,
      });
      setAudioClarity(claritySetting);

      // Sessions par mois (6 derniers mois)
      const { data: sessionData } = await supabase.from('sessions_examen').select('created_at').order('created_at', { ascending: false }).limit(200);
      if (Array.isArray(sessionData)) {
        const map: Record<string, number> = {};
        sessionData.forEach(s => {
          const m = new Date(s.created_at).toLocaleDateString('fr-FR', { month: 'short', year: '2-digit' });
          map[m] = (map[m] || 0) + 1;
        });
        setSessionsParMois(Object.entries(map).slice(0, 6).reverse().map(([mois, sessions]) => ({ mois, sessions })));
      }
      setLoading(false);
    };
    load();
  }, []);

  const handleToggleAudioClarity = async (checked: boolean) => {
    setUpdatingAudio(true);
    setAudioClarity(checked);
    try {
      await setAudioClaritySetting(checked);
      toast.success(
        checked
          ? 'Optimisation et Clarté Vocale activées pour tous les étudiants !'
          : 'Optimisation désactivée — son brut d\'origine rétabli pour tous.'
      );
    } catch (err: any) {
      setAudioClarity(!checked);
      toast.error('Erreur lors de la mise à jour du paramètre : ' + (err?.message || 'Erreur'));
    } finally {
      setUpdatingAudio(false);
    }
  };

  const cards = [
    { label: 'Étudiants', value: stats.totalEtudiants, icon: Users, color: 'text-primary', href: '/admin/utilisateurs?role=etudiant' },
    { label: 'Professeurs', value: stats.totalProfesseurs, icon: UserCheck, color: 'text-secondary', href: '/admin/utilisateurs?role=professeur' },
    { label: "Sessions d'examen", value: stats.totalSessions, icon: ClipboardList, color: 'text-primary', href: '/admin/suivi-etudiants' },
    { label: 'Questions dans la banque', value: stats.totalQuestions, icon: BookOpen, color: 'text-secondary', href: '/admin/questions' },
    { label: 'Corrections en attente', value: stats.correctionsEnAttente, icon: TrendingUp, color: 'text-destructive', href: '/admin/suivi-etudiants' },
  ];

  return (
    <div className="max-w-5xl mx-auto space-y-6 fade-in">
      <div>
        <h1 className="text-2xl font-bold text-foreground text-balance">Tableau de bord Admin</h1>
        <p className="text-muted-foreground mt-1">Vue d'ensemble de la plateforme EduDesk TCF</p>
      </div>

      <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
        {cards.map(card => (
          <Card
            key={card.label}
            className="h-full cursor-pointer hover:border-primary/40 hover:shadow-md transition-all"
            onClick={() => navigate(card.href)}
          >
            <CardContent className="p-4 flex items-center gap-3">
              <div className="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center shrink-0">
                <card.icon className={`w-5 h-5 ${card.color}`} />
              </div>
              <div className="min-w-0">
                {loading ? <Skeleton className="h-6 w-12 bg-muted mb-1" /> : <p className="text-xl font-bold text-foreground">{card.value}</p>}
                <p className="text-xs text-muted-foreground text-pretty">{card.label}</p>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* Configuration Globale : Clarté Audio & Normalisation Vocale */}
      <Card className="border-primary/20 bg-gradient-to-br from-card via-card to-primary/5 shadow-sm">
        <CardHeader className="pb-3">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
            <div className="space-y-1">
              <div className="flex items-center gap-2">
                <div className="w-8 h-8 rounded-lg bg-primary/10 flex items-center justify-center text-primary">
                  <SlidersHorizontal className="w-4 h-4" />
                </div>
                <CardTitle className="text-base font-semibold flex items-center gap-2">
                  Clarté Vocale & Égalisation Globale (Compréhension Orale)
                  <Sparkles className="w-4 h-4 text-amber-500 fill-amber-500" />
                </CardTitle>
              </div>
              <CardDescription className="text-xs sm:text-sm">
                Règle automatiquement les soucis de volume disparate (trop fort / trop faible) et la résonance étouffée ("effet bocal") sur tous les audios.
              </CardDescription>
            </div>

            <div className="flex items-center gap-3 self-start sm:self-center bg-background/80 px-3 py-2 rounded-lg border">
              <div className="text-right">
                <div className="text-xs font-medium">
                  {audioClarity ? (
                    <Badge variant="default" className="bg-emerald-600 hover:bg-emerald-600 text-white gap-1 text-[11px]">
                      <CheckCircle2 className="w-3 h-3" /> Activé pour tous
                    </Badge>
                  ) : (
                    <Badge variant="outline" className="text-muted-foreground text-[11px]">
                      Désactivé (Son brut)
                    </Badge>
                  )}
                </div>
              </div>
              <Switch
                checked={audioClarity}
                disabled={updatingAudio}
                onCheckedChange={handleToggleAudioClarity}
                aria-label="Activer ou désactiver l'optimisation audio pour tous les étudiants"
              />
            </div>
          </div>
        </CardHeader>
        <CardContent className="pt-0 pb-4 text-xs text-muted-foreground">
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 pt-3 border-t border-border/60">
            <div className="flex items-start gap-2">
              <Volume2 className="w-4 h-4 text-primary shrink-0 mt-0.5" />
              <div>
                <span className="font-semibold text-foreground">Normalisation dynamique :</span>
                <p className="text-[11px] text-muted-foreground mt-0.5">Compresse les pointes assourdissantes et rehausse les voix trop faibles.</p>
              </div>
            </div>
            <div className="flex items-start gap-2">
              <Sparkles className="w-4 h-4 text-amber-500 shrink-0 mt-0.5" />
              <div>
                <span className="font-semibold text-foreground">Suppression de lourdeur :</span>
                <p className="text-[11px] text-muted-foreground mt-0.5">Filtre passe-haut + coupe résonance 350 Hz pour un timbre net et sans ronflement.</p>
              </div>
            </div>
            <div className="flex items-start gap-2">
              <CheckCircle2 className="w-4 h-4 text-emerald-500 shrink-0 mt-0.5" />
              <div>
                <span className="font-semibold text-foreground">100% Transparent :</span>
                <p className="text-[11px] text-muted-foreground mt-0.5">Appliqué automatiquement côté navigateur des étudiants sans aucun bouton perturbateur.</p>
              </div>
            </div>
          </div>
        </CardContent>
      </Card>

      {sessionsParMois.length > 0 && (
        <Card className="h-full">
          <CardHeader><CardTitle className="text-base text-balance">Sessions par mois</CardTitle></CardHeader>
          <CardContent>
            <div className="w-full min-w-0 overflow-hidden h-48">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={sessionsParMois}>
                  <CartesianGrid strokeDasharray="3 3" stroke="hsl(var(--border))" />
                  <XAxis dataKey="mois" tick={{ fontSize: 12 }} />
                  <YAxis allowDecimals={false} tick={{ fontSize: 12 }} />
                  <Tooltip contentStyle={{ background: 'hsl(var(--card))', border: '1px solid hsl(var(--border))', borderRadius: '6px' }} />
                  <Bar dataKey="sessions" fill="hsl(var(--primary))" radius={[4, 4, 0, 0]} />
                </BarChart>
              </ResponsiveContainer>
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
