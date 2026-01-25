<#
CoFetchVerify.ps1 — download a URL_RAW, verify SHA256, optionally run it.
Usage:
  pwsh -NoProfile -File .\tools\pwsh\CoFetchVerify.ps1 -UrlRaw <URL_RAW> -Sha256 <hex> -OutFile <path> -Run
#>
param(
  [Parameter(Mandatory=$true)][string]$UrlRaw,
  [Parameter(Mandatory=$true)][string]$Sha256,
  [Parameter(Mandatory=$false)][string]$OutFile = (Join-Path $env:TEMP ("cofetch_" + ([Guid]::NewGuid().ToString("N")) + ".ps1")),
  [Parameter(Mandatory=$false)][switch]$Run
)

$ErrorActionPreference="Stop"; Set-StrictMode -Version Latest

Write-Host ("DL: " + $UrlRaw)
Invoke-WebRequest -Uri $UrlRaw -OutFile $OutFile | Out-Null
$actual = (Get-FileHash -LiteralPath $OutFile -Algorithm SHA256).Hash.ToLower()
$expect = $Sha256.ToLower()
if($actual -ne $expect){ throw ("SHA MISMATCH expected=" + $expect + " actual=" + $actual + " file=" + $OutFile) }
Write-Host ("SHA PASS: " + $actual)
Write-Host ("FILE: " + $OutFile)
if($Run){
  Write-Host "RUN: pwsh -NoProfile -File <downloaded>"
  & pwsh -NoProfile -File $OutFile
}
"OK"
