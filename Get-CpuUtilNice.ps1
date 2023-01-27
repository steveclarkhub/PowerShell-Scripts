(Get-Counter '\Process(*)\% Processor Time').CounterSamples | 
select InstanceName, @{l="cpu_percent"; e={[math]::Round($_.CookedValue, 2)}}  | 
sort -Property cpu_percent -Descending | select -First 10 
