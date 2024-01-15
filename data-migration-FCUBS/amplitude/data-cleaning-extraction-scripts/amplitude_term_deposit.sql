-- Term Deposit
select 
age branch_code
,(select trim(lib) from bkage ba where ba.age=bd.age) branch_name
,eve deposit_number
,(select trim(nomrest) from bkcli bi, bkcom bc where bi.cli=bc.cli and bc.ncp=bd.ncp fetch first 1 row only ) customer_name
,ncp account_number
,dco execution_date
,dva value_date
,mon deposit_amount
,tau interest_rate
,decode(ctr,'0','Pending decision',
'1','Implementation not posted',
'2','In progress',
'3','In progress with modified maturity',
'8','Term deposit pledged and mature',
'9','Mature or early repayment',
'6','Early repayment with rate modification',
'7','Early repayment without rate modification') file_status
,dech maturity_date
from bkdat bd where eta in ('FO','VA');