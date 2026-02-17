# PASS_SCHEMA__LATEST

* UTC: 20260217T054031Z

A lane is PASS only if ALL are present:
- PR_URL is a valid PR link
- RECEIPTS contains a file:// or RAW link with hashes
- RAW_PINS_USED lists commit-pinned RAW/UNC (no /main)
- Bus entry PASS_FAIL=PASS
