import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { supabase } from '@/db/supabase';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Skeleton } from '@/components/ui/skeleton';
import { Users, ClipboardList, BookOpen, TrendingUp, UserCheck } from 'lucide-react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';

export default function AdminDashboard() {
  const navigate = useNavigate();
  const [stats, setStats] = useState({
    totalEtudiants: 0, totalProfesseurs: 0, totalSessions: 0,
    totalQuestions: 0, correctionsEnAttente: 0,
  });
  const [loading, setLoading] = useState(true);
  const [sessionsParMois, setSessionsParMois] = useState<{ mois: string; sessions: number }[]>([]);

  useEffect(() => {
    const load = async () => {
      const [etudiants, professeurs, sessions, questions, corrections] = await Promise.all([
        supabase.from('profiles').select('id', { count: 'exact' }).eq('role', 'etudiant'),
        supabase.from('profiles').select('id', { count: 'exact' }).eq('role', 'professeur'),
        supabase.from('sessions_examen').select('id', { count: 'exact' }),
        supabase.from('questions').select('id', { count: 'exact' }),
        supabase.from('productions').select('id', { count: 'exact' }).eq('statut_correction', 'en_attente'),
      ]);
      setStats({
        totalEtudiants: etudiants.count || 0,
        totalProfesseurs: professeurs.count || 0,
        totalSessions: sessions.count || 0,
        totalQuestions: questions.count || 0,
        correctionsEnAttente: corrections.count || 0,
      });

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
