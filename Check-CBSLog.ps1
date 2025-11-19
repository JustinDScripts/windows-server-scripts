<#
Check cbs.log for errors
#>
Get-Content C:\Windows\Logs\CBS\CBS.log | Select-String ', error'
