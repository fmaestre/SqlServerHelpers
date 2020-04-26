DECLARE @DB_Name	VARCHAR(30)				= '[DataBaseName]'
DECLARE @AOS		VARCHAR(30)				= '[AOSID]'
---BC Proxy Details ---
Declare @BCPSID varchar(50)					= '[BCPROXY_SID]'
Declare @BCPALIAS varchar(50)				= '[bcproxyalias]'
-- File Path
DECLArE @FILEPATH  Nvarchar(100)			= '[FILEPATH]'
---SSAS Services---
Declare @SSASSERVERNAME varchar(20)			= '[SSAS-SERVERNAME]'
---Reporting Services---
Declare @REPORTINSTANCE varchar(50)			= '[SQL instance name]'
Declare @REPORTMANAGERURL varchar(100)		= 'http://[DESTINATIONSERVERNAME]/Reports'
Declare @REPORTSERVERURL varchar(100)		= 'http://[DESTINATIONSERVERNAME]/ReportServer'
Declare @REPORTCONFIGURATIONID varchar(100) = '[UNIQUECONFIGID]'
Declare @REPORTSERVERID varchar(15)			= '[DESTINATIONSERVERNAME]'
---User info---
Declare @AdminUser varchar(15)				= '[Admin User]'
Declare @RFSUserName varchar(15)			= '[RFSmart User Name]'
Declare @RFSUserID varchar(15)				= '[RFSmart User ID]'
---List of users separated by | to keep enabled, while disabling all others--- 
Declare @ENABLE_USERS NVarchar(max)			= '|Admin|fmaestre|dgrekul'
DECLARE @IS_ENABLE_USERS_OPTION_ACTIVE bit	= 0  
---Document Types---
Declare @DocType_CustAppr NVarchar(150)		='[Customer Approval Form]'
Declare @DocType_CustSvcFile NVarchar(150)	='[Customer Service File Attachment]'
Declare @DocType_File NVarchar(150)			= '[File attachments]'
Declare @DocType_Image NVarchar(150)		= '[Image]'
Declare @DocType_IMF NVarchar(150)			= '[Item Master Form]'
---Outbound Ports---
Declare @SendPositivePay_external NVarchar(150)			='[SendPositivePay_external]'
Declare @SendPositivePay200BOA_external NVarchar(150)	='[SendPositivePay200BOA_external]'
Declare @SendPositivePay220_external NVarchar(150)		='[SendPositivePay220_external]'
Declare @SendPositivePay220BOA_external NVarchar(150)	='[SendPositivePay220BOA_external]'
Declare @vpEDI_external NVarchar(150)					='[vpEDI_external]'

SELECT 	@DB_Name = DB_name()
IF @DB_Name = 'AX_PREPROD'
BEGIN
	SET @AOS					= '01@CAVAN01ASW011D'
	---BC Proxy Details ---
	SET @BCPSID					= 'S-1-5-21-1965953594-644884979-15539647-32428'
	SET @BCPALIAS				= 'AX_BCP_TEST'
	-- File Path
	SET @FILEPATH				= '\\cavan01tsw004d\AX\PreProd\FileStore'
	---SSAS Services---
	SET @SSASSERVERNAME			= 'cavan01asw011d'
	---Reporting Services---
	SET @REPORTINSTANCE			= 'MSSQLSERVER'
	SET @REPORTMANAGERURL		= 'http://CAVAN01ASW011D/Reports'
	SET @REPORTSERVERURL		= 'http://CAVAN01ASW011D/ReportServer'
	SET @REPORTCONFIGURATIONID	= 'CAVAN01ASW011DMSSQLSERVER'
	SET @REPORTSERVERID			= 'CAVAN01ASW011D'	
	---User info---
	SET @AdminUser				= 'ADMIN_TEST'
	SET @RFSUserName			= 'AX_RFS_TEST'	
	SET @RFSUserID				= 'AX_RFS_T'
	--Document Types---
	SET @DocType_CustAppr 		= '\\cavan01tsw004d\AX\PreProd\FileStore\CustAppr\'
	SET @DocType_CustSvcFile 	= '\\cavan01tsw004d\AX\PreProd\FileStore\CSAttachments\'
	SET @DocType_File 			= '\\cavan01tsw004d\AX\PreProd\FileStore\Attachments\'
	SET @DocType_Image 			= '\\cavan01tsw004d\AX\PreProd\FileStore\Attachments\'
	SET @DocType_IMF 			= '\\cavan01tsw004d\AX\PreProd\FileStore\IMF\'
	---Outbound Ports---
	SET @SendPositivePay_external 			='\\cavan01tsw004d\AX\PreProd\Export\200\200WFUSD'
	SET @SendPositivePay200BOA_external 	='\\cavan01tsw004d\AX\PreProd\Export\200\200BOA'
	SET @SendPositivePay220_external 		='\\cavan01tsw004d\AX\PreProd\Export\220\220WFUSD'
	SET @SendPositivePay220BOA_external 	='\\cavan01tsw004d\AX\PreProd\Export\220\220BOA'
	SET @vpEDI_external 					='\\cavan01asw011d\DataMasons\vpEDI\data_1\axInboundDocs\AIF'		
	
