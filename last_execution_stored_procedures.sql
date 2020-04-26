select b.name, a.last_execution_time
from sys.dm_exec_procedure_stats a 
inner join sys.objects b on a.object_id = b.object_id and b.type = 'P'
where DB_NAME(a.database_ID) = 'sfc' 
and b.name = 'update_production_order'
order by 2 desc