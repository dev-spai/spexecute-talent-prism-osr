# Bucket Structure

## Overview

Talent Prism stores every applicant inside a dedicated folder (object prefix) within the storage bucket.

Rather than storing all images in a single directory, applicant media is organized by organization, workflow, date, and applicant identifier.

This keeps the bucket structured, scalable, and easy to navigate while preventing filename collisions.

The reference implementation uses the following structure.

```
bucket/
└── {organization-slug}/
    └── intake/
        └── talent_prism/
            └── YYYY-MM/
                └── {application_uuid}/
                    ├── headshot.jpg
                    ├── full_body.jpg
                    ├── profile.jpg
                    ├── three_quarter.jpg
                    └── polaroid.jpg
```

Example:

```
bucket/
└── noir-collective-france/
    └── intake/
        └── talent_prism/
            └── 2026-05/
                └── 1189266f-fcab-4a8c-8504-621dbfe4ad00/
                    ├── headshot_Rjv1pp.jpg
                    ├── full_body_BeAqMA.jpg
                    ├── profile_E6ve4q.jpg
                    ├── three_quarter_1RDz1O.jpg
                    └── polaroid_Y9pXL6.jpg
```

---

# Folder Structure

## Organization

```
noir-collective-france/
```

The top-level folder identifies the organization or brand.

This allows multiple organizations to share the same storage bucket while keeping their media completely separated.

Examples:

- elite-world-group
- wilhelmina-new-york
- ford-models-paris
- noir-collective-france

---

## Workflow

```
intake/
```

The second level identifies the workflow responsible for uploading the files.

This makes it possible for different workflows (intake, exports, media forensics, AI processing, etc.) to maintain their own storage areas if required.

---

## Platform

```
talent_prism/
```

Identifies the application or service responsible for creating the objects.

This becomes particularly useful if multiple products share the same storage account.

---

## Month

```
2026-05/
```

Applications are grouped by month.

Benefits include:

- Easier navigation
- Simpler lifecycle management
- Archive by month
- Faster manual inspection
- Cleaner storage organization

---

## Application ID

```
1189266f-fcab-4a8c-8504-621dbfe4ad00/
```

Each application receives its own unique folder.

The folder name is the application's UUID.

This guarantees uniqueness while making it easy to retrieve every file associated with a specific applicant.

---

## Uploaded Images

Each uploaded photograph is stored using a descriptive filename followed by a short unique suffix.

Example:

```
headshot_Rjv1pp.jpg
full_body_BeAqMA.jpg
profile_E6ve4q.jpg
three_quarter_1RDz1O.jpg
polaroid_Y9pXL6.jpg
```

Using descriptive names makes manual inspection significantly easier than relying solely on randomly generated filenames.

The random suffix prevents filename collisions if images are uploaded multiple times.

---

# Why This Structure?

This hierarchy was chosen because it scales well regardless of storage provider.

Benefits include:

- Separation between organizations.
- Easy retrieval of all media for a single applicant.
- No filename collisions.
- Predictable object paths.
- Simple archival and cleanup.
- Compatible with Cloudflare R2, Amazon S3, Google Cloud Storage, MinIO, Backblaze B2, and other object storage services.

---

# Can I Use a Different Structure?

Absolutely.

This folder hierarchy is the **reference implementation** used by Talent Prism.

If you use another storage provider or have different operational requirements, you are free to organize your objects differently.

The only requirement is that your application can reliably:

- Upload media.
- Retrieve media.
- Associate uploaded objects with an application.
- Generate accessible URLs when needed.

The exact folder hierarchy is an implementation detail and can be adapted to suit your own infrastructure.

# Recommended Bucket Configuration

For production deployments, we recommend the following Cloudflare R2 bucket settings.

| Setting | Recommendation |
| --- | --- |
| Bucket Visibility | Private |
| Public Access | Disabled |
| Object Listing | Disabled |
| Authentication | API Tokens |
| API Permissions | Least Privilege (Read/Write only where required) |
| HTTPS | Enabled |
| Object Versioning | Optional |
| Lifecycle Rules | Configure based on your data retention policy |

### Keep Your Bucket Private

Applicant media often contains personally identifiable information (PII), including photographs and personal details.

For this reason, your R2 bucket should remain **private**. Files should only be accessed through your application or secure backend services rather than being publicly exposed.

### Use Scoped API Tokens

Avoid using Global API Keys.

Instead, create dedicated Cloudflare API Tokens with only the permissions required by your application. This reduces the impact of compromised credentials and follows the principle of least privilege.

### Access Through the Application

The reference implementation retrieves media through authenticated application services rather than exposing the bucket directly to end users. This allows you to enforce authentication, authorization, logging, and auditing before media is served.