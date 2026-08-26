import { createContext, useContext, useEffect, useState, useCallback, type ReactNode } from 'react';
import { supabase } from '@/db/supabase';
import type { User } from '@supabase/supabase-js';
import type { Profile, UserRole } from '@/types/index';

// Clé localStorage pour le token de session unique
const SESSION_TOKEN_KEY = 'tcf_session_token';

export async function getProfile(userId: string): Promise<Profile | null> {
  const { data, error } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', userId)
    .maybeSingle();
  if (error) {
    console.error('Erreur chargement profil:', error);
    return null;
  }
  return data;
}

interface AuthContextType {
  user: User | null;
  profile: Profile | null;
  loading: boolean;
  signIn: (email: string, password: string) => Promise<{ error: Error | null; profile: Profile | null }>;
  signUp: (email: string, password: string, nom: string, prenom: string) => Promise<{ error: Error | null }>;
  signOut: () => Promise<void>;
  refreshProfile: () => Promise<void>;
  hasRole: (roles: UserRole[]) => boolean;
  isAdmin: boolean;
  isSuperAdmin: boolean;
  isProfesseur: boolean;
  isEtudiant: boolean;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [profile, setProfile] = useState<Profile | null>(null);
  const [loading, setLoading] = useState(true);

  const refreshProfile = async () => {
    if (!user) { setProfile(null); return; }
    const p = await getProfile(user.id);
    setProfile(p);
  };

  // Vérification de session unique : si un autre appareil s'est connecté,
  // le token local diffère du token en base → déconnexion automatique
  const validateSessionToken = useCallback(async (userId: string) => {
    const localToken = localStorage.getItem(SESSION_TOKEN_KEY);
    if (!localToken) return; // pas de token local → rien à vérifier

    const { data } = await supabase
      .from('profiles')
      .select('current_session_token')
      .eq('id', userId)
      .maybeSingle();

    if (data && data.current_session_token !== localToken) {
      // Un autre appareil a pris la session → déconnecter
      localStorage.removeItem(SESSION_TOKEN_KEY);
      await supabase.auth.signOut();
      setUser(null);
      setProfile(null);
    }
  }, []);

