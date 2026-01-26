Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'

$here = Split-Path $MyInvocation.MyCommand.Path -Parent
$tool = Join-Path $here 'LATEST__CoBusTool__PUBLIC__Set-CoSessionEnv__LATEST.ps1'
if(-not (Test-Path $tool)){ throw "Tool missing: $tool" }

Remove-Item Env:\CO_SESSION_LABEL -ErrorAction SilentlyContinue
Remove-Item Env:\CO_TARGET_SESSION_LABEL -ErrorAction SilentlyContinue

& $tool -From 'CoShare_Migration_2' -To '4.0|PRIME|260125' | Out-Null
if($env:CO_SESSION_LABEL -ne 'CoShare_Migration_2'){ throw "env not set: CO_SESSION_LABEL" }
if($env:CO_TARGET_SESSION_LABEL -ne '4.0|PRIME|260125'){ throw "env not set: CO_TARGET_SESSION_LABEL" }

$ok=$false
try { & $tool -From 'Bad Label With Space' -To '4.0|PRIME|260125' | Out-Null } catch { $ok=$true }
if(-not $ok){ throw "Expected failure on whitespace label" }

"PASS: Test-CoSessionEnv"