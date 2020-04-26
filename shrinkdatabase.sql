use[tempdb]
DBCC shrinkfile (tempdev,1)
alter database [db1] set recovery simple with no_wait
alter database [db1] set recovery full with no_wait

--Libera espacio en disco
use[tempdb]
DBCC shrinkdatabase (tempdb,10)


