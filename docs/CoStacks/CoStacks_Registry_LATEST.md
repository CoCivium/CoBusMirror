# CoStacks Registry (LATEST)

UTC=20260125T054828Z

## Purpose
This is the public, machine-readable-ish index of **CoStacks** surfaces used for orchestration and cross-session coordination.

## Canon rules (public)
- All cross-session pointers are FULL URLs (prefer URL_RAW).
- CoPong is a single physical line that starts with # .
- Treat CoBeacon as START_HERE and keep it filled.

## Entries (seed)
- CoBeacon (START_HERE): https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBEACON_LATEST.txt
- Pointer Spec: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/inbox/LATEST__CoBusNote__PUBLIC__Pointer_Spec__LATEST.txt
- CoPong Spec: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/inbox/LATEST__CoBusNote__PUBLIC__CoPong_Spec__LATEST.txt
- CoBus Spec: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/inbox/LATEST__CoBusNote__PUBLIC__CoBus_Spec__LATEST.txt
- CoBus Index: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/inbox/LATEST__CoBusNote__PUBLIC__CoBus_Index__LATEST.json
- CoPre WaveHeader: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/inbox/LATEST__CoBusNote__PUBLIC__CoPre_WaveHeader__LATEST.txt

## Token stance (avoid churn)
- Keep [CoHeader]/[CoFooter] canonical for now.
- Proposal [CoHead]/[CoTail] = HOLD unless CoPrime explicitly greenlights (avoid drift).
