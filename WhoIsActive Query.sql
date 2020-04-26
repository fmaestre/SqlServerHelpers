USE dba

SELECT TOP 1000 CPU
	,reads
	,collection_time
	,start_time
	,[dd hh:mm:ss.mss] AS 'run duration'
	,[program_name]
	,login_name
	,database_name
	,session_id
	,blocking_session_id
	,wait_info
	,sql_text
	,*----,
	--distinct host_name
FROM WhoIsActive
WHERE --session_id = 106 and
	--AND collection_time > '2018-04-03 08:00:00.000'
collection_time BETWEEN '2019-03-13 10:30:30.000' AND '2019-03-13 10:50:00.000'
--and host_name leke= 'CAVAN01ASW011D'
---AND login_name in('ANGAXConnect') --not IN ('ANGIO\AX_AOS','ANGAXConnect','ANGIO\BPMADM')
--AND CAST(sql_text AS varchar(max)) LIKE '%EDIWmsOrder%'
ORDER BY 3 DESC

--'ANGIO\hbailey','ANGIO\kmcdonald'
