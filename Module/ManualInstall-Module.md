Manually installing PowerShell modules from a NuGet package:

1. Unblock the Internet-downloaded NuGet package (.nupkg) file, for example using Unblock-File -Path C:\Downloads\module.nupkg cmdlet.
2. Rename .nupkg to .zip.
3. Extract the contents of the NuGet package to a local folder.
4. Delete the NuGet-specific elements from the folder.
5. Rename the folder to this sample format "azurerm.storage". The default folder name is usually <name>.<version>. 
      The version can include -prerelease if the module is tagged as a prerelease version. 
      Rename the folder to just the module name. For example, azurerm.storage.5.0.4-preview becomes azurerm.storage.
6. Copy the folder to one of the folders in the $env:PSModulePath value. 
      $env:PSModulePath is a semicolon-delimited set of paths in which PowerShell should look for modules.

Ref: https://learn.microsoft.com/en-us/powershell/gallery/how-to/working-with-packages/manual-download?view=powershellget-3.x

PowerCLI module installation:
https://learn.microsoft.com/en-us/powershell/gallery/how-to/working-with-packages/manual-download?view=powershellget-3.x
https://developer.broadcom.com/tools/vmware-powercli/latest/
