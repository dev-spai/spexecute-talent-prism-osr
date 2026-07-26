-- ============================================================================
-- Talent Prism
-- Row Level Security Policies
-- Table: roster
--
-- Description
-- Controls access to accepted talent records.
--
-- ============================================================================

ALTER TABLE public.roster ENABLE ROW LEVEL SECURITY;

-- Read Roster

CREATE POLICY anon_read_roster
ON public.roster
AS PERMISSIVE
FOR SELECT
TO anon
USING (true);

-- Update Operational Fields

CREATE POLICY anon_update_roster
ON public.roster
AS PERMISSIVE
FOR UPDATE
TO anon
USING (true)
WITH CHECK (
       agent_notes IS NOT NULL
    OR stats_last_updated IS NOT NULL
    OR global_status IS NOT NULL
    OR career_stage IS NOT NULL
);

-- Full Administrative Access

CREATE POLICY service_full_roster
ON public.roster
AS PERMISSIVE
FOR ALL
TO service_role
USING (true)
WITH CHECK (true);