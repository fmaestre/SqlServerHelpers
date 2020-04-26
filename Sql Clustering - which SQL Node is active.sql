USE Master
GO

SELECT getdate() as myCurrentDateTime, 
@@SERVERNAME as myServerName,
SERVERPROPERTY('IsClustered') as [Clustered],
SERVERPROPERTY('ComputerNamePhysicalNetBIOS') as [ActiveNode], 
os.Cores, df.Files 
FROM 
(SELECT COUNT(*) AS Cores FROM sys.dm_os_schedulers WHERE status = 'VISIBLE ONLINE') AS os, 
(SELECT COUNT(*) AS Files FROM tempdb.sys.database_files WHERE type_desc = 'ROWS') AS df; 
GO