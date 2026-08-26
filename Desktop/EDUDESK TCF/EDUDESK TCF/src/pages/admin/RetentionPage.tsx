import { useState, useEffect, useCallback } from 'react';
import { supabase } from '@/db/supabase';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import { Button } from '@/components/ui/button';
import { Checkbox } from '@/components/ui/checkbox';
import {
  Table, TableBody, TableCell, TableHead, TableHeader, TableRow,
} from '@/components/ui/table';
import {
  AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent,
  AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle,
  AlertDialogTrigger,
} from '@/components/ui/alert-dialog';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { toast } from 'sonner';
import {
  Trash2, Shield, Clock, CalendarX, UserX, RefreshCw, Info,
  Eye, AlertTriangle, CheckSquare,
} from 'lucide-react';

interface AuditSuppression {
  id: string;
  profil_id: string;
  role: string;
  email: string | null;
  prenom: string | null;
  nom: string | null;
  raison: string;
  created_at_profil: string | null;
  last_active_at: string | null;
  supprime_at: string;
}

// Correction 5 — Structure retournée par dry_run
interface DryRunProfile {
  id: string;
  role: string;
  email: string | null;
  prenom: string | null;
  nom: string | null;
  raison: string;
  created_at: string | null;
  last_active_at: string | null;
}

const RAISON_CONFIG: Record<string, { label: string; icon: React.ReactNode; variant: 'destructive' | 'outline' | 'secondary' }> = {
  expiration_1_an: {
    label: 'Expiration 1 an',
    icon: <CalendarX className="w-3.5 h-3.5" />,
    variant: 'destructive',
  },
  inactivite_etudiant: {
    label: 'Inactivité étudiant (5 mois)',
    icon: <Clock className="w-3.5 h-3.5" />,
    variant: 'outline',
  },
  inactivite_professeur: {
    label: 'Inactivité professeur (3 mois)',
    icon: <Clock className="w-3.5 h-3.5" />,
    variant: 'secondary',
  },
};

function fmt(date: string | null) {
  if (!date) return '—';
  return new Date(date).toLocaleDateString('fr-FR', { day: '2-digit', month: 'short', year: 'numeric' });
}

