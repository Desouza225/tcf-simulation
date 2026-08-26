import { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

// L'inscription publique est désactivée — seuls les administrateurs créent des comptes
export default function InscriptionPage() {
  const navigate = useNavigate();
  useEffect(() => { navigate('/connexion', { replace: true }); }, [navigate]);
  return null;
}
