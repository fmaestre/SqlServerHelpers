select s.name,b.name,b.type_desc, b.type,  a.*
from  sys.dm_db_index_usage_stats a right join sys.objects b on a.object_id = b.object_id
inner join sys.schemas s on s.schema_id = b.schema_id
where type = 'U'
and last_user_scan is null and last_user_lookup is null and last_user_seek is null and last_user_update is null
order by 1,2


--select * from imagenes






