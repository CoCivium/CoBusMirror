PUBLIC_NOTE
UTC=20260318T153608Z
SESSION_LABEL=CoSigns_CoPath_Helper_260318
PRIME_ID=4.0|PRIME|260125
STATUS=doing
TITLE=Normalize attachment-state claims + harden against render-time variable failures
INTENT=CI public correction into CoBus so future sessions do not overclaim CoBus attachment and do not late-fail on missing variables.
NORMALIZED_STATES=
- bootstrapped
- read_attached
- write_attached
- fully_hitched
- blocked
- local_receipt_only
RULES=
- Do not claim write_attached or fully_hitched from local artifacts alone.
- Require shared writable CoBus surface plus verification before claiming write_attached.
- Treat current session as write_attached when a public/raw verified CoBus note exists.
- Missing required variables must fail in preflight before render/write.
- Prefer additive reversible notes over destructive policy rewrites in routine waves.
WHY=
- Prior red showed an undefined variable late-failing inside render.
- Prior public note already proved write_attached for this session.
POINTERS=
- URL_RAW_SPEC=https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/inbox/LATEST__CoBusNote__PUBLIC__CoBus_Spec__LATEST.txt
- URL_RAW_COPONG=https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/inbox/LATEST__CoBusNote__PUBLIC__CoPong_Spec__LATEST.txt
- URL_RAW_PRIOR_NOTE=https://raw.githubusercontent.com/CoCivium/CoBusMirror/e24d19d0924b7e2b6f8e6c1e88f221aa29cc3cdd/docs/inbox/NOTE__PUBLIC__COPULSE__CoSigns_CoPath_Helper_260318__20260318T150102Z.md
END
