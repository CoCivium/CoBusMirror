# CoProfile Bundle Schema v0.1 (PUBLIC)

## Bundle object (v0.1)
- coprofile_id: opaque stable id (NOT platform account id)
- version: "0.1"
- style_prefs: vector map (small set; seed)
- consent_scope: policy rules (who/where/when can see which fields)
- disclosure_min: default-minimization policy (seed default: prefs-only)
- pet_owner_type_key: deterministic render key (see CardKey spec)
- receipts: { consent_receipt_ref, created_at, updated_at, expires_at?, revocation_ref? }
- pointers: optional FULL URLs only (never required)
- signature: seed = server-signed JWS; later = SD-JWT/VC (optional lane)

## Minimal vectors (seed)
- critique_mode: SoftBall|HardBall
- directness: 0..5
- pace: 0..5
- pushback: 0..5
- uncertainty_display: minimal|explicit
- affect: neutral|warm
- risk_posture: conservative|exploratory

## Invariants (seed)
- Do not compute “trust score” from prefs.
- Multi-ID supported; do not hard bind to platform account id.
- Cross-context display requires explicit consent.

END
