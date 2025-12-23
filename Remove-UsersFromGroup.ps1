<#
Remove-UsersFromGroup.ps1
Purpose: To remove multiple user accounts from an AD group
Author: Justin D | 2025-12-23
Instructions:
1 Update .\UserNames.txt with the user names that needs to be removed
2 Yodate $GroupName = 'GroupName' with the AD group name
#>
Push-Location $PSScriptRoot # JD To cd scriptdir
Import-Module ActiveDirectory
$UserNamesfile = ".\UserNames.txt"
$GroupName = 'Local Admin'
if  (test-path $UserNamesfile -PathType leaf) {
$Usernames = Get-content ".\UserNames.txt"
foreach ($Username in $Usernames) {
try {Remove-ADGroupMember $GroupName -Members $Username -Confirm:$False -whatif} catch {write-warning "$($_.exception.message)"}
} # foreach
} # test-path

