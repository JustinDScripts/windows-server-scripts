# 1. Round a number
$roundedUnavailableMinutes = [math]::Round($unavailableMinutes,1)
# Example 2:
$sizeGB = [math]::Round($disk.Size / 1GB,2)
# Create a TimeSpan
$serviceStartTimeout = [TimeSpan]::FromSeconds(30)
# Used with WaitForStatus:
$service.WaitForStatus(
    [System.ServiceProcess.ServiceControllerStatus]::Running,
    [TimeSpan]::FromSeconds(30)
)
# For readability
$runningStatus =
    [System.ServiceProcess.ServiceControllerStatus]::Running
$serviceStartTimeout = [TimeSpan]::FromSeconds(30)
$service.WaitForStatus(
    $runningStatus,
    $serviceStartTimeout
)
# 3 Check for null, empty, or whitespace
if (
    [string]::IsNullOrWhiteSpace($errorMessage)
) {
    $errorMessage = (
        'The operation failed without returning ' +
        'an error message.'
    )
}
# Negated usage:
if (
    -not [string]::IsNullOrWhiteSpace(
        $reportDirectory
    )
) {
    # Continue.
}
# 4. Create a new GUID
$guid = [guid]::NewGuid()
# GUID without hyphens:
$guidText = [guid]::NewGuid().ToString('N')
# Temporary filename:
$temporaryFileName = (
    '.{0}.{1}.tmp' -f
    $scriptName,
    [guid]::NewGuid().ToString('N')
)
# State temporary filename:
$temporaryFileName = (
    '.{0}.{1}.{2}.tmp' -f
    (
        Split-Path `
            -Path $statePath `
            -Leaf
    ),
    $PID,
    [guid]::NewGuid().ToString('N')
)
# 5. Replace an existing file
[System.IO.File]::Replace(
    $temporaryPath,
    $statePath,
    $backupPath,
    $true
)
<# The parameters are:
Source temporary file
Destination authoritative file
Backup file
Ignore metadata errors
#>
# Use Move-Item when the destination does not yet exist:
if (
    Test-Path `
        -LiteralPath $statePath `
        -PathType Leaf
) {
    [System.IO.File]::Replace(
        $temporaryPath,
        $statePath,
        $backupPath,
        $true
    )
}
else {
    Move-Item `
        -LiteralPath $temporaryPath `
        -Destination $statePath `
        -ErrorAction Stop
}
# 6. Read all file bytes
$targetBytes =
    [System.IO.File]::ReadAllBytes(
        $targetPath
    )
    # For source and destination comparison:
    $sourceBytes =
    [System.IO.File]::ReadAllBytes(
        $sourcePath
    )

$targetBytes =
    [System.IO.File]::ReadAllBytes(
        $targetPath
    )
    # 7. Get the maximum of two values
    $maximumLength = [math]::Max(
    $sourceBytes.Length,
    $targetBytes.Length
)
# For the Windows Server 2025 disk-space requirement:
$requiredOSDriveFreeSpace = [math]::Max(
    $OSDriveFreeSpace,
    30
)
# 8. Parse a PowerShell file
$tokens = $null
$parseErrors = $null

[System.Management.Automation.Language.Parser]::ParseFile(
    $scriptPath,
    [ref]$tokens,
    [ref]$parseErrors
) | Out-Null
# 9. Task Scheduler service state enum
$runningStatus =
    [System.ServiceProcess.ServiceControllerStatus]::Running
    # Complete service wait:
    $serviceStartTimeout =
    :FromSeconds(30)

$service.WaitForStatus(
    [System.ServiceProcess.ServiceControllerStatus]::Running,
    $serviceStartTimeout
)
# Quick search for damaged .NET calls
Select-String `
    -LiteralPath '.\WIN_OS_Inplace_Upgrade_v3.09.ps1' `
    -Pattern `
        '(?<!:):Round',
        '(?<!:):Max',
        '(?<!:):FromSeconds',
        '(?<!:):IsNullOrWhiteSpace',
        '(?<!:):NewGuid',
        '(?<!:):Replace',
        '(?<!:):ReadAllBytes',
        '(?<!:):ParseFile',
        '(?<!:):Running' |
    Select-Object `
        LineNumber,
        Line
