# Intake Form Integration

# Frontend & Workflow Integration

Talent Prism is designed to be **frontend agnostic**.

The platform does not require a specific website builder, frontend framework, Content Management System (CMS), Customer Relationship Management (CRM) platform, Applicant Tracking System (ATS), or agency management software.

Whether your organization uses WordPress, Webflow, Wix, Squarespace, React, Vue, Angular, Bubble, Flutter, a custom-built application, or an existing agency management platform such as Mainboard, Mediaslide, or Syngency, the integration principles remain the same.

Talent Prism does not replace your website or your existing business systems.

Instead, it provides a configurable intake workflow that automates applicant processing after an application has been submitted.

---

# Reference Implementation

The reference implementation uses **n8n** as the workflow orchestration platform.

The workflow begins with an **HTTP Webhook Trigger**, which receives applicant information from your website or existing systems.

This webhook acts as the entry point into the Talent Prism workflow.

```
Applicant
      │
      ▼
Website / Existing System
      │
HTTP POST
      │
      ▼
n8n Webhook Trigger
      │
      ▼
Talent Prism Workflow
```

Once the webhook receives the application, the remainder of the workflow is handled automatically.

This includes:

- Applicant validation
- Organization configuration lookup
- Image processing
- Cloudflare R2 uploads
- Database storage
- AI evaluation
- Qualification
- Recruiter review

Although the reference implementation uses n8n, organizations are free to replace the workflow engine with any equivalent orchestration platform, provided it accepts the required applicant payload and performs the same processing steps.

---

# Philosophy

Talent Prism intentionally separates the **presentation layer** from the **processing layer**.

Your frontend remains responsible for:

- Website design
- Branding
- Applicant experience
- Form validation
- Marketing
- User interaction

Talent Prism becomes responsible for:

- Intake processing
- Workflow orchestration
- Applicant validation
- Configuration lookup
- Secure media storage
- Database storage
- AI evaluation
- Recruiter review
- Workflow automation

This separation allows organizations to modernize their recruitment process without rebuilding their public-facing website.

---

# Understanding the Workflow

Every application eventually enters the same workflow regardless of where it originated.

```
Applicant
      │
      ▼
Application Form
      │
HTTP POST
      │
      ▼
Talent Prism Webhook
      │
      ▼
Workflow Processing
      │
      ▼
Cloudflare R2
      │
      ▼
Supabase
      │
      ▼
AI Evaluation
      │
      ▼
Recruiter Dashboard
```

The source of the application is irrelevant.

Every applicant is processed using the same configurable workflow.

---

