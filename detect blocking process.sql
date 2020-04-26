--Finding the lead blocker in a chain of blocks is a difficult challenge when using sp_who2. 
--There are also a lot of detect blocking scripts that I have run in production environments that seem to block things themselves.
--Probably the most efficient way to detect blocks is to query sysprocesses. The following script displays the lead blocker in a chain of blocks:

SELECT
    spid
    ,sp.status
    ,loginame   = SUBSTRING(loginame, 1, 12)
    ,hostname   = SUBSTRING(hostname, 1, 12)
    ,blk        = CONVERT(char(3), blocked)
    ,open_tran
    ,dbname     = SUBSTRING(DB_NAME(sp.dbid),1,10)
    ,cmd
    ,waittype
    ,waittime
    ,last_batch
    ,SQLStatement       =
        SUBSTRING
        (
            qt.text,
            er.statement_start_offset/2,
            (CASE WHEN er.statement_end_offset = -1
                THEN LEN(CONVERT(nvarchar(MAX), qt.text)) * 2
                ELSE er.statement_end_offset
                END - er.statement_start_offset)/2
        )
FROM master.dbo.sysprocesses sp
LEFT JOIN sys.dm_exec_requests er
    ON er.session_id = sp.spid
OUTER APPLY sys.dm_exec_sql_text(er.sql_handle) as qt
WHERE spid IN (SELECT blocked FROM master.dbo.sysprocesses)
AND blocked = 0

--This will also display the SQL Statement that is the offending blocker.