param(
  [Parameter(Mandatory=$true)][string]$From,
  [Parameter(Mandatory=$true)][string]$To,
  [Parameter(Mandatory=$true)][string]$Repo,
  [ValidateSet('doing','done','hold')][string]$State = 'doing',
  [string]$Intent = '',
  [string]$Lane = 'main'
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'

$here = Split-Path $MyInvocation.MyCommand.Path -Parent
$setEnv = Join-Path $here 'LATEST__CoBusTool__PUBLIC__Set-CoSessionEnv__LATEST.ps1'
$guard  = Join-Path $here 'LATEST__CoBusTool__PUBLIC__Assert-CoRepoIdentity__LATEST.ps1'
$ml1    = Join-Path $here 'LATEST__CoBusTool__PUBLIC__New-CoMilestoneLine__LATEST.ps1'
$cp     = Join-Path $here 'LATEST__CoBusTool__PUBLIC__New-CoPong__LATEST.ps1'
$prog   = Join-Path $here 'LATEST__CoBusTool__PUBLIC__Show-CoStacksProgress__LATEST.ps1'

if(-not (Test-Path $setEnv)){ throw "Missing tool: $setEnv" }
if(-not (Test-Path $guard)){ throw "Missing tool: $guard" }

& $setEnv -From $From -To $To | Out-Null
& $guard -Repo $Repo | Out-Null
if(Test-Path $prog){ & $prog -Repo $Repo | Out-Null }

if(Test-Path $ml1){
  & $ml1 -Scope PROJ -Id 'CoStacks' -Current 8 -Total 8 -Next 8 -Exit 1 -Ext PASS -Confidence 0.85 -Tax M -Lane $Lane
} else {
  "ML1 S=PROJ ID=CoStacks LANE=$Lane M=8/8 N=8 X=1 EXT=PASS C=0.85 T=M"
}

if($Intent){
  if(-not (Test-Path $cp)){ throw "Missing tool: $cp" }
  & $cp -State $State -Intent $Intent -Repo $Repo
} else {
  "TIP: To emit a CoPong, pass -Intent ""your one-liner""."
}