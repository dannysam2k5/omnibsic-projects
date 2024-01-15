-- STTM_UPLOAD_CUST_SHAREHOLDER

select 
cli CUSTOMER_NO 
,cact SHAREHOLDER_ID 
,pcap PERCENTAGE_HOLDING    
,'' CONVERSION_STATUS_FLAG
,'' ERR_MSG 
,'' MAINTENANCE_SEQ_NO    
,'' SOURCE_SEQ_NO  
,(select age from bkcli bc where bc.cli=ba.cli) BRANCH_CODE    
,'' SOURCE_CODE    
from bkactcli ba;