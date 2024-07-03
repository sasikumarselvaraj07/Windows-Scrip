$FolderPath = "$Env:USERPROFILE\Downloads\GPO_results"

# Check if the folder path exists
if (-not (Test-Path -Path $FolderPath)) {
    # If the folder path does not exist, create the folder
    New-Item -Path $FolderPath -ItemType Directory -Force
    Write-Host "Folder created at $FolderPath"
} else {
    Write-Host "Folder already exists at $FolderPath"
}

$allgpos = Get-GPO -All | Select-Object -ExpandProperty DisplayName
 
foreach ($g in $allgpos) {
 
    Get-GPOReport -Name $g -ReportType HTML -Path $FolderPath\$g.html
 
}

# Retrieve all GPOs
$AllGpos = Get-GPO -All

# Create a custom object holding all the GPOs and their links (separate for each distinct OU)
$GpoLinks = foreach ($g in $AllGpos){
    [xml]$Gpo = Get-GPOReport -ReportType Xml -Guid $g.Id
    foreach ($i in $Gpo.GPO.LinksTo) {
        [PSCustomObject]@{
            "Name" = $Gpo.GPO.Name
            "Link" = $i.SOMPath
            "LinkEnabled" = $i.Enabled
        }
    }
}

# Export the output to a CSV file
$GpoLinks | Sort-Object Name | Export-Csv -Path "$FolderPath\GPO_Links.csv" -NoTypeInformation