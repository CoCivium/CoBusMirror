# CoCarryDrain Spec v0.1
UTC_CREATED: 20260303T165859Z

## Purpose
- Define a deterministic, fail-closed workflow that drains session-only knowledge (**CoCarry**) into CoSource (repo) with receipts, so sessions can terminate safely.

## Definitions
- **CoCarry**: Any valuable state living outside CoSource (chat-only text, local files, sandbox artifacts, unpushed branches).
- **CoCarryDrain**: A repeatable procedure producing a recoverable handoff set: (1) drain record, (2) raw capture, (3) ledger row(s), (4) optional artifact pack, (5) receipts (hashes, commit SHA, pointers).
- **Handoff** (best-practice meaning): Recoverable state transfer, not a summary. Must include: verified done, remaining, assumptions, risks, reproduction steps, and where receipts/pointers live.

## Session status semantics
- **.dead**: No durable CoSource record exists; the only copy is chat/local/sandbox. Session death implies loss.
- **.liveYYYYMMDD.<Session>**: A durable CoSource drain record exists (ledger + capture + entry + commit SHA). Session can be safely closed even if persistence class is CHAT_ONLY.
- **.cosourcedYYYYMMDD.<Session>** (optional stronger label): Publish-required artifacts are committed/pushed and pinned via commit-SHA RAW pointers; ledger references them with sha256 receipts.

## Persistence classes (Q_PERSISTENCE_CLASS)
- **CHAT_ONLY**: Drained record exists, but no artifact pack / no additional repo material beyond the drain record.
- **MIXED**: Some artifacts exist (local/sandbox) but publish is still required for full recovery.
- **COSOURCED**: All required artifacts are committed and pinned; reproduction does not require the chat.
- **LOCAL_ONLY**: Files exist only on a machine path; unacceptable for termination unless explicitly allowed.

## Receipts tiers
- **STRUCTURAL**: Schema/fields present; no hash verification of dependencies.
- **HASH_ONLY**: sha256 receipts verified for shipped artifacts + captures + ledger/entry.
- **EXECUTION**: Deterministic scripts ran; outputs match receipts; commit SHA recorded.
- **SEMANTIC**: Work advances the current Gate/DoD (e.g., CoStacks Gate-1) and is verifiably accepted by the owning lane.

## Gates / rules (binding)
- **Publish slow**: do not relabel to .cosourced until required artifacts are committed/pushed and pinned.
- **Stop rule**: if a session is not advancing the current top objective (e.g., CoStacks Gate-1), it must go STATE=hold but still emit a drain record or minimal entry.
- **Fail-closed**: missing pointers/receipts or missing identity must stop mutations.
- **One-entry-per-wave** on CoBusLite when BROADCAST demands EntryPayload-only: comply; SideNotes go into captures/ledger notes instead.

## Minimal drain deliverables per session
- A one-line drain block (WF_DRAIN) captured verbatim.
- Raw capture file stored under docs/inbox/workflows/captures/ with sha256.
- Ledger append row(s) referencing capture sha256 and recommended action.
- A CoBusLite entry file pointing to the ledger and capture (and to any published artifacts).

## Recommended operational flow
1) Collect drain replies (WF_DRAIN v2 blocks) from sessions.
2) Ingest (clipboard or folder) -> capture raw -> parse -> append ledger -> write entry -> commit/push.
3) For sessions with R_PUBLISH_REQUIRED=Y, publish their artifacts (pack + sha + pointers) and append a follow-up ledger row upgrading them to COSOURCED.
4) Relabel sessions: .liveYYYYMMDD only after step (2). .cosourcedYYYYMMDD only after step (3).

