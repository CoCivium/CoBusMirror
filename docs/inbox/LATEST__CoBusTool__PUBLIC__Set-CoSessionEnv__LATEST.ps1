param(
  [Parameter(Mandatory=$true)][string]$From,
  [Parameter(Mandatory=$true)][string]$To
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'

function Assert-CoSessionLabel([string]$Label,[string]$Field){
  if([string]::IsNullOrWhiteSpace($Label)){ throw "FAIL-CLOSED: $Field missing" }
  if($Label -match '\s'){ throw "FAIL-CLOSED: $Field contains whitespace: $Label" }
  if($Label -match '^[^/]+/[^/]+$'){ throw "FAIL-CLOSED: $Field looks like a repo ($Label)" }
  if($Label -notmatch '^[A-Za-z0-9][A-Za-z0-9._-]{1,79}(\|[A-Za-z0-9][A-Za-z0-9._-]{1,79}){0,3}$'){
    throw "FAIL-CLOSED: $Field not an allowed label token(s): $Label"
  }
}

Assert-CoSessionLabel $From 'FROM'
Assert-CoSessionLabel $To   'TO'

$env:CO_SESSION_LABEL        = $From.Trim()
$env:CO_TARGET_SESSION_LABEL = $To.Trim()

"OK: CO_SESSION_LABEL=$($env:CO_SESSION_LABEL) CO_TARGET_SESSION_LABEL=$($env:CO_TARGET_SESSION_LABEL)"