# CoProfile Threat Model + Abuse Cases v0.1 (PUBLIC)

## Primary risks (seed)
1) Prefs misread as reputation (must block)
2) Doxxing via profile linkage (multi-ID + minimization)
3) Spoofing/copycat cards (server signature + receipts)
4) Harassment via “HardBall baiting” (user-controlled overrides; safe defaults)
5) Vendor misuse (consent_scope enforced; prefs-only default)

## Abuse cases
- “Trust score laundering” via prefs -> MUST NOT exist
- “Profile stalking” across contexts -> consent-scope + revocation
- “Badge inflation” -> badges are UX-only unless attested
- “Card screenshot leakage” -> always render minimal; avoid sensitive fields

## Mitigations
- strict separation: PREFS != REP != PROOFS
- receipts + revoke-now path
- default-minimization + explicit expand for anything beyond prefs
- deterministic card_key but opaque coprofile_id

END
