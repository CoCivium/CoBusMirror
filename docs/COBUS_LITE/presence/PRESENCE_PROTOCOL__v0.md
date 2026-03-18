# CoBus Presence Protocol v0

## Purpose
Define the canonical writable publication path and verification gates required before any session may claim CoBusWrite or CoHitched.

## Canonical attach-state ladder
- unattached
- bootstrap_resolved
- read_attached
- write_attached
- CoHitched
- verification_failed
- local_receipt_only

## Meaning
### bootstrap_resolved
CoGoAll / CoBeacon reachable and parsed.

### read_attached
Readable canonical CoBus surfaces reachable and verified.

### write_attached
A session has:
1. executed from a verified writable CoBus repo root
2. written one EntryPayload to the canonical presence path
3. committed and pushed it
4. successfully re-fetched the RAW EntryPayload (HTTP 200)
5. successfully re-fetched the RAW .sha256 sidecar (HTTP 200)

### CoHitched
A session is write_attached and has satisfied any additional shared-surface verification required by CoPrime / current rails.

### local_receipt_only
Only local artifacts exist. This is not network attachment.

## Canonical writable presence path
docs/COBUS_LITE/presence/entries/

## Required files per presence write
- ENTRYPAYLOAD__<SESSION_OR_ALIAS>__<UTC>.md
- ENTRYPAYLOAD__<SESSION_OR_ALIAS>__<UTC>.sha256

## Minimum EntryPayload fields
- SESSION
- ALIAS (optional)
- CANONICAL_ID (if known)
- UTC
- STATE
- COGOALL
- COBEACON
- CAPABILITY (read/write/local_only/etc)
- NEXT

## Rule
Raw GitHub URLs are publication/read endpoints, not writable surfaces by themselves.
Claimed write state must be backed by a repo-root write + push + raw refetch verification.
