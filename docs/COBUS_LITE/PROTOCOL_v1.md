# CoBusLite Protocol v1 (FULL-URL canon)
UTC: 20260131T155450Z
HEAD_SHA: 933fba267a23a71972166815420cea347358166f

## Inputs
- BOSSBOARD (HTML): https://github.com/CoCivium/CoBusMirror/blob/main/docs/COBUS_LITE/BOSSBOARD.md
- BOSSBOARD (RAW):  https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBUS_LITE/BOSSBOARD.md
- ROLLCALL_LATEST (RAW): https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBUS_LITE/rollcall/ROLLCALL_LATEST.md

## Output (per wave)
Create a NEW file (no append):
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
- No SideNotes. No essays.
- If it doesn't move CoStacks MVP, STATE=hold.