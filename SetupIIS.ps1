param(
	[String]$appPoolName = '',
	[String]$physicalPath = '',
	[String]$webSiteName = '',
	[String]$hostHeader = ''
)

Write-Host "Arg: $appPoolName"
Write-Host "Arg: $physicalPath"
Write-Host "Arg: $webSiteName"
Write-Host "Arg: $hostHeader"

Import-Module WebAdministration

cd IIS:

if(Test-Path IIS:\AppPools\$appPoolName)
{
	echo "App pool exists - removing"
	Remove-WebAppPool $appPoolName
	gci IIS:\AppPools
}
$pool = New-Item IIS:\AppPools\$webSiteName

$pool.processModel.identityType = 0
$pool | set-item

if(Test-Path IIS:\Sites\$webSiteName)
{
echo "Website exists - removing"
Remove-WebSite $webSiteName
gci IIS:\Sites
}

echo "Creating new website"
New-Website -name $webSiteName -PhysicalPath $physicalPath -ApplicationPool $appPoolName -HostHeader $hostHeader

Set-WebConfigurationProperty -filter /system.webServer/security/authentication/windowsAuthentication -name enabled -value true -PSPath IIS:\Sites\$webSiteName

Set-WebConfigurationProperty -filter /system.webServer/security/authentication/anonymousAuthentication -name enabled -value false -PSPath IIS:\Sites\$webSiteName
