param(
  [string]$Session = "4.0|PRIME|260307",
  [string]$Role = "PRM|CORE|260307",
  [string]$Ptr = ""
)

function Write-CoProof { param([string]$t) Write-Host $t -ForegroundColor Cyan }
function Write-CoStatus { param([string]$t) Write-Host $t -ForegroundColor Yellow }

Write-CoStatus ("RENAME_CHAT_TO: " + $Session + "  (optional but helpful)")
$bootstrap = "BOOTSTRAP: CoSync | SESSION=" + $Session + " | ROLE=" + $Role + ( $Ptr ? (" | PTR=" + $Ptr) : "" )
Write-CoProof $bootstrap
