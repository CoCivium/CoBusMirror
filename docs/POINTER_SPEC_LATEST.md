# CoPointer Spec (PUBLIC LATEST)
UTC=20260117T205811Z

## Rule 0 (Default)
Always provide full canonical URLs for any asset you expect a fresh session to read.

## Allowed pointer forms (in descending preference)
1) Full HTTPS URL (preferred), plus SHA256 when feasible.
   - Example: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/AI_ONRAMP_LATEST.txt

2) OWNER/REPO@REF:path (only if the resolver rule is stated in the same message)
   - Example: CoCivium/CoBusMirror@main:docs/AI_ONRAMP_LATEST.txt
   - Resolver rule: "RAW = https://raw.githubusercontent.com/{OWNER}/{REPO}/{REF}/{path}"

## Disallowed
- Naked relative paths with no repo + ref context.
  - Example: docs/inbox/SomeFile.txt  (INVALID by itself)

## LATEST convention
- LATEST assets must have stable names that are overwritten intentionally.
- Timestamped copies are allowed for history, but sessions should be pointed to LATEST unless debugging.

## Minimum bootstrap package (PUBLIC)
A session should be able to read:
- AI onramp: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/AI_ONRAMP_LATEST.txt
- CoBeacon: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBEACON_LATEST.txt
- Primer:   https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/inbox/LATEST__CoBusNote__PUBLIC__CoStacks_Primer__LATEST.txt
- Registry: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/registry/CoStacksRegistry__LATEST.json
- PS7 spec: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/ps7/PS7_PANEL_SPEC_LATEST.md
- Pointer spec: https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/POINTER_SPEC_LATEST.md

END
