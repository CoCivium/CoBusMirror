# CoProfile Bundle Schema v0.1 (PUBLIC)

## Non-negotiable separation
- PREFS (self-chosen UX controls) != REP (attested by others) != PROOFS (cryptographic artifacts).
- Seed MVP ships PREFS + consent only; REP/PROOFS are explicit plug-ins.

## Bundle object (v0.1)
- coprofile_id: opaque stable id (NOT platform account id)
- version: "0.1"
- style_prefs: vector map (SoftBall/HardBall, pace, pushback, uncertainty display, etc.)
- consent_scope: ABAC-like rules (who/where/when can see which fields)
- disclosure_min: default-minimization policy
- pet_owner_type_key: deterministic render key (see CardKey note)
- receipts: { consent_receipt_ref, updated_at, expires_at?, revocation_ref? }
- pointers: optional URL_RAWs to external resources (never required)
- signature: seed = server-signed (JWS ok); later = SD-JWT/VC

## Minimal vectors (seed)
- critique_mode: SoftBall|HardBall
- directness: low..high
- pace: concise..thorough
- pushback: low..high
- uncertainty: minimal..explicit
- affect: neutral..warm
- risk_posture: conservative..exploratory

## Threat model (seed)
- No “trust score” derived from prefs.
- No implicit identity binding; multi-ID supported.
- Explicit consent required for any cross-context display.

END
