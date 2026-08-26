
-- Helper function for role checks (SECURITY DEFINER to prevent recursion)
CREATE OR REPLACE FUNCTION public.get_user_role(uid uuid)
RETURNS public.user_role
LANGUAGE sql SECURITY DEFINER SET search_path = public
AS $$
  SELECT role FROM public.profiles WHERE id = uid;
$$;

CREATE OR REPLACE FUNCTION public.is_admin_or_super(uid uuid)
RETURNS boolean
LANGUAGE sql SECURITY DEFINER SET search_path = public
AS $$
  SELECT role IN ('admin', 'super_admin') FROM public.profiles WHERE id = uid;
$$;

CREATE OR REPLACE FUNCTION public.is_super_admin(uid uuid)
RETURNS boolean
LANGUAGE sql SECURITY DEFINER SET search_path = public
AS $$
  SELECT role = 'super_admin' FROM public.profiles WHERE id = uid;
$$;

-- Profiles RLS
CREATE POLICY "Super admin full access profiles" ON public.profiles
  FOR ALL TO authenticated USING (is_super_admin(auth.uid()));

CREATE POLICY "Admin full access profiles" ON public.profiles
  FOR ALL TO authenticated USING (is_admin_or_super(auth.uid()));

CREATE POLICY "Users view own profile" ON public.profiles
  FOR SELECT TO authenticated USING (auth.uid() = id);

CREATE POLICY "Users update own profile" ON public.profiles
  FOR UPDATE TO authenticated USING (auth.uid() = id)
  WITH CHECK (role IS NOT DISTINCT FROM get_user_role(auth.uid()));

-- Questions RLS
CREATE POLICY "Admin can manage questions" ON public.questions
  FOR ALL TO authenticated USING (is_admin_or_super(auth.uid()));

CREATE POLICY "All authenticated can read questions" ON public.questions
  FOR SELECT TO authenticated USING (actif = true);

-- Tâches RLS
CREATE POLICY "Admin can manage taches" ON public.taches
  FOR ALL TO authenticated USING (is_admin_or_super(auth.uid()));

CREATE POLICY "All authenticated can read taches" ON public.taches
  FOR SELECT TO authenticated USING (actif = true);

-- Attributions RLS
CREATE POLICY "Admin can manage attributions" ON public.attributions
  FOR ALL TO authenticated USING (is_admin_or_super(auth.uid()));

CREATE POLICY "Professeur can view own attributions" ON public.attributions
  FOR SELECT TO authenticated USING (professeur_id = auth.uid());

CREATE POLICY "Etudiant can view own attribution" ON public.attributions
  FOR SELECT TO authenticated USING (etudiant_id = auth.uid());

-- Abonnements RLS
CREATE POLICY "Admin can manage abonnements" ON public.abonnements
  FOR ALL TO authenticated USING (is_admin_or_super(auth.uid()));

CREATE POLICY "Student can view own abonnement" ON public.abonnements
  FOR SELECT TO authenticated USING (etudiant_id = auth.uid());

-- Paiements RLS
CREATE POLICY "Admin can manage paiements" ON public.paiements
  FOR ALL TO authenticated USING (is_admin_or_super(auth.uid()));

CREATE POLICY "Student can view own paiements" ON public.paiements
  FOR SELECT TO authenticated USING (etudiant_id = auth.uid());

CREATE POLICY "Student can insert paiement" ON public.paiements
  FOR INSERT TO authenticated WITH CHECK (etudiant_id = auth.uid());

-- Sessions examen RLS
CREATE POLICY "Admin can view all sessions" ON public.sessions_examen
  FOR SELECT TO authenticated USING (is_admin_or_super(auth.uid()));

CREATE POLICY "Student can manage own sessions" ON public.sessions_examen
  FOR ALL TO authenticated USING (etudiant_id = auth.uid());

CREATE POLICY "Professeur can view sessions of attributed students" ON public.sessions_examen
  FOR SELECT TO authenticated USING (
    EXISTS (
      SELECT 1 FROM public.attributions a
      WHERE a.professeur_id = auth.uid() AND a.etudiant_id = sessions_examen.etudiant_id
    )
  );

-- Réponses QCM RLS
CREATE POLICY "Student can manage own reponses" ON public.reponses_qcm
  FOR ALL TO authenticated USING (
    EXISTS (SELECT 1 FROM public.sessions_examen s WHERE s.id = session_id AND s.etudiant_id = auth.uid())
  );

CREATE POLICY "Admin can view all reponses" ON public.reponses_qcm
  FOR SELECT TO authenticated USING (is_admin_or_super(auth.uid()));

CREATE POLICY "Professeur can view reponses of attributed students" ON public.reponses_qcm
  FOR SELECT TO authenticated USING (
    EXISTS (
      SELECT 1 FROM public.sessions_examen s
      JOIN public.attributions a ON a.etudiant_id = s.etudiant_id
      WHERE s.id = session_id AND a.professeur_id = auth.uid()
    )
  );

-- Productions RLS
CREATE POLICY "Student can manage own productions" ON public.productions
  FOR ALL TO authenticated USING (etudiant_id = auth.uid());

CREATE POLICY "Professeur can view and correct attributed student productions" ON public.productions
  FOR ALL TO authenticated USING (professeur_id = auth.uid());

CREATE POLICY "Admin can view all productions" ON public.productions
  FOR SELECT TO authenticated USING (is_admin_or_super(auth.uid()));

-- Notifications RLS
CREATE POLICY "User can view own notifications" ON public.notifications
  FOR SELECT TO authenticated USING (utilisateur_id = auth.uid());

CREATE POLICY "User can update own notifications" ON public.notifications
  FOR UPDATE TO authenticated USING (utilisateur_id = auth.uid());

CREATE POLICY "Admin can insert notifications" ON public.notifications
  FOR INSERT TO authenticated WITH CHECK (is_admin_or_super(auth.uid()));

CREATE POLICY "Service can insert notifications" ON public.notifications
  FOR INSERT WITH CHECK (true);
