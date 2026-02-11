# COSHARE_PINS_TEMPLATE_v0
> Purpose: single authoritative pin set for CoShare migration. FULL URL / UNC only. No local paths.

## Required pins (fill in)
- CANON_COSHARE_ROOT_UNC = <UNC ROOT HERE>
- CANON_QUARANTINE_BASE_UNC = <UNC ROOT HERE>
- HOLD_UNTIL_YYYYMMDD = <YYYYMMDD or 'until cleared by CoPrime'>
- PASS_CRITERIA = HASH_ONLY | HASH_PLUS_PROVENANCE | HASH_PLUS_REDACTED_RELATIVE_PATH (choose one)

## Recommended defaults
- PASS_CRITERIA: HASH_ONLY
- Provenance fields to always capture (even with HASH_ONLY):
  - origin_repo (git remote URL)
  - origin_commit_sha
  - sha256
  - created_utc
  - actor/session label

## Notes
- Treat this file as canon: update via PR only.
- If a pin changes, also add a short change note to the broadcast or a CoBusLite entry.
