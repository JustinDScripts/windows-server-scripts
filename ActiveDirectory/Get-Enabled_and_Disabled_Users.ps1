<#
Get-Enabled_and_Disabled_Users.ps1
To get enabled and disabled users
Gets all users with below details:
Enabled: True of false, WhenCreated, whenChanged, PasswordLastSet, PasswordExpired

Author: JustinD
Version : 0.1 | 2026-02-05
#>
$OutFile = "E:\Data\Reports\Enabled_and_Disabled_User_$((Get-Date).ToString('yyyy-MM-dd_HH-mm')).csv"
Get-ADuser -Filter * -Properties Name,WhenCreated,whenChanged,PasswordLastSet,PasswordExpired  | 
Select SamAccountName,
Name,
Enabled,
WhenCreated,
WhenChanged,
PasswordLastSet,
PasswordExpired | 
#Out-GridView
Export-Csv -Path $OutFile -NoTypeInformation
if (test-path -Path $OutFile -PathType Leaf) {invoke-item -Path $OutFile}
# 
