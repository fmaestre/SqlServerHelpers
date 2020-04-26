USE AX_PROD
GO 
SELECT o.name tname, s.object_id, s.index_id, avg_fragmentation_in_percent, page_count, i.name,
	 'ALTER INDEX ' + i.name + ' ON ' + q.name + '.' + o.name + 
	 CASE 
		 when avg_fragmentation_in_percent >= 30 then ' REBUILD; ' 
		 when avg_fragmentation_in_percent < 30  then ' REORGANIZE; ' 
	 end as scr
into #frag	 
FROM sys.dm_db_index_physical_stats(DB_ID('AX_PROD'), --bd id
                                    null, --OBJECT_ID('REQTRANS'), --table id
                                    NULL, 
                                    NULL, 
                                    NULL) s
	 join sys.objects o on o.object_id = s.object_id 
	 join sys.indexes i on o.object_id = i.Object_id and s.index_id = i.index_id
	 join sys.schemas q on o.schema_id = q.schema_id
WHERE o.type_desc = 'USER_TABLE' and avg_fragmentation_in_percent >=0
	  and i.Name is not null

--- most used

DECLARE @dbid INT

SET @dbid = db_id()

SELECT db_name(d.database_id) database_name
	,object_name(d.object_id) object_name
	,s.NAME index_name
	,x.avg_fragmentation_in_percent
	,STATS_DATE(d.object_id, d.index_id) AS statistics_update_date
	,x.scr
	,x.page_count
	,c.index_columns
	,d.*
FROM sys.dm_db_index_usage_stats d
INNER JOIN sys.indexes s ON d.object_id = s.object_id
	AND d.index_id = s.index_id
LEFT OUTER JOIN (
	SELECT DISTINCT object_id
		,index_id
		,stuff((
				SELECT ',' + col_name(object_id, column_id) AS 'data()'
				FROM sys.index_columns t2
				WHERE t1.object_id = t2.object_id
					AND t1.index_id = t2.index_id
				FOR XML PATH('')
				), 1, 1, '') AS 'index_columns'
	FROM sys.index_columns t1
	) c ON c.index_id = s.index_id
	AND c.object_id = s.object_id
	left join #frag x on x.name = s.name
WHERE database_id = @dbid
	AND s.type_desc = 'NONCLUSTERED'
	AND objectproperty(d.object_id, 'IsIndexable') = 1
	--
	and x.page_count > 5000
	and avg_fragmentation_in_percent > 20
	--
ORDER BY 5 asc --(user_seeks + user_scans + user_lookups + system_seeks + system_scans + system_lookups) DESC

go
drop table #frag

--DBCC SHOW_STATISTICS(N'INVENTSETTLEMENT', I_173RECID)
--ALTER INDEX I_173RECID ON dbo.INVENTSETTLEMENT REBUILD; 
