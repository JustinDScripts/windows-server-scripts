# Import the WSUS module
Import-Module UpdateServices

# Connect to the WSUS server
$wsusServerName = "YourWSUSServerName" # Replace with your WSUS server's name
$port = 8530 # Replace with your WSUS port (8530 for HTTP, 8531 for HTTPS)
$wsus = Get-WsusServer -Name $wsusServerName -PortNumber $port #

# Specify the computer group you want to report on
$computerGroupName = "YourComputerGroupName" # Replace with the target group name, e.g., "All Computers"
$computerGroups = $wsus.GetComputerTargetGroups() | Where-Object { $_.Name -eq $computerGroupName }

if ($computerGroups) {
    # Get all updates and filter for installed status within the specified group
    $reportData = $wsus.GetUpdates() | ForEach-Object {
        $update = $_
        foreach ($group in $computerGroups) {
            $statusSummary = $update.GetUpdateInstallationInfoPerComputerTargetGroup($group.Id)
            foreach ($status in $statusSummary) {
                if ($status.InstalledCount -gt 0) {
                    [PSCustomObject]@{
                        ComputerGroup  = $group.Name
                        UpdateTitle    = $update.Title
                        UpdateDate     = $update.CreationDate
                        InstalledCount = $status.InstalledCount
                        NotInstalled   = $status.NotInstalledCount
                        Unknown        = $status.UnknownCount
                    }
                }
            }
        }
    }

    # Export the report data to a CSV file
    $exportPath = "C:\Path\To\Export\WSUSReport_$computerGroupName.csv" # Replace with your desired path
    $reportData | Export-Csv -Path $exportPath -NoTypeInformation
    Write-Host "WSUS report generated and exported to $exportPath successfully."
} else {
    Write-Host "Computer group '$computerGroupName' not found."
}
