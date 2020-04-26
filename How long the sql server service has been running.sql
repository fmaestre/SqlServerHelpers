SELECT
    login_time
FROM
    sys.dm_exec_sessions
WHERE
    session_id = 1


-- For the Server 2003
 net statistics server