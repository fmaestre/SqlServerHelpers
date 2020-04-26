Declare @source		nvarchar(200)		= N'E:\CheckDB\AxProdBackup\'
Declare @targetdata	nvarchar(100)		= N'E:\CheckDB\AXPRODCHECK.MDF'
Declare @targetlog	nvarchar(100)		= N'E:\CheckDB\AXPRODCHECK.LDF'
Declare @dataname	nvarchar(100)		= N'AX_PROD'
Declare @logname	nvarchar(100)		= N'AX_PROD_log'
DECLARE @filen		nvarchar(200)
DECLARE @sourcefile nvarchar(200)

DECLARE @tab AS TABLE (filen VARCHAR(100), d varchar(10), f varchar(10) ) 
INSERT into @tab
EXEC xp_dirtree @source, 1, 1

begin try
    
	if db_id('AX_PROD_CHECK') is not null
	   DROP DATABASE AX_PROD_CHECK 

	if ((select COUNT(*) from @tab) > 1)  RAISERROR ('More tha 1 file in the directory', 16,1)

	SELECT @filen = filen from @tab
	print @filen

	SET @sourcefile = @source + @filen

	RESTORE DATABASE AX_PROD_CHECK 
	FROM DISK = @sourcefile 
	WITH     FILE = 1, 
	MOVE  @dataname TO @targetdata , 
	MOVE  @logname  TO @targetlog  , RECOVERY
END TRY
BEGIN CATCH
	DECLARE @ErrorMessage NVARCHAR(4000);      
    SET @ErrorMessage = ERROR_MESSAGE(); 
    
 RAISERROR (@ErrorMessage, 16,1)
END CATCH



 