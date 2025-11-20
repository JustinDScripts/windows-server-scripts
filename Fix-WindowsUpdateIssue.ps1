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
<#
After analyzing the collected data, it was observed the following servicing payload corruption.
[CBS.log]
2025-11-19 15:59:25, Info                  CBS   
=================================
Checking System Update Readiness.
(p) CSI Payload Corrupt   wow64_windowssearchengine_31bf3856ad364e35_7.0.14393.206_none_b351c84b3e083664\mssphtb.dll
Repair failed: Missing replacement payload.
(p) CSI Payload Corrupt   wow64_windowssearchengine_31bf3856ad364e35_7.0.14393.206_none_b351c84b3e083664\SearchProtocolHost.exe
Repair failed: Missing replacement payload.
(p) CSI Payload Corrupt   wow64_windowssearchengine_31bf3856ad364e35_7.0.14393.206_none_b351c84b3e083664\mssrch.dll
Repair failed: Missing replacement payload.
(p) CSI Payload Corrupt   wow64_windowssearchengine_31bf3856ad364e35_7.0.14393.206_none_b351c84b3e083664\Search.ProtocolHandler.MAPI2.dll
Repair failed: Missing replacement payload.
(p) CSI Payload Corrupt   wow64_windowssearchengine_31bf3856ad364e35_7.0.14393.206_none_b351c84b3e083664\WSearchMigPlugin.dll
Repair failed: Missing replacement payload.
(p) CSI Payload Corrupt   wow64_windowssearchengine_31bf3856ad364e35_7.0.14393.206_none_b351c84b3e083664\tquery.dll
Repair failed: Missing replacement payload.
(p) CSI Payload Corrupt   wow64_windowssearchengine_31bf3856ad364e35_7.0.14393.206_none_b351c84b3e083664\SearchIndexer.exe
Repair failed: Missing replacement payload.
(p) CSI Payload Corrupt   wow64_windowssearchengine_31bf3856ad364e35_7.0.14393.206_none_b351c84b3e083664\mssitlb.dll
Repair failed: Missing replacement payload.
(p) CSI Payload Corrupt   wow64_windowssearchengine_31bf3856ad364e35_7.0.14393.206_none_b351c84b3e083664\mssprxy.dll
Repair failed: Missing replacement payload.
(p) CSI Payload Corrupt   x86_microsoft-windows-advapi32_31bf3856ad364e35_10.0.14393.0_none_b49e21a1e4d6ebe1\advapi32.dll
Repair failed: Missing replacement payload.
Summary:
Operation: Detect and Repair
Operation result: 0x800f0906
Last Successful Step: Entire operation completes.
Total Detected Corruption: 10
 CBS Manifest Corruption: 0
 CBS Metadata Corruption: 0
 CSI Manifest Corruption: 0
 CSI Metadata Corruption: 0
 CSI Payload Corruption: 10
Total Repaired Corruption: 0
 CBS Manifest Repaired: 0
 CSI Manifest Repaired: 0
 CSI Payload Repaired: 0
 CSI Store Metadata refreshed: True
Total Operation Time: 471 seconds.
2025-11-19 15:59:25, Info                  CBS    CheckSur: hrStatus: 0x800f0906 [CBS_E_DOWNLOAD_FAILURE], download Result: 0x80240438 [Unknown Error]
2025-11-19 15:59:25, Info                  CBS    Count of times corruption detected: 1
2025-11-19 15:59:25, Info                  CBS    Seconds between initial corruption detections: -1
2025-11-19 15:59:25, Info                  CBS    Seconds between corruption and repair: -1
2025-11-19 15:59:25, Info                  CBS    SQM: Package change report datapoints not populated because SQM is not initialized or not running online.
2025-11-19 15:59:25, Info                  CBS    Failed to run Detect and repair. [HRESULT = 0x800f0906 - CBS_E_DOWNLOAD_FAILURE]
2025-11-19 15:59:25, Info                  CBS    Reboot mark cleared
2025-11-19 15:59:25, Info                  CBS    Winlogon: Simplifying Winlogon CreateSession notifications
2025-11-19 15:59:25, Info                  CBS    Winlogon: Deregistering for CreateSession notifications
2025-11-19 15:59:25, Info                  CBS    Exec: Processing complete, session(Corruption Repairing): 31218019_4279730216 [HRESULT = 0x800f0906 - CBS_E_DOWNLOAD_FAILURE]
2025-11-19 15:59:25, Error                 CBS    Session: 31218019_4279730216 failed to perform store corruption detect and repair operation. [HRESULT = 0x800f0906 - CBS_E_DOWNLOAD_FAILURE]
2025-11-19 15:59:25, Info                  CBS    Session: 31218019_4279730216 finalized. Download error: 0x80240438 [Unknown Error], Reboot required: no [HRESULT = 0x800f0906 - CBS_E_DOWNLOAD_FAILURE]
2025-11-19 15:59:25, Info                  CBS    Failed to FinalizeEx using worker session [HRESULT = 0x800f0906]

I've sourced the missing components and have upload them to the workspace under the file sources.zip.
#>
# Solution:
<#
•	Download and extract sources.zip
•	Open an elevated command prompt and run:
o	Dism /online /cleanup-image /restorehealth /source:<Path_to_extracted_sources>
•	Manually install the latest CU: November 11, 2025—KB5068864 (OS Build 14393.8594) - Microsoft Support
•	Reboot
•	Report back the results
#>
Dism /online /cleanup-image /restorehealth /source:<Path_to_extracted_sources>
