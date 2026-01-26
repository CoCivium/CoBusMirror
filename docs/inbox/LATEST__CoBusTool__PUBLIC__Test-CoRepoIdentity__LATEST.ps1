Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$here = Split-Path $MyInvocation.MyCommand.Path -Parent
$tool = Join-Path $here 'LATEST__CoBusTool__PUBLIC__Assert-CoRepoIdentity__LATEST.ps1'
if(-not (Test-Path $tool)){ throw "Tool missing: $tool" }

& $tool -Repo 'CoCivium/CoBusMirror' | Out-Null

$ok=$false
try { & $tool -Repo 'CoCivium/DefinitelyWrongRepoName' | Out-Null } catch { $ok=$true }
if(-not $ok){ throw "Expected failure on wrong Repo" }

"PASS: Test-CoRepoIdentity"