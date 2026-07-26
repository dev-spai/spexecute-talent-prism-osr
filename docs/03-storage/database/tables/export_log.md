# export_log

Tracks generated exports for auditing and temporary download access.

| Column | Type | Description |
| --- | --- | --- |
| id | uuid | Primary key |
| exported_by | text | User initiating export |
| export_type | text | csv, photos, or both |
| record_count | integer | Number of exported records |
| intake_ids | uuid[] | Exported intake records |
| created_at | timestamptz | Creation timestamp |
| expires_at | timestamptz | Download expiration |
| download_url | text | Temporary signed download URL |