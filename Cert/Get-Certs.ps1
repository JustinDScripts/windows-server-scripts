Get-ChildItem -Path Cert:\LocalMachine -Recurse | Where-Object subject -like *ivanti* | Select-Object NotBefore,NotAfter,DNsNameList,SerialNumber,Thumbprint,Subject,Issuer | ft -AutoSize