END
ELSE IF (@DB_Name = 'AX_TEST'  AND @@SERVERNAME = 'CAVAN01DBW008D') 
BEGIN
	SET @AOS					= '01@CAVAN01ASW012D'
	---BC Proxy Details ---
	SET @BCPSID					= 'S-1-5-21-1965953594-644884979-15539647-32428'
	SET @BCPALIAS				= 'AX_BCP_TEST'
	-- File Path
	SET @FILEPATH				= '\\cavan01tsw004d\AX\Test\FileStore'
	---SSAS Services---
	SET @SSASSERVERNAME			= 'CAVAN01DBW010D'
	---Reporting Services---
	SET @REPORTINSTANCE			= 'MSSQLSERVER'
	SET @REPORTMANAGERURL		= 'http://CAVAN01DBW010D/Reports'
	SET @REPORTSERVERURL		= 'http://CAVAN01DBW010D/ReportServer'
	SET @REPORTCONFIGURATIONID	= 'CAVAN01ASW012DMSSQLSERVER'
	SET @REPORTSERVERID			= 'CAVAN01DBW010D'	
	---User info---
	SET @AdminUser				= 'ADMIN_TEST'	
	SET @RFSUserName			= 'AX_RFS_TEST'	
	SET @RFSUserID				= 'AX_RFS_T'
	--Document Types---
	SET @DocType_CustAppr 		= '\\cavan01tsw004d\AX\Test\FileStore\CustAppr\'
	SET @DocType_CustSvcFile 	= '\\cavan01tsw004d\AX\Test\FileStore\CSAttachments\'
	SET @DocType_File 			= '\\cavan01tsw004d\AX\Test\FileStore\Attachments\'
	SET @DocType_Image 			= '\\cavan01tsw004d\AX\Test\FileStore\Attachments\'
	SET @DocType_IMF 			= '\\cavan01tsw004d\AX\Test\FileStore\IMF\'	
	---Outbound Ports---
	SET @SendPositivePay_external 			='\\cavan01tsw004d\AX\Test\Export\200\200WFUSD'
	SET @SendPositivePay200BOA_external 	='\\cavan01tsw004d\AX\Test\Export\200\200BOA'
	SET @SendPositivePay220_external 		='\\cavan01tsw004d\AX\Test\Export\220\220WFUSD'
	SET @SendPositivePay220BOA_external 	='\\cavan01tsw004d\AX\Test\Export\220\220BOA'
	SET @vpEDI_external 					='\\cavan01dbw010d\DataMasons\vpEDI\data_1\axInboundDocs\AIF'	
END
ELSE IF @DB_Name = 'AX_DEV'
BEGIN
	SET @AOS					= '01@CAVAN01DBW009D'
	---BC Proxy Details ---
	SET @BCPSID					= 'S-1-5-21-1965953594-644884979-15539647-32420'
	SET @BCPALIAS				= 'AX_BCP_DEV'
	-- File Path
	SET @FILEPATH				= '\\cavan01tsw004d\AX\Dev\FileStore'
	---SSAS Services---
	SET @SSASSERVERNAME			= 'CAVAN01DBW009D'
	---Reporting Services---
	SET @REPORTINSTANCE			= 'MSSQLSERVER'
	SET @REPORTMANAGERURL		= 'http://CAVAN01DBW009D/Reports'
	SET @REPORTSERVERURL		= 'http://CAVAN01DBW009D/ReportServer'
	SET @REPORTCONFIGURATIONID	= 'CAVAN01DBW009DMSSQLSERVER'
	SET @REPORTSERVERID			= 'CAVAN01DBW009D'	
	---User info---
	SET @AdminUser				= 'ADMIN_DEV'
	SET @RFSUserName			= 'AX_RFS_DEV'	
	SET @RFSUserID				= 'AX_RFS_D'
	--Document Types---
	SET @DocType_CustAppr 		= '\\cavan01tsw004d\AX\Dev\FileStore\CustAppr\'
	SET @DocType_CustSvcFile 	= '\\cavan01tsw004d\AX\Dev\FileStore\CSAttachments\'
	SET @DocType_File 			= '\\cavan01tsw004d\AX\Dev\FileStore\Attachments\'
	SET @DocType_Image 			= '\\cavan01tsw004d\AX\Dev\FileStore\Attachments\'
	SET @DocType_IMF 			= '\\cavan01tsw004d\AX\Dev\FileStore\IMF\'	
	---Outbound Ports---
	SET @SendPositivePay_external 			='\\cavan01tsw004d\AX\Dev\Export\200\200WFUSD'
	SET @SendPositivePay200BOA_external 	='\\cavan01tsw004d\AX\Dev\Export\200\200BOA'
	SET @SendPositivePay220_external 		='\\cavan01tsw004d\AX\Dev\Export\220\220WFUSD'
	SET @SendPositivePay220BOA_external 	='\\cavan01tsw004d\AX\Dev\Export\220\220BOA'
	SET @vpEDI_external 					='\\cavan01dbw009d\DataMasons\vpEDI\data_1\axInboundDocs\AIF'		
