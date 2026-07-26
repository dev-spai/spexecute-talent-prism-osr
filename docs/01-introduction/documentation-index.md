# Documentation Index

The documentation is organized to guide readers from understanding the business problem through the technical implementation of the reference architecture.

If you are new to Talent Prism, we recommend reading the documentation in the order below.

| Document | Description |
| --- | --- |
| **README.md** | Repository overview, architecture summary, business value, and navigation guide. |
| **Why Talent Prism** | Explains the industry challenges Talent Prism addresses, the business value it provides, and the philosophy behind the project. |
| **Repository Overview** | Introduces the repository structure and explains how each component fits into the overall architecture. |
| **Architecture Overview** | High-level overview of the applicant processing pipeline and system architecture. |
| **Configuration** | Explains how organizations customize prompts, thresholds, categories, markets, and other behavior without modifying workflows. |
| **Workflow Automation** | Documents the applicant intake, validation, AI evaluation, and maintenance workflows implemented in n8n. |
| **Cloudflare R2 Storage** | Describes media storage architecture, bucket organization, security, and signed URL strategy. |
| **Cloudflare Worker** | Documents the signed URL generation service, deployment, configuration, and testing. |
| **Frontend Integration** | Shows how Talent Prism integrates with existing websites, forms, and talent management systems. |
| **Frontend Reference** | Production UI mockups demonstrating one possible implementation of the platform. |
| **Technology Stack** | Explains the technologies used in the reference implementation and suitable alternatives. |
| **Reference Implementation Scope** | Defines what is included, what is intentionally excluded, and where organizations are expected to extend the platform. |

---

## Recommended Reading Order

### Business & Product

1. Why Talent Prism
2. Repository Overview
3. Architecture Overview
4. Reference Implementation Scope

---

### Technical Implementation

1. Configuration
2. Workflow Automation
3. Cloudflare R2 Storage
4. Cloudflare Worker

---

### Integration & Extension

1. Frontend Integration
2. Frontend Reference
3. Technology Stack

---

## Intended Audience

| Role | Recommended Sections |
| --- | --- |
| Agency Owners & Founders | Why Talent Prism, Business Value, ROI, Frontend Reference |
| Product Managers | Architecture Overview, Frontend Integration, Configuration |
| Solution Architects | Repository Overview, Architecture, Workflow Automation |
| Software Developers | Workflow Automation, Storage, Cloudflare Worker, Technology Stack |
| Implementation Partners | Read the complete documentation from start to finish |