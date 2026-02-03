Get-ADuser -Filter * -Properties Name,WhenCreated,whenChanged,PasswordLastSet,PasswordExpired  | 
Select SamAccountName,
Name,
Enabled,
@{Name="WhenCreated"; Expression={($_.WhenCreated).ToString('yyyy-MM-dd_HH-mm-ss')}},
@{Name="WhenChanged"; Expression={($_.WhenChanged).ToString('yyyy-MM-dd_HH-mm-ss')}},
@{Name="PasswordLastSet"; Expression={($_.PasswordLastSet).ToString('yyyy-MM-dd_HH-mm-ss')}},
PasswordExpired | 
#Out-GridView
Export-Csv -Path E:\Data\Reports\UserAccouts_$((Get-Date).ToString('yyyy-MM-dd_HH-mm')).csv -NoTypeInformation
# 
