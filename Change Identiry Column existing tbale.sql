Alter Table dbo.tblMoldHistory
Add Id_new Int Identity(1, 1)
Go
Alter Table tblMoldHistory Drop Column reg_id
Go
Exec sp_rename 'tblMoldHistory.Id_new', 'reg_id', 'Column'
go
alter table tblMoldHistory add primary key (reg_id)

