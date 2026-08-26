import { useState, useEffect } from 'react';
import { supabase } from '@/db/supabase';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Skeleton } from '@/components/ui/skeleton';
import {
  Select, SelectContent, SelectItem, SelectTrigger, SelectValue,
} from '@/components/ui/select';
import { Loader2, UserCheck, Plus, Trash2 } from 'lucide-react';
import { toast } from 'sonner';
import type { Profile } from '@/types/index';

interface Attribution {
  id: string;
  etudiant_id: string;
  professeur_id: string;
  etudiant?: Profile;
  professeur?: Profile;
}

export default function AttributionsPage() {
  const [attributions, setAttributions] = useState<Attribution[]>([]);
  const [etudiants, setEtudiants] = useState<Profile[]>([]);
  const [professeurs, setProfesseurs] = useState<Profile[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedEtudiant, setSelectedEtudiant] = useState('');
  const [selectedProfesseur, setSelectedProfesseur] = useState('');
  const [saving, setSaving] = useState(false);

  const fetchData = async () => {
    try {
      const [attrResult, etudiantsResult, professeursResult] = await Promise.all([
        supabase.from('attributions').select('*, etudiant:profiles!etudiant_id(*), professeur:profiles!professeur_id(*)').order('created_at', { ascending: false }),
        supabase.from('profiles').select('*').eq('role', 'etudiant').order('nom'),
        supabase.from('profiles').select('*').eq('role', 'professeur').order('nom'),
      ]);

      if (attrResult.error) {
        console.error('Erreur attributions:', attrResult.error);
        // Fallback sans alias si besoin
        const fallback = await supabase.from('attributions').select('*').order('created_at', { ascending: false });
        if (fallback.data && etudiantsResult.data && professeursResult.data) {
          const etudMap = new Map(etudiantsResult.data.map(e => [e.id, e]));
          const profMap = new Map(professeursResult.data.map(p => [p.id, p]));
          const enriched = fallback.data.map(a => ({
            ...a,
            etudiant: etudMap.get(a.etudiant_id),
            professeur: profMap.get(a.professeur_id),
          }));
          setAttributions(enriched);
        }
      } else {
        setAttributions(Array.isArray(attrResult.data) ? attrResult.data : []);
      }

      setEtudiants(Array.isArray(etudiantsResult.data) ? etudiantsResult.data : []);
      setProfesseurs(Array.isArray(professeursResult.data) ? professeursResult.data : []);
    } catch (err) {
      console.error('Erreur chargement données:', err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { fetchData(); }, []);

  const handleAttribuer = async () => {
    if (!selectedEtudiant || !selectedProfesseur) {
      toast.error('Sélectionnez un étudiant et un professeur.');
      return;
    }
    // Vérifier si déjà attribué
    const existing = attributions.find(a => a.etudiant_id === selectedEtudiant);
    if (existing) {
      toast.error('Cet étudiant est déjà attribué à un professeur. Supprimez d\'abord l\'attribution existante.');
      return;
    }
    setSaving(true);
    const { error } = await supabase.from('attributions').insert({ etudiant_id: selectedEtudiant, professeur_id: selectedProfesseur });
    setSaving(false);
    if (error) { toast.error('Erreur lors de l\'attribution.'); return; }
    toast.success('Attribution créée avec succès !');
    setSelectedEtudiant('');
    setSelectedProfesseur('');
    fetchData();
  };

  const handleDelete = async (id: string) => {
    const { error } = await supabase.from('attributions').delete().eq('id', id);
    if (error) { toast.error('Erreur lors de la suppression.'); return; }
    toast.success('Attribution supprimée.');
    setAttributions(prev => prev.filter(a => a.id !== id));
  };

  const etudiantsSansAttribution = etudiants.filter(e => !attributions.find(a => a.etudiant_id === e.id));

  return (
    <div className="max-w-3xl mx-auto space-y-6 fade-in">
      <div>
        <h1 className="text-2xl font-bold text-foreground text-balance">Attributions étudiants-professeurs</h1>
        <p className="text-muted-foreground mt-1">{attributions.length} attribution{attributions.length !== 1 ? 's' : ''} active{attributions.length !== 1 ? 's' : ''}</p>
      </div>

      {/* Formulaire d'attribution */}
      <Card className="h-full">
        <CardHeader><CardTitle className="text-base text-balance">Nouvelle attribution</CardTitle></CardHeader>
        <CardContent className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="space-y-2">
              <label className="text-sm font-normal text-muted-foreground">Étudiant</label>
              <Select value={selectedEtudiant} onValueChange={setSelectedEtudiant}>
                <SelectTrigger>
                  <SelectValue placeholder={etudiantsSansAttribution.length === 0 ? 'Tous les étudiants sont attribués' : 'Choisir un étudiant'} />
                </SelectTrigger>
                <SelectContent>
                  {etudiantsSansAttribution.length === 0 ? (
                    <SelectItem value="none" disabled>Aucun étudiant disponible</SelectItem>
                  ) : (
                    etudiantsSansAttribution.map(e => (
                      <SelectItem key={e.id} value={e.id}>{e.prenom} {e.nom}</SelectItem>
                    ))
                  )}
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <label className="text-sm font-normal text-muted-foreground">Professeur</label>
              <Select value={selectedProfesseur} onValueChange={setSelectedProfesseur}>
                <SelectTrigger>
                  <SelectValue placeholder={professeurs.length === 0 ? 'Aucun professeur' : 'Choisir un professeur'} />
                </SelectTrigger>
                <SelectContent>
                  {professeurs.length === 0 ? (
                    <SelectItem value="none" disabled>Aucun professeur disponible</SelectItem>
                  ) : (
                    professeurs.map(p => (
                      <SelectItem key={p.id} value={p.id}>{p.prenom} {p.nom}</SelectItem>
                    ))
                  )}
                </SelectContent>
              </Select>
            </div>
          </div>
          <Button onClick={handleAttribuer} disabled={saving || !selectedEtudiant || !selectedProfesseur} className="w-full gap-2">
            {saving ? <><Loader2 className="w-4 h-4 animate-spin" />Création...</> : <><Plus className="w-4 h-4" />Créer l'attribution</>}
          </Button>
        </CardContent>
      </Card>

      {/* Liste des attributions */}
      <Card className="h-full">
        <CardHeader><CardTitle className="text-base text-balance">Attributions actuelles</CardTitle></CardHeader>
        <CardContent>
          {loading ? (
            <div className="space-y-2">{[1,2,3].map(i => <Skeleton key={i} className="h-14 w-full bg-muted" />)}</div>
          ) : attributions.length === 0 ? (
            <div className="text-center py-8">
              <UserCheck className="w-10 h-10 text-muted-foreground/30 mx-auto mb-2" />
              <p className="text-sm text-muted-foreground">Aucune attribution pour le moment.</p>
            </div>
          ) : (
            <div className="space-y-2">
              {attributions.map(attr => (
                <div key={attr.id} className="flex items-center gap-3 p-3 rounded-md bg-muted/50">
                  <div className="flex-1 min-w-0 grid grid-cols-1 md:grid-cols-2 gap-2">
                    <div className="min-w-0">
                      <p className="text-xs text-muted-foreground">Étudiant</p>
                      <p className="text-sm font-medium text-foreground truncate">
                        {attr.etudiant?.prenom} {attr.etudiant?.nom}
                      </p>
                    </div>
                    <div className="min-w-0">
                      <p className="text-xs text-muted-foreground">Professeur</p>
                      <p className="text-sm font-medium text-foreground truncate">
                        {attr.professeur?.prenom} {attr.professeur?.nom}
                      </p>
                    </div>
                  </div>
                  <Button variant="ghost" size="icon" className="text-destructive hover:text-destructive shrink-0" onClick={() => handleDelete(attr.id)}>
                    <Trash2 className="w-4 h-4" />
                  </Button>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
