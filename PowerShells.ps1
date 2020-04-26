$PSVersionTable


#last Windows boot up time with Powershell
Get-WmiObject win32_operatingsystem | select csname, @{LABEL=’LastBootUpTime’;EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}}
################################################################################

#SQL Server database checkout script
$isodate=Get-Date -format s 
  $isodate=$isodate -replace(":","")
  $basepath=(Get-Location -PSProvider FileSystem).ProviderPath
  $outputfile="\logs\connectivity_quick_" + $isodate + ".html"
  $outputfilefull = $basepath + $outputfile

 $dt = new-object "System.Data.DataTable"
 foreach ($svr in get-content "C:\dbintances\dbinstances_all.txt"){
    $svr
    $cn = new-object System.Data.SqlClient.SqlConnection "server=$svr;database=master;Integrated Security=sspi"
    $cn.Open()
    $sql = $cn.CreateCommand()
    $sql.CommandText = "select db1.name as db_name,@@servername as server_name,db1.state_desc,
CASE WHEN  db2.event_type IS NULL THEN 000 ELSE db2.event_type END as corruption ,ISNULL(error_count,0),getdate() as date_time from 
sys.databases db1
LEFT JOIN msdb..suspect_pages db2 ON db1.database_id = db2.database_id 


 "
    $rdr = $sql.ExecuteReader()
    $dt.Load($rdr)
    $cn.Close()
  
 }

$dt| select * -ExcludeProperty RowError, RowState, HasErrors, Name, Table, ItemArray |ConvertTo-Html -body "Databases checkout"| Add-Content $outputfilefull 
################################################################################

#Servers Disk's Space
foreach ($svr in get-content "C:\dbintances\instances_all.txt"){
	Get-DBADiskSpace $svr 
}
################################################################################

#Users in a AD's group
Get-ADGroupMember -Identity "AX Reporting" | 
Select samAccountName,Name | Sort-Object -Property samAccountName
################################################################################
