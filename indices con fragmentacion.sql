/*	  
---------------------------------------------------------------------------------------------  
  Reference Values (in %)							Action					SQL statement
---------------------------------------------------------------------------------------------
avg_fragmentation_in_percent > 5 AND < 30		Reorganize Index		ALTER INDEX REORGANIZE
avg_fragmentation_in_percent > 30				Rebuild Index			ALTER INDEX REBU  
*/

--USE AX_PROD
GO 

DECLARE @Script NVARCHAR(400), 
	--	@DB NVARCHAR(6) = 'AX_PROD',
		@Size int = 10000,
		@Exclude nvarchar(20) 	= 'REBUILD'


SELECT top 100	o.name, 
				s.object_id, 
				s.index_id, 
				avg_fragmentation_in_percent, 
				page_count, 
				i.name idxName,
				'ALTER INDEX ' + i.name + ' ON ' + q.name + '.' + o.name + 
				CASE 
					 WHEN avg_fragmentation_in_percent >= 30 then ' REBUILD; ' 
					 WHEN avg_fragmentation_in_percent between 10 and 30  then ' REORGANIZE; ' 
				END AS script
--into #idxs
FROM sys.dm_db_index_physical_stats(DB_ID(), --bd id
                                    null, --table id
                                    NULL, 
                                    NULL, 
                                    NULL) s
	 join sys.objects o on o.object_id = s.object_id
	 join sys.indexes i on o.object_id = i.Object_id and s.index_id = i.index_id
	 join sys.schemas q on o.schema_id = q.schema_id
WHERE o.type_desc = 'USER_TABLE' and avg_fragmentation_in_percent >= 10
	  and i.Name is not null
	  and page_count > @Size
ORDER BY 4 ASC  



