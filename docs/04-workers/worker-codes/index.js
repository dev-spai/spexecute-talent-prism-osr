/**
 * SPeXecute R2 Signer - Cloudflare Worker
 *
 * Generates AWS Signature Version 4 (AWS4) presigned GET URLs
 * for private Cloudflare R2 objects. THIS IS THE MAIN CODE
 *
 * Required Environment Variables:
 * - SPX_AUTH_TOKEN
 * - R2_ACCESS_KEY_ID
 * - R2_SECRET_ACCESS_KEY
 * - R2_ACCOUNT_ID
 * - R2_BUCKET_NAME
 */

export default {
  async fetch(request, env) {

    // ------------------------------------------------------------------
    // Validate Environment Configuration
    // ------------------------------------------------------------------

    const REQUIRED_ENV = [
      "SPX_AUTH_TOKEN",
      "R2_ACCESS_KEY_ID",
      "R2_SECRET_ACCESS_KEY",
      "R2_ACCOUNT_ID",
      "R2_BUCKET_NAME"
    ];

    for (const variable of REQUIRED_ENV) {
      if (!env[variable]) {
        return new Response(
          JSON.stringify({
            error: `Missing environment variable: ${variable}`
          }),
          {
            status: 500,
            headers: {
              "Content-Type": "application/json"
            }
          }
        );
      }
    }

    // ------------------------------------------------------------------
    // Allow POST only
    // ------------------------------------------------------------------

    if (request.method !== "POST") {
      return new Response(
        JSON.stringify({
          error: "Method not allowed. Use POST."
        }),
        {
          status: 405,
          headers: {
            "Content-Type": "application/json"
          }
        }
      );
    }

    // ------------------------------------------------------------------
    // Authenticate Request
    // ------------------------------------------------------------------

    const token = request.headers.get("X-SPX-Token");

    if (!token || token !== env.SPX_AUTH_TOKEN) {
      return new Response(
        JSON.stringify({
          error: "Unauthorized"
        }),
        {
          status: 401,
          headers: {
            "Content-Type": "application/json"
          }
        }
      );
    }

    try {

      // --------------------------------------------------------------
      // Parse Request
      // --------------------------------------------------------------

      const {
        r2_object_key,
        expiry_seconds = 604800
      } = await request.json();

      if (!r2_object_key || typeof r2_object_key !== "string") {
        throw new Error("Missing or invalid r2_object_key.");
      }

      // --------------------------------------------------------------
      // Expiry Validation
      // --------------------------------------------------------------

      const ALLOWED_EXPIRIES = [
        604800,   // 7 Days
        1209600   // 14 Days
      ];

      const EXPIRY = ALLOWED_EXPIRIES.includes(Number(expiry_seconds))
        ? Number(expiry_seconds)
        : 604800;

      // --------------------------------------------------------------
      // Environment Variables
      // --------------------------------------------------------------

      const ACCESS_KEY_ID = env.R2_ACCESS_KEY_ID;
      const SECRET_ACCESS_KEY = env.R2_SECRET_ACCESS_KEY;
      const ACCOUNT_ID = env.R2_ACCOUNT_ID;
      const BUCKET = env.R2_BUCKET_NAME;
      const REGION = "auto";

      // --------------------------------------------------------------
      // Build URL
      // --------------------------------------------------------------

      const host = `${ACCOUNT_ID}.r2.cloudflarestorage.com`;

      const url = new URL(
        `https://${host}/${BUCKET}/${strictUriEncode(r2_object_key)}`
      );

      const now = new Date();

      const amzDate = now
        .toISOString()
        .replace(/[:-]|\.\d{3}/g, "");

      const dateStamp = amzDate.slice(0, 8);

      const credentialScope =
        `${dateStamp}/${REGION}/s3/aws4_request`;

      const queryParams = {
        "X-Amz-Algorithm": "AWS4-HMAC-SHA256",
        "X-Amz-Credential": `${ACCESS_KEY_ID}/${credentialScope}`,
        "X-Amz-Date": amzDate,
        "X-Amz-Expires": EXPIRY.toString(),
        "X-Amz-SignedHeaders": "host",
      };

      for (const [key, value] of Object.entries(queryParams)) {
        url.searchParams.set(key, value);
      }

      url.searchParams.sort();

      // --------------------------------------------------------------
      // AWS4 Signature
      // --------------------------------------------------------------

      const canonicalRequest = [
        "GET",
        url.pathname,
        url.searchParams.toString(),
        `host:${host}\n`,
        "host",
        "UNSIGNED-PAYLOAD",
      ].join("\n");

      const stringToSign = [
        "AWS4-HMAC-SHA256",
        amzDate,
        credentialScope,
        await hashHex(canonicalRequest),
      ].join("\n");

      const signingKey = await getSigningKey(
        SECRET_ACCESS_KEY,
        dateStamp,
        REGION,
        "s3"
      );

      const signature = await hmacHex(
        signingKey,
        stringToSign
      );

      url.searchParams.set(
        "X-Amz-Signature",
        signature
      );

      // --------------------------------------------------------------
      // Success Response
      // --------------------------------------------------------------

      return new Response(
        JSON.stringify({
          retool_signed_url: url.toString(),
          retool_url_expires_at: new Date(
            now.getTime() + EXPIRY * 1000
          ).toISOString()
        }),
        {
          status: 200,
          headers: {
            "Content-Type": "application/json",
            "Cache-Control": "no-store"
          }
        }
      );

    } catch (err) {

      return new Response(
        JSON.stringify({
          error: err.message
        }),
        {
          status: 400,
          headers: {
            "Content-Type": "application/json"
          }
        }
      );

    }
  }
};

// ------------------------------------------------------------------
// Helpers
// ------------------------------------------------------------------

function strictUriEncode(str) {
  return str
    .split("/")
    .map(segment =>
      encodeURIComponent(segment).replace(
        /[!'()*]/g,
        c => "%" + c.charCodeAt(0).toString(16).toUpperCase()
      )
    )
    .join("/");
}

async function hashHex(str) {
  const bytes = new TextEncoder().encode(str);

  const hash = await crypto.subtle.digest(
    "SHA-256",
    bytes
  );

  return Array.from(new Uint8Array(hash))
    .map(b => b.toString(16).padStart(2, "0"))
    .join("");
}

async function hmac(key, data) {
  const cryptoKey = await crypto.subtle.importKey(
    "raw",
    key,
    {
      name: "HMAC",
      hash: "SHA-256"
    },
    false,
    ["sign"]
  );

  return crypto.subtle.sign(
    "HMAC",
    cryptoKey,
    new TextEncoder().encode(data)
  );
}

async function hmacHex(key, data) {
  const signature = await hmac(key, data);

  return Array.from(new Uint8Array(signature))
    .map(b => b.toString(16).padStart(2, "0"))
    .join("");
}

async function getSigningKey(secret, date, region, service) {
  const kDate = await hmac(
    new TextEncoder().encode("AWS4" + secret),
    date
  );

  const kRegion = await hmac(kDate, region);
  const kService = await hmac(kRegion, service);

  return hmac(kService, "aws4_request");
}