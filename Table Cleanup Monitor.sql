create table #t
(
  name nvarchar(128),
  rows varchar(50),
  reserved varchar(50),
  data varchar(50),
  indexes_size varchar(50),
  unused varchar(50)
)

create table #t2
(
  name nvarchar(128),
  rows varchar(50),
  reserved varchar(50),
  data varchar(50),
  indexes_size varchar(50),
  unused varchar(50),
  ts	 datetime
)

declare @id nvarchar(128)

declare @i int = 0
while 1=1 begin

		declare c cursor for
		select name from sysobjects where xtype='U' and name = 'COSTSHEETCACHE'


		open c
		fetch c into @id

		while @@fetch_status = 0 begin

		  insert into #t
		  exec sp_spaceused @id
		  
		  insert into #t2
		  select *, getdate() from #t

		  delete #t
		  
		  fetch c into @id
		end

		close c
		deallocate c

		set @i =  @i + 1
		if (@i = 15) break -- 15 minutes
		
		waitfor delay '00:01' --1 minutes

end

select *  from #t2
order by convert(int, substring(data, 1, len(data)-3)) desc

drop table #t
drop table #t2