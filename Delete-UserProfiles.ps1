<#
PowerShell one-liner to delete user profiles with specific strings:
Get-CimInstance -ClassName Win32_UserProfile | ?{$_.LocalPath -like "*UserNameEndswith"} | Remove-CimInstance -Confirm:$false
#>
try {Get-CimInstance -ClassName Win32_UserProfile | ?{$_.LocalPath -like "*UserNameEndswith"} | Remove-CimInstance -Confirm:$false } catch {"$_.exception.message"}
