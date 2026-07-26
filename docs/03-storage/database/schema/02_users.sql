-- ============================================================================
-- Table: users
--
-- Description:
-- Stores internal Talent Prism users, their operational roles, and platform
-- permissions.
--
-- This table is used for authentication, authorization, workload assignment,
-- and workflow auditing. Rather than implementing a full Role-Based Access
-- Control (RBAC) system, permissions are stored as explicit boolean flags,
-- making it easy to understand which capabilities are available to each user.
--
-- Typical users include:
--
-- • Managing Directors
-- • Head Scouts
-- • Scouts
-- • Virtual Assistants
--
-- Related Tables
--
-- • intake (assigned_to, scout_assigned, stage_updated_by, etc.)
-- • intake_notes (author_id)
-- • stage_history (changed_by)
-- • export_log (exported_by)
--
-- ============================================================================

CREATE TABLE public.users (
  id uuid not null default gen_random_uuid (),
  full_name text not null,
  email text not null,
  role text null,
  can_greenlight boolean null default false,
  can_export_csv boolean null default false,
  can_view_all boolean null default false,
  can_view_vip_tab boolean null default false,
  can_view_fraud_tab boolean null default false,
  can_view_archive_tabs boolean null default false,
  assigned_batch text null,
  active boolean null default true,
  created_at timestamp with time zone null default now(),
  notes text null,
  permission_level text null,
  assigned_territories text[] null,
  can_view_young_talent boolean null default false,
  can_view_escalated boolean null default false,
  can_escalate_to_hot boolean null default false,
  escalation_tier text null,
  constraint users_pkey primary key (id),
  constraint users_email_key unique (email),
  constraint users_escalation_tier_check check (
    (
      escalation_tier = any (
        array[
          'scout'::text,
          'senior'::text,
          'head'::text,
          'manager'::text,
          'admin'::text
        ]
      )
    )
  ),
  constraint users_role_check check (
    (
      role = any (
        array[
          'MD'::text,
          'Head Scout'::text,
          'Scout'::text,
          'VA'::text
        ]
      )
    )
  )
) TABLESPACE pg_default;

-- ============================================================================
-- Table Comments
-- ============================================================================

COMMENT ON TABLE public.users IS
'Stores internal Talent Prism users, operational roles, and platform permissions.';

COMMENT ON COLUMN public.users.id IS
'Unique identifier for the user.';

COMMENT ON COLUMN public.users.full_name IS
'Full name of the internal user.';

COMMENT ON COLUMN public.users.email IS
'Unique email address used to identify the user.';

COMMENT ON COLUMN public.users.role IS
'Primary operational role within the platform.';

COMMENT ON COLUMN public.users.permission_level IS
'Optional high-level permission grouping for administrative use.';

COMMENT ON COLUMN public.users.assigned_batch IS
'Batch currently assigned to the user for processing.';

COMMENT ON COLUMN public.users.assigned_territories IS
'Regions or territories assigned to the user.';

COMMENT ON COLUMN public.users.active IS
'Indicates whether the user account is active.';

COMMENT ON COLUMN public.users.created_at IS
'Timestamp indicating when the user record was created.';

COMMENT ON COLUMN public.users.notes IS
'Internal administrative notes about the user.';

COMMENT ON COLUMN public.users.escalation_tier IS
'Highest escalation level the user is authorized to handle.';

-- ============================================================================
-- Column Groups
--
-- Identity
-- • id
-- • full_name
-- • email
--
-- Role & Permissions
-- • role
-- • permission_level
-- • escalation_tier
--
-- Operational Permissions
-- • can_greenlight
-- • can_export_csv
-- • can_view_all
-- • can_view_vip_tab
-- • can_view_fraud_tab
-- • can_view_archive_tabs
-- • can_view_young_talent
-- • can_view_escalated
-- • can_escalate_to_hot
--
-- Work Assignment
-- • assigned_batch
-- • assigned_territories
--
-- Account Status
-- • active
--
-- Administration
-- • notes
--
-- Audit
-- • created_at
--
-- ============================================================================
-- Recommended Indexes
--
-- Depending on workload, consider creating indexes on:
--
-- • role
-- • active
-- • escalation_tier
-- • assigned_batch
-- • created_at
--
-- The email column is already indexed through its UNIQUE constraint.
-- Additional indexes have intentionally been omitted because the optimal
-- indexing strategy depends on authentication, reporting, and operational
-- query patterns.
--
-- ============================================================================