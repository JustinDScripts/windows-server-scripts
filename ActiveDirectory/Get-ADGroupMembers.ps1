<#
Get-ADGroupMembers.ps1
This script will get an output csv file with all the groups in the current domain or given group name and their members.
Author: Justin D
Date : 2026-06-02
#>
Param(
    [STRING]$GroupName="All"
    )
# Initial Settings:
Push-Location $PSScriptRoot # JD To cd scriptdir
$OutputDir = ".\Outputs\Outputs_$((Get-Date).ToString('yyyy-MM-dd'))"
$null = New-Item -Path $OutputDir -type directory -Force -ErrorAction SilentlyContinue
$OutFile = Join-Path -Path  $OutputDir -ChildPath "Groups_n_Users_$((Get-Date).ToString('yyyy-MM-dd_HH-mm-ss')).csv"
# Initialize a list to store the results
$results = New-Object System.Collections.Generic.List[System.Object]

# Get all Active Directory groups
#$GroupName = '*'
#$GroupName = 'dc3-tsi-pool_b-veeam_restore'
try {
if ($GroupName -eq 'All') {$groups = Get-ADGroup -Filter * -Properties Name}else {$groups = Get-ADGroup -Identity $GroupName -Properties Name}
# Loop through each group
foreach ($group in $groups) {
write-host "Getting members of group: $($group.name)"
    # Get members of the current group (use -Recursive to include nested group members)
    $members = Get-ADGroupMember -Identity $group.Name -Recursive | Where-Object {$_.objectClass -eq 'user'} # Filter for only user objects
    # Loop through each member and add to the results list
    foreach ($member in $members) {
    $MemberProps = Get-ADUser -Identity $member.SamAccountName -Properties Enabled, WhenCreated, WhenChanged
#$MemberProps = Get-ADUser -filter $member -properties PasswordExpired, PasswordLastSet, PasswordNeverExpires,lastlogontimestamp,mail | 
#sort-object PasswordLastSet | 
#select-object Name,GivenName, SamAccountName, UserPrincipalName,Mail,Enabled,lastlogontimestamp,PasswordLastSet,PasswordExpired
        $results.Add([PSCustomObject]@{
            GroupName        = $group.Name
            Member_SamAccountName = $member.SamAccountName
            Member_Name         = $member.Name
            Member_Enabled         = $MemberProps.Enabled
            Member_Created         = $MemberProps.WhenCreated
            Member_Changed        = $MemberProps.WhenChanged
            #Enabled = $MemberProps.Enabled
            #PasswordLastSet = $MemberProps.PasswordLastSet
            #lastlogontimestamp = $MemberProps.lastlogontimestamp
        })
    }
}
# Export the results to a CSV file
$results | Export-Csv -Path $OutFile -NoTypeInformation -Encoding UTF8
Write-Host "Export completed. Data saved to $OutFile"
} catch {$_.exception.message}
if (test-path -path $OutFile -PathType Leaf) {invoke-item $OutFile}