  useEffect(() => {
    let mounted = true;

    // getSession : restaure l'état d'une session existante au chargement de la page
    supabase.auth.getSession()
      .then(async ({ data: { session } }) => {
        if (!mounted) return;
        setUser(session?.user ?? null);
        if (session?.user) {
          const p = await getProfile(session.user.id);
          if (mounted) setProfile(p);
        }
      })
      .finally(() => { if (mounted) setLoading(false); });

    // onAuthStateChange : gère les changements d'état (SIGNED_IN, SIGNED_OUT, TOKEN_REFRESHED…)
    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!mounted) return;
      setUser(session?.user ?? null);
      if (session?.user) {
        getProfile(session.user.id).then(p => {
          if (!mounted) return;
          if (p?.bloque) {
            supabase.auth.signOut();
            localStorage.removeItem(SESSION_TOKEN_KEY);
            setUser(null);
            setProfile(null);
          } else {
            setProfile(p);
          }
        });
      } else {
        setProfile(null);
      }
    });

    return () => {
      mounted = false;
      subscription.unsubscribe();
    };
  }, []);

  // Vérifier la session unique à la reprise de visibilité de la page
  // - Seulement si l'onglet a été masqué plus de 30 secondes (évite faux positifs mobile)
  // - Délai de grâce : si token différent, revérifier après 5s avant de déconnecter
  // - Pendant un examen en cours, la vérification est totalement désactivée
  useEffect(() => {
    let hiddenAt: number | null = null;
    const ABSENCE_THRESHOLD_MS = 30_000; // 30 secondes
    const GRACE_DELAY_MS = 5_000;        // 5 secondes de grâce

    const isExamEnCours = (): boolean => {
      // Lire le flag posé par ExamenBlancPage dans sessionStorage
      return sessionStorage.getItem('exam_en_cours') === 'true';
    };

    const checkToken = async () => {
      const { data: { user: u } } = await supabase.auth.getUser();
      if (!u) return;
      await validateSessionToken(u.id);
    };

    const handleVisibilityChange = () => {
      if (document.visibilityState === 'hidden') {
        hiddenAt = Date.now();
      } else {
        // Page redevenue visible
        if (hiddenAt === null) return;
        const absentMs = Date.now() - hiddenAt;
        hiddenAt = null;

        // Pas de vérification si absence < seuil ou si un examen est en cours
        if (absentMs < ABSENCE_THRESHOLD_MS || isExamEnCours()) return;

        // 1ère vérification
        supabase.auth.getUser().then(({ data: { user: u } }) => {
          if (!u) return;
          supabase.from('profiles')
            .select('current_session_token')
            .eq('id', u.id)
            .maybeSingle()
            .then(({ data }) => {
              const local = localStorage.getItem(SESSION_TOKEN_KEY);
              if (!data || data.current_session_token === local) return;

              // Token différent : délai de grâce avant confirmation
              setTimeout(() => {
                if (isExamEnCours()) return; // examen démarré entre-temps
                checkToken();
              }, GRACE_DELAY_MS);
            });
        });
      }
    };

    document.addEventListener('visibilitychange', handleVisibilityChange);
    return () => document.removeEventListener('visibilitychange', handleVisibilityChange);
  }, [validateSessionToken]);

  const signIn = async (email: string, password: string) => {
    try {
      const cleanEmail = email.trim().toLowerCase();
      const { data, error } = await supabase.auth.signInWithPassword({ email: cleanEmail, password });
      if (error) throw error;

      let profile: Profile | null = null;

      if (data.user) {
        const p = await getProfile(data.user.id);

        // Vérifier si le compte est bloqué
        if (p?.bloque) {
          await supabase.auth.signOut();
          throw new Error('Votre compte a été bloqué. Veuillez contacter un administrateur.');
        }

        // Blocage en cascade : si l'admin créateur est bloqué
        if (p?.cree_par) {
          const { data: adminProfile } = await supabase
            .from('profiles')
            .select('bloque')
            .eq('id', p.cree_par)
            .maybeSingle();
          if (adminProfile?.bloque) {
            await supabase.auth.signOut();
            throw new Error("L'accès à votre compte est temporairement suspendu. Veuillez contacter votre établissement.");
          }
        }

        // Générer un token de session unique (invalide les autres appareils)
        const newToken = crypto.randomUUID();
        localStorage.setItem(SESSION_TOKEN_KEY, newToken);

        await supabase
          .from('profiles')
          .update({
            current_session_token: newToken,
            last_active_at: new Date().toISOString(),
          })
          .eq('id', data.user.id);

        profile = p;
        setProfile(p);
        setUser(data.user);
      }

      return { error: null, profile };
    } catch (error) {
      return { error: error as Error, profile: null };
    }
  };

  const signUp = async (email: string, password: string, nom: string, prenom: string) => {
    try {
      const cleanEmail = email.trim().toLowerCase();
      const { data, error } = await supabase.auth.signUp({ email: cleanEmail, password });
      if (error) throw error;
      if (data.user) {
        await supabase.from('profiles').update({ nom, prenom }).eq('id', data.user.id);
      }
      return { error: null };
    } catch (error) {
      return { error: error as Error };
    }
  };

  const signOut = async () => {
    localStorage.removeItem(SESSION_TOKEN_KEY);
    await supabase.auth.signOut();
    setUser(null);
    setProfile(null);
  };

  const hasRole = (roles: UserRole[]) => !!profile && roles.includes(profile.role);
  const isSuperAdmin = profile?.role === 'super_admin';
  const isAdmin = profile?.role === 'admin' || isSuperAdmin;
  const isProfesseur = profile?.role === 'professeur';
  const isEtudiant = profile?.role === 'etudiant';

  return (
    <AuthContext.Provider value={{
      user, profile, loading,
      signIn, signUp, signOut, refreshProfile,
      hasRole, isAdmin, isSuperAdmin, isProfesseur, isEtudiant,
    }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) {
    // Contexte non encore disponible (HMR ou edge-case d'initialisation) :
    // retourner un état "chargement" neutre évite le crash et laisse RouteGuard
    // afficher le spinner jusqu'à ce qu'AuthProvider soit monté.
    return {
      user: null,
      profile: null,
      loading: true,
      signIn: async () => ({ error: null, profile: null }),
      signUp: async () => ({ error: null }),
      signOut: async () => {},
      refreshProfile: async () => {},
      hasRole: () => false,
      isAdmin: false,
      isSuperAdmin: false,
      isProfesseur: false,
      isEtudiant: false,
    } satisfies AuthContextType;
  }
  return context;
}
