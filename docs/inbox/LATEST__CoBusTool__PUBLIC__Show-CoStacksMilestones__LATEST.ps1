<# Show-CoStacksMilestones (PUBLIC, LATEST) FAIL-CLOSED.
   Reads CoStacks manifest JSON and prints a one-line milestones bar + counts.
   Default manifest: docs/inbox/LATEST__CoBusNote__PUBLIC__CoStacks_Manifest__LATEST.json
#>
param(
  [string]$ManifestPath = '.\docs\inbox\LATEST__CoBusNote__PUBLIC__CoStacks_Manifest__LATEST.json',
  [switch]$Plain
)

Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
function OneLine([string]$s){ ($s -replace "(\r?\n)+"," " -replace "\s{2,}"," ").Trim() }

if(-not (Test-Path -LiteralPath $ManifestPath)){ Fail "Missing manifest: $ManifestPath" }
$m = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json

$r = $null
foreach($k in 'rungs','milestones','items','stacks'){
  if($m.PSObject.Properties.Name -contains $k){
    $r = $m.$k
    if($r){ break }
  }
}
if(-not $r){
  $line = "CoStacks: manifest schema unknown (no rungs/milestones/items/stacks). file=$ManifestPath"
  if($Plain){ Write-Output $line } else { Write-Host $line -ForegroundColor Yellow }
  exit 0
}

$r = @($r)
$total = $r.Count

function NormState($x){
  if($null -eq $x){ return 'UNKNOWN' }
  $s = ($x.ToString()).Trim().ToLower()
  if($s -in @('pass','passed','done','ok','complete','completed','merged')){ return 'PASS' }
  if($s -in @('hold','blocked','paused')){ return 'HOLD' }
  if($s -in @('doing','inprogress','in-progress','wip','active')){ return 'DOING' }
  if($s -in @('fail','failed','error')){ return 'FAIL' }
  if($s -in @('todo','next','queued','pending')){ return 'TODO' }
  return 'UNKNOWN'
}

$counts = @{ PASS=0; HOLD=0; DOING=0; TODO=0; FAIL=0; UNKNOWN=0 }
$tags = New-Object System.Collections.Generic.List[string]
for($i=0; $i -lt $r.Count; $i++){
  $it = $r[$i]
  $name = $null
  foreach($nk in 'id','code','name','label','rung','milestone'){
    if($it.PSObject.Properties.Name -contains $nk){ $name = $it.$nk; if($name){ break } }
  }
  if(-not $name){ $name = "R$([int]($i+1))" }

  $stRaw = $null
  foreach($sk in 'state','status','result'){
    if($it.PSObject.Properties.Name -contains $sk){ $stRaw = $it.$sk; if($stRaw){ break } }
  }
  $st = NormState $stRaw
  if(-not $counts.ContainsKey($st)){ $st='UNKNOWN' }
  $counts[$st]++
  $tags.Add( ("[{0}:{1}]" -f $name,$st) ) | Out-Null
}

$bar = ($tags -join '')
$summary = "PASS=$($counts.PASS) HOLD=$($counts.HOLD) DOING=$($counts.DOING) TODO=$($counts.TODO) FAIL=$($counts.FAIL) UNKNOWN=$($counts.UNKNOWN) TOTAL=$total"
$line = OneLine ("CoStacks " + $bar + " :: " + $summary)

if($Plain){ Write-Output $line }
else {
  Write-Host $line -ForegroundColor Cyan
  if($counts.FAIL -gt 0){ Write-Host "FAIL present => investigate gates before claiming MVP." -ForegroundColor Red }
  elseif($counts.HOLD -gt 0){ Write-Host "HOLD present => expected if workflows/rung8 are HOLD." -ForegroundColor Yellow }
}