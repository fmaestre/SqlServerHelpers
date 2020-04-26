use mrocore;
CREATE TABLE #tmp2 (
					RowID int IDENTITY(1, 1),	
					[name] [nvarchar](64) ,	
					[data] [ntext] , 
					[type] [nchar](1),	
					[version] [int],
					[date_create] [datetime] ,
					[date_modify] [datetime] ,	
					[system] [nvarchar](3),	
					[module] [nvarchar](3) 
					)
-- the query
Insert into #tmp2
SELECT * FROM syn_t_trans_data where name IN ('component','document_get_data','down.bmp','get_lastdata','inc_dat_document','maccfg_delete','maccfg_get_sestime','maccfg_insert','maccfg_update','machines_cfg','menus_html/control/operations','mroctrl.dll','mrogui2.exe','mudescs','muerrds','mumacs','proxy','t_descriptions','tctrls/xhtml/ctrl_mac','tmcodes/tmcerrds','tmcodes/tmctrans','tmcodes/tmutrans','trans_exists','trans_get_likes','txsesinf','txsqlses','txviwhis','up.bmp')



-- the query

DECLARE @ROWCOUNT INT = @@rowcount
DECLARE @COUNTER INT = 1
-- variablaes used
DECLARE @name nvarchar(64) 	
DECLARE @data nvarchar(max)  
DECLARE @type nvarchar(1)  
DECLARE @version int
DECLARE @system nvarchar(3)  
DECLARE @module nvarchar(3)  

BEGIN TRY
BEGIN TRAN
-- variablaes used

WHILE @COUNTER <= @ROWCOUNT
begin
  SELECT @name=name, @data = data, @type = [type], @version = version, @system = [system], @module = module  
  FROM #tmp2 WHERE RowID = @COUNTER

 -- the process
  
  update t_trans_data 
  set data = cast(@data as ntext), [type]= @type, [version] = @version, [system] = @system, module = @module, 
             date_modify = GETDATE()     
  where name = @name
  if (@@rowcount = 0) Begin
     insert into t_trans_data (name,data,[type],[version],[system],module)
     values(@name,@data,@type,@version,@system,@module)          
     print 'Inserted...' + @name
     
  end else begin
     print 'Updated...' + @name
  end
  /*
   update a
	 set a.ES = b.es, 
		 a.EN = b.en, 
		 a.po = b.po, 
		 a.ge = b.ge, 
		 a.ch = b.ch
   from  dbo.t_modules a , syn_t_modules b
    where a.module =		b.module		and 
		   a.module_id =	b.module_id		and 
		   --a.language_id =	b.language_id   and
		   --a.cap		 =	b.cap and
		   a.module_id = @name
     
     if (@@rowcount = 0) Begin
	     insert into dbo.t_modules
	     select * from syn_t_modules a where a.module_id = @name
	      print 'Module Inserted...' + @name
     end else begin
          print 'Module Updated...' + @name
     end
  */
 -- the process
 
  SET @COUNTER = @COUNTER + 1;
  
    insert into t_descriptions
    select * from dbo.syn_t_descriptions where codeid not in (select codeid from t_descriptions)
	
end

commit tran
END TRY
BEGIN CATCH
	rollback tran
END CATCH

drop table #tmp2



     

