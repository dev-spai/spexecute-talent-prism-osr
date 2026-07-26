-- ============================================================================
-- Table: stage_history
--
-- Description:
-- Records every significant workflow event that occurs during an applicant's
-- lifecycle within the Talent Prism platform.
--
-- Rather than overwriting workflow information, this table maintains a
-- chronological audit trail of stage transitions, assignments, flags,
-- escalations, notes, and other operational actions.
--
-- This history provides complete traceability for applicant processing,
-- operational reporting, and internal auditing.
--
-- Related Tables
--
-- • intake (Applicant associated with the workflow event)
--
-- ============================================================================

CREATE TABLE public.stage_history (
  id uuid not null default gen_random_uuid (),
  intake_id uuid null,
  from_stage text null,
  to_stage text null,
  changed_by text null,
  changed_at timestamp with time zone null default now(),
  notes text null,
  action_type text null,
  constraint stage_history_pkey primary key (id),
  constraint stage_history_intake_id_fkey
    foreign KEY (intake_id)
    references intake (intake_id),
  constraint stage_history_action_type_check check (
    (
      action_type = any (
        array[
          'stage_change'::text,
          'assignment'::text,
          'flag'::text,
          'escalation'::text,
          'note_added'::text,
          'bulk_action'::text
        ]
      )
    )
  )
) TABLESPACE pg_default;

-- ============================================================================
-- Table Comments
-- ============================================================================

COMMENT ON TABLE public.stage_history IS
'Maintains a chronological audit trail of applicant workflow events.';

COMMENT ON COLUMN public.stage_history.id IS
'Unique identifier for the workflow event.';

COMMENT ON COLUMN public.stage_history.intake_id IS
'Applicant associated with the recorded event.';

COMMENT ON COLUMN public.stage_history.from_stage IS
'Workflow stage before the action occurred.';

COMMENT ON COLUMN public.stage_history.to_stage IS
'Workflow stage after the action completed.';

COMMENT ON COLUMN public.stage_history.changed_by IS
'User or system that performed the action.';

COMMENT ON COLUMN public.stage_history.changed_at IS
'Timestamp when the workflow event occurred.';

COMMENT ON COLUMN public.stage_history.notes IS
'Optional notes providing additional context for the event.';

COMMENT ON COLUMN public.stage_history.action_type IS
'Categorizes the workflow event (stage change, assignment, flag, escalation, note, or bulk action).';

-- ============================================================================
-- Column Groups
--
-- Identity
-- • id
-- • intake_id
--
-- Workflow Transition
-- • from_stage
-- • to_stage
-- • action_type
--
-- Audit Information
-- • changed_by
-- • changed_at
--
-- Additional Context
-- • notes
--
-- ============================================================================
-- Recommended Indexes
--
-- Depending on workload, consider creating indexes on:
--
-- • intake_id
-- • changed_at
-- • action_type
-- • changed_by
-- • to_stage
--
-- These indexes have intentionally been omitted because the optimal indexing
-- strategy depends on audit volume, reporting requirements, and query
-- patterns.
--
-- ============================================================================