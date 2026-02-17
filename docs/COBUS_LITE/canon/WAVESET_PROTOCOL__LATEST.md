# WAVESET_PROTOCOL__LATEST

* UTC: 20260217T053509Z

## Purpose
Run N lanes (default 24) in parallel with least user effort. No chat glue. Repo is the bus.

## Vocabulary (fixed)
- WaveSet: one parallel batch of lanes (default 24).
- Lane: one worker session labeled Sub1..Sub24.
- CoPrime: orchestrator + triage authority.
- CoBeacon: canonical bootstrap pointer list (FULL-URL only).
- PointerPack/Rollup: pinned machine inputs (commit-SHA RAW only).
- Bus Entry: per-lane state file in repo.
- Receipt: proof of execution (paths, hashes, PR).

## Non-negotiable rails
- Repo-first only.
- Follow ONLY commit-pinned RAW/UNC pins discovered from CoBeacon; do not guess paths.
- No raw.githubusercontent.com/.../main/ anywhere (machine surfaces must be deterministic).
- One task per lane per wave.
- Each lane must update its Bus Entry every wave.
- PASS requires PR + receipt + pins used.

## Canon bootstrap (always first)
RAW_COBEACON:
https://raw.githubusercontent.com/CoCivium/CoBusMirror/5dd6352cf3da72ec5dc0a3b23947a61a95648b7f/docs/COBEACON_LATEST.txt

## Repo surfaces
- Lane state (Bus Entry): docs/COBUS_LITE/bus/subsessions/SubX__LATEST.md
- Lane artifacts: docs/COBUS_LITE/subsessions/SubX/

## Bus Entry required fields
UTC:
SUB_ID:
INTENT:
DONE:
DOING:
NEXT:
PR_URL:
RECEIPTS:
RAW_PINS_USED:
PASS_FAIL:
BLOCKERS:

## Universal lane ignition prompt (paste into each lane; only change SUB_ID)

SUB_ID=Sub1   (change to Sub2..Sub24)

You are a CoCivium WaveSet lane.

MISSION:
Advance exactly ONE canon-defined task to a PR + receipt with zero chat coordination.

HARD RAILS:
- Repo-first only
- Discover from pinned surfaces only
- No guessing paths
- No /main RAW links (commit-SHA RAW only)
- Prefer PS7 automation
- Every wave updates lane bus-entry file

BOOTSTRAP:
Fetch CoBeacon RAW:
https://raw.githubusercontent.com/CoCivium/CoBusMirror/5dd6352cf3da72ec5dc0a3b23947a61a95648b7f/docs/COBEACON_LATEST.txt
Follow ONLY the FULL-URL pointers listed there.
If required pointer is missing, write BLOCKED bus-entry and STOP.

WHERE TO WRITE:
docs/COBUS_LITE/bus/subsessions/SUB_ID__LATEST.md
docs/COBUS_LITE/subsessions/SUB_ID/

WORKFLOW:
1) DISCOVERY: locate canon rails + gates + queues.
2) SELECT ONE TASK ONLY: prefer queued task; else publish minimal queue definition.
3) EXECUTE: branch we-SUB_ID__UTC; smallest advancing change; commit/push/PR; emit receipt.
4) PUBLISH STATE: update bus-entry with PR + receipt + pins used.
STOP after PASS or BLOCKED.

## CoPrime triage prompt (after WaveSet completes)
Read: docs/COBUS_LITE/bus/subsessions/
For each lane:
- Merge PASS lanes.
- Bounce FAIL lanes with exact fix.
- Promote new canon pins where appropriate.
- Update progress surfaces.
- Define next WaveSet queue.
