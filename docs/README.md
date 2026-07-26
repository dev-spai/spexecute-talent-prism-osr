# Deployment

This section describes how to deploy the Talent Prism reference implementation.

Talent Prism consists of several independent services working together. Before deploying, each service must be configured and connected correctly.

---

## Deployment Architecture

Frontend
↓
Cloudflare Workers
↓
n8n
↓
Google Gemini

↓

Supabase
Cloudflare R2
Airtable

---

## Components

| Component | Purpose |
|-----------|---------|
| Frontend | Recruiter interface |
| n8n | Workflow orchestration |
| Supabase | Application database |
| Cloudflare R2 | Object storage |
| Cloudflare Workers | Signed URLs & APIs |
| Airtable | Organization configuration |
| Gemini | AI evaluation |

---

## Deployment Order

1. Create Supabase project
2. Configure Cloudflare R2
3. Deploy Cloudflare Workers
4. Configure Airtable
5. Import n8n workflows
6. Configure environment variables
7. Deploy frontend
8. Verify system health

---

## Related Documentation

- Configuration
- Storage
- Workers
- Workflows