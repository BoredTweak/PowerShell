

$data = Get-Content -Raw -Path dataConfig.json | ConvertFrom-Json
$sandboxPath = Get-Item Env:SAGE_SANDBOX
$destination = $sandboxPath.Value + "\Resources\Data"

Write-Host "Creating path " $destination
New-Item -ItemType Directory -Force -Path $destination | out-null

foreach ($i in $data.datafolders)
{
    if((Get-Item $i).Extension -eq ".zip")
    {
        $baseName = (Get-Item $i).Basename
        $outputPath = Join-Path -Path $destination -ChildPath $baseName

        New-Item -ItemType Directory -Force -Path $outputPath | out-null
        Write-Host "Unzipping " $i " to " $outputPath
        Expand-Archive -LiteralPath $i -DestinationPath $outputPath
    }
    else
    {
        Write-Host "Copying " $i " to " $destination
        Copy-Item -Path $i -Destination $destination
    }
}
