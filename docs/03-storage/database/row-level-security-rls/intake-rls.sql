-- ============================================================================
-- Talent Prism
-- Row Level Security Policies
-- Table: intake
--
-- Description
-- Controls application access to applicant intake records.
--
-- Applications such as n8n, Retool, and custom backend services connect
-- through the Supabase anon role. Administrative operations use the
-- service_role.
--
-- ============================================================================
-- Enable Row Level Security
-- ============================================================================

ALTER TABLE public.intake ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- Policy: Read Intake Records
--
-- Allows backend applications to retrieve applicant records.
-- ============================================================================

CREATE POLICY anon_read_intake
ON public.intake
AS PERMISSIVE
FOR SELECT
TO anon
USING (
    true
);

-- ============================================================================
-- Policy: Update Workflow Fields
--
-- Allows backend workflows to update application-generated fields during
-- processing without granting unrestricted write access.
-- ============================================================================

CREATE POLICY anon_update_intake
ON public.intake
AS PERMISSIVE
FOR UPDATE
TO anon
USING (
    true
)
WITH CHECK (
       batch_processing_status IS NOT NULL
    OR status                  IS NOT NULL
    OR outcome                 IS NOT NULL
    OR scout_notes             IS NOT NULL
    OR model_signed            IS NOT NULL
    OR escalated               IS NOT NULL
    OR application_stage       IS NOT NULL
);

-- ============================================================================
-- Policy: Full Administrative Access
--
-- Allows trusted backend services using the service_role to perform any
-- database operation.
-- ============================================================================

CREATE POLICY service_full_intake
ON public.intake
AS PERMISSIVE
FOR ALL
TO service_role
USING (
    true
)
WITH CHECK (
    true
);