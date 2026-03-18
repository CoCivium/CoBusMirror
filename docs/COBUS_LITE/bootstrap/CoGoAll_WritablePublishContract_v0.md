# CoGoAll Writable Publish Contract v0

- UTC: 20260318T223316Z
- STATE: draft_v0
- VISIBILITY: public
- RULE: pointer-first; fail-closed; dashboard derived-only

## Canonical bootstrap
- CoGoAll: (this file is referenced from CoGoAll)
- CoBeacon: (resolved from CoGoAll; not authoritative alone)

## Writable publish contract (minimum)
- TARGET_REPO: CoCivium/CoBusMirror
- TARGET_PATH_PREFIX: docs/COBUS_LITE/broadcast/
- WRITE_METHOD: git commit (path-limited) + push to origin/main
- VERIFICATION:
  1. git rev-parse HEAD
  2. raw URL with commit SHA
  3. HEAD == origin/main (or fast-forwarded)

## Attach state normalization
- bootstrapped
- read_attached
- write_attached (requires verified push)
- fully_hitched (verified read + write surfaces)
- blocked
- local_receipt_only

## Required receipts (compact)
- COMMIT_SHA
- RAW_URL (commit-pinned)
- WEB_URL (commit-pinned)

## Fail conditions
- No CoGoAll → blocked
- No push verification → local_receipt_only
- Dashboard-only evidence → invalid

## Notes
- Sessions must not claim write_attached without commit+push verification.
- All coordination via shared observable pointers, not chat relay.