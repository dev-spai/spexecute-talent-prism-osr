- - ============================================================================
-- Table: intake_notes
-- Description:
-- Stores reviewer notes, observations, escalation reasons, and decision
-- comments associated with applicant records. This table provides an audit
-- trail of human review activity throughout the applicant lifecycle.
-- ============================================================================

CREATE TABLE public.intake_notes (
id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

```
-- Foreign Keys
intake_id UUID,

-- Author Information
author_id TEXT,

-- Note Information
note_text TEXT NOT NULL,
note_type TEXT,

-- Audit
created_at TIMESTAMPTZ DEFAULT NOW(),

-- Constraints
CONSTRAINT fk_intake_notes_intake
    FOREIGN KEY (intake_id)
    REFERENCES public.intake (intake_id)
    ON DELETE CASCADE,

CONSTRAINT chk_intake_notes_note_type
    CHECK (
        note_type IN (
            'observation',
            'flag_reason',
            'escalation_reason',
            'decision_note'
        )
    )
```

);

- - ============================================================================
-- Indexes
-- ============================================================================

CREATE INDEX idx_intake_notes_intake_id
ON public.intake_notes (intake_id);

CREATE INDEX idx_intake_notes_created_at
ON public.intake_notes (created_at);

- - ============================================================================
-- Table Comments
-- ============================================================================

COMMENT ON TABLE public.intake_notes IS
'Stores reviewer notes, observations, escalation reasons, and decision comments for applicant records.';

COMMENT ON COLUMN public.intake_notes.id IS
'Unique identifier for each reviewer note.';

COMMENT ON COLUMN public.intake_notes.intake_id IS
'References the applicant associated with this note.';

COMMENT ON COLUMN public.intake_notes.author_id IS
'Identifier of the reviewer or user who created the note.';

COMMENT ON COLUMN public.intake_notes.note_text IS
'The content of the reviewer note.';

COMMENT ON COLUMN public.intake_notes.note_type IS
'Categorizes the note (observation, flag reason, escalation reason, or decision note).';

COMMENT ON COLUMN public.intake_notes.created_at IS
'Timestamp indicating when the note was created.';