export default function RetentionPage() {
  const [logs, setLogs] = useState<AuditSuppression[]>([]);
  const [loading, setLoading] = useState(true);
  const [running, setRunning] = useState(false);
  // Correction 5 — État simulation (dry_run)
  const [simulating, setSimulating] = useState(false);
  const [dryRunResults, setDryRunResults] = useState<DryRunProfile[] | null>(null);
  const [confirmChecked, setConfirmChecked] = useState(false);

  const loadLogs = useCallback(async () => {
    setLoading(true);
    const { data } = await supabase
      .from('audit_suppressions')
      .select('*')
      .order('supprime_at', { ascending: false })
      .limit(100);
    setLogs(Array.isArray(data) ? data : []);
    setLoading(false);
  }, []);

  useEffect(() => { loadLogs(); }, [loadLogs]);

  const runCleanupNow = async () => {
    setRunning(true);
    setConfirmChecked(false);
    const { data, error } = await supabase.rpc('cleanup_expired_profiles', { dry_run: false });
    setRunning(false);
    if (error) {
      toast.error(`Erreur lors du nettoyage : ${error.message}`);
      return;
    }
    const count = (data as { deleted_count: number })?.deleted_count ?? 0;
    toast.success(
      count > 0
        ? `${count} profil(s) supprimé(s) avec succès.`
        : 'Aucun profil à supprimer pour le moment.'
    );
    // Effacer les résultats de simulation après la vraie suppression
    setDryRunResults(null);
    loadLogs();
  };

  // Correction 5 — Simulation dry_run avant suppression réelle
  const runSimulation = async () => {
    setSimulating(true);
    setDryRunResults(null);
    setConfirmChecked(false);
    const { data, error } = await supabase.rpc('cleanup_expired_profiles', { dry_run: true });
    setSimulating(false);
    if (error) {
      toast.error(`Erreur simulation : ${error.message}`);
      return;
    }
    const count = (data as { deleted_count: number })?.deleted_count ?? 0;
    if (count === 0) {
      toast.info('Aucun profil ne serait supprimé avec les règles actuelles.');
      setDryRunResults([]);
      return;
    }
    // Récupérer les détails des profils qui seraient supprimés
    const ids: string[] = (data as { deleted_ids: string[] })?.deleted_ids ?? [];
    if (ids.length > 0) {
      const { data: profiles } = await supabase
        .from('profiles')
        .select('id, role, email, prenom, nom, created_at, last_active_at')
        .in('id', ids);
      setDryRunResults(
        (profiles ?? []).map(p => ({
          ...p,
          raison: p.role === 'professeur' ? 'inactivite_professeur'
            : new Date(p.created_at) < new Date(Date.now() - 365 * 86400_000)
              ? 'expiration_1_an'
              : 'inactivite_etudiant',
        }))
      );
    } else {
      setDryRunResults([]);
    }
    toast.warning(`${count} profil(s) seraient supprimés. Vérifiez la liste avant de confirmer.`);
  };

  const stats = {
    total: logs.length,
    expiration: logs.filter(l => l.raison === 'expiration_1_an').length,
    inactiviteEtudiant: logs.filter(l => l.raison === 'inactivite_etudiant').length,
    inactiviteProf: logs.filter(l => l.raison === 'inactivite_professeur').length,
  };

  return (
    <div className="max-w-5xl mx-auto space-y-6 fade-in">
      {/* En-tête */}
      <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-foreground text-balance flex items-center gap-2">
            <Shield className="w-6 h-6 text-primary" /> Rétention des données
          </h1>
          <p className="text-muted-foreground mt-1 text-pretty">
            Gestion automatique des profils expirés ou inactifs
          </p>
        </div>
        <div className="flex items-center gap-2 shrink-0">
          <Button variant="outline" size="sm" onClick={loadLogs} disabled={loading}>
            <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />
            Actualiser
          </Button>
          {/* Correction 5 — Bouton Simuler */}
          <Button variant="outline" size="sm" onClick={runSimulation} disabled={simulating || running}>
            <Eye className={`w-4 h-4 mr-2 ${simulating ? 'animate-pulse' : ''}`} />
            {simulating ? 'Simulation…' : 'Simuler le nettoyage'}
          </Button>
          <AlertDialog>
            <AlertDialogTrigger asChild>
              <Button variant="default" size="sm" disabled={running}>
                <Trash2 className="w-4 h-4 mr-2" />
                Lancer le nettoyage
              </Button>
            </AlertDialogTrigger>
            <AlertDialogContent className="max-w-[calc(100%-2rem)] md:max-w-lg">
              <AlertDialogHeader>
                <AlertDialogTitle>Confirmer le nettoyage</AlertDialogTitle>
                <AlertDialogDescription className="text-pretty">
                  Cette action va supprimer définitivement tous les profils expirés ou inactifs
                  ainsi que toutes leurs données associées. Cette opération est irréversible.
                  {!dryRunResults && (
                    <span className="block mt-2 text-warning font-medium">
                      ⚠️ Aucune simulation n'a été effectuée. Cliquez sur "Simuler le nettoyage" d'abord pour voir la liste des comptes concernés.
                    </span>
                  )}
                </AlertDialogDescription>
              </AlertDialogHeader>
              <AlertDialogFooter>
                <AlertDialogCancel>Annuler</AlertDialogCancel>
                <AlertDialogAction onClick={runCleanupNow} className="bg-destructive text-destructive-foreground hover:bg-destructive/90">
                  Confirmer la suppression
                </AlertDialogAction>
              </AlertDialogFooter>
            </AlertDialogContent>
          </AlertDialog>
        </div>
      </div>

      {/* Règles de rétention */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <Card className="h-full border-destructive/30">
          <CardContent className="p-4 flex items-start gap-3">
            <CalendarX className="w-8 h-8 text-destructive/70 shrink-0 mt-0.5" />
            <div>
              <p className="font-semibold text-sm text-foreground">Expiration 1 an</p>
              <p className="text-xs text-muted-foreground text-pretty mt-0.5">
                Tout profil étudiant est supprimé 1 an après sa date de création, quelle que soit son activité.
              </p>
            </div>
          </CardContent>
        </Card>
        <Card className="h-full border-warning/30">
          <CardContent className="p-4 flex items-start gap-3">
            <UserX className="w-8 h-8 text-warning/70 shrink-0 mt-0.5" />
            <div>
              <p className="font-semibold text-sm text-foreground">Inactivité étudiant (5 mois)</p>
              <p className="text-xs text-muted-foreground text-pretty mt-0.5">
                Un étudiant sans connexion depuis plus de 5 mois est supprimé avec toutes ses données.
              </p>
            </div>
          </CardContent>
        </Card>
        <Card className="h-full border-secondary/40">
          <CardContent className="p-4 flex items-start gap-3">
            <Clock className="w-8 h-8 text-secondary/70 shrink-0 mt-0.5" />
            <div>
              <p className="font-semibold text-sm text-foreground">Inactivité professeur (3 mois)</p>
              <p className="text-xs text-muted-foreground text-pretty mt-0.5">
                Un professeur inactif depuis plus de 3 mois est supprimé. Les questions créées sont conservées.
              </p>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Compteurs globaux */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
        {[
          { label: 'Total supprimés', value: stats.total, color: 'text-foreground' },
          { label: 'Expiration 1 an', value: stats.expiration, color: 'text-destructive' },
          { label: 'Inactivité étudiants', value: stats.inactiviteEtudiant, color: 'text-warning' },
          { label: 'Inactivité profs', value: stats.inactiviteProf, color: 'text-muted-foreground' },
        ].map(s => (
          <Card key={s.label} className="h-full">
            <CardContent className="p-3">
              <p className={`text-2xl font-bold ${s.color}`}>{s.value}</p>
              <p className="text-xs text-muted-foreground text-pretty">{s.label}</p>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* Correction 5 — Panneau de simulation dry_run */}
      {dryRunResults !== null && (
        <Card className="h-full border-warning/40 bg-warning/5">
          <CardHeader className="pb-3">
            <CardTitle className="text-base text-balance flex items-center gap-2 text-warning">
              <Eye className="w-4 h-4" />
              Résultats de la simulation — {dryRunResults.length} profil(s) concerné(s)
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            {dryRunResults.length === 0 ? (
              <p className="text-sm text-muted-foreground">Aucun profil ne serait supprimé.</p>
            ) : (
              <>
                <Alert className="border-destructive/30 bg-destructive/5">
                  <AlertTriangle className="h-4 w-4 text-destructive" />
                  <AlertDescription className="text-pretty text-sm">
                    Ces <strong>{dryRunResults.length} compte(s)</strong> seraient supprimés définitivement lors du prochain nettoyage réel.
                    Vérifiez la liste, cochez la case de confirmation, puis cliquez sur "Confirmer la suppression définitive".
                  </AlertDescription>
                </Alert>

                <div className="overflow-x-auto">
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead className="whitespace-nowrap">Nom</TableHead>
                        <TableHead className="whitespace-nowrap">Rôle</TableHead>
                        <TableHead className="whitespace-nowrap">Raison</TableHead>
                        <TableHead className="whitespace-nowrap">Créé le</TableHead>
                        <TableHead className="whitespace-nowrap">Dernière activité</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {dryRunResults.map(p => {
                        const raisonCfg = RAISON_CONFIG[p.raison];
                        return (
                          <TableRow key={p.id}>
                            <TableCell className="whitespace-nowrap">
                              <div>
                                <p className="text-sm font-medium text-foreground">
                                  {p.prenom || '—'} {p.nom || ''}
                                </p>
                                <p className="text-xs text-muted-foreground truncate max-w-[160px]">
                                  {p.email || '—'}
                                </p>
                              </div>
                            </TableCell>
                            <TableCell className="whitespace-nowrap">
                              <Badge variant="outline" className="text-xs capitalize">{p.role}</Badge>
                            </TableCell>
                            <TableCell className="whitespace-nowrap">
                              {raisonCfg ? (
                                <Badge variant={raisonCfg.variant} className="gap-1 text-xs">
                                  {raisonCfg.icon}{raisonCfg.label}
                                </Badge>
                              ) : (
                                <span className="text-xs text-muted-foreground">{p.raison}</span>
                              )}
                            </TableCell>
                            <TableCell className="whitespace-nowrap text-sm text-muted-foreground">
                              {fmt(p.created_at)}
                            </TableCell>
                            <TableCell className="whitespace-nowrap text-sm text-muted-foreground">
                              {fmt(p.last_active_at)}
                            </TableCell>
                          </TableRow>
                        );
                      })}
                    </TableBody>
                  </Table>
                </div>

                {/* Case à cocher obligatoire + bouton de suppression définitive */}
                <div className="space-y-3 pt-2 border-t border-border">
                  <label className="flex items-start gap-3 cursor-pointer">
                    <Checkbox
                      id="confirm-delete"
                      checked={confirmChecked}
                      onCheckedChange={v => setConfirmChecked(v === true)}
                      className="mt-0.5 shrink-0"
                    />
                    <span className="text-sm text-foreground text-pretty">
                      <CheckSquare className="w-3.5 h-3.5 inline mr-1 text-muted-foreground" />
                      Je confirme avoir vérifié cette liste et je souhaite supprimer définitivement
                      ces {dryRunResults.length} compte(s) ainsi que toutes leurs données associées.
                    </span>
                  </label>
                  <AlertDialog>
                    <AlertDialogTrigger asChild>
                      <Button
                        variant="default"
                        size="sm"
                        disabled={!confirmChecked || running}
                        className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
                      >
                        <Trash2 className="w-4 h-4 mr-2" />
                        Confirmer la suppression définitive ({dryRunResults.length} compte{dryRunResults.length > 1 ? 's' : ''})
                      </Button>
                    </AlertDialogTrigger>
                    <AlertDialogContent className="max-w-[calc(100%-2rem)] md:max-w-lg">
                      <AlertDialogHeader>
                        <AlertDialogTitle>Dernière confirmation</AlertDialogTitle>
                        <AlertDialogDescription className="text-pretty">
                          Vous êtes sur le point de supprimer <strong>{dryRunResults.length} compte(s)</strong> de façon
                          irréversible. Cette action ne peut pas être annulée.
                        </AlertDialogDescription>
                      </AlertDialogHeader>
                      <AlertDialogFooter>
                        <AlertDialogCancel>Annuler</AlertDialogCancel>
                        <AlertDialogAction
                          onClick={runCleanupNow}
                          className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
                        >
                          Supprimer définitivement
                        </AlertDialogAction>
                      </AlertDialogFooter>
                    </AlertDialogContent>
                  </AlertDialog>
                </div>
              </>
            )}
          </CardContent>
        </Card>
      )}

      {/* Planification automatique */}
      <Card className="h-full border-primary/20 bg-primary/5">
        <CardContent className="p-4 flex items-start gap-3">
          <Info className="w-5 h-5 text-primary shrink-0 mt-0.5" />
          <p className="text-sm text-muted-foreground text-pretty">
            Les emails d'avertissement sont envoyés <strong className="text-foreground">chaque jour à 02h00 UTC</strong> (J-7) via
            <code className="text-xs bg-muted px-1 py-0.5 rounded mx-1">warn-expiring-profiles</code>.
            Le nettoyage réel s'exécute à <strong className="text-foreground">03h00 UTC</strong> via
            <code className="text-xs bg-muted px-1 py-0.5 rounded mx-1">cleanup-expired-profiles</code>.
            Utilisez <strong className="text-foreground">Simuler</strong> avant tout nettoyage manuel.
          </p>
        </CardContent>
      </Card>

      {/* Journal des suppressions */}
      <Card className="h-full">
        <CardHeader>
          <CardTitle className="text-base text-balance">Journal des suppressions</CardTitle>
        </CardHeader>
        <CardContent className="p-0">
          {loading ? (
            <div className="space-y-2 p-4">
              {[1, 2, 3].map(i => <Skeleton key={i} className="h-10 w-full bg-muted" />)}
            </div>
          ) : logs.length === 0 ? (
            <div className="text-center py-12">
              <Shield className="w-10 h-10 text-muted-foreground/30 mx-auto mb-3" />
              <p className="text-sm text-muted-foreground">Aucune suppression enregistrée.</p>
            </div>
          ) : (
            <div className="overflow-x-auto">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead className="whitespace-nowrap">Nom</TableHead>
                    <TableHead className="whitespace-nowrap">Rôle</TableHead>
                    <TableHead className="whitespace-nowrap">Raison</TableHead>
                    <TableHead className="whitespace-nowrap">Créé le</TableHead>
                    <TableHead className="whitespace-nowrap">Dernière activité</TableHead>
                    <TableHead className="whitespace-nowrap">Supprimé le</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {logs.map(log => {
                    const raisonCfg = RAISON_CONFIG[log.raison];
                    return (
                      <TableRow key={log.id}>
                        <TableCell className="whitespace-nowrap">
                          <div>
                            <p className="text-sm font-medium text-foreground">
                              {log.prenom || '—'} {log.nom || ''}
                            </p>
                            <p className="text-xs text-muted-foreground truncate max-w-[160px]">
                              {log.email || '—'}
                            </p>
                          </div>
                        </TableCell>
                        <TableCell className="whitespace-nowrap">
                          <Badge variant="outline" className="text-xs capitalize">
                            {log.role}
                          </Badge>
                        </TableCell>
                        <TableCell className="whitespace-nowrap">
                          {raisonCfg ? (
                            <Badge variant={raisonCfg.variant} className="gap-1 text-xs">
                              {raisonCfg.icon}
                              {raisonCfg.label}
                            </Badge>
                          ) : (
                            <span className="text-xs text-muted-foreground">{log.raison}</span>
                          )}
                        </TableCell>
                        <TableCell className="whitespace-nowrap text-sm text-muted-foreground">
                          {fmt(log.created_at_profil)}
                        </TableCell>
                        <TableCell className="whitespace-nowrap text-sm text-muted-foreground">
                          {fmt(log.last_active_at)}
                        </TableCell>
                        <TableCell className="whitespace-nowrap text-sm text-muted-foreground">
                          {fmt(log.supprime_at)}
                        </TableCell>
                      </TableRow>
                    );
                  })}
                </TableBody>
              </Table>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
