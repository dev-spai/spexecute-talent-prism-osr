# Storage

Talent Prism stores different types of information throughout the applicant lifecycle, including uploaded media, structured applicant records, workflow state, AI evaluation results, and organization-specific configuration.

Rather than storing everything in a single system, the reference implementation uses the most appropriate service for each type of data.

| Technology | Purpose |
|------------|---------|
| **Supabase** | Primary application database for applicant records, workflow state, AI evaluation results, recruiter notes, and media references. |
| **Cloudflare R2** | Object storage for applicant photos, videos, and other uploaded media. Large files are stored separately from the database for scalability and cost efficiency. |
| **Airtable** | Configuration database containing organization settings, intake configuration, AI prompts, workflow preferences, and other business rules that can be updated without modifying workflows. |

This separation keeps the system scalable, maintainable, and flexible. Structured data is managed in **Supabase**, media assets are stored securely in **Cloudflare R2**, and organization-specific configuration is maintained in **Airtable**, allowing deployments to be customized without changing the application's source code.