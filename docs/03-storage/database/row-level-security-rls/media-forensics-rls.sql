-- ============================================================================
-- Talent Prism
-- Row Level Security Policies
-- Table: media_forensics
--
-- Description
-- Controls access to AI-generated media analysis and forensic results.
--
-- ============================================================================

ALTER TABLE public.media_forensics ENABLE ROW LEVEL SECURITY;

-- Read Analysis

CREATE POLICY anon_read_forensics
ON public.media_forensics
AS PERMISSIVE
FOR SELECT
TO anon
USING (true);

-- Full Administrative Access

CREATE POLICY service_full_forensics
ON public.media_forensics
AS PERMISSIVE
FOR ALL
TO service_role
USING (true)
WITH CHECK (true);