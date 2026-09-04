import { useState, useEffect, useCallback } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { supabase } from '@/db/supabase';
import { useAuth } from '@/contexts/AuthContext';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import { Users, ClipboardList, CheckCircle, RefreshCw, Sparkles, Clock, ChevronRight } from 'lucide-react';
import type { Profile, Production } from '@/types/index';
import { EPREUVE_LABELS } from '@/types/index';

type ProductionWithEtudiant = Production & {
  etudiant?: {
    id: string;
    prenom: string | null;
    nom: string | null;
    email: string | null;
  } | null;
};

export default function ProfesseurDashboard() {
  const { user, profile } = useAuth();
  const navigate = useNavigate();
  const [etudiants, setEtudiants] = useState<Profile[]>([]);
  const [corrections, setCorrections] = useState<ProductionWithEtudiant[]>([]);
  const [totalPendingCount, setTotalPendingCount] = useState<number>(0);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  const load = useCallback(async (isSilent = false) => {
    if (!user) return;
    if (!isSilent) setRefreshing(true);

    try {
      // 1. Récupérer les étudiants attribués
      const { data: rawAttr } = await supabase
        .from('attributions')
        .select('etudiant_id')
        .eq('professeur_id', user.id);
      const ids = (rawAttr || []).map(a => a.etudiant_id).filter(Boolean);

      let etudiantsList: Profile[] = [];
      if (ids.length > 0) {
        const { data: stdProfiles } = await supabase.from('profiles').select('*').in('id', ids);
        etudiantsList = Array.isArray(stdProfiles) ? stdProfiles : [];
      }

      // 2. Compter le total exact de corrections en attente
      const { count: exactPendingCount } = await supabase
        .from('productions')
        .select('id', { count: 'exact', head: true })
        .eq('statut_correction', 'en_attente');

      // 3. Charger les corrections récentes en attente avec profil étudiant
      const { data: corrData, error: corrErr } = await supabase
        .from('productions')
        .select('*, etudiant:profiles!etudiant_id(id, prenom, nom, email)')
        .eq('statut_correction', 'en_attente')
        .order('created_at', { ascending: false })
        .limit(10);

      let recentCorrections: ProductionWithEtudiant[] = [];
      if (!corrErr && Array.isArray(corrData)) {
        recentCorrections = corrData;
      } else {
        // Fallback sans jointure
        const { data: fbData } = await supabase
          .from('productions')
          .select('*')
          .eq('statut_correction', 'en_attente')
          .order('created_at', { ascending: false })
          .limit(10);

        if (Array.isArray(fbData) && fbData.length > 0) {
          const uIds = [...new Set(fbData.map(p => p.etudiant_id).filter(Boolean))];
          const { data: pData } = await supabase.from('profiles').select('id, prenom, nom, email').in('id', uIds);
          const pMap = new Map((pData || []).map(p => [p.id, p]));
          recentCorrections = fbData.map(p => ({ ...p, etudiant: pMap.get(p.etudiant_id) || null }));
        }
      }

      setEtudiants(etudiantsList);
      setTotalPendingCount(exactPendingCount ?? recentCorrections.length);
      setCorrections(recentCorrections);
    } catch (err) {
      console.error('Erreur chargement dashboard professeur:', err);
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  }, [user]);

  useEffect(() => {
    if (!user) return;
    load();

    // Écoute temps réel des nouvelles soumissions
    const channel = supabase
      .channel('prof-dashboard-live')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'productions' }, () => {
        load(true);
      })
      .on('postgres_changes', { event: '*', schema: 'public', table: 'attributions' }, () => {
        load(true);
      })
      .subscribe();

    // Rafraîchissement automatique toutes les 15 secondes
    const interval = setInterval(() => {
      load(true);
    }, 15000);

    return () => {
      supabase.removeChannel(channel);
      clearInterval(interval);
    };
  }, [user, load]);

  const stats = [
    { label: 'Étudiants attribués', value: etudiants.length, icon: Users, color: 'text-primary', href: '/professeur/etudiants' },
    {
      label: 'Corrections en attente',
      value: totalPendingCount,
      icon: ClipboardList,
      color: totalPendingCount > 0 ? 'text-amber-500' : 'text-secondary',
      href: '/professeur/corrections',
      badge: totalPendingCount > 0 ? `${totalPendingCount} à traiter` : null,
    },
  ];

  return (
    <div className="max-w-4xl mx-auto space-y-6 fade-in">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-foreground text-balance">
            Bonjour, {profile?.prenom || 'Professeur'} 👋
          </h1>
          <p className="text-muted-foreground mt-1">Tableau de bord — Espace Professeur</p>
        </div>
        <Button
          variant="outline"
          size="sm"
          onClick={() => load()}
          disabled={refreshing}
          className="self-start sm:self-center gap-2"
        >
          <RefreshCw className={`w-3.5 h-3.5 ${refreshing ? 'animate-spin' : ''}`} />
          <span>Actualiser</span>
        </Button>
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
              <div className="min-w-0">
                <div className="flex items-center gap-2">
                  <p className="text-2xl font-bold text-foreground">{loading ? '—' : stat.value}</p>
                  {stat.badge && (
                    <Badge variant="destructive" className="text-[10px] py-0 px-1.5 h-4">
                      {stat.badge}
                    </Badge>
                  )}
                </div>
                <p className="text-xs text-muted-foreground text-pretty">{stat.label}</p>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* Corrections urgentes */}
      <Card className="h-full">
        <CardHeader className="flex flex-row items-center justify-between pb-3">
          <div>
            <CardTitle className="text-base text-balance flex items-center gap-2">
              <span>Corrections en attente</span>
              {totalPendingCount > 0 && (
                <Badge className="bg-amber-500/15 text-amber-600 border-amber-500/30 text-xs font-semibold">
                  {totalPendingCount} au total
                </Badge>
              )}
            </CardTitle>
          </div>
          <Button variant="ghost" size="sm" asChild>
            <Link to="/professeur/corrections" className="gap-1">
              Voir tout <ChevronRight className="w-4 h-4" />
            </Link>
          </Button>
        </CardHeader>
        <CardContent>
          {loading ? (
            <div className="space-y-2">{[1, 2, 3].map(i => <Skeleton key={i} className="h-12 w-full bg-muted" />)}</div>
          ) : corrections.length === 0 ? (
            <div className="text-center py-8">
              <CheckCircle className="w-10 h-10 text-success/40 mx-auto mb-2" />
              <p className="text-sm text-muted-foreground">Aucune correction en attente. Bravo !</p>
            </div>
          ) : (
            <div className="space-y-2">
              {corrections.map(prod => (
                <div key={prod.id} className="flex items-center justify-between gap-3 p-3 rounded-md bg-muted/40 border border-border/60 hover:border-primary/40 transition-colors">
                  <div className="min-w-0 flex-1">
                    <div className="flex items-center gap-2 flex-wrap">
                      <p className="text-sm font-semibold text-foreground truncate">
                        {prod.etudiant?.prenom ? `${prod.etudiant.prenom} ${prod.etudiant.nom || ''}` : 'Étudiant'}
                      </p>
                      <Badge variant="outline" className="text-[10px] py-0 h-4 border-primary/30 text-primary">
                        {EPREUVE_LABELS[prod.epreuve as keyof typeof EPREUVE_LABELS] || prod.epreuve} · Tâche {prod.numero_tache}
                      </Badge>
                      {prod.reference && (
                        <span className="text-[10px] font-mono text-muted-foreground">({prod.reference})</span>
                      )}
                    </div>
                    <p className="text-xs text-muted-foreground flex items-center gap-1 mt-0.5">
                      <Clock className="w-3 h-3" />
                      Reçu le {new Date(prod.created_at).toLocaleDateString('fr-FR', {
                        day: 'numeric',
                        month: 'short',
                        hour: '2-digit',
                        minute: '2-digit',
                      })}
                    </p>
                  </div>
                  <Button size="sm" asChild className="shrink-0 shadow-xs">
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
        <CardHeader className="flex flex-row items-center justify-between pb-3">
          <CardTitle className="text-base text-balance">Mes étudiants ({etudiants.length})</CardTitle>
          <Button variant="ghost" size="sm" asChild>
            <Link to="/professeur/etudiants" className="gap-1">
              Voir tout <ChevronRight className="w-4 h-4" />
            </Link>
          </Button>
        </CardHeader>
        <CardContent>
          {loading ? (
            <div className="space-y-2">{[1, 2].map(i => <Skeleton key={i} className="h-12 w-full bg-muted" />)}</div>
          ) : etudiants.length === 0 ? (
            <p className="text-sm text-muted-foreground text-center py-6">Aucun étudiant attribué pour l'instant.</p>
          ) : (
            <div className="space-y-2">
              {etudiants.slice(0, 4).map(etudiant => (
                <div
                  key={etudiant.id}
                  className="flex items-center gap-3 p-3 rounded-md bg-muted/40 border border-border/60 cursor-pointer hover:border-primary/40 transition-colors"
                  onClick={() => navigate('/professeur/etudiants')}
                >
                  <div className="w-8 h-8 rounded-full bg-primary/15 flex items-center justify-center shrink-0">
                    <span className="text-xs font-semibold text-primary">
                      {etudiant.prenom?.[0]}{etudiant.nom?.[0]}
                    </span>
                  </div>
                  <div className="min-w-0 flex-1">
                    <p className="text-sm font-medium text-foreground truncate">{etudiant.prenom} {etudiant.nom}</p>
                    <p className="text-xs text-muted-foreground truncate">{etudiant.email}</p>
                  </div>
                  <ChevronRight className="w-4 h-4 text-muted-foreground shrink-0" />
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
