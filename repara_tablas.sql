-- checa errores
DBCC CheckDB('sfc') 
--repara tablas
DBCC CHECKTABLE ('batch_header', REPAIR_ALLOW_DATA_LOSS)
DBCC CHECKTABLE ('batch_detail', REPAIR_ALLOW_DATA_LOSS)
DBCC CHECKTABLE ('t_poly_detail', REPAIR_ALLOW_DATA_LOSS)
