Get-ChildItem -Path Cert:\LocalMachine -Recurse | Where-Object subject -like *ivanti* | Select-Object NotBefore,NotAfter,DNsNameList,SerialNumber,Thumbprint,Subject,FriendlyName,Issuer | ft -AutoSize
# Multiple computers:
# Define your target servers
$Computers = "Server01", "Server02", "Server03"

Invoke-Command -ComputerName $Computers -ScriptBlock {
    Get-ChildItem -Path Cert:\LocalMachine -Recurse | 
        Where-Object Subject -like "*ivanti*" | 
        Select-Object @{Name="ComputerName"; Expression={$env:COMPUTERNAME}}, 
                      NotBefore, NotAfter, DnsNameList, SerialNumber, Thumbprint, Subject, FriendlyName, Issuer
} | Select-Object ComputerName, NotBefore, NotAfter, DnsNameList, SerialNumber, Thumbprint, Subject, FriendlyName, Issuer | 
    Format-Table -AutoSize
