-- ============================================================================
-- Talent Prism
-- Row Level Security Policies
-- Table: users
--
-- Description
-- Controls access to platform user records.
--
-- ============================================================================

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

-- Read Users

CREATE POLICY anon_read_users
ON public.users
AS PERMISSIVE
FOR SELECT
TO anon
USING (true);

-- Create Users

CREATE POLICY anon_insert_users
ON public.users
AS PERMISSIVE
FOR INSERT
TO anon
WITH CHECK (
    email IS NOT NULL
    AND role IS NOT NULL
);

-- Update Users

CREATE POLICY anon_update_users
ON public.users
AS PERMISSIVE
FOR UPDATE
TO anon
USING (true)
WITH CHECK (
    email IS NOT NULL
    AND role IS NOT NULL
);

-- Full Administrative Access

CREATE POLICY service_full_users
ON public.users
AS PERMISSIVE
FOR ALL
TO service_role
USING (true)
WITH CHECK (true);