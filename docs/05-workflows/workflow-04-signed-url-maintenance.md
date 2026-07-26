# Workflow 4 — Active Applicant R2 URL Refresh

Weekly Scheduler
        │
        ▼
Retrieve Active Applicants
        │
        ▼
Extract Intake IDs
        │
        ▼
Retrieve Expiring R2 URLs
        │
        ▼
Filter Matching Media Records
        │
        ▼
Determine URL Expiry (6 days in secs)
        │
        ▼
Generate New Signed URLs
        │
        ▼
Update Media Records
        │
        ▼
Workflow Complete


# Workflow 5 — Inactive Applicant R2 URL Refresh

Weekly Scheduler
        │
        ▼
Retrieve Inactive Applicants
        │
        ▼
Extract Intake IDs
        │
        ▼
Retrieve Expiring R2 URLs
        │
        ▼
Filter Matching Media Records
        │
        ▼
Determine URL Expiry (14 days in secs)
        │
        ▼
Generate New Signed URLs
        │
        ▼
Update Media Records
        │
        ▼
Workflow Complete