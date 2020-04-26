use hidalgo
exec sp_helpfile
/*
USE hidalgo
GO
BACKUP LOG hidalgo TO DISK= 'NUL:' --2008
--BACKUP LOG hidalgo with truncate_only --2005
GO
DBCC SHRINKFILE (HIDALGO_log, 8000)
GO
DBCC SHRINKFILE (HIDALGO, 1000)
GO
exec sp_helpfile   
*/

USE sfc
GO
DBCC SHRINKFILE(sfc_log, 1)
BACKUP LOG sfc TO DISK= 'NUL:' --2008
DBCC SHRINKFILE(sfc_log, 1)
exec sp_helpfile


-------------------------------------------------------------------
-----free space to remove
-------------------------------------------------------------------
SELECT name ,size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 AS AvailableSpaceInMB  
FROM sys.database_files;

OR

DBCC SQLPERF(LOGSPACE);
-------------------------------------------------------------------


------------------------------------------
USE AdventureWorks2008R2;
GO
-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE AdventureWorks2008R2
SET RECOVERY SIMPLE;
GO
-- Shrink the truncated log file to 1 MB.
DBCC SHRINKFILE (AdventureWorks2008R2_Log, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE AdventureWorks2008R2
SET RECOVERY FULL;
GO