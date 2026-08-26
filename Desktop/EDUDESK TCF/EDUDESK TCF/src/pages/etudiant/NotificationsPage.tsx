import { Link } from 'react-router-dom';
import { useNotifications } from '@/hooks/useNotifications';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import { Bell, BellOff, CheckCheck } from 'lucide-react';
import { cn } from '@/lib/utils';

export default function NotificationsPage() {
  const { notifications, loading, markAsRead, markAllAsRead, unreadCount } = useNotifications();

  return (
    <div className="max-w-2xl mx-auto space-y-6 fade-in">
      <div className="flex items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-foreground text-balance">Notifications</h1>
          {unreadCount > 0 && (
            <p className="text-muted-foreground mt-1">{unreadCount} non lue{unreadCount > 1 ? 's' : ''}</p>
          )}
        </div>
        {unreadCount > 0 && (
          <Button variant="outline" size="sm" onClick={markAllAsRead} className="gap-2 shrink-0">
            <CheckCheck className="w-4 h-4" /> Tout marquer lu
          </Button>
        )}
      </div>

      {loading ? (
        <div className="space-y-3">{[1,2,3].map(i => <Skeleton key={i} className="h-20 w-full bg-muted" />)}</div>
      ) : notifications.length === 0 ? (
        <Card className="h-full">
          <CardContent className="p-12 text-center">
            <BellOff className="w-12 h-12 text-muted-foreground/30 mx-auto mb-4" />
            <p className="text-muted-foreground">Aucune notification pour le moment.</p>
          </CardContent>
        </Card>
      ) : (
        <div className="space-y-2">
          {notifications.map(notif => (
            <Card
              key={notif.id}
              className={cn('h-full cursor-pointer transition-colors hover:bg-muted/50', !notif.lue && 'border-primary/40 bg-primary/5')}
              onClick={() => !notif.lue && markAsRead(notif.id)}
            >
              <CardContent className="p-4 flex items-start gap-3">
                <div className={cn('w-2 h-2 rounded-full mt-2 shrink-0', notif.lue ? 'bg-muted' : 'bg-primary')} />
                <div className="flex-1 min-w-0">
                  <div className="flex items-start justify-between gap-2">
                    <p className={cn('font-medium text-sm text-balance', !notif.lue && 'text-primary')}>{notif.titre}</p>
                    {!notif.lue && <Badge className="text-xs shrink-0">Nouveau</Badge>}
                  </div>
                  <p className="text-sm text-muted-foreground mt-1 text-pretty">{notif.message}</p>
                  <p className="text-xs text-muted-foreground mt-1">
                    {new Date(notif.created_at).toLocaleDateString('fr-FR', { day: 'numeric', month: 'long', hour: '2-digit', minute: '2-digit' })}
                  </p>
                  {notif.lien && (
                    <Link to={notif.lien} className="text-xs text-primary hover:underline mt-1 inline-block">
                      Voir les détails →
                    </Link>
                  )}
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      )}
    </div>
  );
}
