# CoStatusCard vNext — CoSourceID (v0)

UTC=20260129T233626Z
CoHealth=OK
Scope=CoSourceID is MasterPlan-front-and-center provenance/ID invariant; publish canonical pickup pointers + receipts; enforce FAIL-CLOSED resolution posture.

## DONE
- POLICY=alias-as-copy-sync (permanent until all fetchers pointer-aware)
- CoSources pack ingested (commit-SHA RAW):
  - PACK_COMMIT=0c00fa6fe4adea2d027c783bdc33aacccb4c3c72
  - PICKUP_URL_RAW=https://raw.githubusercontent.com/CoCivium/CoSources/0c00fa6fe4adea2d027c783bdc33aacccb4c3c72/docs/hold/CoCarry/packs/PACK__CoSourceID__v0__20260129T200324Z/PACK__CoSourceID__v0__20260129T200324Z.zip
  - ZIP_SHA256_FILE=https://raw.githubusercontent.com/CoCivium/CoSources/0c00fa6fe4adea2d027c783bdc33aacccb4c3c72/docs/hold/CoCarry/packs/PACK__CoSourceID__v0__20260129T200324Z/PACK__CoSourceID__v0__20260129T200324Z.zip.sha256
- LANDING_DEST=CoCivium/CoBusMirror:docs/MasterPlan/Appendix/CoSourceID/

## DOING
- (none)

## NEXT
- CoBus note-tool hardening: require explicit -From/-To OR registry resolution; FAIL-CLOSED on unknown/ambiguous IDs
- Standardize sha256 parsing: sha256sum-style "<hash> <filename>" compare FIRST TOKEN only
- Optional: transparency log / signatures layer for Tier-B/Tier-C assets

## RECEIPTS
- Local receipt file: RECEIPT.sha256

## CoGibberNote (optional)
- (leave empty unless a machine-lane payload is required)

# COPY_SAFE:TRUE | END_OF_BLOCK


# COPY_SAFE:TRUE | END_OF_BLOCK
