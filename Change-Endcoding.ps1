<#
Change-Endcoding.ps1
This will convert encoding of a text file.
Author: JustinD
2025-11-25 | Initial | To be tested
#>
function Get-FileEncoding {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$Path
    )
    process {
        if (-not (Test-Path $Path -PathType Leaf)) {
            Write-Warning "File not found: $Path"
            return
        }
        try {
            $stream = New-Object System.IO.FileStream($Path, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read)
            $reader = New-Object System.IO.StreamReader($stream, [System.Text.Encoding]::Default, $true) # $true for detectEncodingFromByteOrderMarks

            # Read a small portion to allow StreamReader to detect BOM
            $null = $reader.Read()

            $encoding = $reader.CurrentEncoding.EncodingName
            $reader.Close()
            $stream.Close()
            $reader.Dispose()
            $stream.Dispose()

            [PSCustomObject]@{
                FilePath = $Path
                Encoding = $encoding
            }
        } catch {
            Write-Error "Error processing file '$Path': $($_.Exception.Message)"
        }
    }
}
# Define the input and output file paths
$InputFilePath = "C:\Server\MyTextFile.ini"
$OutputFilePath = "C:\Server\MyTextFile.ini"
$BAKFile = "C:\Server\MyTextFile.ini_Unicode"
# Get original encoding value:
Write-Output "Before : $env:ComputerName $((Get-FileEncoding -Path $InputFilePath).Encoding)"
# Read the content of the Unicode file, specifying its current encoding
# For UTF-8, use -Encoding UTF8
# For UTF-16 (Unicode), use -Encoding Unicode
$FileContent = Get-Content -Path $InputFilePath -Encoding Unicode # Adjust encoding based on your input file
Rename-Item $InputFilePath $BAKFile
# Write the content to a new file with ANSI encoding
# The 'Default' encoding option corresponds to the system's ANSI code page
Set-Content -Path $OutputFilePath -Value $FileContent -Encoding Ascii -Force
Write-Output "After : $env:ComputerName $((Get-FileEncoding -Path $InputFilePath).Encoding)"
