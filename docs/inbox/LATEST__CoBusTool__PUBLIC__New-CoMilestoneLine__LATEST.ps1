param(
  [Parameter(Mandatory=$true)][ValidateSet('SES','PROJ')][string]$Scope,
  [Parameter(Mandatory=$true)][string]$Id,
  [Parameter(Mandatory=$true)][ValidateRange(0,99)][int]$Current,
  [Parameter(Mandatory=$true)][ValidateRange(1,99)][int]$Total,
  [ValidateRange(0,99)][int]$Next = 0,
  [Parameter(Mandatory=$true)][ValidateRange(1,99)][int]$Exit,
  [ValidateSet('OPT','-')][string]$Ext = 'OPT',
  [ValidateRange(0.0,1.0)][double]$Confidence = 0.7,
  [ValidateSet('L','M','H')][string]$Tax = 'M',
  [string]$Lane = ''
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'

if([string]::IsNullOrWhiteSpace($Id)){ throw "Id required" }
if($Current -gt $Total){ throw "Current>$Total" }
if($Exit -gt $Total){ throw "Exit>$Total" }

$nextOut = if($Next -le 0){ '-' } else { [string]$Next }
$laneOut = if([string]::IsNullOrWhiteSpace($Lane)){ '' } else { " LANE=$Lane" }

"ML1 S=$Scope ID=$Id$laneOut M=$Current/$Total N=$nextOut X=$Exit EXT=$Ext C=$([Math]::Round($Confidence,2)) T=$Tax"