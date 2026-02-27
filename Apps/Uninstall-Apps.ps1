<#
.SYNOPSIS
    Uninstalls specified applications from the system.
.DESCRIPTION
    This script checks for the presence of specified applications and uninstalls them if they are found. It uses the Get-Package cmdlet to find installed applications and the Uninstall-Package cmdlet to remove them.
.PARAMETER AppNames
    An array of application names to check for and uninstall. Wildcards can be used to match multiple versions of an application.
.EXAMPLE
    .\Uninstall-Apps.ps1
    This will check for the specified applications and uninstall them if they are found.
.NOTES
    Author: Justin D
    Date: 2026-02-25
    Version: 1.0
    License: MIT License
    Disclaimer: Use this script at your own risk. Always ensure you have backups before making changes to your system.
#>
Clear-Host
$AppName = "7-Zip*"
$AppNames = "7-Zip*",'Google Chrome*','Mozilla Firefox*','Adobe Acrobat Reader*','WinRAR*'
foreach ($AppName in $AppNames) {
$InstalledApps = get-package -Name $AppName -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
if ($null -ne $InstalledApps) {
     Write-Host "$AppName is installed. Uninstalling..."   
$InstalledApps | ForEach-Object {
    try {
        Uninstall-Package $_ -WhatIf
        write-host "Uninstalled $AppName successfully."
    }
    catch {
        Write-Warning "Failed to uninstall $_. Error: $_"
    }
}
}
else {
    Write-Host "$AppName is not installed."
}
} # Foreach app

<#
7-Zip
Google Chrome Browser
Firefox
WinRAR
Acrobat Reader
Acrobat Reader DC
'Microsoft Edge*',
'VLC Media Player*'
'Notepad++*'
'Spotify*',
'Skype*',
'Zoom*'
#>
