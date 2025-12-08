# WIP param to be updated at least
# Set-SystemFile.ps1
# 2025-12-08 | JustinD | Initial - WIP
<#
Change file attribute as system file.
#>
function Set-SystemFile {
param ()
$currentAttributes = (Get-Item -Path $filePath).Attributes
$newAttributes = $currentAttributes -bor [System.IO.FileAttributes]::System
Set-ItemProperty -Path $filePath -Name Attributes -Value $newAttributes

}
$RebootFiles = @(
    "C:\Folder\Path2\reboot.cmd",
    "C:\Folder\Path2\MOM_reboot.cmd"
)
foreach($RebootFile in $RebootFiles) {
if (test-path $RebootFile -PathType Leaf) {

}
}
