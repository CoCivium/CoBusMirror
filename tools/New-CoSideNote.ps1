param(
  [Parameter(Mandatory=$true)][string]$From,
  [Parameter(Mandatory=$true)][string]$To,
  [Parameter(Mandatory=$true)][ValidateSet('doing','done','hold','blocked')][string]$State,
  [Parameter(Mandatory=$true)][string]$Intent,
  [string]$Utc = $null
)
Set-StrictMode -Version Latest
$ErrorActionPreference='Stop'
function Fail([string]$m){ throw "FAIL-CLOSED: $m" }
function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }
if([string]::IsNullOrWhiteSpace($Utc)){ $Utc = UTS }
if($To -match '(?i)chatgpt|self|me\b|notes?\s*to\s*self'){ Fail "TO rejected (notes-to-self)." }
if($From -eq $To){ Fail "FROM == TO (self-addressed)" }
function OneLine([string]$s){ ($s -replace "(\r?\n)+"," " -replace "\s{2,}"," ").Trim() }
$payload = "<# # SideNote | FROM=$From | TO=$To | UTC=$Utc | STATE=$State | INTENT=$(OneLine $Intent) | END #>"
Write-Host ""
Write-Host "==== SideNote (COPY this one physical line) ===="
Write-Host $payload
Write-Host "==============================================="
Write-Host ""