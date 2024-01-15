-- Frozen accounts
select 
(select bi.cli from bkcli bi, bkcom bc where bi.cli=bc.cli and bc.ncp = boc.ncp fetch first 1 row only) customer_code
,(select trim(nomrest) from bkcli bi, bkcom bc where bi.cli=bc.cli and bc.ncp = boc.ncp fetch first 1 row only) customer_name
,age branch_code
,(select trim(lib) from bkage ba where ba.age = boc.age) branch_name
,dev currency_code
,ncp account_number
,(select sde from bkcom bc where bc.ncp = boc.ncp fetch first 1 row only) account_balance
,ddeb effective_date
from bkoppcom boc where opp = '08';