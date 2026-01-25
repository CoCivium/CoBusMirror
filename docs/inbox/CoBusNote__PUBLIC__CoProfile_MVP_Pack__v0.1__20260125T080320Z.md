# CoProfile MVP Pack v0.1 (PUBLIC)

## Goal
Ship a public-facing CoProfile tool that externalizes Wave-1 ritual into a portable preference + consent preset for registerable IDs, with a mnemonic PetOwnerType card to make it memorable and viral in gamer/XR contexts.

## Non-negotiable separation
- PREFS (self-chosen UX controls) != REP (attested by others) != PROOFS (cryptographic artifacts)
- Seed ships PREFS+consent only. REP/PROOFS are explicit plug-ins.

## Contents (this PR)
- CoProfile Bundle schema (JSON Schema v0.1)
- Example bundle + example consent policy
- PetOwnerType card key derivation spec (deterministic + compositing)
- Archetype registry v0.1 (starter 32)
- Badge registry v0.1 (starter vectors + icons-as-names)
- Threat model + abuse cases (seed)
- BorrowMap (standards + OSS candidates; license gate)
- XR overlay MVP note (web-first; Unity/Unreal later)
- Minimal tools: generate card_key, generate sample bundle, validate minimal invariants
- Receipt JSON + SHA256 sidecars for every file

## Seed UX behavior (Wave-1)
- show active profile card (or default)
- show short legend + pointers-to-pointers
- immediate override (SoftBall/HardBall)
- “Edit profile” -> external tool
- frictionless skip path for casual users

END
