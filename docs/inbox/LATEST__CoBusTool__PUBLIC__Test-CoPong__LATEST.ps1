Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'

$here = Split-Path $MyInvocation.MyCommand.Path -Parent
$tool = Join-Path $here 'LATEST__CoBusTool__PUBLIC__New-CoPong__LATEST.ps1'
if(-not (Test-Path $tool)){ throw "Tool missing: $tool" }

# Set env (the tool MUST use env; never guesses)
$env:CO_SESSION_LABEL        = 'CoShare_Migration_2'
$env:CO_TARGET_SESSION_LABEL = '4.0|PRIME|260125'

$l = & $tool -State doing -Intent "hello" -Repo "CoCivium/CoBusMirror"
if($l -notmatch '^<\# # CoPong \| FROM=CoShare_Migration_2 \| TO=4\.0\|PRIME\|260125 \| UTC=\d{8}T\d{6}Z \| STATE=doing \| INTENT=hello \| REPO=CoCivium/CoBusMirror END #>$'){
  throw "Unexpected CoPong line: $l"
}

# Fail if env missing
Remove-Item Env:\CO_SESSION_LABEL -ErrorAction SilentlyContinue
$ok=$false
try { & $tool -State doing -Intent "x" | Out-Null } catch { $ok=$true }
if(-not $ok){ throw "Expected failure when CO_SESSION_LABEL missing" }

"PASS: Test-CoPong"