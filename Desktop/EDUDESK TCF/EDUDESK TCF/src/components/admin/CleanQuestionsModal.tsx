import { useState } from 'react';
import { supabase } from '@/db/supabase';
import {
  Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { Trash2, AlertTriangle, Loader2 } from 'lucide-react';
import { toast } from 'sonner';
import type { EpreuveType } from '@/types/index';
import { EPREUVE_LABELS } from '@/types/index';

interface CleanQuestionsModalProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  onCleanSuccess: () => void;
}

type CleanTarget = EpreuveType | 'expression_all' | 'all';

export default function CleanQuestionsModal({ open, onOpenChange, onCleanSuccess }: CleanQuestionsModalProps) {
  const [target, setTarget] = useState<CleanTarget>('expression_ecrite');
  const [loading, setLoading] = useState(false);

  const handleClean = async () => {
    try {
      setLoading(true);

      if (target === 'all') {
        // Supprimer toutes les questions et tâches
        const { error: errQ } = await supabase.from('questions').delete().neq('id', '00000000-0000-0000-0000-000000000000');
        const { error: errT } = await supabase.from('taches').delete().neq('id', '00000000-0000-0000-0000-000000000000');
        if (errQ || errT) throw (errQ || errT);
        toast.success('Toutes les questions et tâches ont été vidées avec succès !');

      } else if (target === 'expression_all') {
        // Supprimer EE + EO
        const { error: errQ } = await supabase.from('questions').delete().in('epreuve', ['expression_ecrite', 'expression_orale']);
        const { error: errT } = await supabase.from('taches').delete().in('epreuve', ['expression_ecrite', 'expression_orale']);
        if (errQ || errT) throw (errQ || errT);
        toast.success('Toutes les questions d\'Expression Écrite et Orale ont été vidées !');

      } else {
        // Supprimer une épreuve spécifique
        const { error: errQ } = await supabase.from('questions').delete().eq('epreuve', target);
        if (target === 'expression_ecrite' || target === 'expression_orale') {
          await supabase.from('taches').delete().eq('epreuve', target);
        }
        if (errQ) throw errQ;
        toast.success(`Les questions de l'épreuve "${EPREUVE_LABELS[target]}" ont été supprimées !`);
      }

      onCleanSuccess();
      onOpenChange(false);
    } catch (err: any) {
      console.error(err);
      toast.error(`Erreur lors du nettoyage : ${err.message || 'Échec de la suppression'}`);
    } finally {
      setLoading(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={loading ? () => {} : onOpenChange}>
      <DialogContent className="max-w-[calc(100%-2rem)] md:max-w-lg">
        <DialogHeader>
          <div className="flex items-center gap-2">
            <div className="p-2 rounded-lg bg-destructive/10 text-destructive">
              <Trash2 className="w-5 h-5" />
            </div>
            <div>
              <DialogTitle className="text-xl">Vider une Épreuve</DialogTitle>
              <DialogDescription>
                Supprimez les questions enregistrées pour repartir sur une base propre.
              </DialogDescription>
            </div>
          </div>
        </DialogHeader>

        <div className="space-y-4 py-2">
          <Alert variant="destructive" className="bg-destructive/5 border-destructive/20 text-destructive">
            <AlertTriangle className="w-4 h-4" />
            <AlertDescription className="text-xs">
              Cette action est irréversible. Les questions supprimées devront être réimportées via l'outil d'import.
            </AlertDescription>
          </Alert>

          <div className="space-y-3">
            <Label className="text-sm font-medium">Choisissez ce que vous souhaitez effacer :</Label>
            <RadioGroup value={target} onValueChange={v => setTarget(v as CleanTarget)} className="space-y-2">
              <div className="flex items-center space-x-2 p-2 rounded-lg border border-border hover:bg-muted/40 transition-colors">
                <RadioGroupItem value="expression_ecrite" id="clean-ee" />
                <Label htmlFor="clean-ee" className="flex-1 cursor-pointer text-sm">
                  Expression Écrite uniquement <span className="text-xs text-muted-foreground">(967 sujets)</span>
                </Label>
              </div>

              <div className="flex items-center space-x-2 p-2 rounded-lg border border-border hover:bg-muted/40 transition-colors">
                <RadioGroupItem value="expression_orale" id="clean-eo" />
                <Label htmlFor="clean-eo" className="flex-1 cursor-pointer text-sm">
                  Expression Orale uniquement <span className="text-xs text-muted-foreground">(513 sujets)</span>
                </Label>
              </div>

              <div className="flex items-center space-x-2 p-2 rounded-lg border border-border hover:bg-muted/40 transition-colors">
                <RadioGroupItem value="expression_all" id="clean-exp-all" />
                <Label htmlFor="clean-exp-all" className="flex-1 cursor-pointer text-sm font-medium">
                  Toutes les Expressions (Écrite + Orale)
                </Label>
              </div>

              <div className="flex items-center space-x-2 p-2 rounded-lg border border-border hover:bg-muted/40 transition-colors">
                <RadioGroupItem value="comprehension_ecrit" id="clean-ce" />
                <Label htmlFor="clean-ce" className="flex-1 cursor-pointer text-sm">
                  Compréhension Écrite uniquement <span className="text-xs text-muted-foreground">(1 560 questions)</span>
                </Label>
              </div>

              <div className="flex items-center space-x-2 p-2 rounded-lg border border-border hover:bg-muted/40 transition-colors">
                <RadioGroupItem value="comprehension_oral" id="clean-co" />
                <Label htmlFor="clean-co" className="flex-1 cursor-pointer text-sm">
                  Compréhension Orale uniquement <span className="text-xs text-muted-foreground">(1 560 questions)</span>
                </Label>
              </div>

              <div className="flex items-center space-x-2 p-2 rounded-lg border border-destructive/30 bg-destructive/5 hover:bg-destructive/10 transition-colors">
                <RadioGroupItem value="all" id="clean-all" />
                <Label htmlFor="clean-all" className="flex-1 cursor-pointer text-sm font-semibold text-destructive">
                  Tout vider (Réinitialisation complète de la banque)
                </Label>
              </div>
            </RadioGroup>
          </div>
        </div>

        <DialogFooter className="gap-2 sm:gap-0">
          <Button variant="outline" onClick={() => onOpenChange(false)} disabled={loading}>
            Annuler
          </Button>
          <Button variant="destructive" onClick={handleClean} disabled={loading} className="gap-2">
            {loading ? <><Loader2 className="w-4 h-4 animate-spin" />Suppression...</> : <><Trash2 className="w-4 h-4" />Confirmer la suppression</>}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
