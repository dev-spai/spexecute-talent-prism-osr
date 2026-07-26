-- ============================================================================
-- Talent Prism
-- Row Level Security Policies
-- Table: stage_history
--
-- Description
-- Controls access to application stage transition history.
--
-- ============================================================================

ALTER TABLE public.stage_history ENABLE ROW LEVEL SECURITY;

-- Read Stage History

CREATE POLICY anon_read_stage_history
ON public.stage_history
AS PERMISSIVE
FOR SELECT
TO anon
USING (true);

-- Record Stage Changes

CREATE POLICY anon_insert_stage_history
ON public.stage_history
AS PERMISSIVE
FOR INSERT
TO anon
WITH CHECK (
    intake_id IS NOT NULL
);

-- Full Administrative Access

CREATE POLICY service_full_stage_history
ON public.stage_history
AS PERMISSIVE
FOR ALL
TO service_role
USING (true)
WITH CHECK (true);