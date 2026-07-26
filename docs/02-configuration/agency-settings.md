# Agency Settings

Talent Prism is designed as a multi-organization reference implementation.

Instead of hardcoding business logic into workflows, organization-specific behavior is controlled through a configuration layer. This allows different agencies to share the same processing pipeline while maintaining independent branding, workflows, evaluation criteria, and operational settings.

---

## Overview

Each organization has a unique configuration that defines how Talent Prism behaves for that deployment.

Examples include:

- Agency identity
- Branding
- Supported languages
- Geographic markets
- AI configuration
- Intake forms
- Storage settings
- Workflow behavior

---

## Configuration Example

```yaml
agency_slug: noir-collective-france

agency_name: Noir Collective

default_language: fr

timezone: Europe/Paris

country: France

currency: EUR

branding:
  logo: noir-logo.svg
  primary_color: "#111111"
  accent_color: "#C6A56D"
```

---

# Configuration Reference

## Agency Slug

Unique identifier for the organization.

Used throughout the platform for:

- Workflow routing
- Airtable configuration lookup
- API requests
- Prompt selection
- Storage organization
- Multi-tenant isolation

Example

```yaml
agency_slug: noir-collective-france
```

---

## Agency Name

Human-readable organization name displayed throughout the application.

Example

```yaml
agency_name: Noir Collective
```

---

## Default Language

Primary language used for:

- Applicant communication
- Generated emails
- Notifications
- AI prompt localization
- Dashboard defaults

Supported examples

```yaml
default_language: en
default_language: fr
default_language: de
default_language: es
```

---

## Timezone

Defines operational timezone.

Used by:

- Scheduled workflows
- Batch processing
- URL expiration
- Audit timestamps
- Reporting

Example

```yaml
timezone: Europe/Paris
```

---

## Supported Markets

Markets the agency actively recruits for.

Example

```yaml
markets:

- Editorial

- Commercial

- Runway

- Beauty

- Lifestyle

- Fitness
```

---

## Supported Languages

Languages accepted during applicant intake.

Example

```yaml
languages:

- English

- French

- German

- Spanish
```

---

## Branding

Visual identity used by frontend applications.

Example

```yaml
branding:

  logo: logo.svg

  favicon: favicon.ico

  primary_color: "#111111"

  secondary_color: "#F4F4F4"

  accent_color: "#C6A56D"
```

---

## Intake Provider

Defines where applications originate.

Examples

```yaml
provider: tally

provider: typeform

provider: custom_api
```

---

## Storage Provider

Determines where applicant media is stored.

Example

```yaml
storage:

  provider: cloudflare-r2

  bucket: talent-prism

  signed_urls: true
```

---

## AI Provider

Selects the default AI service.

Example

```yaml
ai:

  provider: gemini

  model: gemini-2.5-flash
```

---

## Workflow Configuration

Organizations may enable or disable optional processing stages.

Example

```yaml
workflows:

  photo_check: true

  structural_analysis: true

  recruiter_review: true

  duplicate_detection: true
```

---

## Security Settings

Example

```yaml
security:

  signed_urls: true

  url_expiry_days: 7

  webhook_authentication: true

  audit_logging: true
```

---

# Best Practices

- Never hardcode organization-specific values into workflows.
- Store business rules in configuration whenever possible.
- Use unique agency slugs for every deployment.
- Keep branding assets outside workflow logic.
- Treat configuration as the primary customization layer.

---

# Related Documentation

- Intake Configuration
- AI Configuration
- Workflow Configuration
- Storage Configuration
- Security Configuration