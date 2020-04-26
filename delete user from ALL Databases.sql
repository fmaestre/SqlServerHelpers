--Drop User from all databases on a server -
EXEC sp_Msforeachdb 'USE [?]; IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N''aaa'') DROP USER [aaa]'
GO

--Drop the login -
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = N'aaa') DROP LOGIN [aaa]
GO