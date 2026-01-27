<# Emit-CoNotes (PUBLIC, LATEST) FAIL-CLOSED.
   Prints PS7-friendly copy blocks for SideNote/CoPong. One-line output; TO-first fields.
   Highlights literal word SideNote (black-on-amber) and CoPong (black-on-magenta) in console ONLY.
   Example:
     & .\docs\inbox\LATEST__CoBusTool__PUBLIC__Emit-CoNotes__LATEST.ps1 -Kind SideNote -From 'X' -To @('Y') -Intent @('...') -State doing -Utc '20260126T__AUTO__Z'
#>
param(
  [Parameter(Mandatory=$true)][ValidateSet('SideNote','CoPong')] [string]$Kind,
  [Parameter(Mandatory=$true)][string]$From,
  [Parameter(Mandatory=$true)][string[]]$To,
  [Parameter(Mandatory=$true)][string[]]$Intent,
  [Parameter(Mandatory=$true)][ValidateSet('doing','hold','done')] [string]$State,
  [Parameter(Mandatory=$true)][string]$Utc
)

Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'

function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
function OneLine([string]$s){ ($s -replace "(\r?\n)+"," " -replace "\s{2,}"," ").Trim() }

$from = $From.Trim()
if([string]::IsNullOrWhiteSpace($from)){ Fail "Empty -From" }
if($To.Count -ne $Intent.Count){ Fail "Count mismatch: -To must equal -Intent" }

$dimMsg = "<<< COPY $Kind (TRIPLE-CLICK NEXT LINE) >>>"
$endMsg = "<<< END $Kind >>>"

function Write-HighlightedKindLine([string]$line,[string]$kind){
  $line = OneLine $line
  $i = $line.IndexOf($kind,[System.StringComparison]::Ordinal)
  if($i -lt 0){ Write-Host $line -ForegroundColor DarkYellow; return }

  $pre  = $line.Substring(0,$i)
  $post = $line.Substring($i + $kind.Length)

  Write-Host $pre -NoNewline -ForegroundColor DarkYellow
  if($kind -eq 'SideNote'){
    Write-Host $kind -NoNewline -ForegroundColor Black -BackgroundColor DarkYellow
  } else {
    Write-Host $kind -NoNewline -ForegroundColor Black -BackgroundColor Magenta
  }
  Write-Host $post -ForegroundColor DarkYellow
}

function Show([string]$line){
  Write-Host ""
  Write-Host $dimMsg -ForegroundColor DarkGray
  Write-HighlightedKindLine $line $Kind
  Write-Host $endMsg -ForegroundColor DarkGray
  Write-Host ""
}

for($k=0; $k -lt $To.Count; $k++){
  $to = $To[$k].Trim()
  if([string]::IsNullOrWhiteSpace($to)){ Fail "Empty TO at index $k" }
  if($to -eq $from){ Fail "Refusing FROM==TO ($from)" }
  $line = "# <# # $Kind | TO=$to | FROM=$from | UTC=$Utc | STATE=$State | INTENT=$($Intent[$k]) END #>"
  Show $line
}