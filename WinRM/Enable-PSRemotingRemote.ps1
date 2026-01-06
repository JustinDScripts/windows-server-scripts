<#
To enable psRemoting in remote computers without ws-man
#>
$computerName = $Servers

$cimParam = @{
    CimSession  = New-CimSession -ComputerName $computerName -SessionOption (New-CimSessionOption -Protocol Dcom)
    ClassName = 'Win32_Process'
    MethodName = 'Create'
    Arguments = @{ CommandLine = 'cmd.exe /c winrm quickconfig' }
}

try {Invoke-CimMethod @cimParam} catch {$_.exception.message}
