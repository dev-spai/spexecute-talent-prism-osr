-- ============================================================================
-- Talent Prism
-- Row Level Security Policies
-- Table: sources
--
-- Description
-- Controls access to applicant source and acquisition records.
--
-- ============================================================================

ALTER TABLE public.sources ENABLE ROW LEVEL SECURITY;

-- Read Sources

CREATE POLICY anon_read_sources
ON public.sources
AS PERMISSIVE
FOR SELECT
TO anon
USING (true);

-- Full Administrative Access

CREATE POLICY service_full_sources
ON public.sources
AS PERMISSIVE
FOR ALL
TO service_role
USING (true)
WITH CHECK (true);