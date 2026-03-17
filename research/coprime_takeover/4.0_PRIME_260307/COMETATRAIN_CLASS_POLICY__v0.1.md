# COMETATRAIN_CLASS_POLICY__v0.1

UTC_CREATED: 20260307T002458Z
SESSION_LABEL: 4.0|PRIME|260307
STATUS: draft-local

## Purpose
- Define which classes of CoCivium-aligned assets should carry embedded CoMetaTrain alignment envelopes.
- Avoid both under-metadata on durable canon-facing assets and over-metadata on transient scratch artifacts.

## Core rule
- CoMetaTrain is mandatory for asset classes that must survive fresh-session recovery, trust transfer, and long-horizon CoEvo.
- CoMetaTrain is optional or omitted for transient/disposable classes unless promoted.

## Mandatory classes
1. Canon doctrine / vision assets
   - constitution
   - theory
   - principles
   - CoMasterPlan / HP projections
   - movement doctrine

2. Protocols / schemas / standards
   - handoff specs
   - receipt schemas
   - transport grammars
   - bootstrap specs
   - event-line protocols

3. Indexes / registries / discovery surfaces
   - CoBeacon
   - CoIndex
   - pointer packs
   - registries
   - rollups
   - manifests

4. Control-plane artifacts
   - scope files
   - bossboards
   - wave manifests
   - lifecycle rails
   - worker/session contracts

5. AI-facing surfaces
   - CoAura assets
   - AI onramps
   - machine-readable explainers
   - semantic maps
   - GIBindex-derived canon outputs

6. Promotable productization artifacts
   - architecture notes
   - subsystem specs
   - productization roadmaps
   - canon-bound dashboards / hubs

## Optional / light classes
- intermediate worker outputs
- temporary staging artifacts
- local diagnostics with promotion potential
- derived convenience files

## Usually no CoMetaTrain by default
- raw logs
- cached downloads
- clipboard captures
- one-off helper outputs
- local-only scratch notes

## Minimal mandatory envelope fields
- COOBJECT_ID
- COCLASS
- COAMBITION
- COALIGNMENT
- COCANON_CLASS
- COLINEAGE
- CODISCOVERY_POINTERS
- CORECOVERY_COORDINATES
- COPROMOTION_RULE

## Design stance
- Location is mutable state; identity and lineage are canon.
- Relative path alone is insufficient.
- Durable aligned assets should be self-describing enough for fresh-session recovery.

## Classification shorthand
- durable aligned assets => mandatory CoMetaTrain
- promotable semi-durable assets => light or promotable CoMetaTrain
- disposable transient assets => no CoMetaTrain unless promoted

## Coordinates
- REPO_NAME: CoBusMirror
- REPO_LOCAL_ROOT: C:\Users\rball\Documents\GitHub\CoBusMirror
- REPO_REL_PATH: research\coprime_takeover\4.0_PRIME_260307\COMETATRAIN_CLASS_POLICY__v0.1.md
- LOCAL_FULL_PATH: C:\Users\rball\Documents\GitHub\CoBusMirror\research\coprime_takeover\4.0_PRIME_260307\COMETATRAIN_CLASS_POLICY__v0.1.md

## Status note
- This policy is repo-local and commit-ready.
- It is not remote-canonical until committed/pushed and discoverable by pointer.
