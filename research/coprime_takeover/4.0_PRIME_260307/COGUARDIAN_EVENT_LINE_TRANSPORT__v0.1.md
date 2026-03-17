# COGUARDIAN_EVENT_LINE_TRANSPORT__v0.1

UTC_CREATED: 20260307T001548Z
SESSION_LABEL: 4.0|PRIME|260307
STATUS: draft-local

## Purpose
- Define a minimal event-line transport grammar for CoGuardian / CoGuard to observe, validate, and route.
- Replace human CoPong relay with typed machine-detectable emissions.

## Core premise
- Raw console chatter is not a transport surface.
- Typed event emissions are the transport surface.
- Color may help humans, but parsing must not depend on color.

## Event model
- Producer: PS7 block, local runtime, or guarded tool wrapper
- Watcher: CoGuardian
- Validator: CoGuard
- Router: CoBus / session-target transport layer

## Trigger rule
- Only explicit machine-marked event lines should trigger action.
- Visual changes alone must not trigger routing.

## Minimal line grammar
- Prefix: VIOLET_EVENT
- Required fields:
  - KIND
  - FROM
  - TO
  - UTC
  - STATE
  - PTR
  - SHA
- Optional fields:
  - NEED
  - TOPIC
  - MODE
  - RETRY

## Example
VIOLET_EVENT | KIND=COPONG | FROM=4.0|PRIME|260307 | TO=Workflows | UTC=20260307T001548Z | STATE=doing | TOPIC=FirstGIBindexCurationPacket | PTR=<FULL_URL_OR_FULL_PATH> | SHA=<sha256>

## Event kinds (initial)
- COPONG
- SIDENOTE
- STATUS
- RECEIPT
- RFA
- DONE

## Validation rules
- Reject malformed lines fail-closed.
- Require FULL URL or full local path in PTR.
- Relative path alone is insufficient.
- Require SHA when artifact/receipt exists.
- Deduplicate identical event lines by stable hash.

## Routing rules
- If TO is session-like, route to session transport target.
- If TO is bus-like, write to CoBus transport surface.
- If transport fails, queue for retry and emit RFA/FAIL event.

## Human factors
- Violet/highlight styling is optional human affordance only.
- Machine parsing must rely on prefix and field grammar.

## Relationship to existing rails
- Complements DO block transport discipline.
- Complements CoBus discovery worker.
- Supports Bootstrap Delta reduction by lowering HumanRelayCount.
- Supports CoAudit by creating receipt-vs-narrative evidence.

## Future linkage
- CoGuardian watches event lines.
- CoGuard validates schema and authority.
- CoAudit scores transport quality and missing-canon conditions.

## Recovery coordinates
- REPO_NAME: CoBusMirror
- REPO_LOCAL_ROOT: C:\Users\rball\Documents\GitHub\CoBusMirror
- REPO_REL_PATH: research\coprime_takeover\4.0_PRIME_260307\COGUARDIAN_EVENT_LINE_TRANSPORT__v0.1.md
- LOCAL_FULL_PATH: C:\Users\rball\Documents\GitHub\CoBusMirror\research\coprime_takeover\4.0_PRIME_260307\COGUARDIAN_EVENT_LINE_TRANSPORT__v0.1.md

## Status note
- This spec is repo-local and commit-ready.
- It is not remote-canonical until committed/pushed and discoverable by pointer.
