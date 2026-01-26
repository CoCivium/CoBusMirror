Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$here = Split-Path $MyInvocation.MyCommand.Path -Parent
$tool = Join-Path $here 'LATEST__CoBusTool__PUBLIC__Show-CoStacksProgress__LATEST.ps1'
if(-not (Test-Path $tool)){ throw "Tool missing: $tool" }
& $tool -Repo 'CoCivium/CoBusMirror' | Out-Null
"PASS: Test-CoStacksProgress"