# HANDOFF_PROTOCOL__LATEST

* UTC: 20260217T054031Z

## Goal
Make subsessions disposable. No chat glue. All state moves through repo bus entries + receipts.

## Lane termination rules
- A lane MUST stop after it sets PASS or BLOCKED in its bus entry.
- A lane MUST include PR_URL + RECEIPTS + RAW_PINS_USED (commit-pinned RAW/UNC only).
- A lane MUST NOT claim completion without receipt+PR.

## CoPrime intake / triage
For each Sub1..Sub24 bus entry:
- PASS: merge PR (or queue for merge), update progress surfaces, mark DONE.
- FAIL: bounce using LANE_BOUNCE_TEMPLATE__LATEST.md with exact error + minimal fix.
- BLOCKED: create a canon queue item to unblock (usually missing pins).

## Handoff artifact locations (fixed)
- Lane state: docs/COBUS_LITE/bus/subsessions/SubX__LATEST.md
- Lane artifacts: docs/COBUS_LITE/subsessions/SubX/
- CoPrime queues: docs/COBUS_LITE/canon/WAVESET_QUEUE__LATEST.yml

## Definition of 'least user effort'
User starts lanes and pastes the kickoff line. Everything else is repo-mediated automation.
