import { useState } from 'react';
import { supabase } from '@/db/supabase';
import { useAuth } from '@/contexts/AuthContext';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { Badge } from '@/components/ui/badge';
import { Separator } from '@/components/ui/separator';
import { Loader2, User, Lock, Eye, EyeOff } from 'lucide-react';
import { toast } from 'sonner';
import { ROLE_LABELS } from '@/types/index';

export default function ProfilPage() {
  const { profile, user, refreshProfile } = useAuth();

  // Infos personnelles
  const [form, setForm] = useState({ nom: profile?.nom || '', prenom: profile?.prenom || '' });
  const [loadingProfile, setLoadingProfile] = useState(false);
  const [errorProfile, setErrorProfile] = useState('');

  // Mot de passe
  const [pwForm, setPwForm] = useState({ current: '', next: '', confirm: '' });
  const [loadingPw, setLoadingPw] = useState(false);
  const [errorPw, setErrorPw] = useState('');
  const [showCurrent, setShowCurrent] = useState(false);
  const [showNext, setShowNext] = useState(false);
  const [showConfirm, setShowConfirm] = useState(false);

  const handleSaveProfile = async () => {
    if (!profile) return;
    setLoadingProfile(true);
    setErrorProfile('');
    const { error: err } = await supabase
      .from('profiles')
      .update({ nom: form.nom || null, prenom: form.prenom || null })
      .eq('id', profile.id);
    setLoadingProfile(false);
    if (err) { setErrorProfile('Erreur lors de la mise à jour. Veuillez réessayer.'); return; }
    await refreshProfile();
    toast.success('Profil mis à jour avec succès !');
  };

  const handleChangePassword = async () => {
    setErrorPw('');
    if (!pwForm.current) { setErrorPw('Veuillez saisir votre mot de passe actuel.'); return; }
    if (pwForm.next.length < 6) { setErrorPw('Le nouveau mot de passe doit contenir au moins 6 caractères.'); return; }
    if (pwForm.next !== pwForm.confirm) { setErrorPw('Les deux mots de passe ne correspondent pas.'); return; }
    if (!user?.email) { setErrorPw('Impossible de vérifier votre identité. Reconnectez-vous.'); return; }

    setLoadingPw(true);

    // Vérifier le mot de passe actuel via re-auth
    const { error: authError } = await supabase.auth.signInWithPassword({
      email: user.email,
      password: pwForm.current,
    });
    if (authError) {
      setLoadingPw(false);
      setErrorPw('Mot de passe actuel incorrect.');
      return;
    }

    // Appliquer le nouveau mot de passe
    const { error: updateError } = await supabase.auth.updateUser({ password: pwForm.next });
    setLoadingPw(false);
    if (updateError) {
      setErrorPw('Erreur lors du changement de mot de passe. Veuillez réessayer.');
      return;
    }

    setPwForm({ current: '', next: '', confirm: '' });
    toast.success('Mot de passe modifié avec succès !');
  };

  return (
    <div className="max-w-xl mx-auto space-y-6 fade-in">
      <div>
        <h1 className="text-2xl font-bold text-foreground text-balance">Mon profil</h1>
        <p className="text-muted-foreground mt-1">Gérez vos informations personnelles et votre sécurité</p>
      </div>

      {/* Informations personnelles */}
      <Card className="h-full">
        <CardHeader>
          <div className="flex items-center gap-4">
            <div className="w-16 h-16 rounded-full bg-primary/15 flex items-center justify-center shrink-0">
              <User className="w-8 h-8 text-primary" />
            </div>
            <div>
              <p className="font-semibold text-foreground">{profile?.prenom} {profile?.nom}</p>
              <p className="text-sm text-muted-foreground">{profile?.email}</p>
              {profile?.role && (
                <Badge variant="outline" className="mt-1 text-xs">{ROLE_LABELS[profile.role]}</Badge>
              )}
            </div>
          </div>
        </CardHeader>
        <CardContent className="space-y-4">
          {errorProfile && <Alert variant="destructive"><AlertDescription>{errorProfile}</AlertDescription></Alert>}
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="prenom" className="text-sm font-normal">Prénom</Label>
              <Input
                id="prenom"
                value={form.prenom}
                onChange={e => setForm(f => ({ ...f, prenom: e.target.value }))}
                className="px-3"
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="nom" className="text-sm font-normal">Nom</Label>
              <Input
                id="nom"
                value={form.nom}
                onChange={e => setForm(f => ({ ...f, nom: e.target.value }))}
                className="px-3"
              />
            </div>
          </div>
          <div className="space-y-2">
            <Label className="text-sm font-normal">Adresse e-mail</Label>
            <Input value={profile?.email || ''} disabled className="bg-muted px-3" />
          </div>
          <Button onClick={handleSaveProfile} disabled={loadingProfile} className="w-full">
            {loadingProfile
              ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" />Sauvegarde...</>
              : 'Enregistrer les modifications'}
          </Button>
        </CardContent>
      </Card>

      {/* Changement de mot de passe */}
      <Card className="h-full">
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2 text-balance">
            <Lock className="w-4 h-4 text-primary shrink-0" />
            Changer le mot de passe
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          {errorPw && <Alert variant="destructive"><AlertDescription>{errorPw}</AlertDescription></Alert>}

          <div className="space-y-2">
            <Label htmlFor="current-pw" className="text-sm font-normal">Mot de passe actuel</Label>
            <div className="relative">
              <Input
                id="current-pw"
                type={showCurrent ? 'text' : 'password'}
                value={pwForm.current}
                onChange={e => setPwForm(f => ({ ...f, current: e.target.value }))}
                className="px-3 pr-10"
                autoComplete="current-password"
              />
              <button
                type="button"
                onClick={() => setShowCurrent(v => !v)}
                className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground"
              >
                {showCurrent ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
              </button>
            </div>
          </div>

          <Separator />

          <div className="space-y-2">
            <Label htmlFor="new-pw" className="text-sm font-normal">Nouveau mot de passe</Label>
            <div className="relative">
              <Input
                id="new-pw"
                type={showNext ? 'text' : 'password'}
                value={pwForm.next}
                onChange={e => setPwForm(f => ({ ...f, next: e.target.value }))}
                className="px-3 pr-10"
                autoComplete="new-password"
              />
              <button
                type="button"
                onClick={() => setShowNext(v => !v)}
                className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground"
              >
                {showNext ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
              </button>
            </div>
            <p className="text-xs text-muted-foreground">Minimum 6 caractères</p>
          </div>

          <div className="space-y-2">
            <Label htmlFor="confirm-pw" className="text-sm font-normal">Confirmer le nouveau mot de passe</Label>
            <div className="relative">
              <Input
                id="confirm-pw"
                type={showConfirm ? 'text' : 'password'}
                value={pwForm.confirm}
                onChange={e => setPwForm(f => ({ ...f, confirm: e.target.value }))}
                className="px-3 pr-10"
                autoComplete="new-password"
              />
              <button
                type="button"
                onClick={() => setShowConfirm(v => !v)}
                className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground"
              >
                {showConfirm ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
              </button>
            </div>
          </div>

          <Button
            onClick={handleChangePassword}
            disabled={loadingPw || !pwForm.current || !pwForm.next || !pwForm.confirm}
            variant="secondary"
            className="w-full"
          >
            {loadingPw
              ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" />Modification...</>
              : 'Modifier le mot de passe'}
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}
