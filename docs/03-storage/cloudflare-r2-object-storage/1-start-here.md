# How to store your Images

Talent Prism uses **Cloudflare R2** as its primary object storage service for applicant media.

Instead of storing images inside the database, all uploaded media is stored in Cloudflare R2 while the database stores only the associated metadata and object URLs.

This architecture provides:

- Scalable object storage
- Low-cost storage for large media files
- Fast global delivery
- Separation of media from relational data
- Easy integration with AI image analysis workflows

Every applicant's uploaded photographs are stored in R2 and referenced throughout the platform using object keys and public or signed URLs.

---

# What is stored in R2?

Cloudflare R2 stores media assets rather than application data.

Typical files include:

- Headshots
- Full body photographs
- Left profile photographs
- Right profile photographs
- Three-quarter photographs
- Additional portfolio images
- Supporting documents (optional)

The database stores references to these files, while the files themselves remain in R2.

# Best Practices

- Keep the bucket private.
- Never expose API credentials in client-side applications.
- Grant only the minimum permissions required.
- Rotate API tokens periodically.
- Configure lifecycle policies if applicant media should be archived or deleted after a retention period.
- Monitor bucket activity and review access logs regularly.