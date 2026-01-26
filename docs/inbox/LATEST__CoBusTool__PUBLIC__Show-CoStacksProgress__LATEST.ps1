param(
  [Parameter(Mandatory=$true)][string]$Repo,
  [switch]$VerifyRaw
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }

$here = Split-Path $MyInvocation.MyCommand.Path -Parent
$manifest = Join-Path $here 'LATEST__CoBusNote__PUBLIC__CoStacks_Manifest__LATEST.json'
if(-not (Test-Path $manifest)){ Fail "Missing manifest: $manifest" }

$j = Get-Content -LiteralPath $manifest -Raw | ConvertFrom-Json
$total = [int]$j.total_rungs
$done = @($j.rungs | Where-Object { $_.done -eq $true }).Count
$pct = [Math]::Round(($done / $total)*100,1)

$barWidth = 20
$filled = [Math]::Round(($pct/100)*$barWidth)
$bar = ('█' * $filled) + ('░' * ($barWidth - $filled))
"CoStacks total-solution ladder: [$bar] $pct% (done=$done total=$total) Repo=$Repo"

if($VerifyRaw){
  $base = "https://raw.githubusercontent.com/$Repo/main/"
  foreach($r in @($j.rungs | Where-Object { param(
  [Parameter(Mandatory=$true)][string]$Repo,
  [switch]$VerifyRaw
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }

$here = Split-Path $MyInvocation.MyCommand.Path -Parent
$manifest = Join-Path $here 'LATEST__CoBusNote__PUBLIC__CoStacks_Manifest__LATEST.json'
if(-not (Test-Path $manifest)){ Fail "Missing manifest: $manifest" }

$j = Get-Content -LiteralPath $manifest -Raw | ConvertFrom-Json
$total = [int]$j.total_rungs
$done = @($j.rungs | Where-Object { $_.done -eq $true }).Count
$pct = [Math]::Round(($done / $total)*100,1)

$barWidth = 20
$filled = [Math]::Round(($pct/100)*$barWidth)
$bar = ('█' * $filled) + ('░' * ($barWidth - $filled))
"CoStacks total-solution ladder: [$bar] $pct% (done=$done total=$total) Repo=$Repo"

if($VerifyRaw){
  $base = "https://raw.githubusercontent.com/$Repo/main/"
  foreach($r in $j.rungs){
    foreach($p in @($r.evidence)){
      $url = $base + ($p -replace '\\','/')
      $sha = $url + '.sha256'
      $cb=UTS; $u1="$url?cb=$cb"; $u2="$sha?cb=$cb"
      $f=New-TemporaryFile; $s=New-TemporaryFile
      $resp = Invoke-WebRequest -UseBasicParsing -Headers @{ 'Cache-Control'='no-cache'; 'Pragma'='no-cache' } -Uri $u1 -OutFile $f -PassThru
      if($resp.StatusCode -ne 200){ Fail "HTTP $($resp.StatusCode) $url" }
      $resp2 = Invoke-WebRequest -UseBasicParsing -Headers @{ 'Cache-Control'='no-cache'; 'Pragma'='no-cache' } -Uri $u2 -OutFile $s -PassThru
      if($resp2.StatusCode -ne 200){ Fail "HTTP $($resp2.StatusCode) $sha" }
      $exp = ((Get-Content -LiteralPath $s -Raw) -split '\s+')[0].Trim().ToLower()
      if($exp -notmatch '^[0-9a-f]{64}$'){ Fail "BAD SHA at $sha" }
      $act = (Get-FileHash -LiteralPath $f -Algorithm SHA256).Hash.ToLower()
      if($act -ne $exp){ Fail "SHA mismatch at $url" }
      "OK RAW+SHA rung=$($r.n) path=$p"
    }
  }
}.done -eq $true })){
    foreach($p in @($r.evidence)){
      $url = $base + ($p -replace '\\','/')
      $sha = $url + '.sha256'
      $cb=UTS; $u1="$url?cb=$cb"; $u2="$sha?cb=$cb"
      $f=New-TemporaryFile; $s=New-TemporaryFile
      $resp = Invoke-WebRequest -UseBasicParsing -Headers @{ 'Cache-Control'='no-cache'; 'Pragma'='no-cache' } -Uri $u1 -OutFile $f -PassThru
      if($resp.StatusCode -ne 200){ Fail "HTTP $($resp.StatusCode) $url" }
      $resp2 = Invoke-WebRequest -UseBasicParsing -Headers @{ 'Cache-Control'='no-cache'; 'Pragma'='no-cache' } -Uri $u2 -OutFile $s -PassThru
      if($resp2.StatusCode -ne 200){ Fail "HTTP $($resp2.StatusCode) $sha" }
      $exp = ((Get-Content -LiteralPath $s -Raw) -split '\s+')[0].Trim().ToLower()
      if($exp -notmatch '^[0-9a-f]{64}$'){ Fail "BAD SHA at $sha" }
      $act = (Get-FileHash -LiteralPath $f -Algorithm SHA256).Hash.ToLower()
      if($act -ne $exp){ Fail "SHA mismatch at $url" }
      "OK RAW+SHA rung=$($r.n) path=$p"
    }
  }
}