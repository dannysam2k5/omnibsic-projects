-- Standing Orders
set define off;
select
cli1 customer_code
,(select trim(nomrest) from bkcli bc where bc.cli = bv.cli1) customer_name
,age1 branch_code
,ncp1 account_number
,(case when typv='120' then 'INT & OTHER BNK STANDING OR/DI' when typv='900' then 'WEB TRANSFERS' end) SI_type
,(select trim(lib)from bkope bo where bo.ope=bv.ope) operation_type
,dpe effective_date
,dde expiry_date
,(case when resi is null then 'Active' else 'Terminated' end) Status
from bkvrt bv;