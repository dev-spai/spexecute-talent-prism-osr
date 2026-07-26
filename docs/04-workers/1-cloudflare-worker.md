# Cloudflare Worker

The Cloudflare Worker acts as a secure gateway between Talent Prism and Cloudflare R2.

Instead of exposing the storage bucket publicly, the Worker generates authenticated, time-limited URLs that allow authorized services to access applicant media.

This approach keeps the R2 bucket private while still allowing trusted internal systems, such as Retool or backend workflows, to securely retrieve uploaded files.

# Why a Cloudflare Worker?

Talent Prism stores applicant media in a private Cloudflare R2 bucket.

Private buckets cannot be accessed directly through a browser or client application.

Instead, the platform uses a Cloudflare Worker to generate temporary AWS Signature Version 4 (AWS4) presigned URLs.

This provides several benefits:

- Keeps the storage bucket private.
- Prevents permanent public URLs.
- Allows controlled access to applicant media.
- Enables expiration of shared links.
- Protects R2 credentials from client applications.

The Worker becomes the only service responsible for creating download links.

## API Reference

```sql
## Endpoint

POST

/sign

### Headers

X-SPX-Token

Authentication token required for every request.

### Request

```json
{
  "r2_object_key": "agency/intake/uuid/headshot.jpg",
  "expiry_seconds":604800
}
```

### Response

```json
{
  "retool_signed_url":"...",
  "retool_url_expires_at":"..."
}
```

### Allowed Expiration Values

- 604800 seconds (7 days)
- 1209600 seconds (14 days)

If another value is supplied, the Worker defaults to 7 days.
```

## Authentication

```sql
# Authentication

Every request must include the following HTTP header.

X-SPX-Token

The value is compared against the configured environment secret.

Requests without a valid token receive a 401 Unauthorized response.

This prevents anonymous users from generating download links.
```

# Environment Variables

```
| Variable | Purpose |
|-----------|----------|
| SPX_AUTH_TOKEN | Authenticates incoming requests |
| R2_ACCESS_KEY_ID | Cloudflare R2 Access Key |
| R2_SECRET_ACCESS_KEY | Cloudflare R2 Secret |
```

## Security Considerations

The Worker assumes that callers are trusted services within the Talent Prism ecosystem.

It does not perform object-level authorization. Any client possessing a valid authentication token may request a presigned URL for any object within the configured bucket.

If your deployment requires finer-grained access control (for example, restricting access by organization, user, or role), implement authorization checks before generating presigned URLs.