END
ELSE IF (@DB_Name = 'AX_TEST' AND @@SERVERNAME = 'VANDBW011D') 
BEGIN
	SET @AOS					= '01@VANDBW011D'
	---BC Proxy Details ---
	SET @BCPSID					= 'S-1-5-21-1965953594-644884979-15539647-32428'
	SET @BCPALIAS				= 'AX_BCP_TEST'	
	-- File Path
	SET @FILEPATH				= '\\cavan01tsw004d\AX\Test3\FileStore'
	---SSAS Services---
	SET @SSASSERVERNAME			= 'VANDBW011D'
	---Reporting Services---
	SET @REPORTINSTANCE			= 'MSSQLSERVER'
	SET @REPORTMANAGERURL		= 'http://VANDBW011D/Reports'
	SET @REPORTSERVERURL		= 'http://VANDBW011D/ReportServer'
	SET @REPORTCONFIGURATIONID	= 'VANDBW011DMSSQLSERVER'
	SET @REPORTSERVERID			= 'VANDBW011D'	
	---User info---
	SET @AdminUser				= 'ADMIN_TEST'	
	SET @RFSUserName			= 'AX_RFS_TEST'	
	SET @RFSUserID				= 'AX_RFS_T'
	--Document Types---
	SET @DocType_CustAppr 		= '\\cavan01tsw004d\AX\Test3\FileStore\CustAppr\'
	SET @DocType_CustSvcFile 	= '\\cavan01tsw004d\AX\Test3\FileStore\CSAttachments\'
	SET @DocType_File 			= '\\cavan01tsw004d\AX\Test3\FileStore\Attachments\'
	SET @DocType_Image 			= '\\cavan01tsw004d\AX\Test3\FileStore\Attachments\'
	SET @DocType_IMF 			= '\\cavan01tsw004d\AX\Test3\FileStore\IMF\'	
	---Outbound Ports---
	SET @SendPositivePay_external 			='\\cavan01tsw004d\AX\Test3\Export\200\200WFUSD'
	SET @SendPositivePay200BOA_external 	='\\cavan01tsw004d\AX\Test3\Export\200\200BOA'
	SET @SendPositivePay220_external 		='\\cavan01tsw004d\AX\Test3\Export\220\220WFUSD'
	SET @SendPositivePay220BOA_external 	='\\cavan01tsw004d\AX\Test3\Export\220\220BOA'
	SET @vpEDI_external 					='\\VANDBW011D\DataMasons\vpEDI\data_1\axInboundDocs\AIF'		
END

