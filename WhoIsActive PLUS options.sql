USE [master]
GO

DECLARE	@return_value int,
		@schema varchar(max)

EXEC	@return_value = [dbo].[sp_WhoIsActive]
		@filter = '',
		@filter_type = 'session',
		@not_filter = '',
		@not_filter_type = 'session',
		@show_own_spid = 0,
		@show_system_spids = 0,
		@show_sleeping_spids = 0,
		@get_full_inner_text = 0,
		@get_plans = 0, 
		@get_outer_command = 0,
		@get_transaction_info = 0,
		@get_task_info = 1,
		@get_locks = 0,
		@get_avg_time = 0,
		@get_additional_info = 0,
		@find_block_leaders = 0,
		@delta_interval = 0,
		@output_column_list = '[dd%][session_id][sql_text][sql_command][login_name][wait_info][tasks][tran_log%][cpu%][temp%][block%][reads%][writes%][context%][physical%][query_plan][locks][%]',
		@sort_order = '[start_time] ASC',
		@format_output = 1,
		@destination_table = '',
		@return_schema = 0,
		@schema = @schema OUTPUT,
		@help = 0

SELECT	@schema as N'@schema'

SELECT	'Return Value' = @return_value

GO


select cast(context_info as varchar(128)) as ci,* from sys.dm_exec_sessions where program_name like '%Dynamics%'


--to resolve FETCT API CURSOR
-- change 186 by the session ID
--https://www.sqlskills.com/blogs/joe/hunting-down-the-origins-of-fetch-api_cursor-and-sp_cursorfetch/
SELECT c.session_id, c.properties, c.creation_time, c.is_open, t.text
FROM sys.dm_exec_cursors (186) c
CROSS APPLY sys.dm_exec_sql_text (c.sql_handle) t

