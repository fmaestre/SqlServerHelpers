
===============================
SELECT T.NAME AS TableName, s.Name AS SchemaName, p.rows AS RowCounts, SUM(a.total_pages) * 8 / 1000 AS TotalSpaceMB, SUM(a.used_pages) * 8 / 1000 AS UsedSpaceMB
FROM sys.tables t iNNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
GROUP BY t.Name, s.Name, p.Rows
ORDER BY SUM(a.used_pages) * 8 / 1000 desc


========================================



CREATE TABLE #t (
	NAME NVARCHAR(128)
	,rows VARCHAR(50)
	,reserved VARCHAR(50)
	,data VARCHAR(50)
	,indexes_size VARCHAR(50)
	,unused VARCHAR(50)
	)

DECLARE @id NVARCHAR(128)

DECLARE c CURSOR
FOR
SELECT NAME
FROM sysobjects
WHERE xtype = 'U' --and name like 'salesp%'

OPEN c

FETCH c
INTO @id

WHILE @@fetch_status = 0
BEGIN
	INSERT INTO #t
	EXEC sp_spaceused @objname = @id, @updateusage = N'TRUE'

	FETCH c
	INTO @id
END

CLOSE c

DEALLOCATE c

SELECT *
FROM #t
ORDER BY convert(INT, substring(data, 1, len(data) - 3)) DESC

DROP TABLE #t

--DBCC SHRINKFILE (AX_PREPROD, 1000)
--DBCC SHRINKFILE(AX_PREPROD_log, 1)
--BACKUP LOG AX_PREPROD TO DISK= 'NUL:' --2008
--DBCC SHRINKFILE(AX_PREPROD_log, 1)
--select year(STARTDATETIME) Year_,month(STARTDATETIME) Month_, COUNT(*) records
--from BATCHHISTORY with(nolock)
--group by month(STARTDATETIME), year(STARTDATETIME)
--order by 1,2
--select year(STARTDATETIME) Year_, COUNT(*) records
--from BATCHHISTORY  with(nolock)
--group by  year(STARTDATETIME)
--order by 1,2
SELECT NAME
	,size / 128.0 - CAST(FILEPROPERTY(NAME, 'SpaceUsed') AS INT) / 128.0 AS AvailableSpaceInMB
FROM sys.database_files;
	--DBCC SQLPERF(LOGSPACE);  
GO

--DBCC SHRINKFILE (AX_PREPROD, 1000)
