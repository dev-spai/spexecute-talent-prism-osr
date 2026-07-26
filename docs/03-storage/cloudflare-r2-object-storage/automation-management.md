# Automatic Folder Management

The folder structure shown previously is managed automatically by the Talent Prism intake workflow.

There is no need to manually create folders, organize files, or manage the storage hierarchy.

When a new application is submitted, the intake workflow automatically:

1. Retrieves the organization's configuration.
2. Generates a unique Application UUID.
3. Builds the appropriate storage path.
4. Uploads the applicant's media to Cloudflare R2.
5. Stores the object keys and metadata in the database.

The entire storage process is handled automatically by the platform, ensuring that every application follows a consistent and predictable folder structure.