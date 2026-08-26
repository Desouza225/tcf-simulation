import { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { supabase } from '@/db/supabase';
import { useAuth } from '@/contexts/AuthContext';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Skeleton } from '@/components/ui/skeleton';
import { Users, ClipboardList, CheckCircle } from 'lucide-react';
import type { Profile, Production } from '@/types/index';

export default function ProfesseurDashboard() {
  const { user, profile } = useAuth();
  const navigate = useNavigate();
  const [etudiants, setEtudiants] = useState<Profile[]>([]);
  const [corrections, setCorrections] = useState<Production[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!user) return;
    const load = async () => {
      const [etudiantsResult, correctionsResult] = await Promise.all([
        supabase.from('attributions').select('etudiant:profiles!etudiant_id(*)').eq('professeur_id', user.id),
        supabase.from('productions').select('*').eq('professeur_id', user.id).eq('statut_correction', 'en_attente').order('created_at', { ascending: false }).limit(5),
      ]);
      
      let etudiantsList: Profile[] = [];
      if (etudiantsResult.error || !etudiantsResult.data) {
        const { data: rawAttr } = await supabase.from('attributions').select('etudiant_id').eq('professeur_id', user.id);
        if (rawAttr && rawAttr.length > 0) {
          const ids = rawAttr.map(a => a.etudiant_id);
          const { data: stdProfiles } = await supabase.from('profiles').select('*').in('id', ids);
          etudiantsList = Array.isArray(stdProfiles) ? stdProfiles : [];
        }
      } else {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        etudiantsList = (etudiantsResult.data || []).map((a: any) => a.etudiant as Profile).filter(Boolean);
      }

      setEtudiants(etudiantsList);
      setCorrections(Array.isArray(correctionsResult.data) ? correctionsResult.data : []);
      setLoading(false);
    };
    load();
  }, [user]);

  const stats = [
    { label: 'Étudiants attribués', value: etudiants.length, icon: Users, color: 'text-primary', href: '/professeur/etudiants' },
    { label: 'Corrections en attente', value: corrections.length, icon: ClipboardList, color: 'text-secondary', href: '/professeur/corrections' },
  ];

  return (
    <div className="max-w-4xl mx-auto space-y-6 fade-in">
      <div>
        <h1 className="text-2xl font-bold text-foreground text-balance">
          Bonjour, {profile?.prenom || 'Professeur'} 👋
        </h1>
        <p className="text-muted-foreground mt-1">Tableau de bord — Espace Professeur</p>
      </div>

      <div className="grid grid-cols-2 gap-4">
        {stats.map(stat => (
          <Card
            key={stat.label}
            className="h-full cursor-pointer hover:border-primary/40 hover:shadow-md transition-all"
            onClick={() => navigate(stat.href)}
          >
            <CardContent className="p-5 flex items-center gap-4">
              <div className="w-12 h-12 rounded-lg bg-primary/10 flex items-center justify-center shrink-0">
                <stat.icon className={`w-6 h-6 ${stat.color}`} />
              </div>
              <div>
                <p className="text-2xl font-bold text-foreground">{loading ? '—' : stat.value}</p>
                <p className="text-xs text-muted-foreground text-pretty">{stat.label}</p>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* Corrections urgentes */}
      <Card className="h-full">
        <CardHeader className="flex flex-row items-center justify-between">
          <CardTitle className="text-base text-balance">Corrections en attente</CardTitle>
          <Button variant="ghost" size="sm" asChild>
            <Link to="/professeur/corrections">Voir tout</Link>
          </Button>
        </CardHeader>
        <CardContent>
          {loading ? (
            <div className="space-y-2">{[1,2,3].map(i => <Skeleton key={i} className="h-12 w-full bg-muted" />)}</div>
          ) : corrections.length === 0 ? (
            <div className="text-center py-8">
              <CheckCircle className="w-10 h-10 text-success/40 mx-auto mb-2" />
              <p className="text-sm text-muted-foreground">Aucune correction en attente. Bravo !</p>
            </div>
          ) : (
            <div className="space-y-2">
              {corrections.map(prod => (
                <div key={prod.id} className="flex items-center justify-between gap-3 p-3 rounded-md bg-muted/50">
                  <div className="min-w-0">
                    <p className="text-sm font-medium text-foreground truncate">
                      {prod.epreuve === 'expression_ecrite' ? 'Expression écrite' : 'Expression orale'} — Tâche {prod.numero_tache}
                    </p>
                    <p className="text-xs text-muted-foreground">
                      {new Date(prod.created_at).toLocaleDateString('fr-FR')}
                    </p>
                  </div>
                  <Button size="sm" asChild>
                    <Link to={`/professeur/corrections/${prod.id}`}>Corriger</Link>
                  </Button>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>

      {/* Étudiants récents */}
      <Card className="h-full">
        <CardHeader className="flex flex-row items-center justify-between">
          <CardTitle className="text-base text-balance">Mes étudiants</CardTitle>
          <Button variant="ghost" size="sm" asChild>
            <Link to="/professeur/etudiants">Voir tout</Link>
          </Button>
        </CardHeader>
        <CardContent>
          {loading ? (
            <div className="space-y-2">{[1,2].map(i => <Skeleton key={i} className="h-12 w-full bg-muted" />)}</div>
          ) : etudiants.length === 0 ? (
            <p className="text-sm text-muted-foreground text-center py-6">Aucun étudiant attribué pour l'instant.</p>
          ) : (
            <div className="space-y-2">
              {etudiants.slice(0, 4).map(etudiant => (
                <div
                  key={etudiant.id}
                  className="flex items-center gap-3 p-3 rounded-md bg-muted/50 cursor-pointer hover:bg-muted transition-colors"
                  onClick={() => navigate('/professeur/etudiants')}
                >
                  <div className="w-8 h-8 rounded-full bg-primary/15 flex items-center justify-center shrink-0">
                    <span className="text-xs font-semibold text-primary">
                      {etudiant.prenom?.[0]}{etudiant.nom?.[0]}
                    </span>
                  </div>
                  <div className="min-w-0">
                    <p className="text-sm font-medium text-foreground truncate">{etudiant.prenom} {etudiant.nom}</p>
                    <p className="text-xs text-muted-foreground truncate">{etudiant.email}</p>
                  </div>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
