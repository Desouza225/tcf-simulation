import { useState, useEffect } from 'react';
import { supabase } from '@/db/supabase';
import { useAuth } from '@/contexts/AuthContext';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import {
  Select, SelectContent, SelectItem, SelectTrigger, SelectValue,
} from '@/components/ui/select';
import {
  Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter,
} from '@/components/ui/dialog';
import {
  AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent,
  AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle, AlertDialogTrigger,
} from '@/components/ui/alert-dialog';
import { Plus, Pencil, Trash2, Loader2, BookOpen, Search, Music, Image as ImageIcon } from 'lucide-react';
import { toast } from 'sonner';
import type { Question, EpreuveType, NiveauCECRL } from '@/types/index';
import { EPREUVE_LABELS, NIVEAU_CECRL_LIST } from '@/types/index';
import MediaUpload from '@/components/ui/MediaUpload';

const EMPTY_FORM = {
  epreuve: '' as EpreuveType,
  niveau: '' as NiveauCECRL | '',
  reference: '',
  texte: '',
  audio_url: '',
  image_url: '',
  explication: '',
  choix: [{ id: 'A', texte: '' }, { id: 'B', texte: '' }, { id: 'C', texte: '' }, { id: 'D', texte: '' }],
  bonne_reponse: 'A',
};

const PAGE_SIZE = 50;

