-- ============================================================================
-- Talent Prism
-- Row Level Security Policies
-- Table: intake_notes
--
-- Description
-- Controls access to reviewer notes associated with applications.
--
-- ============================================================================

ALTER TABLE public.intake_notes ENABLE ROW LEVEL SECURITY;

-- Read Notes

CREATE POLICY anon_read_intake_notes
ON public.intake_notes
AS PERMISSIVE
FOR SELECT
TO anon
USING (true);

-- Insert Notes

CREATE POLICY anon_insert_intake_notes
ON public.intake_notes
AS PERMISSIVE
FOR INSERT
TO anon
WITH CHECK (
    intake_id IS NOT NULL
    AND author_id IS NOT NULL
);

-- Full Administrative Access

CREATE POLICY service_full_intake_notes
ON public.intake_notes
AS PERMISSIVE
FOR ALL
TO service_role
USING (true)
WITH CHECK (true);