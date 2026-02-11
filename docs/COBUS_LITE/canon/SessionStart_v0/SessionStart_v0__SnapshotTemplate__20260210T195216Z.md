⊂ SessionStart v0 — Productization Snapshot (UI/UX EXPERIMENT)

🟢 CoHealth: CU/PU/HU/WT=OK/OK/OK/SOFT | CoBloat=OK | Gate=PASS | UTC=YYYYMMDDTHHMMSSZ

### Phases (global)
- [x] ⊂ P0 Define pins + canon pointers
- [ ] ⊂ P1 Implement runner + receipts
- [ ] ⊂ P2 CoBus drop automation (no user paste)
- [ ] ⊂ P3 RepTag/CoHalo conflict policy + UI
- [ ] ⊂ P4 Integration into CoStacks release rails
- [ ] ⊂ P5 Externalization (developer kits / gaming platform SDK)

### Current Phase Expanded (P1)
- [x] PinGuard: FULL RAW/UNC only
- [x] Read pinned canon: CoBeacon + PointerSpec + CoPre WaveHeader
- [x] Extract FULL pointers from CoBeacon (no inference)
- [x] Emit BootstrapReceipt + SHA256
- [ ] Optional: Emit CoBus entry file to UNC drop + SHA256 (needs pin)
- [ ] Optional: Repo-mode emitter (git) (explicitly non-required)

### Decisions Needed (CoPrime)
- ⊂ Pins: COBEACON_RAW_PIN / POINTER_SPEC_RAW_PIN / COPRE_WAVEHEADER_RAW_PIN (publish canonical)
- ⊂ Paths: HOME_RB_UNC + CoBus drop UNC conventions
- ⊂ Policy: ConflictPolicy default (SURFACE_ONLY vs NUDGE vs ENFORCE)
- ⊂ RepTag: positive-only semantics + privacy tiers

### Receipts (slots)
- Receipt: <LOCAL_OR_RAW_PTR>
- Receipt.sha256: <PTR>
- CoBusDrop (optional): <UNC_PTR>
