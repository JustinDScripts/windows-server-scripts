while ($true){
Get-NetTCPConnection | Where-Object {$_.LocalPort -in 80, 443 -and $_.State -like 'Established'} | Select-Object CreationTime, RemoteAddress, RemotePort, State,LocalAddress, LocalPort, OwningProcess |Sort-Object CreationTime | ft -AutoSize
start-sleep -seconds 5
}
