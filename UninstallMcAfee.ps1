$ErrorActionPreference = "Stop"

$frminstFindings = @(Get-Childitem -Path C:\ -Recurse -Filter 'frminst.exe' -File -Force -ErrorAction SilentlyContinue)
$frminst = $frminstFindings[0].FullName
Write-Host $frminst
if($frminst -eq $null)
{
    Write-Host 'Could not find frminst.exe' 
    Exit
}
else
{
    Start-Process $frminst -Wait -NoNewWindow -ArgumentList @("/forceuninstall")
}

$application = Get-WmiObject Win32_Product -filter "Name='McAfee VirusScan Enterprise'"
$application.Uninstall()