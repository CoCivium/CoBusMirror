param(
    [string]$CoPong
)

function Write-MagentaCoPong {
    param([string]$Text)
    Write-Host $Text -ForegroundColor Magenta
}

Write-MagentaCoPong $CoPong

# do not print anything else
return
