EXEC sp_who2;
DBCC INPUTBUFFER(243);
kill 266
--  10.173.48.90 ldelgado w16d   begin try select hdrid, thdr.pcc, line, thdr.part, status, date, vw_prodxfam.object_id as family, product_ext.desc_short as proddesc from thdr with (nolock)  inner join vw_prodxfam  with (nolock) on (thdr.pcc = prod_code)  inner join product_ext with (nolock) on (thdr.pcc = product_ext.prod_code)  where (hdrid between '4012' and '4255') and  (thdr.pcc between '000' and 'T89') and (line between '54' and '78') and  status != 16  end try begin catch declare @errmsg varchar(256) set @errmsg = ERROR_MESSAGE() RAISERROR (@errmsg, 16,1) end catch 
