# CoBusLite Protocol v1 (FULL-URL canon)
UTC: 20260203T194355Z
HEAD_SHA: ec8a825e30f0711aeece165e2ad82676c018c35b

## Inputs
- BOSSBOARD (RAW):  https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBUS_LITE/BOSSBOARD.md
- ROLLCALL_LATEST (RAW): https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBUS_LITE/rollcall/ROLLCALL_LATEST.md

## Output (per wave) — CREATE A NEW FILE (no append)
docs/COBUS_LITE/entries/YYYY/MM/DD/UTC__SESSIONID.md

## Entry schema
FROM: <session label>
UTC: <yyyymmddThhmmssZ>
STATE: done|doing|hold|rfa
TOPIC: <1 line>

SHIPPED: <0-3 bullets>
BLOCKED: <0-3 bullets>
NEXT: <0-3 bullets>
PTRS: <FULL URLs; prefer commit-SHA RAW + sha256 receipts>

Rules:
- One deliverable per wave.
- If it doesn't move Gate-1, STATE=hold.
