$TasksAtPath = Get-ScheduledTask -TaskPath "\"
$TaskSummary = foreach($ta in $TasksAtPath)
  {
  $TaskDetail = Get-ScheduledTaskInfo -TaskName $($ta.Taskname)
    [pscustomobject]@{
    Name = $ta.TaskName
    Command = $ta.Actions.execute
    Args = $ta.Actions.Arguments
    State = $ta.state
    LastRun = $TaskDetail.LastRunTime
    LastResult =$TaskDetail.LastTaskResult
    NextRun = $TaskDetail.NextRunTime
    }
  }

$TaskSummary
