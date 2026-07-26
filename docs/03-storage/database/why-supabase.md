# Supabase (Database)

Supabase serves as the primary application database for Talent Prism.

It stores all structured application data throughout the applicant lifecycle, acting as the system of record for applicants, workflow execution, AI evaluation results, and recruiter interactions. While uploaded media is stored separately in Cloudflare R2, Supabase maintains the metadata and references required to access and process those files.

---

# Why Supabase?

Talent Prism requires a relational database capable of storing structured data, maintaining relationships between entities, and tracking the state of each applicant as they progress through the recruitment pipeline.

Supabase was selected because it provides:

- PostgreSQL database
- Row Level Security (RLS)
- REST and Realtime APIs
- Authentication support
- SQL views and functions
- Excellent developer experience

---

# What is Stored

Supabase stores structured information generated throughout the application lifecycle.

This includes:

- Applicant records
- Intake submissions
- Workflow status
- Processing history
- AI evaluation results
- Recruiter notes
- Media references
- System metadata
- Audit history

Large media assets such as photos and videos are **not** stored in Supabase. Instead, Supabase stores references to files located in Cloudflare R2.

---

# Database Responsibilities

Supabase is responsible for:

- Persisting applicant data
- Tracking workflow progress
- Recording AI evaluation results
- Maintaining recruiter actions
- Managing relationships between records
- Supporting reporting and analytics
- Providing the application's source of truth

---

# Data Model

The database is organized into several logical entities.

Typical entities include:

- Applicants
- Intake
- Media References
- AI Evaluations
- Workflow History
- Recruiter Notes
- Sources
- Export Logs
- Users

Each entity represents a specific part of the applicant lifecycle and is connected through relational references.

---

# Workflow State

Every applicant moves through multiple processing stages.

Supabase maintains the current state of each application, allowing workflows and the frontend to understand where an applicant is within the recruitment process.

Examples include:

- Processing
- Photo Check
- Structural Analysis
- Candidate Evaluation
- Recruiter Review
- Completed

This state information enables workflows to resume processing and allows recruiters to monitor application progress.

---

# Media References

Uploaded files are stored in Cloudflare R2.

Supabase stores only the metadata required to locate and process those files.

Typical metadata includes:

- Object path
- File name
- MIME type
- Upload timestamp
- Image dimensions
- Processing status

Separating structured data from object storage improves scalability and reduces database size.

---

# Security

Supabase provides several security features used by Talent Prism.

These include:

- Row Level Security (RLS)
- Role-based permissions
- Secure API access
- Database authentication
- SQL policies

Organizations should review and customize security policies before deploying the system in production.

---

# Best Practices

- Store only structured application data in Supabase.
- Store uploaded media in object storage.
- Use references instead of storing binary files in the database.
- Protect tables using Row Level Security.
- Keep workflow state normalized.
- Use indexes for frequently queried fields.
- Maintain audit history for important actions.

---

# Related Documentation

- Database Schema
- Database Views
- Row Level Security
- Cloudflare R2
- Storage Architecture