<# New-CoNoteLine (PUBLIC, LATEST) FAIL-CLOSED.
   Generates a one-line SideNote/CoPong suitable for PS7 pasting.
   FROM defaults to $env:CO_SESSION_LABEL (required). Blocks self-address (TO==FROM).
   Optional -Copy copies the *comment line* to clipboard.
#>
param(
  [ValidateSet('SideNote','CoPong')][string]$Kind='SideNote',
  [Parameter(Mandatory=$true)][string]$To,
  [string]$From = $env:CO_SESSION_LABEL,
  [string]$Utc = '',
  [ValidateSet('hold','doing','done','todo')][string]$State='doing',
  [Parameter(Mandatory=$true)][string]$Intent,
  [switch]$Copy
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }

if(-not $From){ Fail "Missing FROM. Set CO_SESSION_LABEL or pass -From." }
if($From -eq $To){ Fail "Self-address blocked (TO == FROM). Use this only for inter-session notes." }
if(-not $Utc){ $Utc = UTS }

# normalize Intent to one physical line
$Intent = ($Intent -replace "(\r?\n)+"," " -replace "\s{2,}"," ").Trim()

$line = "# <# # $Kind | FROM=$From | TO=$To | UTC=$Utc | STATE=$State | INTENT=$Intent END #>"
if($line -match "(\r|\n)"){ Fail "Line contains newline (must be one physical line)" }

# validate against Test-CoBusLine if present
try{
  $top = (git rev-parse --show-toplevel 2>$null | Out-String).Trim()
  if($top){
    $test = Join-Path $top 'docs/inbox/LATEST__CoBusTool__PUBLIC__Test-CoBusLine__LATEST.ps1'
    if(Test-Path -LiteralPath $test){ & $test -Line $line | Out-Null }
  }
}catch{ Fail ("Validation failed: " + $_.Exception.Message) }

if($Copy){
  try{ Set-Clipboard -Value $line } catch { Fail ("Clipboard copy failed: " + $_.Exception.Message) }
}

# One visual line, with reversed label
Write-Host -NoNewline "# <# # "
Write-Host -NoNewline $Kind -ForegroundColor Black -BackgroundColor Yellow
Write-Host (" | FROM=$From | TO=$To | UTC=$Utc | STATE=$State | INTENT=$Intent END #>") -ForegroundColor DarkYellow