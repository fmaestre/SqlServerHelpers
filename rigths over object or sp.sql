use msdb
go
SELECT  OBJECT_NAME(so.object_id) AS obj_Name, spr.name, sdp.permission_name, sdp.state_desc
FROM sys.database_permissions sdp, sys.objects so, sys.database_principals spr
WHERE sdp.major_id = so.object_id AND spr.principal_id = sdp.grantee_principal_id 
--and so.name = 'clearlog_core'
order by 1
