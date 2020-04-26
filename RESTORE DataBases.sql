use[master]
ALTER DATABASE mrocore SET SINGLE_USER WITH ROLLBACK IMMEDIATE

restore database mrocore
FROM DISK = 'F:\DB_To_Restore\mrocore_backup_2011_11_09_020004_4077286.bak'
WITH REPLACE, NORECOVERY

-- Optional restore Transaction Log Backup
RESTORE DATABASE mrocore WITH RECOVERY
go
ALTER DATABASE mrocore SET MULTI_USER
go


Alter user mrouser with login = mrouser


use[master]
SELECT * FROM sys.server_principals WHERE type IN ('S','U','G')
and principal_id = 270
use [mrocore]
SELECT * FROM sys.database_principals 
where principal_id = 5
GO

/****************************************************************************************************************
 R E S T O R E     DATA BASE DIFERENT FILEGROUPS
/****************************************************************************************************************
RESTORE DATABASE sfc_prod 
FILEGROUP = 'PRIMARY'
FROM DISK = N'C:\BK_HD\Databases\sfc_backup_2012_12_03_020006_7309330.bak' 
WITH 
	MOVE  'sfc' TO 'S:\DB_Data\sfc_prod.MDF', 
	MOVE  'sfc_log' TO 'F:\DB_LOGS\sfc_prod_log.LDF',PARTIAL, NORECOVERY


RESTORE DATABASE sfc_prod 
FILEGROUP = 'SECONDARY'
FROM DISK = N'C:\BK_HD\Databases\sfc_backup_2012_12_03_020006_7309330.bak' 
WITH 
	MOVE  'index_sfc' TO 'S:\DB_Data\index_sfc_prod.MDF',  RECOVERY 
/****************************************************************************************************************








/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/

RESTORE HEADERONLY 
FROM DISK = N's:\Moldes_Progresivos.bak' 
WITH NOUNLOAD;
GO

RESTORE FILELISTONLY  
FROM DISK = N's:\Moldes_Progresivos.bak' 
WITH NOUNLOAD;
GO



RESTORE DATABASE Moldes_Progresivos
FROM DISK = 's:\Moldes_Progresivos.bak'
WITH 
	MOVE  'Moldes_Progresivos_Data' TO 'S:\DB_Data\Moldes_Progresivos.MDF',
	MOVE  'Moldes_Progresivos_Log' TO 'F:\DB_LOGS\Moldes_Progresivos.LDF', RECOVERY


RESTORE DATABASE Moldes_empacados with RECOVERY 
/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/






AX
_________________

use[master]
-- Assume the database is lost, and restore full database,   
-- specifying the original full database backup and NORECOVERY,   
-- which allows subsequent restore operations to proceed.  
ALTER DATABASE AX_TEST SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
RESTORE DATABASE AX_TEST  
   FROM DISK = N'D:\SqlBackupFiles\AX\Simple\AX_TEST\AX_PROD_backup_2018_12_16_001501_0227863.bak'   
   WITH NORECOVERY;  
GO  
-- Now restore the differential database backup, the second backup on   
-- the MyAdvWorks_1 backup device.  
RESTORE DATABASE AX_TEST  
   FROM DISK = N'D:\SqlBackupFiles\AX\Simple\AX_TEST\AX_PROD_backup_2018_12_17_001501_1177145.bak'    
   WITH 
   NORECOVERY;  
 GO  
-- Now restore the differential database backup, the second backup on   
-- the MyAdvWorks_1 backup device.  
RESTORE DATABASE AX_TEST  
   FROM DISK = N'D:\SqlBackupFiles\AX\Simple\AX_TEST\AX_PROD_backup_2018_12_18_001501_2523810.bak'    
   WITH 
   RECOVERY;  
GO 
ALTER DATABASE AX_TEST SET MULTI_USER


Processed 657296 pages for database 'AX_TEST', file 'AX_PROD' on file 1.
Processed 7556 pages for database 'AX_TEST', file 'AX_PROD_log' on file 1.
RESTORE DATABASE successfully processed 664852 pages in 144.120 seconds (36.040 MB/sec).


RESTORE DATABASE AX_TEST_model  
   FROM DISK = N'c:\temp\AX_PROD_model_backup_2017_01_11_001503_1521842.bak'   
   WITH RECOVERY;
   
Processed 1128200 pages for database 'AX_TEST_model', file 'AX_PROD_model' on file 1.
Processed 1 pages for database 'AX_TEST_model', file 'AX_PROD_model_log' on file 1.
RESTORE DATABASE successfully processed 1128201 pages in 127.537 seconds (69.109 MB/sec).   


----------------------------------------------------------------------------------------------
RESTORE AND RENAME FILE GROUPS
----------------------------------------------------------------------------------------------
RESTORE DATABASE [AX_TEST] FROM  DISK = N'C:\AX_PROD_backup_2017_02_07_001503_0248754.bak' 
WITH  FILE = 1,  MOVE N'AX_PROD' 
TO N'D:\SqlDataFiles\AX_TEST.mdf',  
MOVE N'AX_PROD_log' TO N'D:\SqlLogFiles\AX_TEST.LDF',  
NOUNLOAD,  REPLACE,  STATS = 10
GO

USE [AX_TEST]
GO
ALTER DATABASE [AX_TEST] MODIFY FILE (NAME=N'AX_PROD', NEWNAME=N'AX_TEST')
GO
USE [AX_TEST]
GO
ALTER DATABASE [AX_TEST] MODIFY FILE (NAME=N'AX_PROD_log', NEWNAME=N'AX_TEST_log')
GO

update SYSSQMSETTINGS
set GLOBALGUID = '00000000-0000-0000-0000-000000000000'