BEGIN TRAN
	
	---Update AOS Server Config---
	DELETE FROM SYSSERVERCONFIG WHERE RecId not in (SELECT MIN(recId) FROM SYSSERVERCONFIG)
	UPDATE SYSSERVERCONFIG SET serverid=@AOS, ENABLEBATCH=1 
		WHERE serverid != @AOS 
		
	---business connector proxy information--- [This table always contains one record.]
	UPDATE SYSBCPROXYUSERACCOUNT SET SID=@BCPSID, NETWORKALIAS= @BCPALIAS
		WHERE NETWORKALIAS != @BCPALIAS	
 
    ---Update batch configuration instances---
    DELETE BATCHSERVERCONFIG WHERE RecId not in (SELECT MIN(recId) FROM BATCHSERVERCONFIG)
    UPDATE BATCHSERVERCONFIG SET SERVERID = @AOS
		WHERE serverid != @AOS 
		
	---Update batch server groups---
	DELETE BATCHSERVERGROUP WHERE RecId not in (SELECT MIN(recId) FROM BATCHSERVERGROUP)
	UPDATE BATCHSERVERGROUP SET SERVERID = @AOS
		WHERE serverid != @AOS
		 
	--Update batch task information---	
	UPDATE BATCH SET SERVERID = @AOS
		WHERE serverid != @AOS 
	
	--Update file storage path---
	UPDATE SYSFILESTOREPARAMETERS  SET FILEPATH = @FILEPATH
		WHERE FILEPATH != @FILEPATH 
	
	---Update SSAS Services---
	DELETE FROM BIANALYSISSERVER WHERE RecId NOT IN (SELECT MIN(recId) FROM BIAnalysisServer)
	UPDATE BIANALYSISSERVER SET 
		SERVERNAME	=@SSASSERVERNAME, 		
		ISDEFAULT	= 1
	WHERE SERVERNAME <> @SSASSERVERNAME 
	
	---Update Reporting Services---
	DELETE FROM SRSSERVERS WHERE RecId not in (SELECT MIN(RECID) FROM SRSSERVERS)
	UPDATE SRSSERVERS SET 
		SERVERID=@REPORTSERVERID, 
		SERVERURL=@REPORTSERVERURL, 		
		REPORTMANAGERURL=@REPORTMANAGERURL, 
		SERVERINSTANCE=@REPORTINSTANCE, 
		AOSID=@AOS,
		CONFIGURATIONID=@REPORTCONFIGURATIONID 		
	WHERE SERVERID != @REPORTSERVERID 

	
	---Clean up server sessions---
	DELETE FROM SYSSERVERSESSIONS
	---Clean up client sessions---
	DELETE FROM SYSCLIENTSESSIONS

	---Update Admin user---
	UPDATE USERINFO SET NAME= @AdminUser, NETWORKALIAS = @AdminUser
		WHERE ID = 'Admin'
		
	---Update RFS user---
	UPDATE USERINFO SET NAME= @RFSUserName, NETWORKALIAS = @RFSUserName, ID = @RFSUserID
		WHERE ID = 'AX_RFS'	
	
	---Disable all users except for a specific set---
	IF @IS_ENABLE_USERS_OPTION_ACTIVE = 1 
		UPDATE USERINFO SET [ENABLE] =0 WHERE  CharIndex('|'+ cast(ID as varchar) + '|' , @ENABLE_USERS) = 0			
 
	---Put the AX batch jobs on hold by running the following query---
	UPDATE BATCHJOB SET STATUS = 0 WHERE STATUS = 1 
	---Reset cache file settings---
	UPDATE SYSSQMSETTINGS SET GLOBALGUID = '00000000-0000-0000-0000-000000000000'

	---Reset Document Type's paths 
	UPDATE DOCUTYPE
	SET ARCHIVEPATH =
					( 
						SELECT 
							CASE TYPEID
								WHEN 'CustAppr'		THEN @DocType_CustAppr
								WHEN 'CustSvcFile'	THEN @DocType_CustSvcFile
								WHEN 'File'			THEN @DocType_File
								WHEN 'Image'		THEN @DocType_Image
								WHEN 'IMF'			THEN @DocType_IMF
								ELSE	ARCHIVEPATH
							END			
					 )
	WHERE ARCHIVEPATH <> ''
	---Reste Outbound Ports---
	UPDATE AIFCHANNEL 
	SET TRANSPORTADDRESS = 
						    (
								SELECT 
									CASE CHANNELID
										WHEN 'SendPositivePay_external'			THEN @SendPositivePay_external
										WHEN 'SendPositivePay200BOA_external'	THEN @SendPositivePay200BOA_external
										WHEN 'SendPositivePay220_external'		THEN @SendPositivePay220_external
										WHEN 'SendPositivePay220BOA_external'	THEN @SendPositivePay220BOA_external
										WHEN 'vpEDI_external'					THEN @vpEDI_external
										ELSE TRANSPORTADDRESS	
									END
							)
	WHERE ADAPTERCLASSID = '6155'   --File system adapter 

ROLLBACK TRAN 


/*
X	5.1.15  - BCP and wfexc accounts
X	5.1.16  - AOS setup
X	5.1.19 - SSRS setup
o	5.1.21 - deactivate RFSmart and EDI ports
o	5.1.22 – deactivate Positive Pay ports
X	5.1.24 – fix File Store path
o	5.1.25 - Search Crawler account
o	5.1.27 - Management Reporter restart
o	5.1.28 - Generic AX accounts
o	5.1.29 - Configure debugging
o	5.1.30 – Atlas restart
*/

