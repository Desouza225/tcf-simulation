import { useState } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { cn } from '@/lib/utils';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import {
  LayoutDashboard, BookOpen, FileText, Mic, BookMarked, ClipboardList,
  Users, UserCheck, LogOut, ChevronLeft, ChevronRight, Bell,
  BarChart3, Settings, Database, GraduationCap, Menu, X, LineChart, Shield
} from 'lucide-react';
import { Sheet, SheetContent, SheetTitle, SheetTrigger } from '@/components/ui/sheet';
import { useNotifications } from '@/hooks/useNotifications';

const LOGO_URL = '/images/logo/edudesk-logo.png';

interface NavItem {
  label: string;
  href: string;
  icon: React.ComponentType<{ className?: string }>;
  roles?: string[];
  badge?: number;
}

function useNavItems() {
  const { profile, isAdmin, isSuperAdmin, isProfesseur, isEtudiant } = useAuth();
  const { unreadCount } = useNotifications();
  const role = profile?.role;

  const etudiantItems: NavItem[] = [
    { label: 'Tableau de bord', href: '/etudiant', icon: LayoutDashboard },
    { label: 'Entraînement', href: '/etudiant/entrainement', icon: BookOpen },
    { label: 'Examen blanc', href: '/etudiant/examen-blanc', icon: ClipboardList },
    { label: 'Historique', href: '/etudiant/historique', icon: BarChart3 },
    { label: 'Notifications', href: '/etudiant/notifications', icon: Bell, badge: unreadCount },
    { label: 'Profil', href: '/etudiant/profil', icon: Settings },
  ];

  const professeurItems: NavItem[] = [
    { label: 'Tableau de bord', href: '/professeur', icon: LayoutDashboard },
    { label: 'Mes étudiants', href: '/professeur/etudiants', icon: Users },
    { label: 'Corrections', href: '/professeur/corrections', icon: ClipboardList },
    { label: 'Historique', href: '/professeur/historique', icon: BarChart3 },
    { label: 'Profil', href: '/professeur/profil', icon: Settings },
  ];

  const adminItems: NavItem[] = [
    { label: 'Tableau de bord', href: '/admin', icon: LayoutDashboard },
    { label: 'Suivi des étudiants', href: '/admin/suivi-etudiants', icon: LineChart },
    { label: 'Banque de questions', href: '/admin/questions', icon: Database },
    { label: 'Utilisateurs', href: '/admin/utilisateurs', icon: Users },
    { label: 'Attributions', href: '/admin/attributions', icon: UserCheck },
    { label: 'Rétention des données', href: '/admin/retention', icon: Shield },
    ...(isSuperAdmin ? [{ label: 'Administrateurs', href: '/admin/admins', icon: Settings }] : []),
    { label: 'Profil', href: '/admin/profil', icon: Settings },
  ];

  if (isEtudiant) return etudiantItems;
  if (isProfesseur) return professeurItems;
  if (isAdmin) return adminItems;
  return [];
}

