-- ============================================================================
-- Table: intake
--
-- Description:
-- Primary applicant record within the Talent Prism platform.
--
-- This table represents the complete lifecycle of an applicant, including:
--
-- • Personal information
-- • Contact details
-- • Application metadata
-- • Consent & compliance
-- • Workflow state
-- • Communication tracking
-- • AI structural analysis
-- • AI aesthetic analysis
-- • Fraud detection
-- • Image processing
-- • Open call management
-- • Queue management
-- • Talent profile
-- • Employability scoring
-- • Audit information
--
-- Related Tables
--
-- • intake_notes
-- • media_forensics
-- • stage_history
-- • sources
-- • roster
--
-- ============================================================================

create table public.intake (
  intake_id uuid not null default gen_random_uuid (),
  full_name text not null,
  email text not null,
  phone text null,
  date_of_birth date null,
  age_at_application integer null,
  minor_flag text null,
  guardian_consent boolean null,
  location_city text null,
  instagram_url text null,
  language text null,
  application_date timestamp with time zone null default now(),
  reapplication_eligible_date date null,
  application_source text null,
  platform_type text null,
  source_id uuid null,
  last_updated timestamp with time zone null default now(),
  duplicate_of uuid null,
  raw_email_body text null,
  parser_confidence_score numeric(5, 2) null,
  ai_consent boolean null,
  consent_date timestamp with time zone null,
  application_stage text null default 'New'::text,
  status text null default 'New'::text,
  outcome text null,
  outcome_date timestamp with time zone null,
  pipeline_duration_days integer null,
  rejection_reason text null,
  waitlist_position integer null,
  deferred_until date null,
  development_candidate boolean null default false,
  development_notes text null,
  follow_up_date date null,
  escalated boolean null default false,
  escalated_by text null,
  escalated_date timestamp with time zone null,
  escalation_note text null,
  hard_filter_fail_reason text null,
  scout_assigned text null,
  scout_notes text null,
  outreach_attempts integer null default 0,
  applicant_response_status text null,
  acknowledgement_sent boolean null default false,
  rejection_email_sent boolean null default false,
  model_signed boolean null default false,
  model_signed_date timestamp with time zone null,
  model_signed_by text null,
  aesthetic_category text null,
  primary_market text null,
  secondary_market text null,
  structural_score numeric(5, 2) null,
  symmetry_score numeric(5, 2) null,
  symmetry_variance numeric(5, 4) null,
  memorability_index numeric(5, 2) null,
  zygomatic_ratio numeric(5, 3) null,
  zygomatic_confidence text null,
  razor_jaw_angle numeric(5, 2) null,
  intercanthal_distance text null,
  supraorbital_ridge_score numeric(5, 2) null,
  facial_thirds_balance text null,
  smile_corridor text null,
  leg_to_body_ratio numeric(5, 3) null,
  clavicle_prominence text null,
  versatility_flag text null,
  highest_fraud_risk text null,
  fraud_flag_summary text[] null,
  visual_summary text null,
  images_in_batch integer null,
  batch_processing_status text null default 'Pending'::text,
  batch_id uuid null default gen_random_uuid (),
  storage_type text null,
  photo_head_url text null,
  photo_body_url text null,
  photo_profile_url text null,
  photo_quality_status text null default 'Pending'::text,
  photo_instruction_sent boolean null default false,
  photo_instruction_sent_at timestamp with time zone null,
  photo_resubmission_count integer null default 0,
  stage_updated_at timestamp with time zone null,
  analysis_run_count integer null default 0,
  open_call_status text null,
  open_call_invitation_sent boolean null default false,
  open_call_invitation_sent_at timestamp with time zone null,
  moved_to_queue boolean null default false,
  moved_to_queue_by text null,
  moved_to_queue_at timestamp with time zone null,
  moved_to_queue_from text null,
  previous_stage text null,
  stage_updated_by text null,
  androgyny_score numeric(5, 2) null,
  hair_color text null,
  eye_color text null,
  skin_tone text null,
  hair_texture text null,
  nationality text null,
  right_to_work boolean null,
  languages_spoken text[] null,
  modeling_experience boolean null default false,
  experience_details text null,
  special_skills text null,
  availability text null,
  right_to_work_countries text[] null,
  currently_represented boolean null default false,
  current_agencies text null,
  was_scouted boolean null default false,
  scouted_by text null,
  is_reapplication boolean null default false,
  employability_score numeric(5, 2) null,
  employability_calculated_at timestamp with time zone null,
  cooldown_overridden boolean null default false,
  cooldown_overridden_by text null,
  cooldown_overridden_at timestamp with time zone null,
  assigned_to text null,
  cheek_to_jaw_ratio numeric(5, 3) null,
  interpupillary_index numeric(5, 2) null,
  overall_body_proportion numeric(5, 2) null,
  height_to_torso_ratio numeric(5, 3) null,
  shoulder_line text null,
  jaw_definition numeric(5, 2) null,
  cheekbone_structure numeric(5, 2) null,
  jawline_squareness numeric(5, 2) null,
  brow_ridge_strength numeric(5, 2) null,
  neck_definition numeric(5, 2) null,
  shoulder_to_waist_ratio numeric(5, 3) null,
  facial_gender_read text null,
  shoulder_to_hip_ratio numeric(5, 3) null,
  androgyny_casting_fit text null,
  aesthetic_sub_type text null,
  brand_fit text[] null,
  brand_reasoning text null,
  active_category_scores jsonb null,
  location_country text null,
  gdpr_consent boolean null,
  gender text null,
  height_cm numeric null,
  bust_cm numeric null,
  waist_cm numeric null,
  hips_cm numeric null,
  shoe_size_eu numeric null,
  agency_slug text null,
  reapplication_count integer null default 0,
  rank_tier text null,
  first_assigned_to text null,
  flagged boolean null default false,
  flagged_by text null,
  flagged_at timestamp with time zone null,
  flag_reason text null,
  escalated_to text null,
  escalated_at timestamp with time zone null,
  photo_quality_score numeric null,
  aesthetic_score numeric null,
  final_agency_score numeric null,
  booking_potential text null,
  ranking_confidence text null,
  score_reasoning text null,
  final_verdict text null,
  stage2_analysis jsonb null,
  primary_agency_fit_category text null,
  structural_confidence text null,
  constraint intake_pkey primary key (intake_id),
  constraint fk_intake_source foreign KEY (source_id) references sources (id),
  constraint intake_duplicate_of_fkey foreign KEY (duplicate_of) references intake (intake_id),
  constraint intake_application_stage_check check (
    (
      application_stage = any (
        array[
          'new'::text,
          'processing'::text,
          'photo_instruction_fail'::text,
          'hard_filter_fail'::text,
          'structural_analysis_error'::text,
          'aesthetic_analysis_error'::text,
          'structural_scoring'::text,
          'aesthetic_scoring'::text,
          'scored'::text,
          'manual_review'::text
        ]
      )
    )
  ),
  constraint intake_batch_processing_status_check check (
    (
      batch_processing_status = any (
        array[
          'queued'::text,
          'photo_check'::text,
          'structural'::text,
          'aesthetic'::text,
          'ranking'::text,
          'complete'::text,
          'error'::text
        ]
      )
    )
  ),
  constraint intake_storage_type_check check (
    (
      storage_type = any (
        array[
          'r2'::text,
          'google_drive'::text,
          'onedrive'::text,
          'dropbox'::text
        ]
      )
    )
  )
) TABLESPACE pg_default;

-- ============================================================================
-- Triggers
--
-- intake_age_minor_trigger
-- Automatically calculates age_at_application and minor_flag
-- whenever date_of_birth changes.
--
-- intake_last_updated
-- Automatically updates last_updated whenever the record changes.
--
-- model_signed_trigger
-- Executes business logic whenever model_signed changes.
--
-- ============================================================================

create trigger intake_age_minor_trigger BEFORE INSERT
or
update OF date_of_birth on intake for EACH row
execute FUNCTION intake_compute_age_and_minor ();

create trigger intake_last_updated BEFORE
update on intake for EACH row
execute FUNCTION update_last_updated ();

create trigger model_signed_trigger BEFORE
update on intake for EACH row
execute FUNCTION on_model_signed ();



-- ============================================================================
-- Recommended Indexes
--
-- Depending on workload, consider creating indexes on:
--
-- application_stage
-- status
-- assigned_to
-- source_id
-- batch_id
-- application_date
-- follow_up_date
--
-- These indexes have intentionally been omitted because they depend on
-- workload characteristics and query patterns.
-- ============================================================================