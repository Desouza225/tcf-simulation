import { AppSidebar } from './AppSidebar';
import { NotificationsProvider } from '@/contexts/NotificationsContext';

interface AppLayoutProps {
  children: React.ReactNode;
}

export function AppLayout({ children }: AppLayoutProps) {
  return (
    <NotificationsProvider>
      <div className="flex min-h-screen w-full bg-background">
        <AppSidebar />
        <div className="flex-1 min-w-0 overflow-x-clip flex flex-col">
          <main className="flex-1 p-4 md:p-6 pt-16 md:pt-6">
            {children}
          </main>
        </div>
      </div>
    </NotificationsProvider>
  );
}
