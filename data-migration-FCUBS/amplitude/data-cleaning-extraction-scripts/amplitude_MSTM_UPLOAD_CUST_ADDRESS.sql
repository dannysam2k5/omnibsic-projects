-- MSTM_UPLOAD_CUST_ADDRESS
select 
cli CUSTOMER_NO     
,'' LOCATION 
,'' MEDIA    
,adr1 ADDRESS1 
,adr2 ADDRESS2 
,adr3 ADDRESS3 
,ville ADDRESS4 
,(select lib1 from bknom bn where bn.ctab='190' and bn.cacc=ba.lang ) LANGUAGE 
,'' TEST_KEYWORD    
,(select lib1 from bknom bn where ctab = '040' and bn.cacc=ba.cpay) COUNTRY  
,(select trim(nomrest) from bkcli bc where bc.cli = ba.cli) NAME     
,'' ANSWERBACK      
,'' TEST_REQUIRED   
,'' CHECKER_DT_STAMP
,'' MOD_NO   
,'' RECORD_STAT     
,'' AUTH_STAT
,'' ONCE_AUTH
,'' MAKER_DT_STAMP  
,'' MAKER_ID 
,'' CHECKER_ID      
,'' TOBE_EMAILED    
,'' DELIVERY_BY     
,'' HOLD_MAIL
,'' CONVERSION_STATUS_FLAG 
,'' ERR_MSG  
,'' MAINTENANCE_SEQ_NO     
,'' SOURCE_SEQ_NO   
,(select age from bkcli bc where bc.cli = ba.cli) BRANCH_CODE     
,'' SOURCE_CODE     
from bkadcli ba;