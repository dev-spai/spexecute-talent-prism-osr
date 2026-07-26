# Start Here Configuration

The Configuration section describes how Talent Prism can be customized for a specific organization without modifying the application's source code or workflows.

Rather than hardcoding organization-specific behavior, Talent Prism separates business configuration from application logic. This allows different agencies to share the same processing pipeline while maintaining independent branding, evaluation criteria, storage, and operational preferences.

---

# How Configuration Fits Into Talent Prism

## Applicant Processing Flow

Every application follows the same processing lifecycle.

```text
Applicant
    │
    ▼
Tally Forms
(Application Submission)
    │
    ▼
n8n Workflow
    │
    ├────────────► Airtable
    │              (Organization Configuration)
    │
    ├────────────► Cloudflare R2
    │              (Applicant Media)
    │
    └────────────► Supabase
                   (Applicant Record)
                          │
                          ▼
                   Google Gemini
                (AI Evaluation)
                          │
                          ▼
                    Supabase
       (Results & Workflow State)
                          │
                          ▼
                Recruiter Dashboard
```


The configuration layer influences each stage of this process without changing the underlying implementation.

---

# Configuration Areas

Talent Prism separates configuration into several independent domains.

## Organization

Defines the identity of the organization using Talent Prism.

Examples include:

- Agency name
- Agency slug
- Branding
- Supported markets
- Languages
- Timezone
- Locale

---

## Intake

Defines how applications enter the system.

Examples include:

- Form provider
- Required applicant fields
- Media requirements
- Validation rules
- Consent requirements
- Duplicate detection

---

## AI

Defines how applicants are evaluated.

Examples include:

- AI provider
- Models
- Prompt versions
- Confidence thresholds
- Structured outputs
- Human review criteria

---

## Storage

Defines where applicant data and uploaded media are stored.

Examples include:

- Object storage provider
- Supabase database
- File organization
- Signed URLs
- Retention policies

---

## Security

Defines how applicant data and system resources are protected.

Examples include:

- Authentication
- Authorization
- Secrets management
- Storage security
- API protection
- Audit logging

---

# Design Principles

Talent Prism follows a configuration-first approach.

Organizations should be able to customize business behavior without modifying workflow logic or application code.

Configuration should define:

- Business rules
- Organization preferences
- AI behavior
- Storage options
- Security settings

Application code and workflows should remain generic and reusable across deployments.

---
