# CoStacks — Productized Ops Stacks (v0)

UTC=20260130T002030Z
CoHealth=OK
Scope=Define CoStacks as the umbrella for versioned, shareable operational “stacks” (rails + templates + tools + packs) used across CoCivium sessions and repos.

## Definition
CoStacks is a set of interoperable, versioned operational stacks that:
- are reproducible (bootstrap-able)
- are reviewable (diffable)
- are provable (receipts/hashes; optional signatures)
- fail-closed by default (unknown/ambiguous => STOP)
- support public sharing *and* NDA/private sharing via strict partitioning

## Included stacks (initial list)
- CoGuardian / CoGuard: hardening, quarantine, scheduled-task hygiene, focus-steal mitigations
- CoAgent: agent orchestration patterns + safe automation rails
- CoPreFrame / CoPreAttach: prompt framing + attachment discipline + standardized headers/footers
- CoAnchor: canonical pointers + rails for “source of truth” and retrieval
- CoHalo: PR hygiene, whitelist-only publish surfaces, reversible workflows
- CoCrux + BPOE + CoVows: operating environment + consent/reversibility + governance norms
- MasterPlan rails: planning docs + appendices + pointer hygiene
- CoStatus + CoSideNote: status cards + standardized inter-session notes UX
- CoSourceID + CoCarry packs: provenance + packaged distribution

## Public vs NDA/Private partition (non-negotiable)
Public (OK):
- templates, UX tools, formatting standards, non-sensitive rails, non-crown-jewel examples
Private (NDA / vault / restricted repos):
- GLUKEY + crown jewels, patent-adjacent internals, any competitive differentiators not yet protected

Rule: If uncertain => classify as private until reviewed.

## Packaging model (how CoStacks becomes “shareable”)
- Each stack can ship as a CoCarry pack (zip) with:
  - INDEX__LATEST.md inside pack
  - RECEIPT.sha256 for pack contents
  - optional signature/transparency log layer later
- CoBeacon is the *pointer registry*; coherence comes from packs + receipts, not from CoBeacon self-snapshots.

## Bootstrap expectation (what a new NDA user should be able to do)
- Fetch CoBeacon
- Follow FULL-URL pointers only
- Pull the relevant pack(s)
- Verify receipts
- Run preflight rails
- Start emitting standardized CoStatus + SideNotes immediately

## Gates (v0)
- commit-SHA RAW pointers preferred for immutable artifacts
- unknown/ambiguous ID resolution => FAIL-CLOSED
- quarantine first; promote only after PASS (receipt verified + policy review)

# COPY_SAFE:TRUE | END_OF_BLOCK
