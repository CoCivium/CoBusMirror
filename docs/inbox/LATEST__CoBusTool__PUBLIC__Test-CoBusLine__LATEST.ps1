<# Test-CoBusLine (PUBLIC, LATEST) FAIL-CLOSED. #>
param([Parameter(Mandatory=$true)][string]$Line)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
function Fail([string]$m){ throw "FAIL-CLOSED: $m" }

if($Line -match "(\r|\n)"){ Fail "Line contains newline (must be one physical line)" }
$trim=$Line.Trim()

if(-not ($trim.StartsWith('# <# # '))){ Fail "Bad prefix '# <# # '" }
if(-not ($trim.EndsWith(' END #>'))){ Fail "Bad suffix ' END #>'" }

# detect glued blocks, including observed '#># <#' and any second block start
if($trim -match '#><#'){ Fail "Glued blocks '#><#' detected" }
if($trim -match '#>#\s*<#'){ Fail "Glued blocks '#># <#' detected" }
$starts = ([regex]::Matches($trim, [regex]::Escape('# <# # '))).Count
if($starts -ne 1){ Fail ("Multiple blocks detected (# <# # count={0}); must paste one note per line" -f $starts) }

if($trim -notmatch '\s(SideNote|CoPong)\s*\|'){ Fail "Missing Kind token" }
foreach($k in 'TO=','FROM=','UTC=','STATE=','INTENT='){ if($trim -notmatch [regex]::Escape($k)){ Fail ("Missing {0}" -f $k) } }
if($trim -match '\bTO=\s*\|'){ Fail "Empty TO" }
if($trim -match '\bFROM=\s*\|'){ Fail "Empty FROM" }

"PASS"