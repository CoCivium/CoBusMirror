Set-StrictMode -Version Latest

function ConvertTo-CoOneLine {
  param([Parameter(Mandatory=$true)][string]$Text)
  (($Text -replace "(\r?\n)+"," " -replace "\s{2,}"," ").Trim())
}

function New-CoSideNoteLine {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$true)][string]$From,
    [Parameter(Mandatory=$true)][string]$To,
    [Parameter(Mandatory=$true)][string]$Utc,
    [Parameter(Mandatory=$true)][string]$State,
    [Parameter(Mandatory=$true)][string]$Intent
  )
  $sn = "<# # SideNote | FROM=$From | TO=$To | UTC=$Utc | STATE=$State | INTENT=$Intent END #>"
  ConvertTo-CoOneLine $sn
}

function Out-CoSideNote {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$true)][string]$SideNoteLine,
    [Parameter(Mandatory=$true)][string]$Label
  )
  # reverse-video-ish banner (console): black on yellow
  Write-Host ""
  Write-Host (" " + $Label + " ") -ForegroundColor Black -BackgroundColor Yellow -NoNewline
  Write-Host "  copy next line" -ForegroundColor Yellow
  # SideNote line (one physical line; copy/paste safe)
  Write-Host (ConvertTo-CoOneLine $SideNoteLine) -ForegroundColor DarkGreen
}

Export-ModuleMember -Function ConvertTo-CoOneLine, New-CoSideNoteLine, Out-CoSideNote -ErrorAction SilentlyContinue
