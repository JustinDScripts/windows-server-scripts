<#
Get-PageFileDetails.ps1
To get the page file settings in the computer
#>

# Method 1 : For local run
function Get-PageFileDetails_Local {
Get-CimInstance Win32_PageFileUsage | ForEach-Object {
    [PSCustomObject]@{
        Name            = $_.Name
        AllocatedSizeGB = [Math]::Round($_.AllocatedBaseSize / 1024, 2)
        CurrentUsageGB  = [Math]::Round($_.CurrentUsage / 1024, 2)
        PeakUsageGB     = [Math]::Round($_.PeakUsage / 1024, 2)
    } # pscustomobject
} # foreach-object
} #End of function
<#
Sample output:
Name            AllocatedSizeGB CurrentUsageGB PeakUsageGB
----            --------------- -------------- -----------
C:\pagefile.sys               8           0.42        0.43
#>
# Method 2 : For remote computers which might not have WinRM enabled:
function-GetPageFileDetails_NoWinRM {
$Computers = "PC01", "PC02"
# Create a CIM session option for DCOM
$SessionOption = New-CimSessionOption -Protocol Dcom
foreach ($Computer in $Computers) {
    try {
        # Create a session and query the pagefile
        $CimSession = New-CimSession -ComputerName $Computer -SessionOption $SessionOption -ErrorAction Stop
        Get-CimInstance Win32_PageFileUsage -CimSession $CimSession | Select-Object PSComputerName, Name, CurrentUsage, AllocatedBaseSize
        Remove-CimSession $CimSession
    }
    catch {
        Write-Warning "Could not connect to $Computer: $($_.Exception.Message)"
    } # catch
} # foreach ($Computer
} # end of function

# Method 3: for Legacy computers without WinRM
function Get-PageFileDetails_WMI {
$Computers = "PC01", "PC02"
Get-WmiObject Win32_PageFileUsage -ComputerName $Computers | Select-Object @{Name="Computer";Expression={$_.__SERVER}}, Name, CurrentUsage, AllocatedBaseSize
}

# Method 4 : Registry
Function Get-PageFileDetails_Reg {
$Computer = "PC01"
$Reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $Computer)
$Key = $Reg.OpenSubKey("System\CurrentControlSet\Control\Session Manager\Memory Management")
$PageFileValue = $Key.GetValue("PagingFiles")
Write-Output "Pagefile configuration on $Computer: $PageFileValue"
}

# Method 4 : For faster run using invoke-command
function Get-PageFileDetails_fast {
$Computers = Get-Content "C:\Scripts\Servers.txt"
Invoke-Command -ComputerName $Computers -ScriptBlock {
    Get-CimInstance Win32_PageFileUsage | Select-Object Name, CurrentUsage, AllocatedBaseSize, PeakUsage
} | Select-Object PSComputerName, Name, CurrentUsage, AllocatedBaseSize, PeakUsage | Format-Table
} # end of function
