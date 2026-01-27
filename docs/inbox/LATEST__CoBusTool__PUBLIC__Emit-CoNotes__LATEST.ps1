<# Emit-CoNotes (PUBLIC, LATEST) FAIL-CLOSED. #>
param(
  [Parameter(Mandatory=$true)][ValidateSet('SideNote','CoPong')] [string]$Kind,
  [Parameter(Mandatory=$false)][string]$From,
  [Parameter(Mandatory=$true)][string[]]$To,
  [Parameter(Mandatory=$true)][string[]]$Intent,
  [Parameter(Mandatory=$true)][ValidateSet('doing','hold','done')] [string]$State,
  [Parameter(Mandatory=$true)][string]$Utc,
  [switch]$FromEnv,
  [string]$CoSidRegistryPath = '.\docs\protocols\CoBus\CoSidRegistry__LATEST.json',
  [switch]$AllowUnknownIds
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
function OneLine([string]$s){ ($s -replace "(\r?\n)+"," " -replace "\s{2,}"," ").Trim() }

if($To.Count -ne $Intent.Count){ Fail "Count mismatch: -To must equal -Intent" }
if(-not (Test-Path -LiteralPath $CoSidRegistryPath)){ Fail ("Missing CoSid registry: {0}" -f $CoSidRegistryPath) }

$reg = Get-Content -LiteralPath $CoSidRegistryPath -Raw | ConvertFrom-Json
$map=@{}
foreach($s in @($reg.sessions)){
  $label=($s.label|ForEach-Object{$_.ToString()}).Trim()
  if(-not [string]::IsNullOrWhiteSpace($label)){ $map[$label.ToUpperInvariant()]=$label }
  foreach($a in @($s.aliases)){
    $aa=($a|ForEach-Object{$_.ToString()}).Trim()
    if(-not [string]::IsNullOrWhiteSpace($aa)){ $map[$aa.ToUpperInvariant()]=$label }
  }
}
function ResolveId([string]$x,[string]$field){
  $t=($x|ForEach-Object{$_.ToString()}).Trim()
  if([string]::IsNullOrWhiteSpace($t)){ Fail ("Empty {0}" -f $field) }
  $k=$t.ToUpperInvariant()
  if($map.ContainsKey($k)){ return $map[$k] }
  if($AllowUnknownIds){ return $t }
  Fail ("Unknown {0} '{1}' (not in CoSidRegistry)." -f $field,$t)
}

$envFrom=($env:CO_SESSION_LABEL|ForEach-Object{$_.ToString()}).Trim()
$rawFrom=$null
if($FromEnv -or [string]::IsNullOrWhiteSpace($From)){
  if([string]::IsNullOrWhiteSpace($envFrom)){ Fail "FROM missing and CO_SESSION_LABEL empty." }
  $rawFrom=$envFrom
}else{
  $rawFrom=$From.Trim()
  if(-not [string]::IsNullOrWhiteSpace($envFrom)){
    $canonEnv=ResolveId $envFrom 'FROM(env)'
    $canonArg=ResolveId $rawFrom 'FROM(arg)'
    if($canonEnv -ne $canonArg){ Fail ("FROM mismatch arg='{0}' env='{1}' (use -FromEnv)." -f $canonArg,$canonEnv) }
  }
}
$fromCanon=ResolveId $rawFrom 'FROM'

function ValidateLine([string]$line){
  if($line -match "(\r|\n)"){ Fail "Emitter newline" }
  if($line -match '#><#'){ Fail "Emitter glued blocks '#><#'" }
  if(-not ($line.Trim().StartsWith('# <# # '))){ Fail "Bad prefix" }
  if(-not ($line.Trim().EndsWith(' END #>'))){ Fail "Bad suffix" }
}

for($k=0; $k -lt $To.Count; $k++){
  $toCanon=ResolveId $To[$k] ("TO[{0}]" -f $k)
  if($toCanon -eq $fromCanon){ Fail ("Refusing FROM==TO ({0})" -f $fromCanon) }
  $line=OneLine( ("# <# # {0} | TO={1} | FROM={2} | UTC={3} | STATE={4} | INTENT={5} END #>" -f $Kind,$toCanon,$fromCanon,$Utc,$State,$Intent[$k]) )
  ValidateLine $line
  Write-Output $line
}