# Supabase

Talent Prism uses Supabase as the primary application database.

Supabase stores structured application data, workflow state, AI evaluations, audit history, and system configuration. Large media assets are stored separately in object storage and referenced from the database.

Typical records stored in Supabase include:

- Applicants
- Intake submissions
- Organization configuration
- AI evaluation results
- Workflow stages
- Processing history
- Recruiter notes
- Media metadata
- Storage references
- Audit logs

Example

```yaml
database:

  provider: supabase

  schema: public
```

---

## Media References

Instead of storing uploaded files directly in the database, Talent Prism stores references to files located in object storage.

Example

```yaml
media:

  storage_provider: cloudflare-r2

  store_reference_only: true
```

A typical applicant record contains metadata such as:

- File path
- Object key
- Signed URL status
- Upload timestamp
- MIME type
- Image dimensions
- Processing status

This approach keeps the database lightweight while allowing large media files to be managed independently.