# NoHereString Pattern v0.1 (PUBLIC)

## Problem
Pasting PowerShell here-strings into chat/PS7 often breaks due to line wrapping or terminator corruption.

## Rule
- Avoid @" "@ and @' '@ in pasted DO blocks.
- Instead, emit file bodies as arrays of lines and join with `n.

## Canonical snippet
```powershell
$lines = @(
  'line one',
  'line two'
)
Set-Content -LiteralPath $path -Value ($lines -join \"`n\") -Encoding UTF8
```

## Optional: URL_RAW + SHA workflow
- Publish large scripts/specs as versioned files in repo.
- Paste only a short runner command locally that downloads URL_RAW and checks SHA.
- Use tools/pwsh/CoFetchVerify.ps1 for this.

END
