Trigger (From Intake / Manual Retry)
            │
            ▼
Retrieve Applicant
            │
            ▼
Retrieve Applicant Media
            │
            ▼
Generate Signed URLs
            │
            ▼
Read Organization Configuration
            │
            ▼
Build Gemini Request
            │
            ▼
Gemini Photo Quality Check
            │
            ▼
Parse AI Response
            │
            ▼
Pass?
      ┌───────────────┐
      │               │
     Yes             No
      │               │
      ▼               ▼
Update Status     Request New Photos
      │
      ▼
Trigger Candidate Analysis Workflow