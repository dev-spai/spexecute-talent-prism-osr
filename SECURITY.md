# Security Policy

Thank you for helping improve the security of Talent Prism.

The security of this project and its users is important. We appreciate responsible disclosure of potential vulnerabilities and security concerns.

---

# Supported Versions

Talent Prism is provided as a reference implementation.

Security fixes and updates will generally target the latest version available in the repository. Earlier versions may not receive security updates.

---

# Reporting a Security Vulnerability

If you discover a potential security vulnerability, **please do not disclose it publicly through GitHub Issues or Discussions.**

Instead, report the issue privately to the project maintainer with as much detail as possible, including:

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Proof of concept (if available)
- Suggested remediation (optional)

The project maintainer will acknowledge receipt of the report and investigate the issue.

---

# Responsible Disclosure

Please allow a reasonable amount of time for the vulnerability to be investigated and, where appropriate, resolved before publicly disclosing the issue.

Responsible disclosure helps protect users who may be evaluating or extending this reference implementation.

---

# Security Scope

Talent Prism demonstrates architectural patterns and implementation techniques for AI-assisted applicant evaluation.

It is **not** intended to be deployed to production without appropriate review and customization.

Organizations are responsible for implementing security controls appropriate for their environment.

These may include:

- Authentication
- Authorization
- Role-based access control (RBAC)
- Encryption
- Secrets management
- Infrastructure security
- Monitoring and logging
- Rate limiting
- Backup and disaster recovery
- Network security
- Compliance controls

---

# Third-Party Dependencies

Talent Prism relies on third-party software and cloud services as part of the reference implementation.

Examples include:

- n8n
- Cloudflare R2
- Cloudflare Workers
- Google Gemini
- Supabase
- Airtable

Organizations should:

- Monitor security advisories for these services.
- Keep dependencies up to date.
- Review vendor security documentation.
- Apply security patches promptly.

---

# Secrets and Credentials

Never commit:

- API keys
- Access tokens
- Passwords
- Private keys
- Cloud credentials
- Database connection strings
- Service account credentials
- Environment files containing secrets

Use environment variables or a secure secrets management solution appropriate for your deployment environment.

---
# Required Secrets & Credentials

If you implement or adapt the Talent Prism reference architecture, you will need credentials for the external services used throughout the workflows and supporting infrastructure.

| Service | Required |
|---------|:--------:|
| Google Gemini | ✅ |
| Supabase | ✅ |
| Cloudflare R2 | ✅ |
| Airtable | ✅ |
| Cloudflare Workers | ✅ |

These credentials are **not** included in this repository.

Depending on your deployment strategy, configure these credentials using one of the following methods:

- **n8n Credentials** (recommended for services supported by n8n)
- **Environment Variables** (`.env`)
- **Cloudflare Worker Secrets**
- **Supabase Project Settings**
- Your preferred secret management solution

> **Recommendation:** When using n8n, store API keys and service credentials using n8n's built-in **Credentials** system rather than hardcoding secrets inside workflows whenever possible.

> **Security:** Never commit API keys, Personal Access Tokens, service role keys, or other sensitive credentials to source control.

# Production Deployments

Before deploying Talent Prism in production, organizations should perform appropriate security reviews, including:

- Code review
- Dependency scanning
- Infrastructure assessment
- Penetration testing
- Security testing
- Configuration review
- Access control review

This repository should be considered a starting point rather than a production-ready deployment.

---

# AI Security

Organizations using AI models should independently evaluate:

- Prompt security
- Prompt injection risks
- Output validation
- Model limitations
- Data privacy
- Human oversight
- Fairness and bias considerations

AI-generated outputs should always be reviewed by humans before being used to support recruitment decisions.

---

# Security Best Practices

We encourage implementers to follow security best practices, including:

- Keep dependencies updated.
- Follow the principle of least privilege.
- Enable HTTPS for all communications.
- Encrypt sensitive data in transit and at rest.
- Store credentials securely.
- Monitor logs for suspicious activity.
- Validate and sanitize all user input.
- Regularly audit infrastructure and access permissions.

---

# Disclaimer

Talent Prism is provided as an open-source reference implementation.

While reasonable care has been taken during development, no software can be guaranteed to be free of vulnerabilities.

Dev Tripathy AI Systems makes no guarantees regarding the security of deployments based on this repository.

Organizations are responsible for evaluating, securing, and maintaining their own implementations.

---

Thank you for helping keep Talent Prism and its community secure.