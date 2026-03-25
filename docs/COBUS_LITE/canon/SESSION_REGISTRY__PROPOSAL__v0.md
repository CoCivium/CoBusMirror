# SESSION_REGISTRY__PROPOSAL__v0

## Intent
Create a minimal, always-fresh coordination surface so sessions can avoid duplicate work and safely operate in parallel.

## Problem
Current CoBus surfaces (Broadcast, Rollup) are stale and do not provide real-time visibility into active sessions.

## Proposal
Each active session MUST write a single EntryPayload per wave to:

/docs/COBUS_LITE/entries/YYYY-MM-DD/

A lightweight aggregator (script or manual pass) produces:

/docs/COBUS_LITE/canon/SESSION_REGISTRY__LATEST.md

## SESSION_REGISTRY__LATEST format

UTC:

DOING:
- session_label | topic | last_update

HOLD:
- session_label | blocked_reason

BLOCKED:
- session_label | reason

## Rules
- Max DOING sessions: 4 (Gate-1)
- Others default HOLD
- Stale threshold: 30 minutes (or configurable)
- Missing update => auto-demote to HOLD

## Minimal Algorithm
1. Read latest entries folder
2. Parse EntryPayload blocks
3. Keep latest per session label
4. Classify by STATE
5. Emit registry file

## Outcome
- Sessions can check registry before acting
- Duplicate work minimized
- Parallelism becomes safe and bounded

## Status
PROPOSED
