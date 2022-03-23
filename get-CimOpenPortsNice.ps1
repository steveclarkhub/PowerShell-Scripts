# wants? ParentProcessID, (expression: parent process name) HandleCount, ThreadCount, WorkingSetSize
# format (int64?) workingset: @{label="WorkingSetMB";expression={[math]::Round(($_.workingsetsize/1mb),0)}}
# add help
$ProcColl = @()
$listenPorts = Get-NetTCPConnection | where{$_.OwningProcess -ne 0}| select LocalAddress, LocalPort, RemoteAddress, OwningProcess | Sort-Object OwningProcess -Unique
foreach($1port in $listenPorts)
{
$ProcNm = gcim win32_process | where{$_.ProcessId -eq $1port.OwningProcess}
$output1 = "" | Select ProcessName, ProcessID, OwningProcess, TcpPort, ProcessOwner
$output1.ProcessName = $ProcNm.ProcessName
$output1.ProcessID = $ProcNm.ProcessID
# $output1.OwningProcess = $1port.OwningProcess
$output1.TcpPort = $1port.LocalPort
$output1.ProcessOwner = (Invoke-CimMethod -InputObject $ProcNm -MethodName GetOwner).user
$ProcColl += $output1
}

$ProcColl | select TcpPort, ProcessID, ProcessName, ProcessOwner | Sort-Object TcpPort
