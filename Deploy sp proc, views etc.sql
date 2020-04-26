SELECT OBJECT_NAME(OBJECT_ID),
definition
FROM sys.sql_modules
WHERE definition LIKE '%' + 'batch' + '%'


--pasar el grid a texto y yaaaaa
SELECT DISTINCT OBJECT_NAME(OBJECT_ID),
object_definition(OBJECT_ID)
FROM sys.Procedures
WHERE OBJECT_NAME(OBJECT_ID) IN ('qr030','tcovenr','trolley_batch_relation_delete','trolley_batch_relation_get','trolley_batch_relation_get_all','trolley_batch_relation_get_full','trolley_batch_relation_insert','trolley_batch_relation_update','dcswrk01.dll','prod_is_coated','dcswrk02.dll','get_global_finals','get_global_totals')
GO
SELECT DISTINCT OBJECT_NAME(OBJECT_ID),
object_definition(OBJECT_ID) 
FROM sys.Procedures
WHERE OBJECT_NAME(OBJECT_ID) IN ('q058','q059','q070b','qblockh','qc_delete_block_detail','qc_delete_block_header','qc_delete_block_sample','qc_get_block_detail','qc_get_block_header','qc_get_block_sample','qc_get_inspection_detail','qc_get_last_block_header','qc_insert_block_detail','qc_insert_block_header','qc_insert_block_sample','qc_update_block_detail','qc_update_block_header','qc_update_block_sample','qqcdelonesample','qr016l','qr016l_ftr','qr016l_hdr','t_qc_block_detail','t_qc_block_header','t_qc_block_sample','t_trays','tlines_configuration','tray_acquire','tray_release')




SELECT * FROM sys.sql_modules where  OBJECT_NAME(OBJECT_ID) IN ('q058','q059','q070b','qblockh','qc_delete_block_detail','qc_delete_block_header','qc_delete_block_sample','qc_get_block_detail','qc_get_block_header','qc_get_block_sample','qc_get_inspection_detail','qc_get_last_block_header','qc_insert_block_detail','qc_insert_block_header','qc_insert_block_sample','qc_update_block_detail','qc_update_block_header','qc_update_block_sample','qqcdelonesample','qr016l','qr016l_ftr','qr016l_hdr','t_qc_block_detail','t_qc_block_header','t_qc_block_sample','t_trays','tlines_configuration','tray_acquire','tray_release')
EXEC  sp_HelpText 'qc_delete_block_detail'
EXEC  sp_HelpText 'qc_delete_block_detail'