<# OE_HYGIENE v0.1 — detect-only default; FAIL-CLOSED. #>
[CmdletBinding()]param([ValidateSet('detect','apply')][string]$Mode='detect',[string]$OutDir=(Join-Path "" '..\receipts'))
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }
function C([string]$id,[string]$st,[string]$sum,[string]$ev,[string]$fix){[pscustomobject]@{id=$id;status=$st;summary=$sum;evidence=$ev;remediation=$fix}}
$utc=UTS; $checks=New-Object System.Collections.Generic.List[object]
$rk='HKCU:\Software\CoCivium\OE_HYGIENE\RunKeyGuard'; $rkOk=$false
try{ $v=(Get-ItemProperty -Path $rk -Name Enabled -ErrorAction Stop).Enabled; $rkOk=($v -eq 1 -or $v -eq '1') }catch{ $rkOk=$false }
$schDenied=$false
try{ & schtasks /Query /TN '\NonExistent_Task_For_Probe' 1>$null 2>$null; $checks.Add((C 'schtasks.access' 'PASS' 'schtasks callable' 'ok' 'none'))|Out-Null }catch{ if($_.Exception.Message -match 'Access is denied|denied'){ $schDenied=$true } else { $checks.Add((C 'schtasks.access' 'WARN' 'schtasks probe failed' $_.Exception.Message 'investigate'))|Out-Null } }
if($Mode -eq 'apply' -and -not $rkOk){ try{ New-Item -Path $rk -Force|Out-Null; New-ItemProperty -Path $rk -Name Enabled -Value 1 -PropertyType DWord -Force|Out-Null; $rkOk=$true }catch{ $checks.Add((C 'guard.runkey.present' 'FAIL' 'failed to set guard marker' $_.Exception.Message 'fix permissions or run detect'))|Out-Null } }
if($rkOk){ $checks.Add((C 'guard.runkey.present' 'PASS' 'fallback guard present' 'HKCU marker Enabled=1' 'none'))|Out-Null } else { $checks.Add((C 'guard.runkey.present' 'WARN' 'fallback guard absent' 'HKCU marker missing' 'Mode=apply OR rely on schtasks'))|Out-Null }
if($schDenied){ if($rkOk){ $checks.Add((C 'schtasks.access' 'WARN' 'schtasks denied; guard present' 'AccessDenied' 'ok Gate-1 MVP'))|Out-Null } else { $checks.Add((C 'schtasks.access' 'FAIL' 'schtasks denied; no guard' 'AccessDenied' 'enable guard or restore schtasks'))|Out-Null } }
try{ $gv=(& git --version 2>$null).Trim(); if(-not $gv){ throw 'empty' }; $checks.Add((C 'git.health.baseline' 'PASS' 'git runnable' $gv 'none'))|Out-Null }catch{ $checks.Add((C 'git.health.baseline' 'FAIL' 'git not runnable' $_.Exception.Message 'repair git / PATH / security'))|Out-Null }
$flag=Join-Path $env:LOCALAPPDATA 'CoCivium\OE_HYGIENE\signals\security_falsepositive.flag'
if(Test-Path $flag){ $checks.Add((C 'security.falsepositive.signal' 'WARN' 'false-positive signal present' $flag 'review exclusions; clear when done'))|Out-Null } else { $checks.Add((C 'security.falsepositive.signal' 'PASS' 'no signal' 'none' 'none'))|Out-Null }
$fail=@($checks|? status -eq 'FAIL').Count; $warn=@($checks|? status -eq 'WARN').Count
$res=if($fail -gt 0){'FAIL'}elseif($warn -gt 0){'WARN'}else{'PASS'}; $exit=if($res -eq 'PASS'){0}elseif($res -eq 'WARN'){10}else{20}
$rc=[ordered]@{rail='OE_HYGIENE';spec_version='0.1';utc=$utc;host=[ordered]@{computer=$env:COMPUTERNAME;user=$env:USERNAME;os=(Get-CimInstance Win32_OperatingSystem -EA SilentlyContinue|% Caption)};profile=[ordered]@{gate='1';mode=$Mode};summary=[ordered]@{result=$res;warn_count=$warn;fail_count=$fail};checks=$checks}
New-Item -ItemType Directory -Force -Path $OutDir|Out-Null
$out=Join-Path $OutDir ('OE_HYGIENE_RECEIPT__{0}.json' -f $utc)
($rc|ConvertTo-Json -Depth 6) | Set-Content -LiteralPath $out -Encoding UTF8
Write-Output ('OE_HYGIENE={0} RECEIPT={1}' -f $res,$out); exit $exit
