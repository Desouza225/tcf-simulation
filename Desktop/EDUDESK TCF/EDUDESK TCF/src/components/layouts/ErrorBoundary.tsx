import { Component, type ReactNode } from 'react';
import { useLocation } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { AlertTriangle, RefreshCw, ArrowLeft } from 'lucide-react';

interface Props {
  children: ReactNode;
  resetKey?: string;
}

interface State {
  hasError: boolean;
  error: Error | null;
  lastResetKey: string | undefined;
}

/**
 * ErrorBoundary — capture les erreurs JavaScript non gérées dans le rendu React.
 * - Se réinitialise automatiquement quand `resetKey` change (changement de route).
 * - Empêche la page blanche complète : seule la page courante affiche l'erreur.
 */
export class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false, error: null, lastResetKey: props.resetKey };
  }

  // Réinitialiser l'état d'erreur quand la route change (resetKey change)
  static getDerivedStateFromProps(props: Props, state: State): Partial<State> | null {
    if (props.resetKey !== state.lastResetKey) {
      return { hasError: false, error: null, lastResetKey: props.resetKey };
    }
    return null;
  }

  static getDerivedStateFromError(error: Error): Partial<State> {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, info: { componentStack: string }) {
    // Ignorer silencieusement les erreurs DOM causées par les extensions navigateur
    // (Google Translate, Grammarly, etc.) qui modifient le DOM sans que React le sache
    const isExtensionDomError =
      error.message.includes('removeChild') ||
      error.message.includes('insertBefore') ||
      error.message.includes('is not a child of this node') ||
      error.message.includes('Node to be removed');

    if (isExtensionDomError) {
      // Réinitialiser immédiatement : l'erreur vient du navigateur, pas du code
      this.setState({ hasError: false, error: null });
      return;
    }

    console.error('[ErrorBoundary] Erreur capturée:', error.message, info.componentStack);
  }

  handleReload = () => {
    window.location.reload();
  };

  handleBack = () => {
    this.setState({ hasError: false, error: null });
    window.history.back();
  };

  render() {
    if (this.state.hasError) {
      return (
        <div className="flex items-center justify-center min-h-[60vh] p-6">
          <Card className="w-full max-w-md h-full">
            <CardContent className="p-8 flex flex-col items-center gap-5 text-center">
              <div className="w-14 h-14 rounded-full bg-destructive/10 flex items-center justify-center shrink-0">
                <AlertTriangle className="w-7 h-7 text-destructive" />
              </div>
              <div className="space-y-2">
                <h2 className="text-lg font-semibold text-foreground text-balance">
                  Une erreur est survenue
                </h2>
                <p className="text-sm text-muted-foreground text-pretty">
                  Cette page a rencontré un problème inattendu. Vos données ne sont pas affectées.
                </p>
              </div>
              <div className="flex gap-3 flex-wrap justify-center">
                <Button variant="outline" size="sm" onClick={this.handleBack}>
                  <ArrowLeft className="w-4 h-4 mr-2" />
                  Retour
                </Button>
                <Button size="sm" onClick={this.handleReload}>
                  <RefreshCw className="w-4 h-4 mr-2" />
                  Recharger la page
                </Button>
              </div>
            </CardContent>
          </Card>
        </div>
      );
    }

    return this.props.children;
  }
}

/**
 * Wrapper fonctionnel qui passe le pathname courant comme resetKey.
 * Garantit que l'ErrorBoundary se réinitialise à chaque changement de route.
 */
export function RouteErrorBoundary({ children }: { children: ReactNode }) {
  const { pathname } = useLocation();
  return <ErrorBoundary resetKey={pathname}>{children}</ErrorBoundary>;
}