function SidebarContent({ collapsed, onClose }: { collapsed?: boolean; onClose?: () => void }) {
  const location = useLocation();
  const navigate = useNavigate();
  const { profile, signOut } = useAuth();
  const navItems = useNavItems();

  const handleSignOut = async () => {
    await signOut();
    navigate('/');
  };

  return (
    <div className="flex flex-col h-full bg-sidebar text-sidebar-foreground">
      {/* Logo */}
      <div className={cn(
        'flex items-center border-b border-sidebar-border shrink-0',
        collapsed ? 'justify-center p-3' : 'px-4 py-3'
      )}>
        {collapsed ? (
          <GraduationCap className="w-7 h-7 text-sidebar-primary" />
        ) : (
          <div className="flex items-center gap-2 min-w-0 flex-1 overflow-hidden">
            <div className="bg-white rounded-lg px-2 py-1 shrink-0">
              <img
                src={LOGO_URL}
                alt="EduDesk TCF"
                className="h-8 w-auto max-w-[148px] object-contain"
              />
            </div>
          </div>
        )}
        {onClose && (
          <button onClick={onClose} className="ml-auto text-sidebar-foreground/70 hover:text-sidebar-foreground">
            <X className="w-5 h-5" />
          </button>
        )}
      </div>

      {/* Profile summary */}
      {!collapsed && profile && (
        <div className="px-4 py-3 border-b border-sidebar-border shrink-0">
          <p className="font-semibold text-sm truncate">{profile.prenom} {profile.nom}</p>
          <p className="text-xs text-sidebar-foreground/60 truncate">{profile.email}</p>
        </div>
      )}

      {/* Navigation */}
      <nav className="flex-1 overflow-y-auto py-3">
        <ul className="space-y-1 px-2">
          {navItems.map((item) => {
            const isActive = location.pathname === item.href ||
              (item.href !== '/etudiant' && item.href !== '/admin' && item.href !== '/professeur' &&
                location.pathname.startsWith(item.href));
            return (
              <li key={item.href}>
                <Link
                  to={item.href}
                  onClick={onClose}
                  className={cn(
                    'flex items-center gap-3 px-3 py-2.5 rounded-md text-sm font-medium transition-colors',
                    isActive
                      ? 'bg-sidebar-primary text-sidebar-primary-foreground'
                      : 'text-sidebar-foreground hover:bg-sidebar-accent hover:text-sidebar-accent-foreground'
                  )}
                >
                  <item.icon className={cn('shrink-0', collapsed ? 'w-5 h-5' : 'w-4 h-4')} />
                  {!collapsed && (
                    <>
                      <span className="flex-1 truncate">{item.label}</span>
                      {item.badge !== undefined && item.badge > 0 && (
                        <Badge className="bg-destructive text-destructive-foreground text-xs px-1.5 py-0 shrink-0">
                          {item.badge}
                        </Badge>
                      )}
                    </>
                  )}
                </Link>
              </li>
            );
          })}
        </ul>
      </nav>

      {/* Sign out */}
      <div className="p-3 border-t border-sidebar-border shrink-0">
        <Button
          variant="ghost"
          className={cn(
            'w-full text-sidebar-foreground hover:bg-sidebar-accent hover:text-sidebar-accent-foreground',
            collapsed ? 'px-2' : 'justify-start gap-3'
          )}
          onClick={handleSignOut}
        >
          <LogOut className="w-4 h-4 shrink-0" />
          {!collapsed && <span>Déconnexion</span>}
        </Button>
      </div>
    </div>
  );
}

export function AppSidebar() {
  const [collapsed, setCollapsed] = useState(false);
  const [mobileOpen, setMobileOpen] = useState(false);

  return (
    <>
      {/* Desktop sidebar */}
      <aside className={cn(
        'hidden md:flex flex-col shrink-0 transition-all duration-300 relative',
        collapsed ? 'w-16' : 'w-64'
      )}>
        <SidebarContent collapsed={collapsed} />
        <button
          onClick={() => setCollapsed(!collapsed)}
          className="absolute -right-3 top-20 z-10 bg-sidebar border border-sidebar-border rounded-full p-1 text-sidebar-foreground hover:bg-sidebar-accent"
        >
          {collapsed ? <ChevronRight className="w-3.5 h-3.5" /> : <ChevronLeft className="w-3.5 h-3.5" />}
        </button>
      </aside>

      {/* Mobile hamburger */}
      <Sheet open={mobileOpen} onOpenChange={setMobileOpen}>
        <SheetTrigger asChild>
          <button className="md:hidden fixed top-4 left-4 z-50 bg-sidebar text-sidebar-foreground rounded-md p-2 shadow-lg">
            <Menu className="w-5 h-5" />
          </button>
        </SheetTrigger>
        <SheetContent side="left" className="p-0 w-72 bg-sidebar border-sidebar-border">
          <SheetTitle className="sr-only">Menu de navigation</SheetTitle>
          <SidebarContent onClose={() => setMobileOpen(false)} />
        </SheetContent>
      </Sheet>
    </>
  );
}
