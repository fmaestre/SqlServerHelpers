
--******************************GETTING HELP WITH A SLOW SERVER *************************************************************

/* To get the waits right now, run: */
  EXEC sp_BlitzFirst @SinceStartup = 1
 
/* To get the waits right now, run:
1.	The first result set shows current activity at the very start of that sample. Any long-running queries in there? 
	Any non-NULL wait_info or non-NULL blocking_session_id values?. 
2. The second result set gives you informational data as well as high priority data. Was there high CPU utilization? Are there any waits of note in there?
	2.1		If the top wait is ASYNC_NETWORK_IO, you can stop here. You have your answer. 
			It is not a SQL Server problem. It’s almost never a network problem even though the wait stat name makes you think it is. 
			It’s sometimes a bottleneck on the application server, but it’s usually an application bottleneck. 
			Applications that do row-by-row processing while SQL Server is sending the data cause ASYNC_NETWORK_IO waits. 
			SQL Server is sending the data fast, but the application is telling SQL Server to stop while it processes what it has been sent so far. 
			While SQL Server is waiting to be told to send more data, it’s recording waiting time on ASYNC_NETWORK_IO. 
			To fix it, modify the application so that it consumes all of the data from SQL Server and THEN does its row-by-row processing.
	2.2		If the top wait is PAGEIOLATCH_SH, run sp_BlitzIndex @Mode = 0 as it is indicative of memory pressure which can often be fixed by 
			adding high-value missing indexes. Screenshot the “Indexaphobia
3.	All the waits.
4.	The fourth result set shows the I/O performance during that sample for any database file that had some reads or writes. 
	You may have database files that aren’t listed there, it’s just that there weren’t any reads or writes on them during the collection. 
	Do any of the files that are listed have an average stall of over 30 milliseconds. 
	My target for reads is 15 milliseconds or less, and my target for writes is 5 milliseconds or less. 
	Are any files showing high average stalls? The wait stats should reflect I/O waits if there’s a current I/O bottleneck. 			
5.	The fifth result set is a dump of the SQL Server Performance Monitor counters.
6.	The sixth result set? I have no idea. Ask Erik.
7.	And finally the seventh result set. That one shows current activity at the very end of the sample. Anything of note in there? 
	Maybe there wasn’t any blocking when the sample started but maybe there is now.
*/
 EXEC sp_BlitzFirst @ExpertMode = 1, @Seconds = 30