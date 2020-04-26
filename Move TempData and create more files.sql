
1. Execute
SELECT 'ALTER DATABASE tempdb MODIFY FILE (NAME = [' + f.name + '],' + ' FILENAME = ''E:\Sql' + CASE charindex('log', f.name)
		WHEN 0
			THEN 'Data'
		ELSE 'Log'
		END + 'Files\' + f.name + CASE 
		WHEN f.type = 1
			THEN '.ldf'
		ELSE '.mdf'
		END + ''');'	
FROM sys.master_files f
WHERE f.database_id = DB_ID(N'tempdb');

--2. Copy & Paste to SSMS
and Execute

--3. Restart the SQL service.

--4. Create new files
USE [master]; 
GO 
alter database tempdb modify file (name='{fileName}', size = 500MB, FILEGROWTH = 50MB);
GO
 
/* Adding seven additional files */
USE [master];
GO
ALTER DATABASE [tempdb] ADD FILE (NAME = N'{fileName}2', FILENAME = N'{PATH}{fileName}2.mdf' , SIZE = 500MB , FILEGROWTH = 50MB);
ALTER DATABASE [tempdb] ADD FILE (NAME = N'{fileName}3', FILENAME = N'{PATH}{fileName}3.mdf' , SIZE = 500MB , FILEGROWTH = 50MB);
ALTER DATABASE [tempdb] ADD FILE (NAME = N'{fileName}4', FILENAME = N'{PATH}{fileName}4.mdf' , SIZE = 500MB , FILEGROWTH = 50MB);
ALTER DATABASE [tempdb] ADD FILE (NAME = N'{fileName}5', FILENAME = N'{PATH}{fileName}5.mdf' , SIZE = 500MB , FILEGROWTH = 50MB);
ALTER DATABASE [tempdb] ADD FILE (NAME = N'{fileName}6', FILENAME = N'{PATH}{fileName}6.mdf' , SIZE = 500MB , FILEGROWTH = 50MB);
ALTER DATABASE [tempdb] ADD FILE (NAME = N'{fileName}7', FILENAME = N'{PATH}{fileName}7.mdf' , SIZE = 500MB , FILEGROWTH = 50MB);
ALTER DATABASE [tempdb] ADD FILE (NAME = N'{fileName}8', FILENAME = N'{PATH}{fileName}8.mdf' , SIZE = 500MB , FILEGROWTH = 50MB);
GO

