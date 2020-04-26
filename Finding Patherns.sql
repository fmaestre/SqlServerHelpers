--<script type="text/javascript"></script>
select * from t_trans_data
where replace(cast (data as nvarchar(max)),' ','') like '%<scripttype="text/javascript">
</script>%'

