# Release Policy

## Versioning

Talent Prism follows **Semantic Versioning (SemVer)**.

Version numbers follow the format:

MAJOR.MINOR.PATCH

Example:

1.4.2

---

## Major Releases

A major release includes breaking changes such as:

- Workflow redesigns
- Configuration schema changes
- Database schema changes
- API contract changes
- Architectural changes

Example:

1.x.x → 2.0.0

---

## Minor Releases

Minor releases introduce new functionality while maintaining backward compatibility.

Examples include:

- New workflow examples
- Additional integrations
- New documentation
- New configuration options
- Additional frontend references

Example:

1.2.0 → 1.3.0

---

## Patch Releases

Patch releases contain:

- Bug fixes
- Documentation improvements
- Performance improvements
- Security fixes
- Minor workflow corrections

Example:

1.2.1 → 1.2.2

---

# Backward Compatibility

Reasonable effort will be made to maintain backward compatibility within the same major version.

Breaking changes will be documented in release notes whenever practical.

---

# Release Cadence

Talent Prism does not follow a fixed release schedule.

Releases are published when meaningful improvements are ready.

---

# Deprecation

Features may be deprecated before removal.

When practical, documentation will identify deprecated components and recommend migration paths.

---

# Documentation

Major architectural changes will be accompanied by updates to:

- Repository documentation
- Workflow documentation
- Architecture diagrams
- Configuration documentation

---

# Changelog

Significant changes are documented through GitHub Releases and the project changelog (if maintained).

Users are encouraged to review release notes before upgrading.