<#
Microsoft response for case logged for Windows update installation failure:

Open an elevated command prompt and run:
Dism /online /cleanup-image /startcomponentcleanup
Dism /online /cleanup-image /restorehealth
SFC /scannow
Download TSS tool for data collection: https://aka.ms/getTSS
Open an elevated PowerShell prompt on the temporary folder path and run:
Unblock-file .\TSS.zip
Extract TSS.zip
On the elevated PowerShell prompt navigate to the extracted path and run:
Set-ExecutionPolicy RemoteSigned -Scope Process
Select Yes
.\TSS.ps1 -CollectLog DND_SetupReport
Read the EULA and accepted it to proceed with data collection
When the data collection is finished a .zip file will be generated on the OS drive in a folder called MS_DATA
Upload the .zip file to the workspace for analysis: File Transfer - Case <case #>
#>

Dism /online /cleanup-image /startcomponentcleanup
Dism /online /cleanup-image /restorehealth
SFC /scannow
