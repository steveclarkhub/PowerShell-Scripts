# version 5.1
# .but that's for version 4 , so version 5 of

# init vars
$TargetHosts = $($env:COMPUTERNAME)
$SvcName = "AJRouter"


$collobj = @()
foreach($1host in $TargetHosts)
  {
    $SvcObj = get-ciminstance -ClassName win32_service |where{$_.name -match $SvcName}
    if(($SvcObj.DelayedAutoStart) -eq $true)
    {
      $StartMode = "Auto + Delay"
    }else{
      $StartMode = $($SvcObj.StartMode)
    }
    $coll1 = [pscustomobject] @{
    Host = $1host
    Service = $SvcObj.name
    Status = $SvcObj.Status
    Caption = $SvcObj.caption
    StartName = $SvcObj.StartName
    State = $SvcObj.state
    StartMode = $SvcObj.StartMode
    StartDelay = $SvcObj.DelayedAutoStart
    PID = $SvcObj.ProcessId
    }
  $collobj += $coll1
  }
$collobj | ft -AutoSize
