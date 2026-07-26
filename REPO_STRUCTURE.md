talent-prism-osr/
│
├── README.md
├── START_HERE.md
├── REPO_STRUCTURE
├── CHANGELOG.md
├── LICENSE
├── NOTICE.md
├── SECURITY.md
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
├── GOVERNANCE.md
├── DISCLAIMER.md
├── RELEASE_POLICY.md
├── EXPORT_CONTROL.md
├── AI_USAGE.md
├── .env.example
├── .gitignore
│
├── assets/
│   ├── architecture/
│   │   ├── overall-system-architecture-overview.png
│   │   ├── n8n-01-intake-storage.png
│   │   ├── n8n-02-intake-photo-check.png
│   │   ├── n8n-03-intake-candidate-analysis.png
│   │   ├── n8n-sunday-refresh-active-urls.png
│   │   └── n8n-sunday-refresh-inactive-urls.png
│   │
│   ├── diagrams/
│   │   ├── 01-intake-storage.png
│   │   ├── 02-intake-scoring-photo-check.png
│   │   ├── 03-intake-candidate-analysis.png
│   │   ├── active-url-refreshing.png
│   │   └── inactive-profile-url-refreshing.png
│   │
│   ├── frontend/
│   │   ├── 01-live-processing-dashboard.png
│   │   ├── 02-partner-intake-dashboard.png
│   │   ├── 03-open-call-dashboard.png
│   │   ├── 05-review-queue.png
│   │   ├── 06-applicant-profile.png
│   │   ├── 07-applicant-profile-expanded.png
│   │   ├── 08-post-qualification-pipeline.png
│   │   ├── 09-post-qualification-pipeline-sidebar.png
│   │   └── 10-image-authenticity-analysis.png
│   │
│   └── branding/
│       ├── Spexecute Logo.png
│       ├── Spexecute_full_logo.png
│       ├── person-talent-prism.png
│       ├── talent-prism-poster.png
│       └── talentprism-usecase-1.png
│
├── workflows/
│   ├── 01-intake-storage.json
│   ├── 02-intake-scoring-photo-check.json
│   ├── 03-intake-candidate-analysis.json
│   ├── r2-sunday-url-refresh-active.json
│   └── r2-sunday-url-refresh-inactive.json
│
└── docs/
    ├── README.md
    │
    ├── 01-introduction/
    │   ├── README.md
    │   ├── architecture-overview.md
    │   ├── repository-overview.md
    │   ├── technology-stack.md
    │   ├── technology-alternatives.md
    │   ├── who-is-this-repo-for.md
    │   ├── why-talent-prism.md
    │   └── why-open-source-this.md
    │
    ├── 02-configuration/
    │   ├── README.md
    │   ├── agency-settings.md
    │   ├── ai-config.md
    │   ├── intake-config.md
    │   ├── security-config.md
    │   ├── storing-database.md
    │   └── storing-media-files.md
    │
    ├── 03-storage/
    │   ├── README.md
    │   ├── security.md
    │   │
    │   ├── airtable/
    │   │   ├── why-airtable.md
    │   │   ├── configuration-table-schema.md
    │   │   └── important.md
    │   │
    │   ├── cloudflare-r2/
    │   │   ├── README.md
    │   │   ├── bucket-structure.md
    │   │   ├── automation-management.md
    │   │   └── cloudflare-r2.md
    │   │
    │   └── database/
    │       ├── why-supabase.md
    │       │
    │       ├── schema/
    │       │   ├── 00-extensions.sql
    │       │   ├── 01-sources.sql
    │       │   ├── 02-users.sql
    │       │   ├── 03-intake.sql
    │       │   ├── 04-intake-notes.sql
    │       │   ├── 05-media-forensics.sql
    │       │   ├── 06-stage-history.sql
    │       │   ├── 07-roster.sql
    │       │   └── 08-export-log.sql
    │       │
    │       ├── row-level-security/
    │       │   ├── README.md
    │       │   ├── sources.sql
    │       │   ├── users.sql
    │       │   ├── intake.sql
    │       │   ├── intake-notes.sql
    │       │   ├── media-forensics.sql
    │       │   ├── stage-history.sql
    │       │   ├── roster.sql
    │       │   └── export-log.sql
    │       │
    │       ├── tables/
    │       └── views/
    │
    ├── 04-workers/
    │   ├── README.md
    │   ├── cloudflare-worker.md
    │   ├── configuration.md
    │   ├── environment-variables.md
    │   ├── testing.md
    │   ├── wrangler.toml
    │   ├── package.json
    │   └── reference-code/
    │       └── index.js
    │
    ├── 05-workflows/
    │   ├── README.md
    │   ├── workflow-01-applicant-intake.md
    │   ├── workflow-02-photo-quality.md
    │   ├── workflow-03-candidate-analysis.md
    │   └── workflow-04-signed-url-maintenance.md
    │
    ├── 06-frontend/
    │   ├── README.md
    │   ├── supported-integrations.md
    │   ├── the-intake-form.md
    │   └── frontend-reference/
    │       ├── README.md
    │       └── building-your-own-interface.md
    │
    └── 07-implementation-guide/
        ├── README.md
        ├── prerequisites.md
        ├── quick-start.md
        ├── implementation-checklist.md
        └── troubleshooting.md