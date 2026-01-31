# CoBusLite Protocol v1
Goal: remove humans as the router; keep CoStacks MVP moving.

## Canonical inputs
- BOSSBOARD: docs/COBUS_LITE/BOSSBOARD.md
- Rollcall directory: docs/COBUS_LITE/rollcall/
- Latest rollcall pointer: docs/COBUS_LITE/rollcall/ROLLCALL_LATEST.md

## Canonical output (per wave)
Create a NEW file (no append):
docs/COBUS_LITE/entries/YYYY/MM/DD/UTC__SESSIONID.md

## Entry schema (minimal)
FROM: <session label>
UTC: <yyyymmddThhmmssZ>
STATE: done|doing|hold|rfa
TOPIC: <1 line>
SHIPPED: <0-3 bullets>
BLOCKED: <0-3 bullets>
NEXT: <0-3 bullets>
PTRS: <commit-SHA RAW URLs + sha256 receipts>

Rules:
- One deliverable per wave.
- No SideNotes. No essays.
- If it doesn't move CoStacks MVP, STATE=hold.