create table tableMov(a int primary key clustered) 
insert into tableMov
select '1' union
select '2' union
select '3' union
select '4' 

alter table tablemov
drop constraint [PK__tableMov__3BD0198E300424B4] with (move to data)

alter table tablemov add primary key(a)


exec sp_help 'tablemov'