-- Unused Index Script
-- Original Author: Pinal Dave (C) 2011
-- http://blog.sqlauthority.com
SELECT TOP 1000
o.name AS ObjectName
, i.name AS IndexName
, i.index_id AS IndexID 
,i.type_desc
 , dm_ius.user_seeks AS UserSeek
, dm_ius.user_scans AS UserScans
, dm_ius.user_lookups AS UserLookups
, dm_ius.user_updates AS UserUpdates
, p.TableRows
, dm_ius.last_user_update
, 'DROP INDEX ' + QUOTENAME(i.name) 
+ ' ON ' + QUOTENAME(s.name) + '.' + QUOTENAME(OBJECT_NAME(dm_ius.object_id)) as 'drop statement'
, 'ALTER INDEX ' + QUOTENAME(i.name) 
+ ' ON ' + QUOTENAME(s.name) + '.' + QUOTENAME(OBJECT_NAME(dm_ius.object_id)) + ' DISABLE; '  as 'dis statement'
 
FROM sys.dm_db_index_usage_stats dm_ius  
INNER JOIN sys.indexes i ON i.index_id = dm_ius.index_id AND dm_ius.object_id = i.object_id   
INNER JOIN sys.objects o on dm_ius.object_id = o.object_id
INNER JOIN sys.schemas s on o.schema_id = s.schema_id
INNER JOIN (SELECT SUM(p.rows) TableRows, p.index_id, p.object_id 
				FROM sys.partitions p GROUP BY p.index_id, p.object_id) p 
		ON p.index_id = dm_ius.index_id AND dm_ius.object_id = p.object_id
WHERE OBJECTPROPERTY(dm_ius.object_id,'IsUserTable') = 1
AND dm_ius.database_id = DB_ID()   
AND i.type_desc = 'nonclustered'
AND i.is_primary_key = 0
AND i.is_unique_constraint = 0
and dm_ius.last_user_update > GETDATE()-.5
ORDER BY (dm_ius.user_seeks + dm_ius.user_scans + dm_ius.user_lookups) ASC, dm_ius.user_updates desc
GO

/*****LIST ALL DISABLE INDEXES*/

SELECT i.name AS Index_Name, i.index_id, i.type_desc, s.name AS 'Schema_Name', o.name AS Table_Name
FROM sys.indexes i
JOIN sys.objects o on o.object_id = i.object_id
JOIN sys.schemas s on s.schema_id = o.schema_id
WHERE i.is_disabled = 1
ORDER BY
5--i.name
GO