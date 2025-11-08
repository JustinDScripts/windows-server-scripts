<#
These are the useful PS1 one-liners useful for Windows
#>

# Change the 'My Computer' icon name in the Desktop to the actual computer name ($env:computername):
set-itemproperty -path 'registry::HKEY_USERS\S-1-5-21-1343024091-764733703-725345543-71394\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -name '(Default)' -value $($env:computername)
