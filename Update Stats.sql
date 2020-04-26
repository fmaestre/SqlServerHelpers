------------------------------------------------------------------------------------------------------------
--- Check what stats need to be updated , higher rowmodctr is the key.
------------------------------------------------------------------------------------------------------------
SELECT OBJECT_NAME(id),name,STATS_DATE(id, indid) [Last updated],rowmodctr
FROM sys.sysindexes
WHERE STATS_DATE(id, indid)<=DATEADD(DAY,-1,GETDATE()) 
AND rowmodctr>=20000 
AND id IN (SELECT object_id FROM sys.tables)
--and OBJECT_NAME(id)LIKE 'GE%'
order by 4 desc

------------------------------------------------------------------------------------------------------------
-- For updatings the stats
------------------------------------------------------------------------------------------------------------
** sp_updatestats -- For updatings the stats whole DB
** UPDATE STATISTICS *Table* *Index*; -- Update the statistics for an index
** UPDATE STATISTICS *Table* -- Update all statistics on a table
** UPDATE STATISTICS *table*(*stat*) WITH SAMPLE 50 PERCENT; -- Update statistics by using 50 percent sampling
** UPDATE STATISTICS *table*(*stat*) WITH FULLSCAN -- Update statistics by using FULLSCAN
** UPDATE STATISTICS *table*(*stat*) WITH FULLSCAN, NORECOMPUTE; -- Update statistics by using FULLSCAN and turns off automatic statistics for that stat. 
------------------------------------------------------------------------------------------------------------
-- Script to select what to update based on last time and number of rows modified (inserted/Updated/Deleted)
------------------------------------------------------------------------------------------------------------	
	-- Set the thresholds when to consider the statistics outdated
	DECLARE @hours int
	DECLARE @modified_rows int
	DECLARE @update_statement nvarchar(300);

	SET @hours=24
	SET @modified_rows=20000

	--Update all the outdated statistics
	DECLARE statistics_cursor CURSOR FOR
	SELECT 'UPDATE STATISTICS '+OBJECT_NAME(id)+' '+name
	FROM sys.sysindexes
	WHERE STATS_DATE(id, indid)<=DATEADD(HOUR,-@hours,GETDATE()) 
	AND rowmodctr>=@modified_rows 
	AND id IN (SELECT object_id FROM sys.tables)
	 
	OPEN statistics_cursor;
	FETCH NEXT FROM statistics_cursor INTO @update_statement;
	 
	 WHILE (@@FETCH_STATUS <> -1)
	 BEGIN
	  --EXECUTE (@update_statement);
	  PRINT @update_statement + ' ****** ' + convert(nvarchar(20), getdate()) ;
	 
	 FETCH NEXT FROM statistics_cursor INTO @update_statement;
	 END;
	 
	 PRINT 'The outdated statistics have been updated.';
	CLOSE statistics_cursor;
	DEALLOCATE statistics_cursor;
	GO
------------------------------------------------------------------------------------------------------------------

