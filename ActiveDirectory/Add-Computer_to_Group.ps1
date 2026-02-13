Import-Module ActiveDirectory

$groupName = "Name_of_your_AD_Group"
$computerName = "TargetComputerName" # Do not add the '$' manually

$computer = Get-ADComputer -Identity $computerName
Add-ADGroupMember -Identity $groupName -Members $computer
Get-ADGroupMember
