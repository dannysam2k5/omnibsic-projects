-- Closed accounts
select 
cli customer_code
,(select trim(nomrest)from bkcli bi where bi.cli=bc.cli ) customer_name
,age branch_code
,(select trim(lib) from bkage ba where ba.age = bc.age) branch_name
,dev currency_code
,inti account_name
,ncp account_number
,sde acount_balance
,dfe clousre_date
from bkcom bc where cfe = 'O';