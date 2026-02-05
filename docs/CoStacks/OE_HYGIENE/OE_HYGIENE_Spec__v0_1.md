# OE_HYGIENE — Gate-1 Preflight Rail (Spec v0.1)
UTC=20260205T142449Z

## Contract
- EntryPoint: docs/CoStacks/OE_HYGIENE/tools/Invoke-OE_HYGIENE.ps1
- Receipt: docs/CoStacks/OE_HYGIENE/receipts/OE_HYGIENE_RECEIPT__<UTC>.json
- Deterministic result: PASS/WARN/FAIL + exit codes 0/10/20
- Default mode is detect-only; any writes are HKCU-only and require explicit -Mode apply.

## Gate-1 MVP policy
- schtasks denied => WARN **iff** fallback guard is present; else FAIL.

## Checks (MVP)
1) schtasks.access
2) guard.runkey.present (marker: HKCU:\Software\CoCivium\OE_HYGIENE\RunKeyGuard Enabled=1)
3) git.health.baseline (git --version)
4) security.falsepositive.signal (optional flag file under LOCALAPPDATA)

## Receipt JSON schema (minimal)
{ rail, spec_version, utc, host{computer,user,os}, profile{gate,mode}, summary{result,warn_count,fail_count}, checks[] }
