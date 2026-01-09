$updateScope = New-Object Microsoft.UpdateServices.Administration.UpdateScope
$updateScope.TextIncludes= '5074975'
(Get-WsusServer).GetUpdateApprovals($updateScope) | 
ForEach-Object {
 $tg = (Get-WsusServer).GetComputerTargetGroup($($_.ComputerTargetGroupId))
 Write-Verbose -Message "Dealing with approval type $($_.Action) on to target group '$($tg.Name)'" -Verbose
 $tg.GetComputerTargets($true) | 
 ForEach-Object {
  $computer = $_
   $State = $computer.GetUpdateInstallationSummary($updateScope)
   [PSCustomObject]@{
    ComputerName = $_.FullDomainName ;
    Unknown = $( if($State.UnknownCount) { $true } else { $false} );
    NotApplicable = $( if($State.NotApplicableCount) { $true } else { $false } );
    NotInstalled = $( if($State.NotInstalledCount) { $true } else { $false } );
    Downloaded = $( if($State.DownloadedCount) { $true } else { $false } );
    Installed = $( if($State.InstalledCount) { $true } else { $false } );
    InstalledPendingReboot = $( if($State.InstalledPendingRebootCount) { $true } else { $false } );
    Failed = $( if($State.FailedCount) { $true } else { $false } );
   }
 }
} | ogv

# 5074975
