import { Navigate, useLocation } from 'react-router-dom';
import { useAuth } from '@/contexts/AuthContext';
import type { UserRole } from '@/types/index';

interface RouteGuardProps {
  children: React.ReactNode;
  allowedRoles: UserRole[];
  redirectTo?: string;
}

export function RouteGuard({ children, allowedRoles, redirectTo = '/connexion' }: RouteGuardProps) {
  const { user, profile, loading } = useAuth();
  const location = useLocation();

  // Attendre la fin du chargement de l'auth
  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-background">
        <div className="flex flex-col items-center gap-4">
          <div className="w-10 h-10 border-4 border-primary border-t-transparent rounded-full animate-spin" />
          <p className="text-muted-foreground text-sm">Chargement...</p>
        </div>
      </div>
    );
  }

  if (!user) {
    return <Navigate to={redirectTo} state={{ from: location }} replace />;
  }

  // Attendre que le profil soit chargé avant de rendre la page
  // (évite la page blanche après connexion causée par profile=null)
  if (!profile) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-background">
        <div className="flex flex-col items-center gap-4">
          <div className="w-10 h-10 border-4 border-primary border-t-transparent rounded-full animate-spin" />
          <p className="text-muted-foreground text-sm">Chargement du profil...</p>
        </div>
      </div>
    );
  }

  if (!allowedRoles.includes(profile.role)) {
    // Rediriger vers l'espace approprié selon le rôle
    const roleRedirects: Record<UserRole, string> = {
      super_admin: '/admin',
      admin: '/admin',
      professeur: '/professeur',
      etudiant: '/etudiant',
    };
    return <Navigate to={roleRedirects[profile.role]} replace />;
  }

  return <>{children}</>;
}
