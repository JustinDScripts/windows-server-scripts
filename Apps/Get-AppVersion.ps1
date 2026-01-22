<#
Get-AppVersion.ps1
To get the installed version of a specific application (example: VMware Tools) by querying the registry uninstall keys
Author: Justin D
Date: 2026-01-22 | Initial | To be tested
#>
$AppName = 'VMware Tools' # Update this as needed
$Servers = "Server01", "Server02", "Server03" # Update with required servers
$results = foreach ($Server in $Servers) {
    try {
        # Open the remote HKLM hive using DCOM/RPC
        $reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $Server)
        # $AppName is almost always under the 64-bit uninstall key
        $path = "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall"
        $key = $reg.OpenSubKey($path)
        # Search subkeys for "$AppName"
        $version = $null
        foreach ($subKeyName in $key.GetSubKeyNames()) {
            $subKey = $key.OpenSubKey($subKeyName)
            if ($subKey.GetValue("DisplayName") -eq "$AppName") {
                $version = $subKey.GetValue("DisplayVersion")
                break
            }
        }
 
        if ($version) {
            [PSCustomObject]@{
                Server  = $Server
                Product = "$AppName"
                Version = $version
            }
        } else {
            Write-Warning "$AppName not found on $Server"
        }
    }
    catch {
        Write-Warning "Could not connect to registry on $Server : $($_.Exception.Message)"
    }
    finally {
        if ($reg) { $reg.Close() }
    }
}
 
$results | Format-Table -AutoSize
$results | export-csv -path ".\Ouput.csv"-notypeinformation
