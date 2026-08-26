import { useState, useEffect } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { Eye, EyeOff, Loader2 } from 'lucide-react';
import { toast } from 'sonner';

const LOGO_URL = '/images/logo/edudesk-logo.png';

function getDefaultRoute(role: string): string {
  switch (role) {
    case 'super_admin':
    case 'admin':
      return '/admin';
    case 'professeur':
      return '/professeur';
    case 'etudiant':
      return '/etudiant';
    default:
      return '/';
  }
}

function getErrorMessage(error: Error): string {
  const msg = error.message.toLowerCase();
  if (msg.includes('bloqué') || msg.includes('suspendu')) {
    return error.message;
  }
  if (msg.includes('email not confirmed') || msg.includes('not confirmed')) {
    return "Votre adresse e-mail n'a pas encore été confirmée dans Supabase. Veuillez demander à votre administrateur de valider votre compte.";
  }
  if (msg.includes('invalid login credentials') || msg.includes('invalid_credentials')) {
    return "Adresse e-mail ou mot de passe incorrect. Assurez-vous de saisir votre adresse e-mail complète (ex: etudiant@domaine.com) et vérifiez votre mot de passe.";
  }
  if (msg.includes('user not found')) {
    return "Aucun compte trouvé avec cette adresse e-mail. Vérifiez l'adresse saisie ou contactez un administrateur.";
  }
  if (msg.includes('too many requests') || msg.includes('rate limit')) {
    return "Trop de tentatives de connexion échouées. Veuillez patienter quelques instants avant de réessayer.";
  }
  return error.message || 'Adresse e-mail ou mot de passe incorrect. Note : utilisez votre adresse e-mail complète comme identifiant.';
}

export default function ConnexionPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const { signIn, profile, user, loading: authLoading } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();

  const getFrom = () =>
    (location.state as { from?: { pathname: string } })?.from?.pathname ?? null;

  // Rediriger dès que user + profile sont disponibles (session existante ou nouvelle connexion)
  useEffect(() => {
    if (!authLoading && user && profile) {
      navigate(getFrom() || getDefaultRoute(profile.role), { replace: true });
    }
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [authLoading, user, profile]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!email || !password) { setError('Veuillez remplir tous les champs.'); return; }
    setLoading(true);
    setError('');

    const cleanEmail = email.trim().toLowerCase();
    const { error: signInError } = await signIn(cleanEmail, password);

    if (signInError) {
      setLoading(false);
      setError(getErrorMessage(signInError));
      return;
    }

    toast.success('Connexion réussie !');
    // Le spinner reste actif ; le useEffect ci-dessus redirige dès que
    // profile + user sont disponibles (setProfile/setUser appelés dans signIn).
  };

  return (
    <div className="min-h-screen bg-background flex flex-col items-center justify-center p-4">
      <Link to="/" className="mb-8">
        <div className="bg-white rounded-lg px-3 py-1.5">
          <img src={LOGO_URL} alt="EduDesk TCF" className="h-10 w-auto object-contain" />
        </div>
      </Link>

      <Card className="w-full max-w-[calc(100%-2rem)] md:max-w-md">
        <CardHeader className="text-center">
          <CardTitle className="text-xl text-balance">Connexion à EduDesk TCF</CardTitle>
          <CardDescription className="text-pretty">
            Accédez à votre espace de préparation au TCF Canada
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            {error && (
              <Alert variant="destructive">
                <AlertDescription>{error}</AlertDescription>
              </Alert>
            )}

            <div className="space-y-2">
              <Label htmlFor="email" className="text-sm font-normal">Identifiant (Adresse e-mail)</Label>
              <Input
                id="email"
                type="email"
                placeholder="votre@email.com"
                value={email}
                onChange={e => setEmail(e.target.value)}
                autoComplete="email"
                required
              />
              <p className="text-xs text-muted-foreground">
                Saisissez votre adresse e-mail complète (ex : nom@email.com)
              </p>
            </div>

            <div className="space-y-2">
              <Label htmlFor="password" className="text-sm font-normal">Mot de passe</Label>
              <div className="relative">
                <Input
                  id="password"
                  type={showPassword ? 'text' : 'password'}
                  placeholder="••••••••"
                  value={password}
                  onChange={e => setPassword(e.target.value)}
                  autoComplete="current-password"
                  required
                  className="pr-10"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground"
                >
                  {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                </button>
              </div>
            </div>

            <Button type="submit" className="w-full" disabled={loading}>
              {loading ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" /> Connexion...</> : 'Se connecter'}
            </Button>
          </form>

          <div className="mt-6 text-center">
            <p className="text-sm text-muted-foreground">
              Pour obtenir un accès, contactez votre administrateur.
            </p>
          </div>

          <div className="mt-4 pt-4 border-t border-border">
            <p className="text-xs text-muted-foreground text-center text-pretty">
              En vous connectant, vous acceptez nos{' '}
              <span className="underline cursor-pointer">Conditions d'utilisation</span> et notre{' '}
              <span className="underline cursor-pointer">Politique de confidentialité</span>.
            </p>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
