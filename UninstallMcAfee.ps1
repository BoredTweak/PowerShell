$ErrorActionPreference = "Stop"

# Must first uninstall through frminst.exe in order to unlock the full uninstall for McAfee

# Find frminst.exe if it exists
Write-Host 'Searching for frminst.exe'
$searchResult = @(Get-Childitem -Path C:\ -Recurse -Filter 'frminst.exe' -File -Force -ErrorAction SilentlyContinue)
if($searchResult -eq $null -or $searchResult[0] -eq $null -or $searchResult[0].FullName -eq $null)
{
    Write-Host 'Could not find frminst.exe'
    Exit
}
$frminst = $searchResult[0].FullName

# Run frminst.exe /forceuninstall
Write-Host 'Uninstalling $frminst'
Start-Process $frminst -Wait -NoNewWindow -ArgumentList @("/forceuninstall")

# Find and fully uninstall McAfee application
Write-Host 'Uninstalling McAfee'
$application = Get-WmiObject Win32_Product -filter "Name='McAfee VirusScan Enterprise'"
$application.Uninstall()
