
-- To allow advanced options to be changed.  
EXEC sp_configure 'show advanced options', 1;  
GO  
-- To update the currently configured value for advanced options.  
RECONFIGURE;  
GO  
-- To enable the feature.  
EXEC sp_configure 'xp_cmdshell', 1;  
GO  
-- To update the currently configured value for this feature.  
RECONFIGURE;  
GO

set nocount on

declare @DB nvarchar(20) = 'AX_TEST'
declare @PathDiff nvarchar(200) = 'D:\SqlBackupFiles\AX\Simple\' + @DB 
declare @PathFile nvarchar(500) = 'dir ' + @PathDiff + '\*.bak /b'
declare  @fileName nvarchar(500) 
declare @files table (ID int IDENTITY, FileName varchar(100))
declare @Ordfiles table (ID int, FileName varchar(100))

print '--****************************************************************************'
print '--*************START HERE****************'
print '--****************************************************************************'
print 'use[master]'
print '-- Assume the database is lost, and restore full database,   '
print '-- specifying the original full database backup and NORECOVERY,'   
print '-- which allows subsequent restore operations to proceed.  '
print 'ALTER DATABASE ' + @DB + ' SET SINGLE_USER WITH ROLLBACK IMMEDIATE'
--print 'GO'
--print 'RESTORE DATABASE ' + @DB
--print @PathFile
insert into @files execute xp_cmdshell @PathFile
insert into @Ordfiles(id,[filename]) select id,filename from @files where [filename] is not null order by [filename] asc

while (select count(*) from @Ordfiles) > 0
begin

	select top 1 @fileName = [FileName] from @Ordfiles 

	print 'GO'
	print 	'RESTORE DATABASE ' + @DB
	print 	'FROM DISK = ''' + @PathDiff + '\' + @fileName + ''''
	if (select count(*) from @Ordfiles) = 1
		print 	'WITH RECOVERY;  '
	else
		print 	'WITH NORECOVERY, REPLACE;  '


	delete top (1) from @Ordfiles

end

print 'GO'
print 'ALTER DATABASE ' + @db + ' SET MULTI_USER'

/*To Check the progress ************************
SELECT session_id as SPID, command, a.text AS Query, start_time, percent_complete, dateadd(second,estimated_completion_time/1000, getdate()) as estimated_completion_time 
FROM sys.dm_exec_requests r CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) a 
WHERE r.command in ('BACKUP DATABASE','RESTORE DATABASE')
************************************************/