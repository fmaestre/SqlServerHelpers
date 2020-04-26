SELECT 
	   [sjv].[name], [sjv].[description], 
       [sja].[run_requested_date], 
       [sja].[stop_execution_date],
       [sja].[last_executed_step_id], 
       message
FROM [msdb].[dbo].[sysjobs_view] sjv
JOIN [msdb].[dbo].[sysjobactivity] sja
ON [sjv].[job_id] = [sja].[job_id]
left join [msdb].dbo.sysjobhistory jh on jh.[job_id] = [sja].[job_id] and job_history_id = instance_id
WHERE [run_requested_date] > getdate()- .5
and category_id not in(3)
AND [sja].[run_requested_date] is not null
--AND [sja].[stop_execution_date] is null
order by 3 desc