<#
Emit a seed sample bundle JSON to stdout.
#>
param(
  [Parameter(Mandatory=$false)][string]$CoProfileId = ("cp_" + ([Guid]::NewGuid().ToString("N"))),
  [Parameter(Mandatory=$false)][string]$ThemeId = "default"
)

$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest

$prefs = @{
  critique_mode="SoftBall"
  directness=3
  pace=3
  pushback=2
  uncertainty_display="explicit"
  affect="warm"
  risk_posture="conservative"
}

$prefsJson = ($prefs | ConvertTo-Json -Compress)
$cardKey = & "$PSScriptRoot\CoProfile-CardKey.ps1" -CoProfileId $CoProfileId -PrefsJson $prefsJson -ThemeId $ThemeId
$now = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

$bundle = @{
  coprofile_id=$CoProfileId
  version="0.1"
  style_prefs=$prefs
  consent_scope=@{
    default="prefs_only"
    contexts=@(
      @{ctx="chat"; allow=@("style_prefs","pet_owner_type_key")}
      @{ctx="xr_overlay"; allow=@("style_prefs","pet_owner_type_key")}
    )
  }
  disclosure_min="prefs_only"
  pet_owner_type_key=$cardKey
  receipts=@{
    consent_receipt_ref="URL_RAW=https://example.invalid/receipt/seed"
    created_at=$now
    updated_at=$now
    expires_at=$null
    revocation_ref=$null
  }
  pointers=@("https://raw.githubusercontent.com/CoCivium/CoBusMirror/main/docs/COBEACON_LATEST.txt")
  signature=$null
}

$bundle | ConvertTo-Json -Depth 50
