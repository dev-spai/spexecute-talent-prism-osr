
-- ============================================================================
-- File: 00_extensions.sql
--
-- Description:
-- Installs the PostgreSQL extensions required by the Talent Prism database.
--
-- Run this file before creating any database tables.
--
-- Required Extensions
--
-- • pgcrypto
--   Provides cryptographic functions, including gen_random_uuid(), which is
--   used throughout the schema to generate UUID primary keys.
--
-- ============================================================================

CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ============================================================================
-- Notes
--
-- If deploying on Supabase, pgcrypto is already enabled by default.
-- Running this statement is safe because IF NOT EXISTS prevents duplicate
-- installation errors.
--
-- ============================================================================