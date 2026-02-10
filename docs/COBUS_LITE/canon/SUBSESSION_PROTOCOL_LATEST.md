# Subsession Protocol (FAIL-CLOSED, artifacts-first) — LATEST

## Single prerequisite
Every newborn subsession MUST receive exactly one pinned RAW pointer-pack:
- COBEACON_RAW_PIN (commit-SHA RAW)

If missing/unreadable, reply with EXACTLY ONE line:
STATUS=blocked; MISSING_PINS=COBEACON_RAW_PIN; NEEDED_NEXT=Paste COBEACON_RAW_PIN

## After CoBeacon is readable
Subsession MUST output exactly ONE of:
A) ONE copy/paste-ready DO block that produces a durable artifact (preferred), OR
B) ONE-line fail-closed pins request:
STATUS=blocked; MISSING_PINS=[...]; NEEDED_NEXT=[exact pinned RAW URLs needed]

## Hard bans
- no prose plans
- no invented URLs/paths/branches
- no multi-block output
- no “draft spec” without pins evidence

## Definition
CoStall (alias CoFlatline): generic output caused by missing pins/rails, leading to fabrication instead of fail-closed progress.