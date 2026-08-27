import { useState } from 'react';
import { supabase } from '@/db/supabase';
import {
  Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Progress } from '@/components/ui/progress';
import { Card, CardContent } from '@/components/ui/card';
import {
  UploadCloud, FileJson, CheckCircle2, AlertTriangle, Loader2, Sparkles, RefreshCw, PenTool, Mic, BookOpen, Headphones,
} from 'lucide-react';
import { toast } from 'sonner';
import type { EpreuveType } from '@/types/index';

interface PackImportModalProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  onImportSuccess: () => void;
}

interface PackInfo {
  id: EpreuveType;
  titre: string;
  count: number;
  description: string;
  fileUrl: string;
  icon: typeof PenTool;
  badge: string;
}

const OFFICIAL_PACKS: PackInfo[] = [
  {
    id: 'expression_ecrite',
    titre: 'Expression Écrite',
    count: 967,
    description: '306 courriels (T1), 311 articles (T2), 350 débats avec Document A & B (T3)',
    fileUrl: '/data/expression_ecrite_banque.json',
    icon: PenTool,
    badge: 'EE_T1_001 à EE_T3_350',
  },
  {
    id: 'expression_orale',
    titre: 'Expression Orale',
    count: 513,
    description: '4 entretiens (T1), 255 interactions (T2), 254 points de vue (T3)',
    fileUrl: '/data/expression_orale_banque.json',
    icon: Mic,
    badge: 'EO_T1_001 à EO_T3_254',
  },
  {
    id: 'comprehension_ecrit',
    titre: 'Compréhension Écrite',
    count: 1560,
    description: '40 tests complets de 39 questions avec textes et images authentiques',
    fileUrl: '/data/comprehension_ecrite_banque.json',
    icon: BookOpen,
    badge: 'CE_T01_Q01 à CE_T40_Q39',
  },
  {
    id: 'comprehension_oral',
    titre: 'Compréhension Orale',
    count: 1560,
    description: '40 tests complets de 39 questions avec fichiers audios originaux',
    fileUrl: '/data/comprehension_orale_banque.json',
    icon: Headphones,
    badge: 'CO_T01_Q01 à CO_T40_Q39',
  },
];

