$ErrorActionPreference = "Stop"

# Must first uninstall frminst.exe in order to unlock the full uninstall for McAfee

# Find frminst.exe if it exists
$frminstFindings = @(Get-Childitem -Path C:\ -Recurse -Filter 'frminst.exe' -File -Force -ErrorAction SilentlyContinue)
$frminst = $frminstFindings[0].FullName
Write-Host $frminst
if($frminst -eq $null)
{
    Write-Host 'Could not find frminst.exe'
    Exit
}

# Run frminst.exe /forceuninstall
Start-Process $frminst -Wait -NoNewWindow -ArgumentList @("/forceuninstall")

# Find and fully uninstall McAfee application
$application = Get-WmiObject Win32_Product -filter "Name='McAfee VirusScan Enterprise'"
$application.Uninstall()
