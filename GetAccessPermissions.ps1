Param (
	[String]$inputPath
)

Get-ChildItem $inputPath | where-object {($_.PsIsContainer)} | Get-ACL | Format-List | Out-Host