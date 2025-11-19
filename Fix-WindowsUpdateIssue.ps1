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

Sample outputs:

C:\WINDOWS\system32>Dism /online /cleanup-image /startcomponentcleanup
Deployment Image Servicing and Management tool
Version: 10.0.14393.4169
Image Version: 10.0.14393.7426
[==========================100.0%==========================]
The operation completed successfully.

C:\WINDOWS\system32>Dism /online /cleanup-image /restorehealth
Deployment Image Servicing and Management tool
Version: 10.0.14393.4169
Image Version: 10.0.14393.7426
[==========================100.0%==========================]
Error: 0x800f0906
The source files could not be downloaded.
Use the "source" option to specify the location of the files that are required to restore the feature. For more information on specifying a source location, see http://go.microsoft.com/fwlink/?LinkId=243077.
The DISM log file can be found at C:\WINDOWS\Logs\DISM\dism.log

C:\WINDOWS\system32>SFC /scannow
Beginning system scan.  This process will take some time.
Beginning verification phase of system scan.
Verification 100% complete.
Windows Resource Protection did not find any integrity violations.

#>
# Commands:
Dism /online /cleanup-image /startcomponentcleanup
Dism /online /cleanup-image /restorehealth
SFC /scannow
