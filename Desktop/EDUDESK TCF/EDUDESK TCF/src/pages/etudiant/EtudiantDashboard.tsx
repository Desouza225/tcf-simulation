import { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { supabase } from '@/db/supabase';
import { useAuth } from '@/contexts/AuthContext';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import {
  BookOpen, ClipboardList, Headphones, FileText, PenLine, Mic, TrendingUp,
} from 'lucide-react';
import type { SessionExamen, NiveauCECRL } from '@/types/index';
import { CECRL_COLORS, CECRL_DESCRIPTIONS, EPREUVE_LABELS, pctToCECRL } from '@/types/index';

function scoreToNiveau(score: number): NiveauCECRL {
  return pctToCECRL(Math.round((score / 699) * 100));
}

export default function EtudiantDashboard() {
  const { profile, user } = useAuth();
  const [sessions, setSessions] = useState<SessionExamen[]>([]);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    if (!user) return;
    supabase.from('sessions_examen').select('*').eq('etudiant_id', user.id)
      .order('created_at', { ascending: false }).limit(20)
      .then(({ data }) => {
        setSessions(Array.isArray(data) ? data : []);
        setLoading(false);
      });
  }, [user]);

  const lastExamBlancWithScore = sessions.find(
    s => s.mode === 'examen_blanc' && (s.correction_complete || (s.score_expression_ecrite !== null && s.score_expression_orale !== null)) && s.niveau_cecrl
  );

  // Dernier score connu pour chacune des 4 épreuves (toutes sessions confondues)
  const epreuveStats = [
    {
      key: 'comprehension_oral' as const,
      icon: Headphones,
      label: EPREUVE_LABELS.comprehension_oral,
      href: '/etudiant/entrainement?epreuve=comprehension_oral',
      score: sessions.find(s => s.score_oral !== null)?.score_oral ?? null,
    },
    {
      key: 'comprehension_ecrit' as const,
      icon: FileText,
      label: EPREUVE_LABELS.comprehension_ecrit,
      href: '/etudiant/entrainement?epreuve=comprehension_ecrit',
      score: sessions.find(s => s.score_ecrit !== null)?.score_ecrit ?? null,
    },
    {
      key: 'expression_ecrite' as const,
      icon: PenLine,
      label: EPREUVE_LABELS.expression_ecrite,
      href: '/etudiant/entrainement?epreuve=expression_ecrite',
      score: sessions.find(s => s.score_expression_ecrite !== null)?.score_expression_ecrite ?? null,
    },
    {
      key: 'expression_orale' as const,
      icon: Mic,
      label: EPREUVE_LABELS.expression_orale,
      href: '/etudiant/entrainement?epreuve=expression_orale',
      score: sessions.find(s => s.score_expression_orale !== null)?.score_expression_orale ?? null,
    },
  ];

  const hasAnyEpreuveScore = epreuveStats.some(e => e.score !== null);

  return (
    <div className="max-w-5xl mx-auto space-y-6 fade-in">
      {/* En-tête */}
      <div>
        <h1 className="text-2xl font-bold text-foreground text-balance">
          Bonjour, {profile?.prenom || 'Étudiant'} 👋
        </h1>
        <p className="text-muted-foreground mt-1">Prêt pour votre préparation TCF Canada ?</p>
      </div>

      {/* Niveau CECRL actuel */}
      {lastExamBlancWithScore && (
        <Card
          className="border-primary/20 bg-primary/5 cursor-pointer hover:border-primary/40 hover:shadow-md transition-all"
          onClick={() => navigate('/etudiant/historique')}
        >
          <CardContent className="p-4 flex items-center justify-between gap-4">
            <div>
              <p className="text-sm text-muted-foreground">Votre dernier niveau CECRL</p>
              <div className="flex items-center gap-2 mt-1">
                <Badge
                  style={{ backgroundColor: CECRL_COLORS[lastExamBlancWithScore.niveau_cecrl as NiveauCECRL] }}
                  className="text-white text-lg px-3 py-1"
                >
                  {lastExamBlancWithScore.niveau_cecrl}
                </Badge>
                <span className="text-sm text-muted-foreground">
                  Score : {lastExamBlancWithScore.score_global}/699
                </span>
              </div>
            </div>
            <TrendingUp className="w-10 h-10 text-primary/30 shrink-0" />
          </CardContent>
        </Card>
      )}

      {/* Actions rapides */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <Card className="h-full hover:shadow-md transition-shadow">
          <CardContent className="p-6 flex flex-col h-full">
            <div className="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center mb-4">
              <BookOpen className="w-5 h-5 text-primary" />
            </div>
            <h3 className="font-semibold text-foreground mb-2 text-balance">Mode Entraînement</h3>
            <p className="text-sm text-muted-foreground flex-1 mb-4 text-pretty">
              Exercez-vous épreuve par épreuve avec correction immédiate.
            </p>
            <Button className="w-full mt-auto" onClick={() => navigate('/etudiant/entrainement')}>
              S'entraîner
            </Button>
          </CardContent>
        </Card>

        <Card className="h-full hover:shadow-md transition-shadow">
          <CardContent className="p-6 flex flex-col h-full">
            <div className="w-10 h-10 rounded-lg bg-secondary/15 flex items-center justify-center mb-4">
              <ClipboardList className="w-5 h-5 text-secondary" />
            </div>
            <h3 className="font-semibold text-foreground mb-2 text-balance">Examen Blanc</h3>
            <p className="text-sm text-muted-foreground flex-1 mb-4 text-pretty">
              Simulation complète des 4 épreuves avec correction professeur.
            </p>
            <Button className="w-full mt-auto" onClick={() => navigate('/etudiant/examen-blanc')}>
              Passer un examen blanc
            </Button>
          </CardContent>
        </Card>
      </div>

      {/* Épreuves disponibles — avec dernier niveau CECRL si connu */}
      <div>
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-foreground">Les 4 épreuves du TCF Canada</h2>
          {hasAnyEpreuveScore && (
            <span className="text-xs text-muted-foreground">Dernier niveau obtenu</span>
          )}
        </div>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
          {epreuveStats.map(item => {
            const niveau = item.score !== null ? scoreToNiveau(item.score) : null;
            return (
              <Card
                key={item.key}
                className="h-full hover:border-primary/40 transition-colors cursor-pointer"
                onClick={() => navigate(item.href)}
              >
                <CardContent className="p-4 flex flex-col items-center text-center gap-2">
                  <div className="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center">
                    <item.icon className="w-5 h-5 text-primary" />
                  </div>
                  <p className="text-xs font-medium text-foreground text-balance leading-tight">
                    {item.label}
                  </p>
                  {niveau ? (
                    <div className="flex flex-col items-center gap-0.5">
                      <Badge
                        style={{ backgroundColor: CECRL_COLORS[niveau] }}
                        className="text-white text-xs px-2"
                      >
                        {niveau}
                      </Badge>
                      <span className="text-[10px] text-muted-foreground">{item.score}/699</span>
                    </div>
                  ) : loading ? (
                    <Skeleton className="h-5 w-10 bg-muted" />
                  ) : (
                    <span className="text-[10px] text-muted-foreground italic">—</span>
                  )}
                </CardContent>
              </Card>
            );
          })}
        </div>
      </div>

      {/* Sessions récentes */}
      {!loading && sessions.length > 0 && (
        <div>
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">Sessions récentes</h2>
            <Link to="/etudiant/historique" className="text-sm text-primary hover:underline">Voir tout</Link>
          </div>
          <div className="space-y-3">
            {sessions.slice(0, 3).map(session => (
              <Card
                key={session.id}
                className="h-full cursor-pointer hover:border-primary/40 hover:shadow-md transition-all"
                onClick={() => navigate('/etudiant/historique')}
              >
                <CardContent className="p-4 flex items-center justify-between gap-3">
                  <div className="min-w-0">
                    <p className="font-medium text-sm text-foreground truncate">
                      {session.mode === 'entrainement' ? 'Entraînement' : 'Examen blanc'} —{' '}
                      {EPREUVE_LABELS[session.epreuve_actuelle!] || 'Toutes épreuves'}
                    </p>
                    <p className="text-xs text-muted-foreground mt-0.5">
                      {new Date(session.created_at).toLocaleDateString('fr-FR', {
                        day: 'numeric', month: 'long', year: 'numeric',
                      })}
                    </p>
                  </div>
                  <div className="shrink-0 flex items-center gap-2">
                    {session.niveau_cecrl && (
                      <Badge
                        style={{ backgroundColor: CECRL_COLORS[session.niveau_cecrl] }}
                        className="text-white"
                      >
                        {session.niveau_cecrl}
                      </Badge>
                    )}
                    {session.score_global !== null && (
                      <span className="text-xs font-semibold text-foreground">
                        {session.score_global}/699
                      </span>
                    )}
                    <Badge
                      variant={session.statut === 'termine' ? 'default' : 'outline'}
                      className="text-xs"
                    >
                      {session.statut === 'termine' ? 'Terminé'
                        : session.statut === 'en_cours' ? 'En cours' : 'Abandonné'}
                    </Badge>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      )}

      {loading && (
        <div className="space-y-3">
          {[1, 2, 3].map(i => <Skeleton key={i} className="h-16 w-full bg-muted" />)}
        </div>
      )}
    </div>
  );
}
