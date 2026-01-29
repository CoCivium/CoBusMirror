# CoSourceID (v0) — provenance + deterministic identity layer

## Thesis
CoSourceID is the externalized provenance/ID layer: immutable canonical IDs + mutable aliases + deterministic resolution + receipts (hashes) + optional signatures/transparency log.
All resolution is **FAIL-CLOSED** on unknown/ambiguous IDs.

## Policy
- POLICY: alias-as-copy-sync (permanent until all fetchers are pointer-aware)
- .sha256 files are sha256sum-style: "<hash> <filename>" → verifiers must compare **first token only**
- Tools must accept explicit -From/-To OR resolve via a registry; never silently infer identity from env state.

## Pickup (commit-SHA RAW)
- PACK_COMMIT: 0c00fa6fe4adea2d027c783bdc33aacccb4c3c72
- PICKUP_URL_RAW: https://raw.githubusercontent.com/CoCivium/CoSources/0c00fa6fe4adea2d027c783bdc33aacccb4c3c72/docs/hold/CoCarry/packs/PACK__CoSourceID__v0__20260129T200324Z/PACK__CoSourceID__v0__20260129T200324Z.zip
- ZIP_SHA256_FILE: https://raw.githubusercontent.com/CoCivium/CoSources/0c00fa6fe4adea2d027c783bdc33aacccb4c3c72/docs/hold/CoCarry/packs/PACK__CoSourceID__v0__20260129T200324Z/PACK__CoSourceID__v0__20260129T200324Z.zip.sha256

## Landing
- LANDING_DEST: CoCivium/CoBusMirror:docs/MasterPlan/Appendix/CoSourceID/
