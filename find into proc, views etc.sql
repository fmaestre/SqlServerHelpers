SELECT OBJECT_NAME(OBJECT_ID),
definition
FROM sys.sql_modules
WHERE definition LIKE '%' + 'PRICECALCID' + '%'
      and definition LIKE '%' + 'acum' + '%'
      and definition LIKE '%' + 'update' + '%'

--pasar el grid a texto y ya   (from DEV)
SELECT DISTINCT OBJECT_NAME(OBJECT_ID),
object_definition(OBJECT_ID)
FROM sys.Procedures
WHERE OBJECT_NAME(OBJECT_ID) IN ('z_ordenes')
GO
SELECT DISTINCT OBJECT_NAME(OBJECT_ID),
object_definition(OBJECT_ID) 
FROM sys.Procedures
WHERE OBJECT_NAME(OBJECT_ID) IN ('z_ordenes')



SELECT j.name, s.step_id, s.database_name, s.command
    FROM msdb.dbo.sysjobsteps AS s
    INNER JOIN msdb.dbo.sysjobs AS j
    ON s.job_id = j.job_id
    WHERE s.command like '%yield%'





SELECT * FROM sys.sql_modules where  OBJECT_NAME(OBJECT_ID) IN ('z_ordenes')
EXEC  sp_HelpText 'qc_delete_block_detail'
EXEC  sp_HelpText 'qc_delete_block_detail'



--2000
SELECT DISTINCT o.name ,o.xtype
FROM syscomments c
INNER JOIN sysobjects o ON c.id=o.id
WHERE c.text LIKE '%PRICECALCID%'


-- find columns on tables or views
SELECT   SchemaName = c.table_schema,
         TableName = c.table_name,
		 t.table_type,
         ColumnName = c.column_name,
         DataType = data_type
FROM     information_schema.columns c
         INNER JOIN information_schema.tables t
           ON c.table_name = t.table_name
              AND c.table_schema = t.table_schema
              --AND t.table_type = 'BASE TABLE'
where c.column_name like '%node%'
ORDER BY 2
