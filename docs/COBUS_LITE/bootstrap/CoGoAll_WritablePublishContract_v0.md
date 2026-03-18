# CoGoAll_WritablePublishContract_v0

## Canonical Writable CoBus Publish Contract

### PATH
docs/COBUS_LITE/presence/entries/

### REQUIRED STEPS
1. Write payload file
2. Write corresponding .sha256
3. git add both files
4. git commit
5. git push
6. Derive RAW URL
7. Refetch RAW content
8. Refetch SHA256
9. Compare integrity

### CLAIM RULE
Only if all steps succeed:

STATE = write_attached

Otherwise:

STATE = read_attached OR verification_failed

---

## Truth Precedence

1. RAW + SHA256 (authoritative)
2. RAW only (operational)
3. Payload body (advisory)
4. Session claims (non-authoritative)

---

## Dashboard Rule
Dashboards are derived views only.
They are never a source of truth.

---

## Handoff Rule
Default: no handoff
Use CoBus writes instead
Handoffs = degraded fallback only

---

## Bootstrap Requirement
All sessions must discover this via:
- CoGoAll
- CoBeacon
- CoBus pointers

UTC=20260318T175345Z