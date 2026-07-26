-- ============================================================================
-- Table: sources
--
-- Description:
-- Stores information about the origin of applicant submissions.
--
-- A source represents the organization, recruiter, agency, platform,
-- or referral channel through which an applicant entered the Talent Prism
-- platform. Separating sources into their own table avoids duplicate data
-- and enables reporting on recruitment performance across multiple channels.
--
-- Typical examples include:
--
-- • Modeling agencies
-- • Talent scouts
-- • Open calls
-- • Instagram campaigns
-- • Referral partners
-- • Website applications
--
-- Related Tables
--
-- • intake (Applicants reference a source through source_id)
--
-- ============================================================================

CREATE TABLE public.sources (
  id uuid not null default gen_random_uuid (),
  agency_name text null,
  contact_name text null,
  contact_email text null,
  contact_phone text null,
  region text null,
  platform_type text null,
  active boolean null default true,
  created_at timestamp with time zone null default now(),
  constraint sources_pkey primary key (id)
) TABLESPACE pg_default;

-- ============================================================================
-- Table Comments
-- ============================================================================

COMMENT ON TABLE public.sources IS
'Stores agencies, referral partners, recruiters, and other applicant sources.';

COMMENT ON COLUMN public.sources.id IS
'Unique identifier for the recruitment source.';

COMMENT ON COLUMN public.sources.agency_name IS
'Name of the agency, recruiter, organization, or referral source.';

COMMENT ON COLUMN public.sources.contact_name IS
'Primary contact person for the recruitment source.';

COMMENT ON COLUMN public.sources.contact_email IS
'Primary email address for the recruitment source.';

COMMENT ON COLUMN public.sources.contact_phone IS
'Primary phone number for the recruitment source.';

COMMENT ON COLUMN public.sources.region IS
'Geographic region served by the recruitment source.';

COMMENT ON COLUMN public.sources.platform_type IS
'Platform or recruitment channel associated with the source.';

COMMENT ON COLUMN public.sources.active IS
'Indicates whether the recruitment source is currently active.';

COMMENT ON COLUMN public.sources.created_at IS
'Timestamp indicating when the source record was created.';

-- ============================================================================
-- Column Groups
--
-- Identity
-- • id
--
-- Source Information
-- • agency_name
-- • platform_type
-- • region
--
-- Contact Information
-- • contact_name
-- • contact_email
-- • contact_phone
--
-- Status
-- • active
--
-- Audit
-- • created_at
--
-- ============================================================================
-- Recommended Indexes
--
-- Depending on workload, consider creating indexes on:
--
-- • agency_name
-- • platform_type
-- • region
-- • active
-- • created_at
--
-- These indexes have intentionally been omitted because the optimal indexing
-- strategy depends on reporting requirements, search patterns, and workload.
--
-- ============================================================================