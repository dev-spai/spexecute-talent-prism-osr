# Why Airtable Configuration Layer

### **Read configuration-table-schema** if you want to know what tables to make

# Client Configuration

One of the first questions we asked while designing Talent Prism was:

**Can the same platform be used by different talent organizations without rewriting the system every time?**

To answer that question, we spent time researching modeling agencies, management companies, and talent organizations across different markets.

What we discovered was that most organizations are much more complex than they appear.

Many independent agencies operate under a single brand, but larger organizations often manage multiple brands, regional offices, or specialized divisions under one parent company.

For example, a single organization may operate:

- A runway division
- A commercial division
- A new faces division
- An influencer division
- Multiple regional agencies
- Multiple brands acquired over time

Although these brands belong to the same organization, they rarely evaluate talent in exactly the same way.

One brand may primarily look for editorial and runway talent.

Another may focus on commercial campaigns.

Another may specialize in fitness, influencer, lifestyle, or luxury talent.

As a result, every brand develops its own internal standards for evaluating applicants.

These differences may include:

- Minimum height requirements
- Age ranges
- Required photographs
- Portfolio expectations
- AI evaluation prompts
- Candidate scoring weights
- Qualification thresholds
- Review workflow
- Recruiter preferences
- Escalation rules

If these rules were hardcoded directly into SQL queries, AI prompts, or automation workflows, every new client or every new brand would require modifying the platform itself.

That approach does not scale.

Instead, Talent Prism separates **business configuration** from **application logic**.

The application contains only the processing logic.

The business rules live in a separate configuration layer.

Whenever a new application enters the system, the platform first loads the appropriate configuration profile for the selected brand.

That configuration determines how the rest of the workflow behaves.

The automation, database, AI evaluation pipeline, and scoring engine all remain exactly the same.

Only the configuration changes.

This allows the same Talent Prism deployment to support organizations of very different sizes without creating separate versions of the platform.


# Why Airtable?

The reference implementation stores configuration in Airtable.

Airtable was chosen because it provides an interface that both technical and non-technical teams can use.

Recruiters, talent directors, operations managers, and agency administrators can update business rules without writing SQL, editing workflows, or changing application code.

Instead of asking an engineer to deploy a new version of the platform every time a scoring rule changes, teams can simply update the configuration record.

The automation will automatically use the updated configuration during the next application.

This significantly reduces maintenance while allowing organizations to evolve their evaluation process over time.

Typical configuration includes:

## Organization

- Organization name
- Brand name
- Brand identifier
- Markets served
- Regional settings

## Candidate Requirements

- Height requirements
- Age limits
- Measurement standards
- Required media
- Eligibility rules

## AI Evaluation

- AI prompts
- Scoring weights
- Qualification thresholds
- Brand-specific evaluation criteria

## Workflow Behaviour

- Review stages
- Assignment rules
- Escalation behaviour
- Reviewer preferences
- Notification settings

---

# Is Airtable Required?

No.

Airtable is simply the reference implementation used in this project.

Talent Prism does not depend on Airtable.

The platform only requires that a configuration profile can be retrieved before an application begins processing.

Organizations are free to replace Airtable with any structured data source that can provide the same information.

Examples include:

- PostgreSQL
- Supabase
- MySQL
- Google Sheets
- Internal APIs
- Custom configuration services

The automation workflows remain unchanged.

Only the source of the configuration changes.

---

# Design Philosophy

Business rules change.

Software should not.

By separating configuration from application logic, organizations can adapt their evaluation process without modifying the platform itself.

This makes Talent Prism easier to maintain, easier to customize, and easier to deploy across organizations ranging from independent agencies to global talent groups managing multiple brands.