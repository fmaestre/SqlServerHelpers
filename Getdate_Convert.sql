declare @i int = -1
while @i < 500
begin
	begin try
		print cast(@i as nvarchar) + ' ** ' +  convert(nvarchar,GETDATE(),@i)
	end try
	begin catch 	
	end catch
	set @i = @i + 1
end