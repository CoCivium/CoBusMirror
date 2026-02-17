# COPYPONG | SHELL=pwsh | COPY_SAFE=TRUE | NAME=CoBlock.NoHangWrapper.TEMPLATE | NOTE=Wrap long work so users never see a “hanging cursor” and never need Ctrl+C. Shows a heartbeat until work finishes; always prints END marker.
& {
  Set-StrictMode -Version Latest
  $ErrorActionPreference='Stop'
  $ProgressPreference='SilentlyContinue'

  function OneLine([string]$s){ ($s -replace "(\r?\n)+"," " -replace "\s{2,}"," ").Trim() }
  function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }
  function Fail([string]$m){ throw "FAIL-CLOSED: $m" }

  function Invoke-CoNoHang {
    param(
      [Parameter(Mandatory=$true)][scriptblock]$Work,
      [int]$HeartbeatSeconds = 2,
      [string]$Label = "WORK"
    )

    $utc = UTS
    $sw = [Diagnostics.Stopwatch]::StartNew()
    Write-Host (OneLine "CO_NOHANG|UTC=$utc|STATE=START|LABEL=$Label|NOTES=Heartbeat running; do not interrupt.")
    $job = Start-Job -ScriptBlock {
      param($sb)
      & $sb
    } -ArgumentList $Work

    try {
      while($true){
        $s = $job.State
        if($s -in @('Completed','Failed','Stopped')){ break }
        $t = [int]$sw.Elapsed.TotalSeconds
        # Visible heartbeat (no carriage-return tricks; safe for PS7 panels/logs)
        Write-Host (OneLine "CO_NOHANG|UTC=$utc|STATE=RUNNING|LABEL=$Label|ELAPSED_S=$t|JOB_STATE=$s")
        Start-Sleep -Seconds $HeartbeatSeconds
      }

      Receive-Job -Job $job -ErrorAction Stop | Out-Host
      $final = $job.State
      $t2 = [int]$sw.Elapsed.TotalSeconds
      if($final -ne 'Completed'){
        Fail ("Work did not complete cleanly. job_state=" + $final)
      }

      Write-Host (OneLine "CO_NOHANG|UTC=$utc|STATE=PASS|LABEL=$Label|ELAPSED_S=$t2|NOTES=Work finished; prompt should return now.")
    }
    catch {
      $t3 = [int]$sw.Elapsed.TotalSeconds
      Write-Host (OneLine "CO_NOHANG|UTC=$utc|STATE=FAIL|LABEL=$Label|ELAPSED_S=$t3|ERR=$($_.Exception.Message)")
      throw
    }
    finally {
      try { Stop-Job -Job $job -Force -ErrorAction SilentlyContinue | Out-Null } catch {}
      try { Remove-Job -Job $job -Force -ErrorAction SilentlyContinue | Out-Null } catch {}
      $sw.Stop()
      Write-Host "# COPY_SAFE:TRUE | END_OF_BLOCK"
    }
  }

  # =========================
  # EXAMPLE USAGE (replace)
  # =========================
  Invoke-CoNoHang -Label "Example.Sleep10" -HeartbeatSeconds 2 -Work {
    Start-Sleep -Seconds 10
    "EXAMPLE_DONE"
  }
}
