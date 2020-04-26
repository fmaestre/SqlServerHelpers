/*A Better sp_who2 using DMVs (sp_who3)


Posted by Derek Dieter
on	  June 19 2009
The following code generates the same information found in sp_who2, along with some additional troubleshooting information. It also contains the SQL Statement being run, so instead of having to execute a separate DBCC INPUTBUFFER, the statement being executed is shown in the results.

Unlike sp_who2, this custom sp_who3 only shows sessions that have a current executing request.

What is also shown is the reads and writes for the current command, along with the number of reads and writes for the entire SPID. It also shows the protocol being used (TCP, NamedPipes, or Shared Memory).
*/
CREATE PROCEDURE [dbo].[sp_who3]
 
AS
BEGIN
 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 
SELECT
    SPID                = er.session_id
    ,BlkBy              = er.blocking_session_id
    ,ElapsedMS          = er.total_elapsed_time
    ,CPU                = er.cpu_time
    ,IOReads            = er.logical_reads + er.reads
    ,IOWrites           = er.writes
    ,Executions         = ec.execution_count
    ,CommandType        = er.command
    ,ObjectName         = OBJECT_SCHEMA_NAME(qt.objectid,dbid) + '.' + OBJECT_NAME(qt.objectid, qt.dbid)
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
    ,Status             = ses.status
    ,[Login]            = ses.login_name
    ,Host               = ses.host_name
    ,DBName             = DB_Name(er.database_id)
    ,LastWaitType       = er.last_wait_type
    ,StartTime          = er.start_time
    ,Protocol           = con.net_transport
    ,transaction_isolation =
        CASE ses.transaction_isolation_level
            WHEN 0 THEN 'Unspecified'
            WHEN 1 THEN 'Read Uncommitted'
            WHEN 2 THEN 'Read Committed'
            WHEN 3 THEN 'Repeatable'
            WHEN 4 THEN 'Serializable'
            WHEN 5 THEN 'Snapshot'
        END
    ,ConnectionWrites   = con.num_writes
    ,ConnectionReads    = con.num_reads
    ,ClientAddress      = con.client_net_address
    ,Authentication     = con.auth_scheme
FROM sys.dm_exec_requests er
LEFT JOIN sys.dm_exec_sessions ses
ON ses.session_id = er.session_id
LEFT JOIN sys.dm_exec_connections con
ON con.session_id = ses.session_id
CROSS APPLY sys.dm_exec_sql_text(er.sql_handle) as qt
OUTER APPLY
(
    SELECT execution_count = MAX(cp.usecounts)
    FROM sys.dm_exec_cached_plans cp
    WHERE cp.plan_handle = er.plan_handle
) ec
ORDER BY
    er.blocking_session_id DESC,
    er.logical_reads + er.reads DESC,
    er.session_id
 
END
