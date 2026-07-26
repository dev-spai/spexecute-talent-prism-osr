-- ============================================================================
-- Talent Prism
-- Row Level Security Policies
-- Table: export_log
--
-- Description
-- Controls access to export activity and audit records.
--
-- ============================================================================

ALTER TABLE public.export_log ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- Policy: Read Export Logs
--
-- Allows applications to retrieve export history.
-- ============================================================================

CREATE POLICY anon_read_export_log
ON public.export_log
AS PERMISSIVE
FOR SELECT
TO anon
USING (true);

-- ============================================================================
-- Policy: Create Export Log
--
-- Allows applications to record completed export operations.
-- ============================================================================

CREATE POLICY anon_insert_export_log
ON public.export_log
AS PERMISSIVE
FOR INSERT
TO anon
WITH CHECK (
    exported_by IS NOT NULL
);

-- ============================================================================
-- Policy: Full Administrative Access
-- ============================================================================

CREATE POLICY service_full_export_log
ON public.export_log
AS PERMISSIVE
FOR ALL
TO service_role
USING (true)
WITH CHECK (true);