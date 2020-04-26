---------------------------------------------
SELECT SERVERPROPERTY('ErrorLogFileName') 
               AS 'Error log file location'
---------------------------------------------

---------------------------------------------			   
EXECUTE SP_READERRORLOG -- read it all (slow)
---------------------------------------------

---------------------------------------------
xp_readerrorlog 
0,  -- 0 means current
1,  -- 1 or NULL = error log, 2 = SQL Agent log
'requests taking longer',  -- text to find
NULL, 		--  text to refine search
'2019-06-06 12:00:00',  -- from
'2019-06-06 16:00:00',  -- to
N'asc'			   
---------------------------------------------


Message
SQL Server has encountered 140 occurrence(s) of I/O requests taking longer than 15 seconds to 
complete on file [K:\SqlDataFiles\tempdb.mdf] in database [tempdb] (2).  The OS file handle is 0x0000000000000BCC.  The offset of the latest long I/O is: 0x000001fa2b0000

