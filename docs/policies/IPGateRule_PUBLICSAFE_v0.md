---
title: "IP Gate Rule (PUBLIC-SAFE) v0"
ipgate_version: "0"
utc_created: "20260205T142939Z"
utc_updated: "20260205T142939Z"
session_label: "4"
coclass: "PUBLIC_SAFE"
coid: "IPGATE-RULE-PUBLICSAFE-V0"
safe_summary: "Defines minimal frontmatter + public-allowed COCLASS + where enforcement hooks live. Safe to publish."
sources:
  - "https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBEACON_LATEST.txt"
tags: ["policy","ipgate","publicsafe","machine-checkable"]
---

# IP Gate Rule (PUBLIC-SAFE) v0

## Goal
Provide a tiny, machine-checkable public-safe gate that prevents accidental publication of sensitive material without revealing private taxonomies.

## Canon stance
- Any file intended to ship publicly MUST declare `coclass` in frontmatter.
- In public repos, only an allowlist of `coclass` values may ship.
- Anything not explicitly allowlisted is treated as NONPUBLIC (fail-closed).

## Frontmatter requirement (minimum)
For policy/spec/docs content under `docs/**` (excluding tool/vendor boilerplate), require YAML frontmatter with at least:
- coclass (string)
- coid (string, stable identifier)
- utc_created (string, YYYYMMDDTHHMMSSZ or __AUTO__Z)
- session_label (string)
- safe_summary (string)

Optional but recommended:
- utc_updated, sources[] (FULL URLs), tags[], ipgate_version

### Minimal example
---
coclass: "PUBLIC_SAFE"
coid: "EXAMPLE-THING-V0"
utc_created: "20260205T__AUTO__Z"
session_label: "4"
safe_summary: "One-line public-safe summary."
---

## COCLASS rules (public)
Public repos MUST accept only:
- PUBLIC
- PUBLIC_SAFE

Any other coclass value (including missing/blank) is NONPUBLIC and MUST FAIL the gate.

Note: This spec intentionally does not enumerate private classes.

## Scope rules (what is checked)
Checked (requires frontmatter):
- docs/**/*.md
- docs/**/*.txt

Exempt (no frontmatter required):
- LICENSE*, NOTICE*, CODEOWNERS
- .github/**
- **/*.png|jpg|jpeg|gif|webp|svg|ico
- **/*.zip|7z|gz|tar|pdf (see binary policy)

## Binary policy (public)
Binary files are allowed only if:
- They are in an explicit allowlisted path (recommended: docs/assets/**)
- They do not include private bundle markers, and
- CI scanning passes

## Enforcement hooks (where the gate lives)
1) Pre-commit: scan staged files; fail on missing/invalid frontmatter or non-allowlisted coclass.
2) CI: authoritative scan on PRs; required status check.
3) Write-gate: branch protection; no direct pushes to main; require CI pass.

## Machine-checking: reference algorithm (pseudo)
For each changed file:
- If path matches Checked:
  - Parse YAML frontmatter.
  - Require minimum keys.
  - Require coclass in allowlist.
- Else: skip.
Fail-closed on parse errors.

## Output contracts
On failure, output:
- file path
- reason (missing_frontmatter, missing_key, coclass_not_allowed, parse_error)
- suggested fix

## Versioning
v0 is minimal; expand only with CoPrime approval.