function Write-CoProof {
    param([string]$Text)
    Write-Host $Text -ForegroundColor Cyan
}

function Write-CoStatus {
    param([string]$Text)
    Write-Host $Text -ForegroundColor Yellow
}

function Write-MagentaCoPong {
    param([string]$Text)
    Write-Host $Text -ForegroundColor Magenta
}

function Write-CoSignal {
    param([string]$Text)
    Write-Host $Text -ForegroundColor White -BackgroundColor DarkBlue
}
