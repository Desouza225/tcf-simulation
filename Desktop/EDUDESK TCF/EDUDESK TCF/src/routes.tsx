import type { ReactNode } from 'react';
import HomePage from './pages/HomePage';
import ConnexionPage from './pages/ConnexionPage';
import InscriptionPage from './pages/InscriptionPage';
// Étudiant
import EtudiantDashboard from './pages/etudiant/EtudiantDashboard';
import EntrainementPage from './pages/etudiant/EntrainementPage';
import ExamenBlancPage from './pages/etudiant/ExamenBlancPage';
import HistoriquePage from './pages/etudiant/HistoriquePage';
import NotificationsPage from './pages/etudiant/NotificationsPage';
import ProfilPage from './pages/etudiant/ProfilPage';
// Professeur
import ProfesseurDashboard from './pages/professeur/ProfesseurDashboard';
import EtudiantsListePage from './pages/professeur/EtudiantsListePage';
import CorrectionsPage from './pages/professeur/CorrectionsPage';
import CorrectionInterface from './pages/professeur/CorrectionInterface';
import ProfesseurHistoriquePage from './pages/professeur/ProfesseurHistoriquePage';
// Admin
import AdminDashboard from './pages/admin/AdminDashboard';
import QuestionsPage from './pages/admin/QuestionsPage';
import UtilisateursPage from './pages/admin/UtilisateursPage';
import AttributionsPage from './pages/admin/AttributionsPage';
import SuiviEtudiantsPage from './pages/admin/SuiviEtudiantsPage';
import RetentionPage from './pages/admin/RetentionPage';

export interface RouteConfig {
  name: string;
  path: string;
  element: ReactNode;
  visible?: boolean;
  public?: boolean;
}

export const routes: RouteConfig[] = [
  // Public
  { name: 'Accueil', path: '/', element: <HomePage />, public: true },
  { name: 'Connexion', path: '/connexion', element: <ConnexionPage />, public: true },
  { name: 'Inscription', path: '/inscription', element: <InscriptionPage />, public: true },
  // Étudiant
  { name: 'Tableau de bord', path: '/etudiant', element: <EtudiantDashboard /> },
  { name: 'Entraînement', path: '/etudiant/entrainement', element: <EntrainementPage /> },
  { name: 'Examen blanc', path: '/etudiant/examen-blanc', element: <ExamenBlancPage /> },
  { name: 'Historique', path: '/etudiant/historique', element: <HistoriquePage /> },
  { name: 'Notifications', path: '/etudiant/notifications', element: <NotificationsPage /> },
  { name: 'Profil', path: '/etudiant/profil', element: <ProfilPage /> },
  // Professeur
  { name: 'Tableau de bord Professeur', path: '/professeur', element: <ProfesseurDashboard /> },
  { name: 'Étudiants', path: '/professeur/etudiants', element: <EtudiantsListePage /> },
  { name: 'Corrections', path: '/professeur/corrections', element: <CorrectionsPage /> },
  { name: 'Correction', path: '/professeur/corrections/:id', element: <CorrectionInterface /> },
  { name: 'Historique', path: '/professeur/historique', element: <ProfesseurHistoriquePage /> },
  { name: 'Profil', path: '/professeur/profil', element: <ProfilPage /> },
  // Admin
  { name: 'Dashboard Admin', path: '/admin', element: <AdminDashboard /> },
  { name: 'Questions', path: '/admin/questions', element: <QuestionsPage /> },
  { name: 'Utilisateurs', path: '/admin/utilisateurs', element: <UtilisateursPage /> },
  { name: 'Attributions', path: '/admin/attributions', element: <AttributionsPage /> },
  { name: 'Suivi des étudiants', path: '/admin/suivi-etudiants', element: <SuiviEtudiantsPage /> },
  { name: 'Rétention des données', path: '/admin/retention', element: <RetentionPage /> },
  { name: 'Admins', path: '/admin/admins', element: <UtilisateursPage /> },
  { name: 'Profil', path: '/admin/profil', element: <ProfilPage /> },
];
