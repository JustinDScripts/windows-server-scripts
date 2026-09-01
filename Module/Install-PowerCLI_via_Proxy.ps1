$proxy = New-Object System.Net.WebProxy('http://145.26.202.186:8080', $true)
$proxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials # DefaultCredentials passes your currently logged-in Windows credentials through to the proxy
#  $proxy.Credentials = Get-Credential If the proxy needs explicit creds
[System.Net.WebRequest]::DefaultWebProxy = $proxy
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Register-PSRepository -Default
#Get-PSRepository
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
# Install-Module VMware.PowerCLI -Scope CurrentUser -Force -AllowClobber  # This may give error 
#Install-Module VMware.PowerCLI -Scope CurrentUser -Force -AllowClobber -SkipPublisherCheck # for current user only
Install-Module VMware.PowerCLI -Scope AllUsers -Force -AllowClobber -SkipPublisherCheck # for all users

# Copy folders method
<#
Copy vmware* folders to C:\Program Files\WindowsPowerShell\Modules\
Get-Module VMware.PowerCLI -ListAvailable
Import-Module VMware.PowerCLI

Parallel run sample:

$servers = @('PC01','PC02','PC03')
$sourceDir = '\\fileserver\share\PayloadFolder'
$destDir = 'C:\Program Files\WindowsPowerShell\Modules'
$jobs = foreach ($server in $servers) {
    Invoke-Command -ComputerName $server -AsJob -JobName $server -ScriptBlock {
        param($src, $dest)
        robocopy $src $dest /E /Z /R:3 /W:5 /MT:8 /NP /LOG:"C:\Temp\robocopy.log"
        [PSCustomObject]@{ ExitCode = $LASTEXITCODE }
    } -ArgumentList $sourceDir, "$destDir"
}
$jobs | Wait-Job | Receive-Job
#>
