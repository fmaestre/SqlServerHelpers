--The Analysis: my crappy assumptions:
--UPDATE STATISTICS dbo.GMPVDET 
--tables under 1000 rows, I'll leave then at 20%
--tables with more rows than that, I'll use an arbitrary sliding scale formula.
--formula to be modified  based on analysis
DECLARE @option nvarchar(20) = 'COLUMNS' -- 'COLUMNS' / "ALL" (use Columns after Rebuild (index rebuilds do update index stats))
DECLARE @sql nvarchar(500) 

SELECT X.*,
  ISNULL(CASE
    WHEN X.[Total Rows]<=1000
    THEN
      CASE 
        WHEN [Percent Modified] >=20.0
        THEN 'UPDATE STATISTICS ' + [Schema Name] + '.' + [Table Name] + ' WITH ' + @option + ', FULLSCAN  --20% Small Table Rule'
      END
    WHEN [Percent Modified] = 100.00
    THEN 'UPDATE STATISTICS ' + [Schema Name] + '.' + [Table Name]     + ' WITH ' + @option + ', FULLSCAN  --100% No real Stats Rule'
    --WHEN X.[Rows Modified] > 1000
    --THEN 'UPDATE STATISTICS ' + [Schema Name] + '.' + [Table Name]     + ' WITH ' + @option + ', FULLSCAN  --1000 Rows Modified Rule'
    ELSE 
      CASE 
        WHEN X.[Total Rows] > 1000000000 --billion rows
        THEN CASE
               WHEN [Percent Modified] > 0.1
               THEN 'UPDATE STATISTICS ' + [Schema Name] + '.' + [Table Name]     + ' WITH ' + @option + ', FULLSCAN  -- 1B Big Table Rule'
             END
        WHEN X.[Total Rows] > 100000000  --hundred million rows
        THEN CASE
               WHEN [Percent Modified] > 1.0
               THEN 'UPDATE STATISTICS ' + [Schema Name] + '.' + [Table Name]     + ' WITH ' + @option + ', FULLSCAN  -- 100M Big Table Rule'
             END
        WHEN X.[Total Rows] > 10000000   --ten million rows
        THEN CASE
               WHEN [Percent Modified] > 2.0
               THEN 'UPDATE STATISTICS ' + [Schema Name] + '.' + [Table Name]     + ' WITH ' + @option + ', FULLSCAN  -- 10M Big Table Rule'
             END
        WHEN X.[Total Rows] > 1000000    --million rows
        THEN CASE
               WHEN [Percent Modified] > 5.0
               THEN 'UPDATE STATISTICS ' + [Schema Name] + '.' + [Table Name]     + ' WITH ' + @option + ', FULLSCAN  -- 1M Big Table Rule'
             END
        WHEN X.[Total Rows] > 100000     --hundred thousand rows
        THEN CASE
               WHEN [Percent Modified] > 10.0
               THEN 'UPDATE STATISTICS ' + [Schema Name] + '.' + [Table Name]     + ' WITH ' + @option + ', FULLSCAN  -- 100K Big Table Rule'
             END
        WHEN X.[Total Rows] > 10000      --ten thousand rows
        THEN CASE
               WHEN [Percent Modified] > 20.0
               THEN 'UPDATE STATISTICS ' + [Schema Name] + '.' + [Table Name]     + ' WITH ' + @option + ', FULLSCAN  -- 10K Big Table Rule'
             END
        END
  END,'') AS [Statistics SQL]
INTO #Stats  
FROM (
SELECT  DISTINCT
        DB_NAME()   AS [Database],
        S.name      AS [Schema Name],
        T.name      AS [Table Name],
        I.rowmodctr AS [Rows Modified],
        P.rows      AS [Total Rows],
        CASE 
          WHEN I.rowmodctr > P.rows
          THEN 100
          ELSE CONVERT(decimal(8,2),((I.rowmodctr * 1.0) / P.rows * 1.) * 100.0)
        END AS [Percent Modified]
FROM 
        sys.partitions P 
        INNER JOIN sys.tables  T ON P.object_Id = T.object_id 
        INNER JOIN sys.schemas S ON T.schema_id = S.schema_id
        INNER JOIN sysindexes  I ON P.object_id = I.id
WHERE P.index_id in (0,1)
  AND I.rowmodctr > 0
) X
WHERE [Rows Modified] > 1000
ORDER BY 7 -- [Rows Modified] DESC


while (select count(*) d from #Stats) > 1
begin
	
	select top 1 @sql = [Statistics SQL]  from #Stats

	if (@sql <> '') 
	begin
		print @sql 
		exec (@sql)
	end
	
	delete top(1) from #Stats
end

drop table #Stats