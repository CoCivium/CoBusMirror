param(
  [Parameter(Mandatory=$true)][ValidateSet('doing','done','hold')][string]$State,
  [Parameter(Mandatory=$true)][string]$Intent,
  [string]$Repo = '',
  [string]$ChatUrl = '',
  [string]$ChatUid = ''
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'

function Assert-CoSessionLabel([string]$Label,[string]$Field){
  if([string]::IsNullOrWhiteSpace($Label)){ throw "FAIL-CLOSED: $Field missing" }
  if($Label -match '\s'){ throw "FAIL-CLOSED: $Field contains whitespace: $Label" }
  # repo-looking labels are forbidden
  if($Label -match '^[^/]+/[^/]+$'){ throw "FAIL-CLOSED: $Field looks like a repo ($Label)" }
  # allow: CoShare_Migration_2 OR 4.0|PRIME|260125 OR CoX|v1
  if($Label -notmatch '^[A-Za-z0-9][A-Za-z0-9._-]{1,79}(\|[A-Za-z0-9][A-Za-z0-9._-]{1,79}){0,3}$'){
    throw "FAIL-CLOSED: $Field not an allowed label token(s): $Label"
  }
}

Assert-CoSessionLabel $env:CO_SESSION_LABEL 'CO_SESSION_LABEL'
Assert-CoSessionLabel $env:CO_TARGET_SESSION_LABEL 'CO_TARGET_SESSION_LABEL'

if([string]::IsNullOrWhiteSpace($Intent)){ throw "FAIL-CLOSED: Intent missing" }

# prevent breaking the block comment wrapper
if($Intent -match '#>'){ throw "FAIL-CLOSED: Intent contains '#>' terminator sequence" }

$utc  = (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ')
$from = $env:CO_SESSION_LABEL.Trim()
$to   = $env:CO_TARGET_SESSION_LABEL.Trim()

# sanitize to ONE physical line
$intent1 = ($Intent -replace "(\r?\n)+"," " -replace "\s{2,}"," ").Trim()

$extra = @()
if($Repo){   $extra += "REPO=$Repo" }
if($ChatUrl){$extra += "CHAT_URL=$ChatUrl" }
if($ChatUid){$extra += "CHAT_UID=$ChatUid" }
$extraTxt = if($extra.Count){ " | " + ($extra -join " | ") } else { "" }

"<# # CoPong | FROM=$from | TO=$to | UTC=$utc | STATE=$State | INTENT=$intent1$extraTxt END #>"