export default function QuestionsPage() {
  const [questions, setQuestions] = useState<Question[]>([]);
  const [totalCount, setTotalCount] = useState(0);
  const [page, setPage] = useState(0);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [filterEpreuve, setFilterEpreuve] = useState<EpreuveType | 'toutes'>('toutes');
  const [form, setForm] = useState<{
    epreuve: EpreuveType;
    niveau: NiveauCECRL | '';
    reference: string;
    texte: string;
    audio_url: string;
    image_url: string;
    explication: string;
    choix: { id: string; texte: string }[];
    bonne_reponse: string;
  }>(EMPTY_FORM);
  const [editId, setEditId] = useState<string | null>(null);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [saving, setSaving] = useState(false);

  const fetchQuestions = async (currentPage = page) => {
    setLoading(true);
    let q = supabase
      .from('questions')
      .select('*', { count: 'exact' })
      .order('created_at', { ascending: false })
      .range(currentPage * PAGE_SIZE, (currentPage + 1) * PAGE_SIZE - 1);
    if (filterEpreuve !== 'toutes') q = q.eq('epreuve', filterEpreuve);
    const { data, count } = await q;
    setQuestions(Array.isArray(data) ? data : []);
    setTotalCount(count ?? 0);
    setLoading(false);
  };

  useEffect(() => {
    setPage(0);
    fetchQuestions(0);
  }, [filterEpreuve]);

  useEffect(() => {
    fetchQuestions(page);
  }, [page]);

  const filtered = questions.filter(q =>
    !search ||
    q.texte?.toLowerCase().includes(search.toLowerCase()) ||
    q.reference?.toLowerCase().includes(search.toLowerCase())
  );

  const handleOpen = (question?: Question) => {
    if (question) {
      setEditId(question.id);
      setForm({
        epreuve: question.epreuve,
        niveau: question.niveau || '',
        reference: question.reference || '',
        texte: question.texte || '',
        audio_url: question.audio_url || '',
        image_url: question.image_url || '',
        explication: question.explication || '',
        choix: question.choix || EMPTY_FORM.choix,
        bonne_reponse: question.bonne_reponse || 'A',
      });
    } else {
      setEditId(null);
      setForm(EMPTY_FORM);
    }
    setDialogOpen(true);
  };

  const handleSave = async () => {
    if (!form.epreuve) { toast.error('Sélectionnez une épreuve.'); return; }
    setSaving(true);
    const isQCM = form.epreuve === 'comprehension_oral' || form.epreuve === 'comprehension_ecrit';
    const payload = {
      epreuve: form.epreuve,
      niveau: form.niveau || null,
      reference: form.reference?.trim() || null,
      texte: form.texte || null,
      audio_url: form.audio_url || null,
      image_url: form.image_url || null,
      explication: form.explication || null,
      choix: isQCM ? form.choix : null,
      bonne_reponse: isQCM ? form.bonne_reponse : null,
      actif: true,
    };

    const { error } = editId
      ? await supabase.from('questions').update(payload).eq('id', editId)
      : await supabase.from('questions').insert(payload);

    setSaving(false);
    if (error) { toast.error('Erreur lors de la sauvegarde.'); return; }
    toast.success(editId ? 'Question modifiée !' : 'Question créée !');
    setDialogOpen(false);
    fetchQuestions(page);
  };

  const handleDelete = async (id: string) => {
    const { error } = await supabase.from('questions').delete().eq('id', id);
    if (error) { toast.error('Erreur lors de la suppression.'); return; }
    toast.success('Question supprimée !');
    fetchQuestions(page);
  };

  const isQCM = form.epreuve === 'comprehension_oral' || form.epreuve === 'comprehension_ecrit';

  return (
    <div className="max-w-5xl mx-auto space-y-6 fade-in">
      <div className="flex items-start justify-between gap-4 flex-wrap">
        <div>
          <h1 className="text-2xl font-bold text-foreground text-balance">Banque de questions</h1>
          <p className="text-muted-foreground mt-1">{totalCount} question{totalCount !== 1 ? 's' : ''} au total</p>
        </div>
        <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
          <DialogTrigger asChild>
            <Button onClick={() => handleOpen()} className="gap-2 shrink-0">
              <Plus className="w-4 h-4" /> Nouvelle question
            </Button>
          </DialogTrigger>
          <DialogContent className="max-w-[calc(100%-2rem)] md:max-w-2xl max-h-[90dvh] overflow-y-auto">
            <DialogHeader>
              <DialogTitle className="text-balance">{editId ? 'Modifier la question' : 'Nouvelle question'}</DialogTitle>
            </DialogHeader>
            <div className="space-y-4 py-2">
              <div className="grid grid-cols-3 gap-3">
                <div className="space-y-2">
                  <Label className="text-sm font-normal">Épreuve *</Label>
                  <Select value={form.epreuve} onValueChange={v => setForm(f => ({ ...f, epreuve: v as EpreuveType }))}>
                    <SelectTrigger><SelectValue placeholder="Choisir l'épreuve" /></SelectTrigger>
                    <SelectContent>
                      {(Object.keys(EPREUVE_LABELS) as EpreuveType[]).map(ep => (
                        <SelectItem key={ep} value={ep}>{EPREUVE_LABELS[ep]}</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <Label className="text-sm font-normal">Niveau CECRL</Label>
                  <Select value={form.niveau || 'all'} onValueChange={v => setForm(f => ({ ...f, niveau: v === 'all' ? ('' as '') : v as NiveauCECRL }))}>
                    <SelectTrigger><SelectValue placeholder="Niveau" /></SelectTrigger>
                    <SelectContent>
                      <SelectItem value="all">Sans niveau spécifique</SelectItem>
                      {NIVEAU_CECRL_LIST.map(n => <SelectItem key={n} value={n}>{n}</SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <Label className="text-sm font-normal">Code Référence</Label>
                  <Input
                    value={form.reference}
                    onChange={e => setForm(f => ({ ...f, reference: e.target.value }))}
                    placeholder="ex: CO_012, CE_045"
                  />
                </div>
              </div>
              <div className="space-y-2">
                <Label className="text-sm font-normal">Texte / Consigne de la question</Label>
                <Textarea value={form.texte} onChange={e => setForm(f => ({ ...f, texte: e.target.value }))} placeholder="Saisissez le texte de la question..." className="min-h-24" />
              </div>
              <div className="grid grid-cols-1 gap-4">
                <MediaUpload
                  type="audio"
                  value={form.audio_url}
                  onChange={url => setForm(f => ({ ...f, audio_url: url }))}
                  label="Fichier audio (optionnel)"
                />
                <MediaUpload
                  type="image"
                  value={form.image_url}
                  onChange={url => setForm(f => ({ ...f, image_url: url }))}
                  label="Image (optionnel)"
                />
              </div>
              {isQCM && (
                <>
                  <div className="space-y-3">
                    <Label className="text-sm font-normal">Choix de réponses</Label>
                    {form.choix.map((c, i) => (
                      <div key={c.id} className="flex items-center gap-2">
                        <span className="font-semibold text-sm text-muted-foreground w-6 shrink-0">{c.id}.</span>
                        <Input
                          value={c.texte}
                          onChange={e => setForm(f => ({ ...f, choix: f.choix.map((ch, j) => j === i ? { ...ch, texte: e.target.value } : ch) }))}
                          placeholder={`Option ${c.id}`}
                          className="flex-1"
                        />
                      </div>
                    ))}
                  </div>
                  <div className="space-y-2">
                    <Label className="text-sm font-normal">Bonne réponse</Label>
                    <Select value={form.bonne_reponse} onValueChange={v => setForm(f => ({ ...f, bonne_reponse: v }))}>
                      <SelectTrigger><SelectValue /></SelectTrigger>
                      <SelectContent>
                        {form.choix.map(c => <SelectItem key={c.id} value={c.id}>Réponse {c.id}</SelectItem>)}
                      </SelectContent>
                    </Select>
                  </div>
                </>
              )}
              <div className="space-y-2">
                <Label className="text-sm font-normal">Explication (optionnel)</Label>
                <Textarea value={form.explication} onChange={e => setForm(f => ({ ...f, explication: e.target.value }))} placeholder="Explication de la bonne réponse..." className="min-h-20" />
              </div>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setDialogOpen(false)}>Annuler</Button>
              <Button onClick={handleSave} disabled={saving}>
                {saving ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" />Sauvegarde...</> : 'Enregistrer'}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>

      {/* Filtres */}
      <div className="flex flex-col md:flex-row gap-3">
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
          <Input value={search} onChange={e => { setSearch(e.target.value); setPage(0); }} placeholder="Rechercher par texte ou code référence (ex: CO_012)..." className="pl-9" />
        </div>
        <Select value={filterEpreuve} onValueChange={v => setFilterEpreuve(v as EpreuveType | 'toutes')}>
          <SelectTrigger className="w-full md:w-56"><SelectValue /></SelectTrigger>
          <SelectContent>
            <SelectItem value="toutes">Toutes les épreuves</SelectItem>
            {(Object.keys(EPREUVE_LABELS) as EpreuveType[]).map(ep => (
              <SelectItem key={ep} value={ep}>{EPREUVE_LABELS[ep]}</SelectItem>
            ))}
          </SelectContent>
        </Select>
      </div>

      {/* Liste */}
      {loading ? (
        <div className="space-y-2">{[1,2,3,4,5].map(i => <Skeleton key={i} className="h-16 w-full bg-muted" />)}</div>
      ) : filtered.length === 0 ? (
        <Card className="h-full">
          <CardContent className="p-12 text-center">
            <BookOpen className="w-12 h-12 text-muted-foreground/30 mx-auto mb-4" />
            <p className="text-muted-foreground">Aucune question trouvée.</p>
          </CardContent>
        </Card>
      ) : (
        <div className="overflow-x-auto">
          <table className="w-full min-w-max">
            <thead>
              <tr className="border-b border-border">
                <th className="text-left text-xs font-medium text-muted-foreground whitespace-nowrap px-3 py-2">RÉFÉRENCE</th>
                <th className="text-left text-xs font-medium text-muted-foreground whitespace-nowrap px-3 py-2">ÉPREUVE</th>
                <th className="text-left text-xs font-medium text-muted-foreground whitespace-nowrap px-3 py-2">NIVEAU</th>
                <th className="text-left text-xs font-medium text-muted-foreground whitespace-nowrap px-3 py-2">TEXTE</th>
                <th className="text-left text-xs font-medium text-muted-foreground whitespace-nowrap px-3 py-2">ACTIONS</th>
              </tr>
            </thead>
            <tbody>
              {filtered.map(q => (
                <tr key={q.id} className="border-b border-border hover:bg-muted/30 transition-colors">
                  <td className="px-3 py-3 whitespace-nowrap">
                    {q.reference ? (
                      <Badge variant="outline" className="text-xs font-mono font-medium border-primary/40 bg-primary/5 text-primary">
                        {q.reference}
                      </Badge>
                    ) : (
                      <span className="text-xs text-muted-foreground">—</span>
                    )}
                  </td>
                  <td className="px-3 py-3 whitespace-nowrap">
                    <Badge variant="outline" className="text-xs">{EPREUVE_LABELS[q.epreuve]?.split(' ')[0]}</Badge>
                  </td>
                  <td className="px-3 py-3 whitespace-nowrap">
                    <span className="text-xs text-muted-foreground">{q.niveau || '—'}</span>
                  </td>
                  <td className="px-3 py-3 max-w-xs">
                    <p className="text-sm text-foreground truncate">{q.texte || q.audio_url ? (q.texte || '(Audio seulement)') : '—'}</p>
                    <div className="flex items-center gap-2 mt-1">
                      {q.audio_url && <span className="inline-flex items-center gap-1 text-xs text-muted-foreground"><Music className="w-3 h-3" />Audio</span>}
                      {q.image_url && <span className="inline-flex items-center gap-1 text-xs text-muted-foreground"><ImageIcon className="w-3 h-3" />Image</span>}
                    </div>
                  </td>
                  <td className="px-3 py-3 whitespace-nowrap">
                    <div className="flex items-center gap-2">
                      <Button variant="ghost" size="icon" onClick={() => handleOpen(q)}>
                        <Pencil className="w-4 h-4" />
                      </Button>
                      <AlertDialog>
                        <AlertDialogTrigger asChild>
                          <Button variant="ghost" size="icon" className="text-destructive hover:text-destructive">
                            <Trash2 className="w-4 h-4" />
                          </Button>
                        </AlertDialogTrigger>
                        <AlertDialogContent className="max-w-[calc(100%-2rem)] md:max-w-lg">
                          <AlertDialogHeader>
                            <AlertDialogTitle className="text-balance">Supprimer la question ?</AlertDialogTitle>
                            <AlertDialogDescription className="text-pretty">Cette action est irréversible. La question sera définitivement supprimée.</AlertDialogDescription>
                          </AlertDialogHeader>
                          <AlertDialogFooter>
                            <AlertDialogCancel>Annuler</AlertDialogCancel>
                            <AlertDialogAction className="bg-destructive text-destructive-foreground hover:bg-destructive/90" onClick={() => handleDelete(q.id)}>
                              Supprimer
                            </AlertDialogAction>
                          </AlertDialogFooter>
                        </AlertDialogContent>
                      </AlertDialog>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {/* Pagination */}
      {totalCount > PAGE_SIZE && (
        <div className="flex items-center justify-between gap-4 pt-2">
          <p className="text-sm text-muted-foreground">
            Page {page + 1} sur {Math.ceil(totalCount / PAGE_SIZE)} — {totalCount} questions
          </p>
          <div className="flex items-center gap-2">
            <Button
              variant="outline"
              size="sm"
              disabled={page === 0 || loading}
              onClick={() => setPage(p => p - 1)}
            >
              Précédent
            </Button>
            <Button
              variant="outline"
              size="sm"
              disabled={(page + 1) * PAGE_SIZE >= totalCount || loading}
              onClick={() => setPage(p => p + 1)}
            >
              Suivant
            </Button>
          </div>
        </div>
      )}
    </div>
  );
}
