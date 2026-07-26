# Workflow Automation

Talent Prism is built around an event-driven workflow architecture.

Rather than embedding all application logic inside a backend service, the reference implementation uses **n8n** as the workflow orchestration platform responsible for coordinating every stage of the applicant intake process.

This design separates business logic from infrastructure, making the platform easier to understand, extend, maintain, and customize.

Although the reference implementation uses n8n, organizations are free to replace it with another workflow orchestration platform or custom backend provided the same workflow stages are preserved.

---

# Philosophy

Talent Prism treats every application as an event.

When an applicant submits an application, that event enters the workflow and passes through a series of independent processing stages.

Each stage has a single responsibility.

Instead of one large application performing every task, the workflow coordinates multiple specialized operations.

Examples include:

- Applicant validation
- Organization configuration lookup
- Media storage
- Database persistence
- AI evaluation
- Recruiter notification
- Human review

This modular architecture makes it significantly easier to modify individual stages without affecting the remainder of the workflow.

---

# Why n8n?

The reference implementation uses n8n because it provides:

- Visual workflow development
- Extensive integration support
- Native HTTP endpoints
- Error handling
- Retry mechanisms
- Logging
- Version control
- Self-hosting capabilities
- Low operational overhead

n8n is not a requirement.

Organizations may replace it with:

- Make
- Zapier
- Temporal
- Camunda
- AWS Step Functions
- Azure Logic Apps
- Google Workflows
- Custom backend services

The workflow is the important component—not the orchestration platform itself.

---

# Workflow Overview

Every applicant follows the same processing pipeline.

```
Applicant
      │
      ▼
Webhook Trigger
      │
      ▼
Request Validation
      │
      ▼
Organization Configuration
      │
      ▼
Media Processing
      │
      ▼
Cloudflare R2 Upload
      │
      ▼
Supabase Storage
      │
      ▼
AI Evaluation
      │
      ▼
Scoring
      │
      ▼
Recruiter Queue
      │
      ▼
Notifications
```

Every workflow execution is independent.

An applicant from one organization never affects another organization's workflow.

---

# Workflow Stages

The following sections describe each stage of the intake workflow.

The corresponding n8n workflow JSON files are included within this repository.

These files can be imported directly into an n8n instance.

---

# Stage 1 — Webhook Trigger

The workflow begins with an HTTP Webhook Trigger.

This endpoint receives applicant submissions from:

- Custom websites
- WordPress
- Webflow
- Wix
- Squarespace
- React
- Vue
- Bubble
- Internal applications
- CRM systems
- Automation platforms

Input typically includes:

- Applicant information
- Organization identifier
- Uploaded media
- Metadata

Once received, the workflow execution begins.

---

# Stage 2 — Request Validation

The validation stage ensures the request contains all required information before additional processing begins.

Typical validation includes:

- Required fields
- Organization identifier
- File presence
- File types
- File size
- Payload structure

Invalid requests terminate immediately with an appropriate response.

Processing only continues after successful validation.

---

# Stage 3 — Organization Configuration

The workflow retrieves the organization's configuration.

The reference implementation stores configuration within Airtable.

Configuration determines:

- Evaluation rules
- Required applicant information
- AI prompts
- Organization preferences
- Workflow behavior

Different organizations may therefore execute different evaluation logic while sharing the same workflow.

---

# Stage 4 — Media Processing

Applicant media is prepared before storage.

Depending on organizational requirements this stage may include:

- Image validation
- File renaming
- Metadata extraction
- Duplicate detection
- Image normalization

Additional processing steps may be added if required.

---

# Stage 5 — Cloudflare R2 Upload

Applicant media is uploaded into Cloudflare R2.

The reference implementation automatically creates the storage hierarchy.

Example:

Organization

↓

Workflow

↓

Month

↓

Application UUID

↓

Applicant Images

The resulting object references become part of the applicant record.

---

# Stage 6 — Database Storage

Applicant information is stored within Supabase.

Typical information includes:

- Applicant profile
- Contact information
- Organization
- Uploaded media references
- Workflow status
- Metadata

At this stage the applicant officially exists within the Talent Prism platform.

---

# Stage 7 — AI Evaluation

After successful storage the applicant enters the AI evaluation pipeline.

The reference implementation may perform multiple evaluation stages depending on organizational configuration.

Examples include:

- Vision analysis
- Applicant qualification
- Prompt generation
- Structured reasoning
- Scoring
- Recommendation generation

The evaluation process is fully configurable.

Organizations may customize prompts, models, thresholds, and evaluation criteria.

---

# Stage 8 — Scoring

AI evaluation produces structured outputs.

These outputs are transformed into recruiter-friendly scores.

Examples include:

- Overall score
- Qualification score
- Recommendation
- Confidence
- Explanation

Scoring logic may differ between organizations.

---

---

---

# Error Handling

Each workflow stage should fail independently.

Typical failures include:

## Validation Errors

Examples:

- Missing applicant information
- Invalid payload
- Unsupported file format

Processing terminates immediately.

---

## Storage Errors

Examples:

- Cloudflare R2 unavailable
- Upload failure
- Permission errors

The workflow should log the failure and optionally retry.

---

## Database Errors

Examples:

- Supabase unavailable
- Constraint violations

Database operations should avoid duplicate applicant creation.

---

## AI Errors

Examples:

- Model unavailable
- Timeout
- Rate limiting
- Invalid AI response

Organizations may retry, defer evaluation, or route applicants for manual review.

---

# Retry Strategy

Not every stage should automatically retry.

Safe retry examples:

- Cloudflare R2 upload
- AI evaluation
- Notifications

Stages requiring additional care:

- Applicant creation
- Database insertion
- Duplicate detection

Retry strategies should preserve workflow idempotency wherever possible.

---

# Extending the Workflow

One advantage of workflow orchestration is extensibility.

Additional stages may be inserted without modifying existing functionality.

Examples include:

- Face verification
- OCR
- Background verification
- Portfolio analysis
- Recruiter or Scout assignment
- Duplicate applicant detection
- Translation
- WhatsApp messaging
- Slack notifications
- CRM synchronization
- ATS synchronization
- Email automation

Organizations are encouraged to extend the workflow according to their operational requirements.

---

# Workflow JSON Files

The repository includes the complete workflow definitions used by the reference implementation.

These workflows can be imported directly into n8n.

Depending on the repository structure, workflows may be organized by responsibility.

Example:

```
workflow-automation/
└── workflows/
    ├── intake-workflow.json
    ├── ai-evaluation.json
    ├── media-processing.json
    ├── notifications.json
    └── recruiter-review.json
```

Each workflow file is documented independently throughout this section.

---

---

# Workflow Completion

After AI evaluation has completed, the workflow updates the applicant record with the evaluation results.

At this point, workflow execution is complete.

The applicant and evaluation results are now available to any application, dashboard, or service that reads from the configured database.

The reference implementation does not prescribe how organizations review applicants after evaluation. Some organizations may build an internal dashboard, while others may synchronize approved applicants into existing recruitment or agency management platforms.

This separation allows the inta