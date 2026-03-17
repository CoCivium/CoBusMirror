function Write-CoSignal {
    param([string]$Text)
    Write-Host $Text -ForegroundColor Magenta
}

function Write-CoPongLine {
    param([string]$Text)
    Write-Host $Text -ForegroundColor White -BackgroundColor DarkMagenta
}
