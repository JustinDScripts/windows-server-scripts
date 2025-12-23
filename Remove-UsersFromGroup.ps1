<#
Remove-UsersFromGroup.ps1
Purpose: To remove multiple user accounts from an AD group
Instructions:
1 Update .\UserNames.txt with the user names that needs to be removed
2 Yodate $UserGroup = 'GroupName' with the AD group name
#>
Import-Module ActiveDirectory
$Usernames = Get-content ".\UserNames.txt"
$UserGroup = 'GroupName'
Remove-ADGroupMember $UserGroup -Members $Usernames -Confirm:$False -Force -whatif
