<#
PowerShell one-liner to delete user profiles with specific strings:
Get-CimInstance -ClassName Win32_UserProfile | ?{$_.LocalPath -like "*UserNameEndswith"} | Remove-CimInstance -Confirm:$false
#>
try {Get-CimInstance -ClassName Win32_UserProfile | ?{$_.LocalPath -like "*-A"} | Remove-CimInstance -Confirm:$false -ErrorAction Stop } catch {$_.exception.message}

Get-CimInstance -ClassName Win32_UserProfile | ?{$_.LocalPath -like "*-A"} | Remove-CimInstance -Confirm:$false -ErrorAction SilentlyContinue

# To take ownership
takeown /F "C:\Path\To\Your\Folder" /R /D Y

# To grant access to administrators:
icacls "C:\Path\To\Your\Folder" /grant Administrators:F /t /c /q
icacls "C:\Path\To\Your\Folder" /grant "BUILTIN\Administrators:(OI)(CI)F" /T

# Delete folders under C:\Users
Get-ChildItem "c:\users" -filter "*-A" -Directory | Remove-Item -Force -Confirm:$false -ErrorAction SilentlyContinue -Recurse
