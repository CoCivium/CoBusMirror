# MegaWave Tailsafe Policy v0

## Problem
Successful sealed outputs can still be followed by render-tail blowups due to oversized inline chatter, unterminated strings, or unsafe last-line paste behavior.

## Rules
1. Sealed outputs > console chatter
2. Max render budget per wave should be kept small
3. Final console line must be either:
   - a one-line NEXT receipt
   - or nothing
4. Optional no-console mode should be allowed:
   - SUMMARY
   - FINAL_RECEIPT
   - MANIFEST
   only
5. PS7 blocks should be linted for unmatched quotes before emission
6. MegaWave means:
   - a single bounded mutation
   - sealed outputs
   - not giant prose/code dumps

## Copy/paste-safe discipline
- begin with sacrificial comment/header
- avoid fragile tail chatter
- do not leave unterminated final lines
- prefer pointer receipts over verbose console output
