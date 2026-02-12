# Trying to Turn off Firewall which was Enabled by local policy
# No success yet, still looking at the ways:
reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile" /f
gpupdate /force

Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled False
# To Allow defaultinboudAction
Set-NetFirewallProfile -Profile Domain,Private,Public -DefaultInboundAction Allow
