--Logical
exec xp_msver 'ProcessorCount'
--Phisical
SELECT  cpu_count / hyperthread_ratio AS physical_cpu_sockets
FROM    sys.dm_os_sys_info ;