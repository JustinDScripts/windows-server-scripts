$proxy = New-Object System.Net.WebProxy('http://145.26.202.186:8080', $true)
$proxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials # DefaultCredentials passes your currently logged-in Windows credentials through to the proxy
#  $proxy.Credentials = Get-Credential If the proxy needs explicit creds
[System.Net.WebRequest]::DefaultWebProxy = $proxy
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Install-Module VMware.PowerCLI -Scope CurrentUser -Force -AllowClobber  # This may give error 
#Install-Module VMware.PowerCLI -Scope CurrentUser -Force -AllowClobber -SkipPublisherCheck # for current user only
Install-Module VMware.PowerCLI -Scope AllUsers -Force -AllowClobber -SkipPublisherCheck # for all users
