import { Link, useNavigate } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Headphones, FileText, PenLine, Mic, CheckCircle, GraduationCap, ArrowRight } from 'lucide-react';
import { useAuth } from '@/contexts/AuthContext';

const LOGO_URL = 'https://miaoda-conversation-file.s3cdn.medo.dev/user-c1l0w4uc1wqo/app-c1l1gqq5sjr5/20260601/396842.png';

const epreuves = [
  {
    icon: Headphones,
    titre: "Compréhension Orale",
    description: "Évaluez votre capacité à comprendre des enregistrements audio en français : dialogues, monologues, annonces et émissions.",
    color: 'text-primary',
    bg: 'bg-primary/5',
    border: 'border-primary/20',
  },
  {
    icon: FileText,
    titre: "Compréhension Écrite",
    description: "Testez votre compréhension de documents écrits variés : articles, courriels, affiches et textes informatifs.",
    color: 'text-secondary',
    bg: 'bg-secondary/10',
    border: 'border-secondary/30',
  },
  {
    icon: PenLine,
    titre: "Expression Écrite",
    description: "Rédigez des textes en réponse à des consignes variées et faites corriger votre production par un professeur certifié.",
    color: 'text-primary',
    bg: 'bg-primary/5',
    border: 'border-primary/20',
  },
  {
    icon: Mic,
    titre: "Expression Orale",
    description: "Entraînez-vous à prendre la parole en français sur des sujets du quotidien, avec minuteur pour simuler les conditions réelles.",
    color: 'text-secondary',
    bg: 'bg-secondary/10',
    border: 'border-secondary/30',
  },
];

const avantages = [
  "Contenus 100% adaptés au TCF Canada officiel",
  "Correction par des professeurs qualifiés",
  "Niveaux CECRL de A1 à C2",
  "Interface entièrement en français",
  "Accessible depuis votre téléphone",
  "Rapports de progression détaillés",
];

export default function HomePage() {
  const { user, profile } = useAuth();
  const navigate = useNavigate();

  const getDashboardLink = () => {
    if (!profile) return '/connexion';
    if (profile.role === 'etudiant') return '/etudiant';
    if (profile.role === 'professeur') return '/professeur';
    return '/admin';
  };

  return (
    <div className="min-h-screen flex flex-col bg-background">
      {/* Header */}
      <header className="border-b border-border bg-card/80 backdrop-blur-sm sticky top-0 z-40">
        <div className="max-w-6xl mx-auto px-4 h-16 flex items-center justify-between">
          <img src={LOGO_URL} alt="EduDesk TCF" className="h-10 w-auto object-contain" />
          <nav className="flex items-center gap-2">
            {user ? (
              <Button asChild>
                <Link to={getDashboardLink()}>
                  Mon espace <ArrowRight className="ml-1 w-4 h-4" />
                </Link>
              </Button>
            ) : (
              <Button asChild>
                <Link to="/connexion">Connexion</Link>
              </Button>
            )}
          </nav>
        </div>
      </header>

      {/* Hero */}
      <section className="gradient-bg text-white py-16 md:py-24">
        <div className="max-w-4xl mx-auto px-4 text-center">
          <Badge className="bg-secondary/20 text-secondary border-secondary/30 mb-4 text-sm px-3 py-1">
            Préparation TCF Canada
          </Badge>
          <h1 className="text-3xl md:text-5xl font-bold mb-6 text-balance leading-tight">
            Réussissez votre{' '}
            <span className="text-secondary">TCF Canada</span>{' '}
            avec EduDesk
          </h1>
          <p className="text-lg md:text-xl text-white/80 mb-8 max-w-2xl mx-auto text-pretty">
            La plateforme de référence pour les francophones qui préparent leur immigration au Canada.
            Entraînez-vous, simulez l'examen et obtenez une correction professionnelle.
          </p>
          <div className="flex justify-center">
            {user ? (
              <Button size="lg" className="bg-secondary text-secondary-foreground hover:bg-secondary/90" asChild>
                <Link to={getDashboardLink()}>Accéder à mon espace <ArrowRight className="ml-2 w-5 h-5" /></Link>
              </Button>
            ) : (
              <Button size="lg" className="bg-secondary text-secondary-foreground hover:bg-secondary/90" asChild>
                <Link to="/connexion">Se connecter <ArrowRight className="ml-2 w-5 h-5" /></Link>
              </Button>
            )}
          </div>
        </div>
      </section>

      {/* Épreuves TCF */}
      <section className="py-16 px-4">
        <div className="max-w-6xl mx-auto">
          <div className="text-center mb-12">
            <h2 className="text-2xl md:text-3xl font-bold text-foreground mb-3 text-balance">
              Les 4 épreuves du TCF Canada
            </h2>
            <p className="text-muted-foreground max-w-xl mx-auto text-pretty">
              Préparez-vous sur l'ensemble des compétences évaluées lors de l'examen officiel TCF Canada.
            </p>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {epreuves.map((e, i) => (
              <Card key={i} className={`border ${e.border} h-full`}>
                <CardContent className="p-6 flex flex-col h-full">
                  <div className={`w-12 h-12 rounded-lg ${e.bg} flex items-center justify-center mb-4 shrink-0`}>
                    <e.icon className={`w-6 h-6 ${e.color}`} />
                  </div>
                  <h3 className="font-semibold text-lg text-foreground mb-2 text-balance">{e.titre}</h3>
                  <p className="text-muted-foreground text-sm flex-1 text-pretty">{e.description}</p>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Avantages */}
      <section className="py-16 px-4 bg-muted/40">
        <div className="max-w-4xl mx-auto">
          <div className="text-center mb-10">
            <h2 className="text-2xl md:text-3xl font-bold text-foreground mb-3 text-balance">
              Pourquoi choisir EduDesk TCF ?
            </h2>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {avantages.map((a, i) => (
              <div key={i} className="flex items-center gap-3">
                <div className="w-8 h-8 rounded-full bg-secondary/15 flex items-center justify-center shrink-0">
                  <GraduationCap className="w-4 h-4 text-secondary" />
                </div>
                <span className="text-sm text-foreground">{a}</span>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="border-t border-border py-8 px-4 bg-card mt-auto">
        <div className="max-w-6xl mx-auto flex flex-col md:flex-row items-center justify-between gap-4">
          <img src={LOGO_URL} alt="EduDesk TCF" className="h-8 w-auto object-contain" />
          <p className="text-sm text-muted-foreground text-center">
            © 2026 EduDesk TCF — Plateforme de préparation au TCF Canada
          </p>
          <div className="flex gap-4 text-sm text-muted-foreground">
            <Link to="/connexion" className="hover:text-foreground">Connexion</Link>
          </div>
        </div>
      </footer>
    </div>
  );
}
