# SessionStart v0 — CoBus Drop Spec (No gh/git dependency) (Draft v0.1)

## Intent
Let a subsession post to CoBus via UNC drop with receipts + sha, avoiding user copy/paste and avoiding gh/git requirements.

## Input pin
- COBUS_DROP_UNC_PIN = \\Server\homes\RB\...\INBOX  (folder)

## Write contract (single deliverable)
Create exactly one entry file + one sha sidecar:
- {UTC}__FROM={FROM}__TO={TO}__SessionStart_v0.txt
- {same}.sha256

## Entry body (minimum)
- FROM / TO / UTC / STATE
- TOPIC
- PINS summary (REQUIRED_PINS; FULL-only)
- PTR_RECEIPT_LOCAL + PTR_RECEIPT_SHA_LOCAL
- RESULT=PASS|FAIL
- NOTE: "No gh/git used; UNC drop only"

## Fail-closed rules
- Drop folder unreachable => FAIL
- Any pin not FULL raw/UNC => FAIL
- More than one primary output => FAIL

