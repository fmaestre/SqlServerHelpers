SELECT T.NAME AS TableName, s.Name AS SchemaName, p.rows AS RowCounts, SUM(a.total_pages) * 8 / 1000 AS TotalSpaceMB, SUM(a.used_pages) * 8 / 1000 AS UsedSpaceMB
FROM sys.tables t iNNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
GROUP BY t.Name, s.Name, p.Rows
ORDER BY SUM(a.used_pages) * 8 / 1000 desc
 
SELECT t.Name AS TableName, l.TABLE_ AS TableId, 
SUM(CASE WHEN l.logtype = 0 THEN 1 ELSE 0 END) AS InsertCnt,
SUM(CASE WHEN l.logtype = 1 THEN 1 ELSE 0 END) AS DeleteCnt,
SUM(CASE WHEN l.logtype = 2 THEN 1 ELSE 0 END) AS UpdateCnt,
SUM(CASE WHEN l.logtype = 3 THEN 1 ELSE 0 END) AS KeyRenameCnt
FROM SYSDATABASELOG AS l LEFT OUTER JOIN
     SQLDICTIONARY AS t ON l.TABLE_ = t.TABLEID
WHERE FIELDID = 0
GROUP BY l.TABLE_, t.NAME


SELECT t.Name AS TableName, l.TABLE_ AS TableId, 
SUM(CASE WHEN l.logtype = 0 THEN 1 ELSE 0 END) AS InsertCnt,
SUM(CASE WHEN l.logtype = 1 THEN 1 ELSE 0 END) AS DeleteCnt,
SUM(CASE WHEN l.logtype = 2 THEN 1 ELSE 0 END) AS UpdateCnt,
SUM(CASE WHEN l.logtype = 3 THEN 1 ELSE 0 END) AS KeyRenameCnt
FROM SYSDATABASELOG AS l LEFT OUTER JOIN
     SQLDICTIONARY AS t ON l.TABLE_ = t.TABLEID
WHERE FIELDID = 0
GROUP BY l.TABLE_, t.NAME




SELECT T.NAME AS TableName, s.Name AS SchemaName, p.rows AS RowCounts, SUM(a.total_pages) * 8 / 1000 AS TotalSpaceMB, SUM(a.used_pages) * 8 / 1000 AS UsedSpaceMB
FROM sys.tables t iNNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
WHERE t.NAME = 'SYSDATABASELOG' or t.NAME = 'BATCHHISTORY'
GROUP BY t.Name, s.Name, p.Rows
ORDER BY SUM(a.used_pages) * 8 / 1000 DESC




--auto growth percentage for data and log files
select DB_NAME(files.database_id) database_name, files.name logical_name, 
CONVERT (numeric (15,2) , (convert(numeric, size) * 8192)/1048576) [file_size (MB)],
[next_auto_growth_size (MB)] = case is_percent_growth
    when 1 then CONVERT(numeric(18,2), (((convert(numeric, size)*growth)/100)*8)/1024)
    when 0 then CONVERT(numeric(18,2), (convert(numeric, growth)*8)/1024)
end,
is_read_only = case is_read_only 
    when 1 then 'Yes'
    when 0 then 'No'
end,    
is_percent_growth = case is_percent_growth 
    when 1 then 'Yes'
    when 0 then 'No'
end, 
physical_name
from sys.master_files files
where files.type in (0,1)
and files.growth != 0