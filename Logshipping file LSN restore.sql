WITH full_backups AS 
(
SELECT 
	ROW_NUMBER() OVER(PARTITION BY database_name ORDER BY database_name ASC, backup_finish_date DESC) AS [Row Number],
	server_name,
	database_name, 
	backup_set_id,
	backup_finish_date,
	last_lsn,
	media_set_id
FROM msdb.dbo.[backupset] 
WHERE [type] = 'L'
	AND [database_name] = 'AX_PROD'
)

SELECT TOP 10
	FB.server_name, 
	FB.database_name, 
	FB.backup_finish_date,
	BMF.physical_device_name AS primary_database_physical_device_name,
	'RESTORE LOG [' + FB.database_name + '] FROM  DISK = N''' + PD.backup_share + RIGHT(BMF.physical_device_name, LEN(BMF.physical_device_name) - LEN(PD.backup_directory))  + ''' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 10' AS restore_command_for_log_shipped_copy
FROM full_backups FB 
 INNER JOIN msdb.dbo.backupmediafamily BMF ON FB.media_set_id = BMF.media_set_id
 INNER JOIN msdb.dbo.log_shipping_primary_databases PD ON FB.database_name = PD.primary_database
WHERE FB.backup_finish_date > '2016-09-07 13:00:00.000'
ORDER BY FB.[Row Number] DESC;