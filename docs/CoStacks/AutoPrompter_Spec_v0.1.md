# CoStacks AutoPrompter Spec v0.1
UTC: 20260203T194355Z

## Goal
Standardize the prompt you paste into sessions so they (a) don't guess paths, (b) ship one thing, (c) emit an entry payload with FULL-URL pointers.

## Canonical inputs (paste these RAW URLs)
- START_HERE (RAW): https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBUS_LITE/START_HERE.md
- BOSSBOARD (RAW):  https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBUS_LITE/BOSSBOARD.md
- PROTOCOL (RAW):   https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBUS_LITE/PROTOCOL_v1.md
- CoBeacon (RAW):   https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBEACON_LATEST.txt
- Registry (RAW):   https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/CoStacks/CoStacks_Registry_LATEST.md
- Gate-1 checklist: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/CoStacks/Gate1_Checklist_v0.1.md

## Required session output (NO essays)
1) A single 'EntryPayload' in CoBusLite schema (FROM/UTC/STATE/TOPIC + bullets + FULL-URL PTRS).
2) If STATE=done: include output pack URL + sha256 URL.
3) If blocked: STATE=rfa and list NEED (0–3 bullets).

## Policy
- Default STATE=hold unless you are assigned a BOSSBOARD item.
- Never post relative paths. Never guess private/vault paths.
