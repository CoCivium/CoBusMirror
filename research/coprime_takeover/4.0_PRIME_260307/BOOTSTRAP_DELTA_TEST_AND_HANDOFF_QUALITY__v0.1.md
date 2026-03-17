# BOOTSTRAP_DELTA_TEST_AND_HANDOFF_QUALITY__v0.1

UTC_CREATED: 20260307T001345Z
SESSION_LABEL: 4.0|PRIME|260307
STATUS: draft-local

## Purpose
- Define a measurable protocol for comparing fresh-session repo-only bootstrap against assisted bootstrap.
- Define a first-pass handoff quality scoring model.
- Reduce the gap between narrative claims and independently recoverable repo truth.

## Core premise
- Sessions are mortal caches.
- Chat memory is salvage, not foundation.
- Repo artifacts, pointers, receipts, and recovery coordinates are the foundation.

## Definitions
- Bootstrap Delta: the difference between what a fresh CoPrime can infer from repo/pointers alone and what still requires SideNotes/chat relay/manual reconstruction.
- Handoff Quality: a score describing how recoverable a session's claimed outputs are by a fresh session.
- Recovery Coordinates: minimum data needed for independent artifact recovery.

## Required recovery coordinates
1. full address path
2. exact repo name
3. exact branch or commit SHA
4. exact repo-relative path
5. landed state
6. pointer / receipt when applicable

## Bootstrap Delta Test
### Test A - Repo/Pins Only
- Inputs allowed: CoBeacon, Broadcast, Registry, PointerPack, bootstrap rollups, canon scope files, bookmarks if already canonicalized.
- Inputs forbidden: chat memory, manual verbal explanations, unstated assumptions, guessed paths.
- Record:
  - time-to-first-accurate-model
  - count of artifacts fetched
  - count of pointers followed
  - count of repos/clones inspected
  - number of unresolved ambiguities

### Test B - Assisted Bootstrap
- Inputs allowed: all Test A inputs plus structured handoff packets / SideNotes / worker returns.
- Record same metrics as Test A.

### Delta outputs
- BootstrapInferenceCost
- PointerCount
- ArtifactFetchCount
- AmbiguityCount
- HumanRelayCount
- TimeToOperationalAwareness

## Handoff Quality Scoring (v0.1)
### Score bands
- HQ0 = narrative only; no recovery coordinates
- HQ1 = partial coordinates; recovery uncertain
- HQ2 = exact path or exact ref but incomplete receipts/pointers
- HQ3 = recoverable with repo/ref/path and partial receipt evidence
- HQ4 = independently recoverable with full coordinates and receipts
- HQ5 = independently recoverable and bootstrap-discoverable by fresh session without manual relay

### Downgrade rules
- Any claimed asset not found in repo truth or git history is noncanonical/recreatable until independently verified.
- Relative path alone is insufficient.
- Local-only or chat-derived assets without exact ref/path are below HQ2.

## Missing-canon detection
- A claim should be flagged when narrative mentions an asset but repo truth lacks path/ref/receipt evidence.
- A handoff should emit a missing-canon list explicitly.

## Typed object lifecycle rail
- INBOX -> ROUTING -> EXECUTION/ARCHIVE -> RECEIPT -> QUARANTINE/REPAIR
- Objects should move through typed stages rather than remain in chat-only narrative form.

## CoAudit role (proposed)
- compare receipts vs narrative
- score handoff quality
- detect missing canon
- recommend recovery path
- recommend downgrade to noncanonical/recreatable when evidence is absent

## Current session evidence motivating this spec
- Fresh bootstrap in this session succeeded partially via CoBeacon, Broadcast, Registry, control-plane docs, bookmarks, and local clone discovery.
- Multiple claimed assets from 260304 were later explicitly downgraded to noncanonical/recreatable because repo substantiation was unavailable.
- Workflows provided stronger repo-facing externalization and clearer pointer-backed research artifacts.

## Success criteria for future CoPrime sessions
- A fresh CoPrime should reconstruct an accurate operating model from a small bootstrap bundle.
- Manual CoPong relay should trend toward zero.
- Claimed outputs should default to HQ4+ or be explicitly downgraded.

## Coordinates
- REPO_NAME: CoBusMirror
- REPO_LOCAL_ROOT: C:\Users\rball\Documents\GitHub\CoBusMirror
- REPO_REL_PATH: research\coprime_takeover\4.0_PRIME_260307\BOOTSTRAP_DELTA_TEST_AND_HANDOFF_QUALITY__v0.1.md
- LOCAL_FULL_PATH: C:\Users\rball\Documents\GitHub\CoBusMirror\research\coprime_takeover\4.0_PRIME_260307\BOOTSTRAP_DELTA_TEST_AND_HANDOFF_QUALITY__v0.1.md

## Status note
- This spec is repo-local and commit-ready.
- It is not remote-canonical until committed/pushed and discoverable by pointer.
