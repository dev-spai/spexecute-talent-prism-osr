# Technology Alternatives

The technologies used in this repository were selected because they fit the goals of the reference implementation. They are **not architectural requirements**.

Organizations are free to substitute individual components with technologies that better align with their existing infrastructure, cloud provider, security policies, or engineering preferences.

| Component | Reference Implementation | Possible Alternatives |
| --- | --- | --- |
| Workflow Automation | n8n | Make, Zapier, Temporal, Apache Airflow, Camunda, Azure Logic Apps, AWS Step Functions, Custom Backend |
| Database | Supabase | PostgreSQL, MySQL, Microsoft SQL Server, MongoDB, Firebase, DynamoDB |
| Object Storage | Cloudflare R2 | Amazon S3, Google Cloud Storage, Azure Blob Storage, DigitalOcean Spaces, MinIO, Backblaze B2 |
| Signed URL Service | Cloudflare Workers | AWS Lambda, Azure Functions, Google Cloud Functions, FastAPI, Express.js |
| AI Models | Google Gemini | OpenAI GPT-4.1, Claude, Mistral, Llama, Azure OpenAI, Amazon Bedrock, Vertex AI |
| Configuration Store | Airtable | PostgreSQL, Supabase, Firebase, Google Sheets, Notion, Contentful, Strapi, Custom Admin Panel |
| Frontend | Frontend Agnostic | React, Next.js, Vue, Angular, Svelte, Flutter, FlutterFlow, Bubble, Retool, Lovable, WordPress |
| Authentication | Your Existing Provider | Auth0, Clerk, Firebase Auth, Supabase Auth, AWS Cognito, Keycloak, Microsoft Entra ID |
| APIs | HTTP Webhooks & REST | GraphQL, gRPC, Message Queues, Event Bus |
| Hosting | Your Preferred Provider | AWS, Azure, Google Cloud, Cloudflare, Railway, Fly.io, DigitalOcean, Render, Vercel, Netlify |
| Monitoring | Your Preferred Platform | Grafana, Datadog, New Relic, Prometheus, Sentry, OpenTelemetry |

## Vendor Agnostic by Design

Talent Prism is designed around architectural principles rather than specific vendors.

Every major component—including workflow automation, AI models, databases, object storage, frontend frameworks, and cloud providers—can be replaced without fundamentally changing the applicant processing pipeline.

This allows organizations to:

- Continue using technologies already approved by their engineering teams.
- Align deployments with existing cloud infrastructure.
- Meet internal security and compliance requirements.
- Integrate with established development practices.
- Adopt new technologies as they become available.

The goal of this repository is to demonstrate **how the system is architected**, not to prescribe **which technologies must be used**.