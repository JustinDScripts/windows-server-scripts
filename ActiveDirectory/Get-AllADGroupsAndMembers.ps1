<#
This script will get an output csv file with all the groups in the current domain and their members.
Author: Justin D
Date : 2026-06-22
#>
# Initial Settings:
Push-Location $PSScriptRoot # JD To cd scriptdir
$OutputDir = ".\Outputs\Outputs_$((Get-Date).ToString('yyyy-MM-dd'))"
$null = New-Item -Path $OutputDir -type directory -Force -ErrorAction SilentlyContinue
$OutFile = Join-Path -Path  $OutputDir -ChildPath "Groups_n_Users_$((Get-Date).ToString('yyyy-MM-dd_HH-mm-ss')).csv"
# Initialize a list to store the results
$results = New-Object System.Collections.Generic.List[System.Object]

# Get all Active Directory groups
$groups = Get-ADGroup -Filter * -Properties Name

# Loop through each group
foreach ($group in $groups) {
write-host "Getting members of group: $($group.name)"
    # Get members of the current group (use -Recursive to include nested group members)
    $members = Get-ADGroupMember -Identity $group.Name -Recursive | Where-Object {$_.objectClass -eq 'user'} # Filter for only user objects

    # Loop through each member and add to the results list
    foreach ($member in $members) {
#$MemberProps = Get-ADUser -filter $member -properties PasswordExpired, PasswordLastSet, PasswordNeverExpires,lastlogontimestamp,mail | 
#sort-object PasswordLastSet | 
#select-object Name,GivenName, SamAccountName, UserPrincipalName,Mail,Enabled,lastlogontimestamp,PasswordLastSet,PasswordExpired
        $results.Add([PSCustomObject]@{
            GroupName        = $group.Name
            UserName         = $member.Name
            UserSamAccountName = $member.SamAccountName
            #Enabled = $MemberProps.Enabled
            #PasswordLastSet = $MemberProps.PasswordLastSet
            #lastlogontimestamp = $MemberProps.lastlogontimestamp
        })
    }
}

# Export the results to a CSV file
$results | Export-Csv -Path $OutFile -NoTypeInformation -Encoding UTF8
Write-Host "Export complete. Data saved to $OutFile"
