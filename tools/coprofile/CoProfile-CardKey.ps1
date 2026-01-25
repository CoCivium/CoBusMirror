<#
CoProfile-CardKey.ps1
Deterministic mnemonic card_key (seed).
Usage:
  pwsh -NoProfile -File .\CoProfile-CardKey.ps1 -CoProfileId cp_xxx -PrefsJson '{...}' -ThemeId default
#>
param(
  [Parameter(Mandatory=$true)][string]$CoProfileId,
  [Parameter(Mandatory=$true)][string]$PrefsJson,
  [Parameter(Mandatory=$false)][string]$ThemeId = "default",
  [Parameter(Mandatory=$false)][string]$Version = "0.1"
)

$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest

function Sha256Bytes([byte[]]$bytes){
  $sha = [System.Security.Cryptography.SHA256]::Create()
  return $sha.ComputeHash($bytes)
}

function CanonicalizeJson([string]$json){
  # Seed-only: stable top-level key ordering. Later: RFC 8785 canonical JSON.
  $obj = $json | ConvertFrom-Json -Depth 50
  $ht = [ordered]@{}
  foreach($k in ($obj.PSObject.Properties.Name | Sort-Object)){
    $ht[$k] = $obj.$k
  }
  return ($ht | ConvertTo-Json -Depth 50 -Compress)
}

function Base32Like([byte[]]$bytes){
  # Seed base32-ish (stable mnemonic, not RFC4648 exact).
  $alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
  $bits = New-Object System.Collections.Generic.List[int]
  foreach($b in $bytes){
    for($i=7;$i -ge 0;$i--){ $bits.Add((($b -shr $i) -band 1)) | Out-Null }
  }
  $out = New-Object System.Text.StringBuilder
  for($i=0; $i -lt $bits.Count; $i+=5){
    $v=0
    for($j=0;$j -lt 5;$j++){
      $v = $v -shl 1
      if(($i+$j) -lt $bits.Count){ $v = $v -bor $bits[$i+$j] }
    }
    [void]$out.Append($alphabet[$v])
  }
  return $out.ToString().Substring(0,32)
}

$canon = CanonicalizeJson $PrefsJson
$payload = "$CoProfileId|$Version|$canon|$ThemeId"
$bytes = [System.Text.Encoding]::UTF8.GetBytes($payload)
$hash  = Sha256Bytes $bytes
$key   = "B32:" + (Base32Like $hash)

$key
