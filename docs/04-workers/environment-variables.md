# Configuration

The Cloudflare Worker requires the following environment variables:

| Variable | Description |
| --- | --- |
| SPX_AUTH_TOKEN | Authentication token used to authorize requests |
| R2_ACCESS_KEY_ID | Cloudflare R2 Access Key |
| R2_SECRET_ACCESS_KEY | Cloudflare R2 Secret Access Key |
| R2_ACCOUNT_ID | Your Cloudflare Account ID |
| R2_BUCKET_NAME | The name of the R2 bucket |

These values can be configured through the Cloudflare Workers dashboard under **Settings → Variables and Secrets**, or through Wrangler if you deploy the Worker using the Cloudflare CLI.