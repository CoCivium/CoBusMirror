Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
$here = Split-Path $MyInvocation.MyCommand.Path -Parent
$tool = Join-Path $here 'LATEST__CoBusTool__PUBLIC__Invoke-CoStacksBootstrap__LATEST.ps1'
if(-not (Test-Path $tool)){ throw "Tool missing: $tool" }

$out2 = @(& $tool -From '4.0|PRIME|260125' -To 'CoShare_Migration_2' -Repo 'CoCivium/CoBusMirror' -State doing -Intent 'bootstrap smoke')
$has = $false
foreach($ln in $out2){ if($ln -match '^<\# # CoPong \| FROM='){ $has=$true; break } }
if(-not $has){ throw "Expected a CoPong line, got: $($out2 -join ' | ')" }

"PASS: Test-CoStacksBootstrap"