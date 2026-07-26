The R2 Signer Worker is a lightweight Cloudflare Worker responsible for generating **AWS Signature Version 4 (AWS4)** presigned URLs for objects stored in a private Cloudflare R2 bucket.

Instead of making your bucket public, internal services request a temporary signed URL from this Worker whenever they need to access an object.

The generated URLs automatically expire after a configurable period, providing secure, time-limited access to applicant media.

---

# Features

- Generates secure AWS4 presigned GET URLs
- Supports private Cloudflare R2 buckets
- Token-based authentication
- Configurable URL expiration
- No public object access required
- Lightweight and serverless

---

# Prerequisites

Before deploying this Worker, ensure you have:

- A Cloudflare account
- A Cloudflare R2 bucket
- An R2 API Token (Access Key + Secret)
- Permission to create Cloudflare Workers

---

# Repository Structure

```
workers/
└── r2-signer/
    ├── index.js
    ├── package.json
    ├── wrangler.toml
    └── README.md
```

---

# Deployment Options

The Worker can be deployed using either:

1. Cloudflare Dashboard (Recommended)
2. Wrangler CLI

Both methods produce the same Worker.

---

# Option 1 — Deploy Using the Cloudflare Dashboard

## Step 1

Log in to your Cloudflare Dashboard.

Navigate to:

```
Workers & Pages
```

---

## Step 2

Click

```
Create Worker
```

Choose a name such as:

```
r2-signer
```

---

## Step 3

Replace the default Worker code with the contents of:

```
index.js
```

Save the changes.

---

## Step 4

Open

```
Settings
```

Then

```
Variables and Secrets
```

Create the following variables.

### Secrets

| Name | Description |
| --- | --- |
| SPX_AUTH_TOKEN | Secret token used to authenticate incoming requests |
| R2_ACCESS_KEY_ID | Cloudflare R2 Access Key |
| R2_SECRET_ACCESS_KEY | Cloudflare R2 Secret Access Key |

### Variables

| Name | Description |
| --- | --- |
| R2_ACCOUNT_ID | Your Cloudflare Account ID |
| R2_BUCKET_NAME | Name of the R2 bucket |

---

## Step 5

Deploy the Worker.

Cloudflare automatically publishes the Worker.

Your endpoint will look similar to:

```
<https://your-worker.workers.dev/sign>
```

---

# Option 2 — Deploy Using Wrangler

Install project dependencies.

```bash
npm install
```

Authenticate Wrangler.

```bash
npx wrangler login
```

Configure the required secrets.

```bash
npx wrangler secret put SPX_AUTH_TOKEN
```

```bash
npx wrangler secret put R2_ACCESS_KEY_ID
```

```bash
npx wrangler secret put R2_SECRET_ACCESS_KEY
```

Update the variables in

```
wrangler.toml
```

```toml
[vars]
R2_ACCOUNT_ID="your-account-id"
R2_BUCKET_NAME="your-bucket-name"
```

Deploy.

```bash
npm run deploy
```

---

# Required Environment Variables

| Variable | Required | Description |
| --- | --- | --- |
| SPX_AUTH_TOKEN | Yes | Authentication token required for every request |
| R2_ACCESS_KEY_ID | Yes | Cloudflare R2 Access Key |
| R2_SECRET_ACCESS_KEY | Yes | Cloudflare R2 Secret Access Key |
| R2_ACCOUNT_ID | Yes | Cloudflare Account ID |
| R2_BUCKET_NAME | Yes | Name of the R2 bucket |

---

# Security Recommendations

For production deployments:

- Keep the R2 bucket private.
- Never expose API keys in client-side applications.
- Store sensitive values as Cloudflare Secrets.
- Rotate credentials periodically.
- Only trusted backend services should communicate with the Worker.

---

# Request Flow

```
Application
      │
      ▼
POST /sign
      │
      ▼
Worker validates X-SPX-Token
      │
      ▼
Worker generates AWS4 signature
      │
      ▼
Temporary signed URL returned
      │
      ▼
Authorized application retrieves object
```

---

# Request Example

Headers

```
X-SPX-Token: your-secret-token
```

Body

```json
{
    "r2_object_key":"agency/intake/application/headshot.jpg",
    "expiry_seconds":604800
}
```

---

# Response Example

```json
{
    "retool_signed_url":"https://...",
    "retool_url_expires_at":"2026-08-01T18:42:19.000Z"
}
```

---

# Supported Expiration Values

The Worker currently supports:

| Seconds | Duration |
| --- | --- |
| 604800 | 7 Days |
| 1209600 | 14 Days |

Any other value defaults to **7 days**.

---

# Troubleshooting

## 401 Unauthorized

The supplied `X-SPX-Token` does not match the configured `SPX_AUTH_TOKEN`.

---

## 400 Bad Request

The request body is invalid or `r2_object_key` is missing.

---

## 405 Method Not Allowed

The endpoint only accepts `POST` requests.

---

## 500 Internal Server Error

One or more required environment variables have not been configured.

---

# Notes

This Worker is intentionally lightweight and performs a single responsibility: generating secure, time-limited download URLs for private Cloudflare R2 objects.

It does not implement object-level authorization. If your deployment requires organization-, user-, or role-based access control, perform those authorization checks before calling the Worker.

This Worker is provided as the reference implementation used by Talent Prism and can be adapted to meet your organization's security and infrastructure requirements.