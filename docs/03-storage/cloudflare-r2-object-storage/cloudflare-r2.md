# Why Cloudflare R2?

Talent Prism requires a reliable object storage solution for applicant media.

Every application submitted to the platform contains multiple high-resolution photographs that must be stored, retrieved, analyzed by AI, and made available to recruiters throughout the review process.

There are many ways to store these files.

Examples include:

- Amazon S3
- Google Cloud Storage
- Azure Blob Storage
- Dropbox
- Google Drive
- DigitalOcean Spaces
- Backblaze B2
- MinIO
- Any S3-compatible object storage service

Talent Prism is intentionally designed so that **the storage provider is not tightly coupled to the application**.

As long as your storage solution can upload, retrieve, and generate accessible URLs for media objects, it can be integrated into the platform.

The reference implementation uses **Cloudflare R2** because it offered the best balance of performance, scalability, simplicity, and operating cost for this project.

---

# Why Cloudflare R2?

After evaluating several object storage solutions, Cloudflare R2 was selected for a number of practical reasons.

## 1. S3 Compatible

Cloudflare R2 supports the Amazon S3 API.

This means that most libraries, SDKs, automation tools, and integrations that work with Amazon S3 will also work with R2 with minimal configuration changes.

This makes the storage layer highly portable and avoids vendor lock-in.

---

## 2. No Egress Fees

One of Cloudflare R2's biggest advantages is that it does not charge egress fees.

Talent Prism frequently retrieves applicant photographs for:

- AI analysis
- Human review
- Reprocessing
- Exports
- Workflow automation

Since media files are downloaded many times throughout their lifecycle, eliminating egress costs significantly reduces long-term operating expenses.

---

## 3. Global Performance

Cloudflare's global network provides fast access to stored media from multiple geographic regions.

Whether photographs are being analyzed by AI services or viewed by recruiters, retrieval remains fast and reliable.

---

## 4. Built for Object Storage

Applicant photographs are binary files rather than relational data.

Cloudflare R2 is purpose-built for storing objects such as:

- Images
- Documents
- Videos
- Attachments

Keeping media separate from the relational database results in a cleaner and more scalable architecture.

---

## 5. Easy Integration

Cloudflare R2 integrates easily with:

- n8n
- Python
- FastAPI
- Supabase
- AI services
- Cloudflare Workers

This made it an excellent fit for the Talent Prism automation pipeline.

---

## 6. Scales with the Platform

As organizations receive more applications, the amount of uploaded media grows quickly.

Cloudflare R2 is designed to scale without requiring changes to the application's architecture.

Whether storing hundreds or millions of images, the interaction pattern remains the same.

---

# Could I Use Something Else?

Absolutely.

Cloudflare R2 is the **reference implementation**, not a requirement.

You can replace it with any storage provider that supports reliable object storage.

Examples include:

- Amazon S3
- Google Cloud Storage
- Azure Blob Storage
- DigitalOcean Spaces
- Backblaze B2
- MinIO
- Self-hosted S3-compatible storage
- Any object storage service capable of generating accessible file URLs

Only the storage adapter needs to change.

The rest of Talent Prism—including the database, automation workflows, AI evaluation pipeline, and application logic—can remain unchanged.

---

# Design Philosophy

Talent Prism treats file storage as infrastructure rather than business logic.

The platform only needs a storage service capable of storing media and returning object references.

By abstracting the storage layer, organizations are free to choose the provider that best fits their technical, operational, or compliance requirements while maintaining the same application architecture.