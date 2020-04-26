if OBJECT_ID('tempdb..#tmp') is not null drop table #tmp
if OBJECT_ID('tempdb..#tmp2') is not null drop table #tmp2

SELECT spid,last_batch
into #tmp
FROM sys.sysprocesses
--where loginame <> 'sfcweb' 
	  --	and 
	  --last_batch > '2015-06-18 10:00:00'
order by last_batch desc

DECLARE @sqltext VARBINARY(400)
DECLARE @sid int = 272

while 1 = 1 begin

   
	select top 1  @sid = spid from #tmp
	if (@@ROWCOUNT = 0) break

	SELECT @sqltext = sql_handle
	FROM sys.sysprocesses
	WHERE spid = @sid
	
	
	if OBJECT_ID('tempdb..#tmp2') is not null 
		insert into #tmp2
		SELECT p.spid,p.loginame, hostname, status, program_name, login_time, last_batch ,TEXT
		FROM sys.dm_exec_sql_text(@sqltext)  , sys.sysprocesses p
		where spid = @sid
	
	else
		SELECT p.spid,p.loginame, hostname, status, program_name, login_time, last_batch ,TEXT
		into #tmp2
		FROM sys.dm_exec_sql_text(@sqltext)  , sys.sysprocesses p
		where spid = @sid


    delete top(1) from #tmp

end


select * from #tmp2
--where loginame = 'sfcuser'
where loginame not in('sfcweb','fcvuser','CZNET\viFMaest') and hostname not in('MXTI1SDB02','MXTI1SAPP01','MXTI1Q0311','MXTI1SDB01')
--and program_name not in('Microsoft SQL Server Management Studio')
order by last_batch desc
