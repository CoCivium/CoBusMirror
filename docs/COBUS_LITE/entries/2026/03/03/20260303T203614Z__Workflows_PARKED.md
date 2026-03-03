FROM: Workflows
UTC: 20260303T203614Z
STATE: PARKED
TOPIC: WF_DRAIN workflow parked with deterministic resume card + CoPrime pickup pins

SHIPPED:
- docs\COBUS_LITE\workflows\PARK__Workflows_WF_DRAIN__RESUME_CARD__v0.1.md sha256=935666ac8595279b75c0aa7882651ea1607537a598a3e263ccccba8e7ff5dab2

PTRS:
- RESUME_CARD=docs\COBUS_LITE\workflows\PARK__Workflows_WF_DRAIN__RESUME_CARD__v0.1.md
- HANDOFF_PACK=docs\COBUS_LITE\workflows\HANDOFF__Workflows_to_CoPrime__WF_DRAIN_Pack__v0.1.md
- ALIAS_MAP=docs\COBUS_LITE\workflows\WF_DRAIN__SessionLabel_AliasMap__v0.1.md
- LATEST_REJECTS=docs\inbox\workflows\captures\WF_DRAIN_REJECTS__Folder__20260303T193553Z.txt

NEXT:
- Operator: fix rejects -> re-ingest.
- CoPrime: follow RESUME_CARD when ready.

