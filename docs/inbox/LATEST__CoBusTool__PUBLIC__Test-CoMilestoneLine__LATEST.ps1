Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'

$here = Split-Path $MyInvocation.MyCommand.Path -Parent
$tool = Join-Path $here 'LATEST__CoBusTool__PUBLIC__New-CoMilestoneLine__LATEST.ps1'
if(-not (Test-Path $tool)){ throw "Tool missing: $tool" }

$l = & $tool -Scope SES -Id 'CoShare_Migration_2' -Current 3 -Total 8 -Next 4 -Exit 5 -Ext OPT -Confidence 0.8 -Tax M -Lane 'main'
if($l -notmatch '^ML1 S=SES ID=CoShare_Migration_2 LANE=main M=3/8 N=4 X=5 EXT=OPT C=0\.8 T=M$'){ throw "Unexpected line: $l" }

$l2 = & $tool -Scope PROJ -Id 'CoStacks' -Current 6 -Total 9 -Exit 7 -Ext OPT -Confidence 0.6 -Tax H
if($l2 -notmatch '^ML1 S=PROJ ID=CoStacks M=6/9 N=- X=7 EXT=OPT C=0\.6 T=H$'){ throw "Unexpected line: $l2" }

"PASS: Test-CoMilestoneLine"