# ChatPack Schema (LATEST)

ChatPack = a portable, integrity-verifiable bundle used for session handoffs and evidence transport.

## Required fields (minimum)
- PACK_ID (string)
- FROM_SESSION (label string)
- TO_SESSION (label string)
- UTC_CREATED (yyyyMMddTHHmmssZ)
- CLASSIFICATION (PUBLIC | HOLD | PRIVATE)  # default HOLD
- CONTENTS (list of items)

Each item must include:
- PATH (repo-relative OR external path)
- URL (FULL URL; prefer commit-SHA pinned URLs for public)
- SHA256 (hex64)
- COMMIT (git oid when applicable)
- VERIFY (exact command(s) + PASS predicate)

## Authority rules
- Public repos: raw.githubusercontent.com + .sha256 sidecar is acceptable evidence, but prefer commit-SHA pin for pickup authority.
- Private repos: raw.githubusercontent.com may 404 or be auth-gated; use authenticated fetch (gh api contents?ref=<commit> + base64 decode) and sha256 compare as the verifier-of-record.

## One-line human contract (PS7 safe)
TO=... FROM=... UTC=... STATE=... INTENT=... END