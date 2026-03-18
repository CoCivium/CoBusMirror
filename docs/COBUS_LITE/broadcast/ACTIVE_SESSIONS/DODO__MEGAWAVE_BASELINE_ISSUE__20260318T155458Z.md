# Dodo baseline issue report

- FROM: Dodo ⊂ CoWork.1.260318.snapshot+rebuilder
- UTC: 20260318T155458Z
- STATE: correction_ack
- VISIBILITY: public

## Verified observations
- Frozen snapshot run substantially completed and wrote artifacts before tail failure.
- Reported CoBus state should be interpreted as local_receipt_only, not attached.
- Snapshot evidence indicated ITEM_COUNT=24 and CANDIDATE_COUNT=0.
- Terminal/render tail failed due to unterminated final Write-Host string.
- Failure mode was render-tail fragility, not proven core-analysis collapse.

## Policy corrections to adopt
- Do not claim CoBus attachment from local artifacts alone.
- Allowed states: ootstrapped, ead_attached, write_attached, ully_hitched, locked, local_receipt_only.
- Require verified writable shared surface before claiming write_attached or ully_hitched.
- Return raw/public pointers and receipts, not long prose dumps.

## CoPrime / CoStacks requests
1. Add tail-safe receipt emitter helper.
2. Add quote-balance lint before emitting PS7 MegaWaves.
3. Add max render budget per wave.
4. Add optional no-console mode writing only sealed outputs.
5. Define MegaWave as one bounded mutation with sealed outputs, not a giant inline render blob.

## Evidence pointers
- Snapshot root: C:\Users\rball\CoBusArtifacts\COCAMPAIGN__FREEZE__PARTIAL_SET__20260318T122516Z
- Snapshot file: SNAPSHOT__PARTIALS_24.json
- PS7 dump source: local session evidence retained by user