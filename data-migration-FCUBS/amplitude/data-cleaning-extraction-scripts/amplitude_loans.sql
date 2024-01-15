-- Loan file
select
age branch_code
,eve loan_number
,cli customer_code
,(select trim(libe) from bktyprt bt where bt.typ=bp.typ ) loan_type
,dev currency_code
,dmep implementation_date
,dpec first_instalment_date
,ddec last_instalment_date
,mon loan_amount
,tau_int interest_rate
,nbe number_of_instalment
,(case 
	when (eta='SI' and ctr='0') then 'Incomplete file under examination' 
	when (eta='SI' and ctr='1') then 'Complete file under examination' 
	when (eta='SI' and ctr='2') then 'Aborted file' 
	when (eta='VB' and ctr='1') then 'File accepted by the bank' 
	when (eta='VB' and ctr='2') then 'File rejected by the bank' 
	when (eta='VB' and ctr='3') then 'File with financing refusal' 
	when (eta='VC' and ctr='1') then 'File accepted by the customer'
	when (eta='VA' and ctr='0') then 'File validated and pending' 
	when (eta='VA' and ctr='1') then 'Implemented file' 
	when (eta='VA' and ctr='2') then 'File aborted at validation time' 
	when (eta='VA' and ctr='3') then 'File with early repayment pending posting' 
	when (eta='VA' and ctr='4') then 'Amendment pending implementation' 
	when (eta='VA' and ctr='5') then 'Early repayment in progress' 
	when (eta='VA' and ctr='9') then 'Expired or Settled file' 
		
end) status
from bkdosprt bp;