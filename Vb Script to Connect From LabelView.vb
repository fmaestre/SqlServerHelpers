Dim conn , rs, sql, ConnString
sql = "SELECT TOP 1 * FROM [AX].[dbo].[Items] Where itemNum= '" &  CStr(Document.DocObjects("Text29").Value)  & "'"
Set rs = CreateObject("ADODB.Recordset")
Set conn = CreateObject("ADODB.Connection")
With conn
      .Provider = "SQLNCLI11"
      '.Mode = adModeReadWrite
      .ConnectionString = "SERVER=CAVAN01BPW001D;Catalog=AX; Trusted_Connection=Yes;"
      .Open
     ' Msgbox("Connection was established.")
End With
rs.Open sql,conn
'If conn.State = 1 Then
       'Msgbox("Connection was established.")
'Else
     'Msgbox("No Connection .")
'End If

 Do Until rs.EOF
    'Msgbox(rs.Fields.Item("ItemNum"))
    Document.DocObjects("Text32").Value = rs.Fields.Item("ItemSrch")
    rs.MoveNext
  Loop

rs.Close
Set rs = Nothing
conn.Close
Set conn = Nothing





