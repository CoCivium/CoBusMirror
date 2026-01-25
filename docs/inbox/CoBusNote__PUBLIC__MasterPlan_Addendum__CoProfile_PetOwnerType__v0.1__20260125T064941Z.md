# MasterPlan Addendum (append-only): CoProfile + CoWaveRitual + PetOwnerType Cards (seed-stage)

## Goal
Ship a public-facing "CoProfile" tool that externalizes session initiation (Wave-1 ritual) into a portable preference + consent preset for registerable IDs, and a prototype UX surface for vendor-facing VR/XR CoHalo + RepTag.

## Hard invariants (seed canon)
1) Separate: PREFS (self-chosen) vs REP (attested by others) vs PROOFS (crypto verifiable artifacts). Never conflate.
2) Default to minimization: disclose only what is needed for the context; upgrade disclosure only by explicit consent.
3) No implicit "trustworthiness score" from prefs. Pprefs are UX controls, not reputation.
4) Multi-ID support: do not hard-bind to a platform account ID; allow pseudonymous profiles.
5) Ritual is skippable; full-fat setup only on self-declare (Contributor/CoSteward mode).

## CoWaveRitual (Wave-1 UX)
Wave-1 should do, by default:
- show the active profile card (or default card)
- summarize the active style vector settings (short list)
- show a 1-paragraph "how this session works" legend + pointers-to-pointers
- provide an immediate override (e.g., switch SoftBall/HardBall)
- provide a redo link: "Edit profile" -> CoProfile tool

Conflict/frustration handling:
- session may re-surface the card as a neutral reminder: "This is the style you enabled; change any time."

## CoProfile tool (externalized ritual)
Public web tool outputs a CoProfile Bundle + mnemonic card. Session ingests bundle by token or URL.

### CoProfile Bundle (v0)
- coprofile_id (opaque, stable)
- style_prefs (vector set)
- consent_scope (what can be shown to whom, in what context)
- consent_receipt_ref (human readable receipt pointer or hash)
- pet_owner_type_key (deterministic key used to render card)
- created_at / updated_at / expires_at
- revocation_ref (how to revoke / hide)
- signature (seed: server-signed JWS; later: VC/SD-JWT)

### Preference vectors (v0; keep small)
- Critique: SoftBall <-> HardBall
- Directness: gentle <-> blunt
- Pace: concise <-> thorough
- Pushback: low <-> high
- Uncertainty display: minimal <-> explicit
- Emotional temperature: neutral <-> warm
- Risk posture: conservative <-> exploratory

## PetOwnerType mnemonic card system (avoid combinatorial explosion)
Do NOT generate bespoke art per vector combo.
Use compositing:
- base archetype set (approx 20-40)
- overlay badges for each vector (icons + 1 short ribbon text max)
- deterministic render key: hash(coprofile_id + vector_set + theme)
- cache outputs (CDN) + allow client-side composition for zero wait

Accessibility:
- always include text summary (no-image mode supported)

## RepTag / CoHalo alignment (seed -> soft launch)
Seed-stage:
- vendor consumes PREFS immediately for UX (in chat + XR overlays)
- REP is separate, off by default unless explicit and verifiable
- PROOFS are never shown unless user explicitly expands and consents

Interop track (post-seed, when needed):
- SD-JWT / SD-JWT VC for selective disclosure
- OpenID4VP/4VCI for presentations/issuance
- Open Badges for "achievement-style" portable recognitions (optional, not a rep system by itself)

## XR vendor MVP (seed wedge)
Deliver a read-only overlay component (web first; Unity/Unreal next) that:
- fetches and shows the PetOwnerType card + minimal prefs summary
- respects consent_scope (prefs only by default)
- supports "hide now" revocation

## Brand kit tokens (derived from provided roots)
- CoCivium gray: #666666
- BeAxa Torch red: #FF3D33
- BeAxa Torch blue accent: ~#277A9D
- Neutral black: #000000
Rule: vector-first assets (SVG) + raster only as cached outputs.

## Diminishing returns gate (stop planning, start building)
Stop expanding plan when:
- v0 bundle schema is stable + versioned
- one integration path is selected (web overlay) with acceptance tests
- one abuse pass is documented (gaming/doxxing/spoofing)
- the remaining questions are empirical (answered by MVP tests, not docs)
