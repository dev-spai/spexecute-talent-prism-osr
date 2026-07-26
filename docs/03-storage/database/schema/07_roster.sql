-- ============================================================================
-- Table: roster
--
-- Description:
-- Stores the active roster of signed talent within the Talent Prism platform.
--
-- Once an applicant successfully completes the intake and review process,
-- they are promoted from the intake pipeline into the roster.
--
-- Unlike the intake table, which tracks applicants throughout the evaluation
-- workflow, the roster table focuses on long-term talent management,
-- representation, contracts, career progression, and brand intelligence.
--
-- This table is responsible for storing:
--
-- • Signed talent information
-- • Active contact details
-- • Contract management
-- • Representation status
-- • Physical statistics
-- • AI-generated talent intelligence
-- • Brand suitability analysis
-- • Career progression
-- • Portfolio and digital asset management
--
-- Related Tables
--
-- • intake (Original applicant record)
-- • media_forensics (Applicant image analysis)
-- • stage_history (Application workflow history)
--
-- ============================================================================

CREATE TABLE public.roster (
  id uuid not null default gen_random_uuid (),
  intake_id uuid null,
  full_name text not null,
  active_email text null,
  active_phone text null,
  age_at_application integer null,
  minor_flag text null,
  instagram_url text null,
  model_signed_date timestamp with time zone null,
  model_signed_by text null,
  global_status text null default 'Active'::text,
  career_stage text null default 'New Face'::text,
  signed_date timestamp with time zone null,
  contract_start_date date null,
  contract_expiry_date date null,
  contract_status text null,
  exclusivity_status text null,
  commission_rate numeric(5, 2) null,
  mother_agency text null,
  agent_assigned text null,
  agent_notes text null,
  height_cm integer null,
  measurements text null,
  shoe_size numeric(4, 1) null,
  dress_size text null,
  hair_color text null,
  eye_color text null,
  skin_tone text null,
  tattoos boolean null default false,
  tattoo_notes text null,
  stats_last_updated date null,
  stats_freshness text null,
  aesthetic_category text null,
  primary_market text null,
  secondary_market text null,
  brand_category_fit text[] null,
  versatility_flag text null,
  spex_rank_score numeric(5, 2) null,
  memorability_index numeric(5, 2) null,
  structural_score numeric(5, 2) null,
  highest_fraud_risk text null,
  gemini_summary text null,
  brand_suitability text null,
  brand_analysis_status text null default 'Pending'::text,
  brand_suitability_date timestamp with time zone null,
  storage_folder_link text null,
  roster_intel_status text null default 'Pending'::text,
  digital_twin_consent boolean null default false,
  likeness_license_active boolean null default false,
  created_at timestamp with time zone null default now(),
  androgyny_score numeric(5, 2) null,
  hair_texture text null,
  nationality text null,
  right_to_work boolean null,
  languages_spoken text[] null,
  modeling_experience boolean null default false,
  experience_details text null,
  special_skills text null,
  availability jsonb null,
  constraint roster_pkey primary key (id),
  constraint roster_intake_id_key unique (intake_id),
  constraint roster_intake_id_fkey
    foreign KEY (intake_id)
    references intake (intake_id)
) TABLESPACE pg_default;

-- ============================================================================
-- Column Groups
--
-- Identity
-- • id
-- • intake_id
-- • full_name
--
-- Contact Information
-- • active_email
-- • active_phone
-- • instagram_url
--
-- Representation
-- • global_status
-- • career_stage
-- • signed_date
-- • model_signed_date
-- • model_signed_by
--
-- Contract Management
-- • contract_start_date
-- • contract_expiry_date
-- • contract_status
-- • exclusivity_status
-- • commission_rate
-- • mother_agency
--
-- Agent Management
-- • agent_assigned
-- • agent_notes
--
-- Physical Attributes
-- • height_cm
-- • measurements
-- • shoe_size
-- • dress_size
-- • hair_color
-- • eye_color
-- • skin_tone
-- • hair_texture
-- • tattoos
-- • tattoo_notes
--
-- Profile Maintenance
-- • stats_last_updated
-- • stats_freshness
--
-- AI Talent Intelligence
-- • aesthetic_category
-- • primary_market
-- • secondary_market
-- • versatility_flag
-- • spex_rank_score
-- • memorability_index
-- • structural_score
-- • androgyny_score
--
-- Brand Intelligence
-- • brand_category_fit
-- • brand_suitability
-- • brand_analysis_status
-- • brand_suitability_date
--
-- Risk Assessment
-- • highest_fraud_risk
--
-- AI Summary
-- • gemini_summary
--
-- Portfolio & Assets
-- • storage_folder_link
--
-- Digital Representation
-- • digital_twin_consent
-- • likeness_license_active
--
-- Experience
-- • modeling_experience
-- • experience_details
-- • special_skills
-- • availability
--
-- Demographics
-- • age_at_application
-- • minor_flag
-- • nationality
-- • languages_spoken
-- • right_to_work
--
-- Audit
-- • created_at
--
-- ============================================================================
-- Recommended Indexes
--
-- Depending on your workload, consider creating indexes on:
--
-- • global_status
-- • career_stage
-- • agent_assigned
-- • contract_status
-- • contract_expiry_date
-- • primary_market
-- • spex_rank_score
-- • structural_score
-- • created_at
--
-- These indexes have intentionally been omitted because the optimal indexing
-- strategy depends on application size, reporting requirements, and query
-- patterns.
--
-- ============================================================================