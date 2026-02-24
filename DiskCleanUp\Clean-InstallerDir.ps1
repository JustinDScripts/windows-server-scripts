$Registered = Get-ItemPropertyValue -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Patches\* -Name LocalPackage
$Found = Get-ChildItem "$env:WINDIR\Installer\*" -Include *.msp,*.msi -Recurse | Select-Object -ExpandProperty FullName

# Show difference
Compare-Object $Registered $Found


$Unregistered = $Found | Where-Object {$_ -notin $Registered}

# Total Bytes unregistered
$Unregistered | Get-ChildItem | Measure-Object -Sum -Property Length

# Remove unregistered installers
$Unregistered | Remove-Item -WhatIf
