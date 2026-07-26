-- ============================================================================
-- Table: media_forensics
--
-- Description:
-- Stores AI-generated image analysis, media metadata, fraud detection,
-- and processing results for applicant photographs.
--
-- Each uploaded image is represented as an individual record, allowing
-- applicants to submit multiple photographs (e.g., headshot, full body,
-- profile, three-quarter view, or polaroid).
--
-- This table is responsible for tracking:
--
-- • Image storage information
-- • AI photo quality assessment
-- • Fraud detection
-- • Processing workflow
-- • Computer vision outputs
-- • Compliance checks
-- • Reviewer feedback
--
-- Related Tables
--
-- • intake (Applicant record)
-- • stage_history (Workflow tracking)
--
-- ============================================================================

CREATE TABLE public.media_forensics (
  id uuid not null default gen_random_uuid (),
  intake_id uuid null,
  batch_id uuid null,
  storage_url text null,
  photo_type text null,
  image_resolution text null,
  image_file_size_kb integer null,
  lighting_quality text null,
  head_count_detected integer null,
  processing_status text null default 'Pending'::text,
  retry_count integer null default 0,
  error_notes text null,
  fraud_risk text null,
  fraud_flags text[] null,
  ela_heatmap_url text null,
  facial_landmark_map_url text null,
  created_at timestamp with time zone null default now(),
  r2_object_key text null,
  retool_signed_url text null,
  retool_url_expires_at timestamp with time zone null,
  is_thumbnail boolean null default false,
  gemini_score numeric(5, 2) null,
  gemini_notes text null,
  photo_instruction_pass boolean null,
  photo_instruction_fail_reason text null,
  photo_compliance_checked boolean null default false,
  constraint media_forensics_pkey primary key (id),
  constraint media_forensics_intake_id_fkey
    foreign KEY (intake_id)
    references intake (intake_id),
  constraint media_forensics_fraud_risk_check check (
    (
      fraud_risk = any (
        array[
          'Clear'::text,
          'Suspicious'::text,
          'Manipulated'::text
        ]
      )
    )
  ),
  constraint media_forensics_photo_type_check check (
    (
      photo_type = any (
        array[
          'headshot'::text,
          'full_body'::text,
          'profile'::text,
          'three_quarter'::text,
          'polaroid'::text
        ]
      )
    )
  )
) TABLESPACE pg_default;

-- ============================================================================
-- Column Groups
--
-- Identity
-- • id
-- • intake_id
-- • batch_id
--
-- Image Storage
-- • storage_url
-- • r2_object_key
-- • retool_signed_url
-- • retool_url_expires_at
-- • is_thumbnail
--
-- Image Metadata
-- • photo_type
-- • image_resolution
-- • image_file_size_kb
-- • lighting_quality
-- • head_count_detected
--
-- Processing Workflow
-- • processing_status
-- • retry_count
-- • error_notes
-- • created_at
--
-- AI Evaluation
-- • gemini_score
-- • gemini_notes
--
-- Photo Compliance
-- • photo_instruction_pass
-- • photo_instruction_fail_reason
-- • photo_compliance_checked
--
-- Fraud Detection
-- • fraud_risk
-- • fraud_flags
-- • ela_heatmap_url
-- • facial_landmark_map_url
--
-- ============================================================================
--
-- Recommended Indexes
--
-- Depending on workload, consider creating indexes on:
--
-- • intake_id
-- • batch_id
-- • processing_status
-- • fraud_risk
-- • photo_type
-- • created_at
--
-- These indexes have intentionally been omitted because the optimal
-- indexing strategy depends on workload, batch size, and query patterns.
--
-- ============================================================================