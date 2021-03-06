use master
GO
ALTER DATABASE AX_TEST_MODEL SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
RESTORE DATABASE AX_TEST_MODEL  
   FROM DISK = N'D:\SqlBackupFiles\AX\Simple\AX_TEST_model\AX_PROD_model_backup_2017_12_25_230002_5126296.bak'   
   WITH RECOVERY;  
GO 
ALTER DATABASE AX_TEST_MODEL SET MULTI_USER
GO 
USE [AX_TEST_MODEL]
GO
ALTER DATABASE [AX_TEST_MODEL] MODIFY FILE (NAME=N'AX_PROD_MODEL', NEWNAME=N'AX_TEST_MODEL')
ALTER DATABASE [AX_TEST_MODEL] MODIFY FILE (NAME=N'AX_PROD_MODEL_log', NEWNAME=N'AX_TEST_Model_log')
GO



use master
GO
ALTER DATABASE AX_TEST SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
RESTORE DATABASE AX_TEST  
   FROM DISK = N'D:\SqlBackupFiles\AX\Simple\AX_TEST\AX_PROD_backup_2017_12_24_001500_8383542.bak'   
   WITH NORECOVERY;  
GO  
RESTORE DATABASE AX_TEST  
   FROM DISK = N'D:\SqlBackupFiles\AX\Simple\AX_TEST\AX_PROD_backup_2017_12_25_001500_7568764.bak'   
   WITH NORECOVERY;  
GO  
RESTORE DATABASE AX_TEST  
   FROM DISK = N'D:\SqlBackupFiles\AX\Simple\AX_TEST\AX_PROD_backup_2017_12_26_001501_5838296.bak'   
   WITH NORECOVERY;  
GO  
RESTORE DATABASE AX_TEST  
   FROM DISK = N'D:\SqlBackupFiles\AX\Simple\AX_TEST\AX_PROD_Manual_Diff_2017Dic26.bkp'   
   WITH RECOVERY;    
GO 
ALTER DATABASE AX_TEST SET MULTI_USER
GO
USE [AX_TEST]
GO
ALTER DATABASE [AX_TEST] MODIFY FILE (NAME=N'AX_PROD', NEWNAME=N'AX_TEST')
ALTER DATABASE [AX_TEST] MODIFY FILE (NAME=N'AX_PROD_log', NEWNAME=N'AX_TEST_log')


GO
update SYSSQMSETTINGS
set GLOBALGUID = '00000000-0000-0000-0000-000000000000'
GO
UPDATE BATCHJOB SET STATUS = 0 WHERE STATUS = 1 
GO

USE AX_TEST
ALTER USER EgonAXConnect WITH LOGIN = EgonAXConnect
ALTER USER CarrierAXConnect WITH LOGIN = CarrierAXConnect
ALTER USER EDIAXConnect WITH LOGIN = EDIAXConnect
ALTER USER ANGAXConnect WITH LOGIN = ANGAXConnect

USE AX_TEST_SSC
ALTER USER EgonAXConnect WITH LOGIN = EgonAXConnect
ALTER USER ANGAXConnect WITH LOGIN = ANGAXConnect

USE AX_TEST_MODEL
ALTER USER ANGAXConnect WITH LOGIN = ANGAXConnect

USE AX_TEST_ManagementReporter
ALTER USER ANGAXConnect WITH LOGIN = ANGAXConnect

****************************
/*
update UserInfo
set ENABLE = 0
where ID not IN ('wfexc','SP_CRAWL','ax_rfs','AX_DATA1','AX_DATAM','AX_EDI_S','ax_alert','admin','fmaestre')
*/



