SELECT DATEADD(hh, DATEDIFF(hh, GETUTCDATE(), CURRENT_TIMESTAMP),    event_time
                             ) as corrected_time, *
 FROM sys.fn_get_audit_file ('f:\db_logs\audit_t_prod_orders_C55C9E4A-BF7E-4E59-9AF0-5B290932B0D0_0_130017314471670000.sqlaudit', default, default)
 order by 1