export default function PackImportModal({ open, onOpenChange, onImportSuccess }: PackImportModalProps) {
  const [importing, setImporting] = useState(false);
  const [currentPackTitle, setCurrentPackTitle] = useState('');
  const [progress, setProgress] = useState(0);
  const [statusMessage, setStatusMessage] = useState('');
  const [selectedCustomFile, setSelectedCustomFile] = useState<File | null>(null);

  // Fonction utilitaire pour insérer par lots de 50
  const insertBatch = async (table: string, items: any[], onBatchProgress: (done: number) => void) => {
    const BATCH_SIZE = 50;
    for (let i = 0; i < items.length; i += BATCH_SIZE) {
      const batch = items.slice(i, i + BATCH_SIZE);
      const { error } = await supabase.from(table).insert(batch);
      if (error) {
        console.error(`Erreur d'insertion dans ${table}:`, error);
        throw error;
      }
      onBatchProgress(Math.min(i + batch.length, items.length));
    }
  };

  // Traitement d'un pack officiel
  const handleImportOfficialPack = async (pack: PackInfo) => {
    try {
      setImporting(true);
      setCurrentPackTitle(pack.titre);
      setProgress(5);
      setStatusMessage(`Téléchargement du pack ${pack.titre}...`);

      const response = await fetch(pack.fileUrl);
      if (!response.ok) throw new Error(`Impossible de charger le fichier ${pack.fileUrl}`);
      const rawData = await response.json();

      if (!Array.isArray(rawData) || rawData.length === 0) {
        throw new Error('Le fichier du pack est vide ou invalide.');
      }

      setStatusMessage(`Nettoyage préalable de l'épreuve ${pack.titre}...`);
      setProgress(15);

      // 1. Nettoyer les anciennes entrées pour cette épreuve
      await supabase.from('questions').delete().eq('epreuve', pack.id);
      if (pack.id === 'expression_ecrite' || pack.id === 'expression_orale') {
        await supabase.from('taches').delete().eq('epreuve', pack.id);
      }

      setStatusMessage(`Préparation des données (${rawData.length} sujets)...`);
      setProgress(25);

      if (pack.id === 'expression_ecrite') {
        // Préparer les lignes pour `questions` et `taches`
        const questionRows: any[] = [];
        const tacheRows: any[] = [];

        for (const item of rawData) {
          const tNum = item.tache_numero || (item.id.includes('_T1_') ? 1 : item.id.includes('_T2_') ? 2 : 3);
          let consigneComplete = '';

          if (tNum === 3) {
            consigneComplete = `${item.consigne || ''}\n\nDocument A :\n${item.document_a || ''}\n\nDocument B :\n${item.document_b || ''}`.trim();
          } else if (tNum === 2) {
            consigneComplete = `${item.tache_nom || 'Tâche 2 — Article'} (${item.nombre_mots_label || '120 à 150 mots'})\n\n${item.consigne || ''}`.trim();
          } else {
            consigneComplete = `${item.tache_nom || 'Tâche 1 — Message'} (${item.nombre_mots_label || '60 à 120 mots'})\n\n${item.consigne || ''}`.trim();
          }

          questionRows.push({
            epreuve: 'expression_ecrite',
            reference: item.id,
            ordre: tNum,
            texte: consigneComplete,
            actif: true,
          });

          tacheRows.push({
            epreuve: 'expression_ecrite',
            numero_tache: tNum,
            reference: item.id,
            consigne: consigneComplete,
            duree_secondes: tNum === 1 ? 600 : tNum === 2 ? 1200 : 1800,
            actif: true,
          });
        }

        setStatusMessage(`Insertion dans la banque de questions...`);
        await insertBatch('questions', questionRows, (done) => {
          setProgress(25 + Math.round((done / questionRows.length) * 35));
        });

        setStatusMessage(`Insertion dans la table des épreuves d'entraînement...`);
        await insertBatch('taches', tacheRows, (done) => {
          setProgress(60 + Math.round((done / tacheRows.length) * 35));
        });

      } else if (pack.id === 'expression_orale') {
        const questionRows: any[] = [];
        const tacheRows: any[] = [];

        // 4 sujets T1 par défaut si manquants
        const t1Defaults = [
          { ref: 'EO_T1_001', texte: 'Tâche 1 — Entretien sans préparation (Durée : 2 minutes)\n\nPrésentez-vous, parlez de votre parcours professionnel ou universitaire, de vos motivations et de vos projets.' },
          { ref: 'EO_T1_002', texte: 'Tâche 1 — Entretien sans préparation (Durée : 2 minutes)\n\nParlez de votre expérience dans l\'apprentissage du français : vos méthodes, vos difficultés et vos plus grandes réussites.' },
          { ref: 'EO_T1_003', texte: 'Tâche 1 — Entretien sans préparation (Durée : 2 minutes)\n\nParlez de vos centres d\'intérêt, de vos loisirs et de la manière dont vous aimez passer votre temps libre.' },
          { ref: 'EO_T1_004', texte: 'Tâche 1 — Entretien sans préparation (Durée : 2 minutes)\n\nDécrivez votre ville ou région d\'origine : son climat, ses atouts, ses traditions et ce que vous y préférez.' }
        ];

        for (const t1 of t1Defaults) {
          questionRows.push({
            epreuve: 'expression_orale',
            reference: t1.ref,
            ordre: 1,
            texte: t1.texte,
            actif: true,
          });
          tacheRows.push({
            epreuve: 'expression_orale',
            numero_tache: 1,
            reference: t1.ref,
            consigne: t1.texte,
            duree_secondes: 120,
            actif: true,
          });
        }

        for (const item of rawData) {
          const tNum = item.tache_numero || (item.id.includes('_T2_') ? 2 : 3);
          let consigneComplete = '';
          if (item.document_support) {
            consigneComplete = `${item.tache_nom || ''} (${item.duree_label || ''})\n\nSujet :\n${item.document_support}\n\nConsignes :\n${item.consigne || ''}`.trim();
          } else {
            consigneComplete = `${item.tache_nom || ''} (${item.duree_label || ''})\n\n${item.consigne || ''}`.trim();
          }

          questionRows.push({
            epreuve: 'expression_orale',
            reference: item.id,
            ordre: tNum,
            texte: consigneComplete,
            actif: true,
          });

          tacheRows.push({
            epreuve: 'expression_orale',
            numero_tache: tNum,
            reference: item.id,
            consigne: consigneComplete,
            duree_secondes: tNum === 2 ? 330 : 270,
            actif: true,
          });
        }

        setStatusMessage(`Insertion dans la banque de questions...`);
        await insertBatch('questions', questionRows, (done) => {
          setProgress(25 + Math.round((done / questionRows.length) * 35));
        });

        setStatusMessage(`Insertion dans la table des épreuves d'entraînement...`);
        await insertBatch('taches', tacheRows, (done) => {
          setProgress(60 + Math.round((done / tacheRows.length) * 35));
        });

      } else {
        // Compréhension Écrite ou Orale
        const questionRows = rawData.map((item: any) => ({
          epreuve: pack.id,
          reference: item.id || item.reference || null,
          niveau: item.niveau || null,
          texte: item.texte || null,
          audio_url: item.audio_url || null,
          image_url: item.image_url || null,
          choix: item.choix || null,
          bonne_reponse: item.bonne_reponse || 'A',
          explication: item.explication || null,
          ordre: item.ordre || 1,
          actif: true,
        }));

        setStatusMessage(`Insertion des ${questionRows.length} questions QCM...`);
        await insertBatch('questions', questionRows, (done) => {
          setProgress(25 + Math.round((done / questionRows.length) * 70));
        });
      }

      setProgress(100);
      setStatusMessage('Importation terminée avec succès !');
      toast.success(`Le pack ${pack.titre} a été importé avec succès !`);
      onImportSuccess();
      setTimeout(() => {
        setImporting(false);
        onOpenChange(false);
      }, 1200);

    } catch (err: any) {
      console.error(err);
      toast.error(`Erreur d'importation : ${err.message || 'Échec de l\'opération'}`);
      setImporting(false);
    }
  };

  // Importer l'intégralité des 4 600 questions
  const handleImportAllPacks = async () => {
    for (const pack of OFFICIAL_PACKS) {
      await handleImportOfficialPack(pack);
    }
    toast.success('La totalité des 4 600 questions et sujets TCF ont été importés !');
  };

  // Import fichier personnalisé JSON
  const handleCustomFileImport = async () => {
    if (!selectedCustomFile) {
      toast.error('Veuillez sélectionner un fichier JSON.');
      return;
    }

    try {
      setImporting(true);
      setCurrentPackTitle(selectedCustomFile.name);
      setProgress(10);
      setStatusMessage('Lecture du fichier...');

      const text = await selectedCustomFile.text();
      const items = JSON.parse(text);

      if (!Array.isArray(items) || items.length === 0) {
        throw new Error('Le fichier doit contenir un tableau JSON non vide.');
      }

      setStatusMessage(`Insertion de ${items.length} éléments...`);
      await insertBatch('questions', items, (done) => {
        setProgress(20 + Math.round((done / items.length) * 75));
      });

      setProgress(100);
      toast.success(`${items.length} questions importées avec succès !`);
      onImportSuccess();
      setTimeout(() => {
        setImporting(false);
        onOpenChange(false);
      }, 1000);
    } catch (err: any) {
      console.error(err);
      toast.error(`Erreur fichier : ${err.message}`);
      setImporting(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={importing ? () => {} : onOpenChange}>
      <DialogContent className="max-w-[calc(100%-2rem)] md:max-w-3xl max-h-[90dvh] overflow-y-auto">
        <DialogHeader>
          <div className="flex items-center gap-2">
            <div className="p-2 rounded-lg bg-primary/10 text-primary">
              <UploadCloud className="w-5 h-5" />
            </div>
            <div>
              <DialogTitle className="text-xl">Importer un Pack de Questions</DialogTitle>
              <DialogDescription>
                Injectez directement les vrais sujets authentiques sans aucune création artificielle.
              </DialogDescription>
            </div>
          </div>
        </DialogHeader>

        {importing ? (
          <div className="py-8 space-y-4 text-center">
            <div className="flex items-center justify-center">
              <Loader2 className="w-10 h-10 text-primary animate-spin" />
            </div>
            <div className="space-y-1">
              <h3 className="font-semibold text-base">{currentPackTitle}</h3>
              <p className="text-sm text-muted-foreground">{statusMessage}</p>
            </div>
            <div className="max-w-md mx-auto space-y-2">
              <Progress value={progress} className="h-2" />
              <p className="text-xs text-muted-foreground font-mono">{progress}%</p>
            </div>
          </div>
        ) : (
          <Tabs defaultValue="officiels" className="space-y-4 py-2">
            <TabsList className="grid grid-cols-2 w-full">
              <TabsTrigger value="officiels" className="gap-2">
                <Sparkles className="w-4 h-4 text-amber-500" /> Packs Officiels Intégrés (4 600)
              </TabsTrigger>
              <TabsTrigger value="fichier" className="gap-2">
                <FileJson className="w-4 h-4 text-blue-500" /> Fichier Externe (JSON)
              </TabsTrigger>
            </TabsList>

            {/* ONGLET 1 : PACKS OFFICIELS */}
            <TabsContent value="officiels" className="space-y-4">
              <div className="flex items-center justify-between p-3 rounded-lg bg-muted/40 border border-border">
                <div>
                  <p className="text-sm font-medium">Banque Globale Complète TCF</p>
                  <p className="text-xs text-muted-foreground">4 épreuves • 4 600 questions authentiques garanties</p>
                </div>
                <Button onClick={handleImportAllPacks} size="sm" className="gap-2 bg-primary hover:bg-primary/90">
                  <RefreshCw className="w-4 h-4" /> Tout importer en 1 clic
                </Button>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                {OFFICIAL_PACKS.map(pack => {
                  const Icon = pack.icon;
                  return (
                    <Card key={pack.id} className="border-border hover:border-primary/50 transition-colors">
                      <CardContent className="p-4 flex flex-col justify-between h-full space-y-3">
                        <div className="space-y-2">
                          <div className="flex items-center justify-between gap-2">
                            <div className="flex items-center gap-2">
                              <div className="p-1.5 rounded-md bg-muted text-primary">
                                <Icon className="w-4 h-4" />
                              </div>
                              <h4 className="font-semibold text-sm">{pack.titre}</h4>
                            </div>
                            <Badge variant="secondary" className="font-mono text-xs">
                              {pack.count} sujets
                            </Badge>
                          </div>
                          <p className="text-xs text-muted-foreground line-clamp-2">
                            {pack.description}
                          </p>
                          <Badge variant="outline" className="text-[10px] text-muted-foreground font-mono">
                            Réf: {pack.badge}
                          </Badge>
                        </div>
                        <Button
                          variant="outline"
                          size="sm"
                          className="w-full gap-2 text-xs"
                          onClick={() => handleImportOfficialPack(pack)}
                        >
                          <UploadCloud className="w-3.5 h-3.5" />
                          Importer ce pack ({pack.count})
                        </Button>
                      </CardContent>
                    </Card>
                  );
                })}
              </div>
            </TabsContent>

            {/* ONGLET 2 : FICHIER EXTERNE */}
            <TabsContent value="fichier" className="space-y-4">
              <div className="border-2 border-dashed border-border rounded-xl p-6 text-center space-y-3">
                <FileJson className="w-10 h-10 text-muted-foreground mx-auto" />
                <div className="space-y-1">
                  <p className="text-sm font-medium">Sélectionnez votre fichier de questions JSON</p>
                  <p className="text-xs text-muted-foreground">Format attendu : tableau d'objets avec champs reference, epreuve, texte, etc.</p>
                </div>
                <input
                  type="file"
                  accept=".json"
                  className="hidden"
                  id="custom-file-input"
                  onChange={e => setSelectedCustomFile(e.target.files?.[0] || null)}
                />
                <label htmlFor="custom-file-input">
                  <Button variant="outline" size="sm" asChild className="cursor-pointer">
                    <span>Parcourir mon ordinateur</span>
                  </Button>
                </label>
                {selectedCustomFile && (
                  <p className="text-xs font-mono text-primary font-medium">
                    Fichier sélectionné : {selectedCustomFile.name} ({(selectedCustomFile.size / 1024).toFixed(1)} KB)
                  </p>
                )}
              </div>
              <Button
                disabled={!selectedCustomFile}
                onClick={handleCustomFileImport}
                className="w-full gap-2"
              >
                <UploadCloud className="w-4 h-4" /> Importer le fichier sélectionné
              </Button>
            </TabsContent>
          </Tabs>
        )}

        {!importing && (
          <DialogFooter>
            <Button variant="ghost" onClick={() => onOpenChange(false)}>
              Fermer
            </Button>
          </DialogFooter>
        )}
      </DialogContent>
    </Dialog>
  );
}
