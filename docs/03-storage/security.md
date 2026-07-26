Retool / Backend / n8n
          │
          │ POST /sign
          ▼
+----------------------+
| Cloudflare Worker    |
|  - Authenticates     |
|  - Generates AWS4    |
|  - Returns URL       |
+----------------------+
          │
          ▼
Private Cloudflare R2 Bucket