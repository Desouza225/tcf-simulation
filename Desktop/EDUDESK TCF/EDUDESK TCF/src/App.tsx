import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { Toaster } from '@/components/ui/sonner';
import { AuthProvider } from '@/contexts/AuthContext';
import { RouteGuard } from '@/components/layouts/RouteGuard';
import { AppLayout } from '@/components/layouts/AppLayout';
import { ErrorBoundary, RouteErrorBoundary } from '@/components/layouts/ErrorBoundary';

// Public
import HomePage from '@/pages/HomePage';
import ConnexionPage from '@/pages/ConnexionPage';
import InscriptionPage from '@/pages/InscriptionPage';
// Étudiant
import EtudiantDashboard from '@/pages/etudiant/EtudiantDashboard';
import EntrainementPage from '@/pages/etudiant/EntrainementPage';
import ExamenBlancPage from '@/pages/etudiant/ExamenBlancPage';
import HistoriquePage from '@/pages/etudiant/HistoriquePage';
import NotificationsPage from '@/pages/etudiant/NotificationsPage';
import ProfilPage from '@/pages/etudiant/ProfilPage';
// Professeur
import ProfesseurDashboard from '@/pages/professeur/ProfesseurDashboard';
import EtudiantsListePage from '@/pages/professeur/EtudiantsListePage';
import CorrectionsPage from '@/pages/professeur/CorrectionsPage';
import CorrectionInterface from '@/pages/professeur/CorrectionInterface';
import ProfesseurHistoriquePage from '@/pages/professeur/ProfesseurHistoriquePage';
// Admin
import AdminDashboard from '@/pages/admin/AdminDashboard';
import QuestionsPage from '@/pages/admin/QuestionsPage';
import UtilisateursPage from '@/pages/admin/UtilisateursPage';
import AttributionsPage from '@/pages/admin/AttributionsPage';
import SuiviEtudiantsPage from '@/pages/admin/SuiviEtudiantsPage';
import RetentionPage from '@/pages/admin/RetentionPage';

// Composant de chargement
function LoadingScreen() {
  return (
    <div className="flex items-center justify-center min-h-screen bg-background">
      <div className="flex flex-col items-center gap-4">
        <div className="w-10 h-10 border-4 border-primary border-t-transparent rounded-full animate-spin" />
        <p className="text-muted-foreground text-sm">Chargement...</p>
      </div>
    </div>
  );
}

// Wrapper pour routes protégées avec AppLayout + ErrorBoundary par page
// RouteErrorBoundary se réinitialise automatiquement à chaque changement de route
// → plus de message d'erreur figé lors de la navigation
function Protected({ children, roles }: { children: React.ReactNode; roles: ('super_admin' | 'admin' | 'professeur' | 'etudiant')[] }) {
  return (
    <RouteGuard allowedRoles={roles}>
      <AppLayout>
        <RouteErrorBoundary>
          {children}
        </RouteErrorBoundary>
      </AppLayout>
    </RouteGuard>
  );
}

const App: React.FC = () => {
  return (
    <ErrorBoundary>
      <Router>
        <AuthProvider>
          <Routes>
          {/* ═══ Routes publiques ═══ */}
          <Route path="/" element={<HomePage />} />
          <Route path="/connexion" element={<ConnexionPage />} />
          <Route path="/inscription" element={<InscriptionPage />} />

          {/* ═══ Espace Étudiant ═══ */}
          <Route path="/etudiant" element={<Protected roles={['etudiant']}><EtudiantDashboard /></Protected>} />
          <Route path="/etudiant/entrainement" element={<Protected roles={['etudiant']}><EntrainementPage /></Protected>} />
          <Route path="/etudiant/examen-blanc" element={<Protected roles={['etudiant']}><ExamenBlancPage /></Protected>} />
          <Route path="/etudiant/historique" element={<Protected roles={['etudiant']}><HistoriquePage /></Protected>} />
          <Route path="/etudiant/notifications" element={<Protected roles={['etudiant']}><NotificationsPage /></Protected>} />
          <Route path="/etudiant/profil" element={<Protected roles={['etudiant']}><ProfilPage /></Protected>} />

          {/* ═══ Espace Professeur ═══ */}
          <Route path="/professeur" element={<Protected roles={['professeur']}><ProfesseurDashboard /></Protected>} />
          <Route path="/professeur/etudiants" element={<Protected roles={['professeur']}><EtudiantsListePage /></Protected>} />
          <Route path="/professeur/corrections" element={<Protected roles={['professeur']}><CorrectionsPage /></Protected>} />
          <Route path="/professeur/corrections/:id" element={<Protected roles={['professeur']}><CorrectionInterface /></Protected>} />
          <Route path="/professeur/historique" element={<Protected roles={['professeur']}><ProfesseurHistoriquePage /></Protected>} />
          <Route path="/professeur/profil" element={<Protected roles={['professeur']}><ProfilPage /></Protected>} />

          {/* ═══ Espace Admin / Super Admin ═══ */}
          <Route path="/admin" element={<Protected roles={['admin', 'super_admin']}><AdminDashboard /></Protected>} />
          <Route path="/admin/questions" element={<Protected roles={['admin', 'super_admin']}><QuestionsPage /></Protected>} />
          <Route path="/admin/utilisateurs" element={<Protected roles={['admin', 'super_admin']}><UtilisateursPage /></Protected>} />
          <Route path="/admin/attributions" element={<Protected roles={['admin', 'super_admin']}><AttributionsPage /></Protected>} />
          <Route path="/admin/suivi-etudiants" element={<Protected roles={['admin', 'super_admin']}><SuiviEtudiantsPage /></Protected>} />
          <Route path="/admin/retention" element={<Protected roles={['admin', 'super_admin']}><RetentionPage /></Protected>} />
          <Route path="/admin/admins" element={<Protected roles={['super_admin']}><UtilisateursPage /></Protected>} />
          <Route path="/admin/profil" element={<Protected roles={['admin', 'super_admin']}><ProfilPage /></Protected>} />

          {/* ═══ Fallback ═══ */}
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
        <Toaster richColors position="top-right" />
      </AuthProvider>
    </Router>
    </ErrorBoundary>
  );
};

export default App;
