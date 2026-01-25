<#
Minimal invariant checks (seed). Throws if invalid, prints OK if valid.
Usage:
  $json = Get-Content bundle.json -Raw
  pwsh -NoProfile -File .\CoProfile-ValidateBundle.ps1 -BundleJson $json
#>
param([Parameter(Mandatory=$true)][string]$BundleJson)

$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest

$b = $BundleJson | ConvertFrom-Json -Depth 50
function Req([bool]$cond,[string]$msg){ if(-not $cond){ throw $msg } }

Req ($b.version -eq "0.1") "version must be 0.1"
Req ($b.coprofile_id -and $b.coprofile_id.Length -ge 16) "coprofile_id missing/short"
Req ($b.style_prefs) "style_prefs missing"
Req ($b.consent_scope) "consent_scope missing"
Req ($b.disclosure_min -in @("prefs_only","prefs_plus_receipts")) "disclosure_min invalid"
Req ($b.pet_owner_type_key -and $b.pet_owner_type_key.ToString().StartsWith("B32:")) "pet_owner_type_key must start with B32:"

# Prohibitions: seed pack is prefs+consent only
if($b.PSObject.Properties.Name -contains "trust_score"){ throw "trust_score is prohibited in seed bundle" }
if($b.PSObject.Properties.Name -contains "rep"){ throw "rep must not be embedded in seed bundle" }
if($b.PSObject.Properties.Name -contains "proofs"){ throw "proofs must not be embedded in seed bundle" }

"OK"
