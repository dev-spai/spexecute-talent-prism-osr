# Integration Scenarios

Every organization is different.

The following sections describe the most common integration approaches.

---

# Scenario 1 — Existing Website Form

This is the most common scenario.

Many organizations already have an application form on their website.

Examples include:

- WordPress
- Webflow
- Wix
- Squarespace
- React
- Vue
- Angular
- Bubble
- HTML

There is no need to redesign or replace your existing form.

Simply configure the form to send applicant information to the Talent Prism intake webhook.

```
Applicant
      │
      ▼
Existing Website Form
      │
HTTP POST
      │
      ▼
Talent Prism Webhook
      │
      ▼
Workflow
```

The applicant experience remains exactly the same.

Only the processing pipeline changes.

---

# Scenario 2 — Existing CRM or Database

Some organizations already collect applications inside another system.

Examples include:

- HubSpot
- Airtable
- Google Sheets
- Notion
- Internal databases
- Existing ATS solutions

Talent Prism can be integrated after the application has been stored.

```
Applicant
      │
      ▼
Website
      │
      ▼
Existing CRM
      │
Automation
      │
      ▼
Talent Prism Webhook
```

Automation platforms such as n8n, Make or Zapier can retrieve applicant information and forward it into the Talent Prism workflow.

No changes to the public website are required.

---

# Scenario 3 — Applications by Email

Some organizations still receive applications through email.

```
Applicant

↓

Recruitment Email

↓

Recruiter Inbox
```

Instead of manually downloading attachments and copying applicant information, automation workflows can process incoming emails.

```
Applicant

↓

Email

↓

n8n

↓

Talent Prism Workflow
```

The workflow extracts:

- Applicant information
- Contact information
- Measurements
- Portfolio links
- Image attachments

before continuing with the standard Talent Prism workflow.

---

# Scenario 4 — Building a New Website

Organizations without an existing application form may build one using any technology.

Examples include:

- HTML
- React
- Vue
- Angular
- Next.js
- WordPress
- Webflow
- Wix
- Squarespace
- Bubble
- Flutter
- Native Mobile Applications

Talent Prism has no frontend requirements.

Any application capable of sending an HTTP POST request to the intake webhook can integrate successfully.

---

# Existing Agency Management Platforms

Many modeling agencies already operate using agency management software.

Examples include:

- Mainboard
- Mediaslide
- Syngency
- Model Management
- Custom agency software
- Internal recruitment platforms

These systems typically manage:

- Talent
- Portfolios
- Clients
- Bookings
- Contracts
- Availability
- Internal operations

Talent Prism is **not designed to replace these systems.**

Instead, it complements them by automating applicant intake and AI-assisted evaluation before candidates enter your operational platform.

---

# Integration Strategies

Different platforms expose different integration capabilities.

Some provide APIs.

Some provide import/export functionality.

Some offer private enterprise integrations.

Others provide no public integration capabilities at all.

Talent Prism supports multiple integration strategies depending on the capabilities of your existing software.

---

## Option 1 — Direct Webhook Integration

If your website or application can make HTTP requests, it can communicate directly with Talent Prism.

```
Website

↓

HTTP POST

↓

Talent Prism Webhook
```

This is the simplest and recommended integration.

---

## Option 2 — Automation Platform

Many organizations already use automation platforms.

Examples include:

- n8n
- Make
- Zapier
- Pipedream

These platforms can transform applicant information before forwarding it into Talent Prism.

```
Website

↓

Webhook

↓

Automation

↓

Talent Prism
```

Automation platforms are useful when:

- Data transformation is required.
- Images need preprocessing.
- Multiple systems must be updated simultaneously.
- Existing systems cannot communicate directly with Talent Prism.

---

## Option 3 — Agency Platform Integration

Agency management platforms differ significantly in their integration capabilities.

For example, Syngency provides publicly documented API capabilities for retrieving published information, while other platforms may rely on import/export workflows or private enterprise integrations.

If your platform provides suitable integration capabilities, a middleware service or automation workflow can synchronize approved applicants.

