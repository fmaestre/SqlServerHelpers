/*
Use Master
GO

EXEC master.dbo.sp_configure 'show advanced options', 1
RECONFIGURE WITH OVERRIDE
GO

EXEC master.dbo.sp_configure 'xp_cmdshell', 1
RECONFIGURE WITH OVERRIDE
GO
*/


-- ALTER DATABASE CURRENCYEVAL SET OFFLINE WITH ROLLBACK  AFTER 10 SECONDS
sp_helpfile
use master
ALTER DATABASE AX_TEST_DataMart SET OFFLINE WITH ROLLBACK  IMMEDIATE

go

declare @source1 varchar(100) = 'D:\SqlDataFiles\AX_TEST_DataMart_Primary.mdf',
        @source2 varchar(100) = 'D:\SqlLogFiles\AX_TEST_DataMart_Primary.ldf',
        @des1 varchar(100) = 'C:\SqlDataFiles\AX_TEST_DataMart_Primary.mdf',
        @des2 varchar(100) = 'C:\SqlLogFiles\AX_TEST_DataMart_Primary.ldf'
        ,
         @sql nvarchar(max) =''

set @sql='
ALTER DATABASE AX_TEST_DataMart 
MODIFY FILE (NAME = AX_TEST_DataMart, FILENAME = ''' + @des1 + ''');'

exec sp_executesql @sql

set @sql='
ALTER DATABASE AX_TEST_DataMart 
MODIFY FILE (NAME = AX_TEST_DataMart_log, FILENAME = ''' + @des2 + ''');'

exec sp_executesql @sql

set @sql='
exec master..xp_cmdshell ''move ' + @source1 + ' ' + @des1 + ''''

exec sp_executesql @sql


set @sql='
exec master..xp_cmdshell ''move ' + @source2 + ' ' + @des2 + ''''

exec sp_executesql @sql

GO

use master
ALTER DATABASE AX_TEST_DataMart SET onLINE 

go
sp_helpfile
 --EXEC xp_cmdshell 'whoami'