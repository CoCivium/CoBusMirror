# COMETATRAIN_HEADER_SCHEMA__v0.1

UTC_CREATED: 20260307T004220Z
SESSION_LABEL: 4.0|PRIME|260307
STATUS: draft-local

## Purpose
- Define a minimal embedded CoMetaTrain header for canon-facing or promotable CoCivium-aligned assets.
- Make durable assets self-describing enough for fresh-session recovery, trust transfer, and AI-facing discovery.

## Design stance
- Location is mutable state; identity and lineage are canon.
- Relative path alone is insufficient.
- Mandatory for CoMetaTrain-mandatory classes; optional/light for lower classes per COMETATRAIN_CLASS_POLICY__v0.1.

## Minimal field set
- COOBJECT_ID
- COCLASS
- COAMBITION
- COALIGNMENT
- COCANONICALITY
- COLINEAGE
- COVERSION
- COPROVENANCE
- COREFS
- COSOURCEREFS
- CORECOVERY_COORDINATES
- CODISCOVERY_POINTERS
- COAURAFINDME
- COEVOINSTRUCTIONS
- COPROMOTION_RULE

## Field notes
### COOBJECT_ID
- Stable canonical identity for the object across mutations.

### COCLASS
- Object class such as doctrine, protocol, registry, control-plane artifact, AI-facing surface, productization artifact.

### COAMBITION
- What the object is trying to accomplish in the CoCivium ecosystem.

### COALIGNMENT
- Alignment declaration, usually CoCivium or a compatible scoped alignment.

### COCANONICALITY
- Expected values: verified | recoverable | noncanonical | recreatable.

### COLINEAGE
- Parent/ancestry chain or lineage identifier.

### COVERSION
- Version/timestamp state for the current mutation.

### COPROVENANCE
- Brief provenance statement describing where the object came from.

### COREFS
- General related-object references.

### COSOURCEREFS
- Explicit source references such as CoSourceID, repo refs, pointer-pack refs, receipts, or related packs.

### CORECOVERY_COORDINATES
- Full address path, repo name, branch or commit SHA, repo-relative path, landed state, pointer/receipt where applicable.

### CODISCOVERY_POINTERS
- Current discovery surfaces such as CoBeacon, CoIndex, CoHub, CoAura, rollups, registries, pointer packs.

### COAURAFINDME
- AI-facing hint or endpoint for finding the object through a CoAura / well-known / machine-readable surface.

### COEVOINSTRUCTIONS
- Guidance about how the object should evolve, mutate, or be handled under CoEvo.

### COPROMOTION_RULE
- What must be true before this object can be promoted to stronger canon status.

## Minimal header example
`	ext
COOBJECT_ID: costacks.transport.eventline
COCLASS: protocol
COAMBITION: guarded machine-detectable event transport for CoGuardian/CoGuard
COALIGNMENT: CoCivium
COCANONICALITY: recoverable
COLINEAGE: costacks.transport.eventline.v0
COVERSION: v0.1
COPROVENANCE: derived from CoBeacon/CoAudit/CoIndex/CoCarryDrain fragments and CoPrime takeover work
COREFS: CoGuardian; CoGuard; CoBus; CoBeacon
COSOURCEREFS: CoSourceID=unknown-yet; local spec path; receipt path
CORECOVERY_COORDINATES: repo=CoBusMirror; ref=local-working; rel=research/...; full=C:\...
CODISCOVERY_POINTERS: CoBeacon; Registry; CoBus entry pointer
COAURAFINDME: pending
COEVOINSTRUCTIONS: prefer additive mutation; preserve lineage
COPROMOTION_RULE: commit + push + pointer discoverability + receipt
`",
",

- Embed directly in canon-facing or promotable markdown/text assets near the top.
- Derived convenience files may omit or shorten the header.
- Temporary scratch artifacts should not receive the full header unless promoted.

## Coordinates
- REPO_NAME: CoBusMirror
- REPO_LOCAL_ROOT: C:\Users\rball\Documents\GitHub\CoBusMirror
- REPO_REL_PATH: research\coprime_takeover\4.0_PRIME_260307\COMETATRAIN_HEADER_SCHEMA__v0.1.md
- LOCAL_FULL_PATH: C:\Users\rball\Documents\GitHub\CoBusMirror\research\coprime_takeover\4.0_PRIME_260307\COMETATRAIN_HEADER_SCHEMA__v0.1.md

## Status note
- This schema is repo-local and commit-ready.
- It is not remote-canonical until committed/pushed and discoverable by pointer.