```
Applicant

↓

Talent Prism

↓

Recruiter Approval

↓

Automation / Middleware

↓

Agency Platform
```

The middleware is responsible for translating Talent Prism data into the format expected by your operational software.

---

## Option 4 — CSV Import

Some agency platforms support importing applicant information through CSV files.

Talent Prism data can be exported into a compatible format before being imported into the operational system.

```
Talent Prism

↓

CSV

↓

Agency Platform
```

This approach is particularly useful for legacy software.

---

## Option 5 — Manual Workflow

Organizations may also choose to use Talent Prism only for applicant evaluation.

```
Applicant

↓

Talent Prism

↓

Recruiter Review

↓

Manual Entry Into Agency Platform
```

Although recruiters still create applicant records manually, they only process qualified applicants rather than reviewing every submission.

---

# Recommended Adoption Strategy

Rather than replacing existing systems immediately, we recommend a phased implementation.

## Phase 1

Continue using your existing website.

Route applications into Talent Prism.

```
Website

↓

Talent Prism

↓

Recruiter Review
```

---

## Phase 2

Connect Talent Prism with your operational software.

```
Website

↓

Talent Prism

↓

Agency Platform
```

---

## Phase 3

Automate synchronization.

```
Website

↓

Talent Prism

↓

Automation

↓

Agency Platform
```

This approach minimizes operational disruption while allowing your organization to validate the workflow before introducing deeper integrations.

---

# Required Applicant Information

The reference implementation expects the following minimum information.

| Field | Required |
| --- | --- |
| Organization | Yes |
| First Name | Yes |
| Last Name | Yes |
| Email | Yes |
| Phone | Recommended |
| Country | Recommended |
| Applicant Photos | Yes |

Additional fields such as height, measurements, portfolio links, social media accounts, and organization-specific questions may be collected depending on business requirements.

---

# Applicant Media

Applicant photographs are submitted together with the application.

Typical media includes:

- Headshot
- Profile
- Full Body
- Three Quarter
- Polaroids

Organizations may collect any additional media required by their recruitment process.

---

# Example Payload

```json
{
  "organization": "noir-collective-france",
  "first_name": "Jane",
  "last_name": "Doe",
  "email": "jane@example.com",
  "phone": "+33 612345678",
  "country": "France",
  "height": 178,
  "portfolio": "<https://janedoe.com>",
  "instagram": "<https://instagram.com/janedoe>",
  "photos": [
    "...",
    "...",
    "..."
  ]
}
```

Additional fields may be included to satisfy organization-specific requirements.

---

# Best Practices

- Keep your existing frontend whenever possible.
- Use the webhook as the single entry point into the workflow.
- Validate applicant information before submission.
- Upload high-quality images while keeping file sizes reasonable.
- Protect credentials by keeping authentication on the server side whenever possible.
- Use HTTPS for all communication.
- Test integrations thoroughly before production deployment.
- Introduce automation gradually.

---

# Troubleshooting

## Applications do not enter the workflow

Verify:

- The webhook URL is correct.
- The HTTP request is successful.
- Required fields are present.
- Authentication has been configured correctly.

---

## Images are missing

Verify:

- Files are included in the request.
- Supported file formats are used.
- Upload limits have not been been exceeded.

---

## AI evaluation does not begin

Verify:

- The workflow completed successfully.
- Images were uploaded to Cloudflare R2.
- Applicant information was written to Supabase.
- Organization configuration exists in Airtable.

---

# Final Notes

Talent Prism is built around a simple architectural principle:

> **Bring your own frontend. Keep your existing systems. Connect everything through a configurable workflow.**
> 

Whether applicants originate from a custom website, WordPress, Webflow, an agency management platform, a CRM, email automation, or another recruitment system, Talent Prism standardizes everything that happens after submission.

The reference implementation uses **n8n** to orchestrate this process, but the workflow itself is platform-independent. Organizations are free to adapt or replace individual components while preserving the overall architecture and processing pipeline.