-- STTM_UPLOAD_CUST_PROFESSIONAL
select 
cli CUSTOMER_NO     
,'' EMPLOYMENT_STATUS      
,'' EMPLOYMENT_TENURE      
,'' RETIREMENT_AGE  
,'' PREV_DESIGNATION
,'' PREV_EMPLOYER   
,(select trim(lib1) from bkprfcli bp,bknom bn where bn.ctab='045' and bn.cacc=bp.prf and bp.cli=bc.cli fetch first 1 row only) DESIGNATION     
,(select trim(nom) from bkempl be, bkprfcli bp where be.emp=bp.emp and bp.cli=bc.cli fetch first 1 row only ) EMPLOYER 
,(select trim(adr1) from bkempl be, bkprfcli bp where be.emp=bp.emp and bp.cli=bc.cli fetch first 1 row only ) E_ADDRESS1      
,(select trim(adr2) from bkempl be, bkprfcli bp where be.emp=bp.emp and bp.cli=bc.cli fetch first 1 row only ) E_ADDRESS2      
,(select trim(adr3) from bkempl be, bkprfcli bp where be.emp=bp.emp and bp.cli=bc.cli fetch first 1 row only ) E_ADDRESS3      
,(select trim(tel) from bkempl be, bkprfcli bp where be.emp=bp.emp and bp.cli=bc.cli fetch first 1 row only ) E_TELEPHONE     
,'' E_TELEX  
,'' E_FAX    
,(select trim(email) from bkempl be, bkprfcli bp where be.emp=bp.emp and bp.cli=bc.cli fetch first 1 row only ) E_EMAIL  
,(select trim(lib1) from bkprfcli bp,bknom bn where bn.ctab='046' and bn.cacc=bp.trev and bp.cli=bc.cli fetch first 1 row only) SALARY   
,'' OTHER_EXPENSES  
,'' OTHER_INCOME    
,'' RENT     
,'' INSURANCE
,'' LOAN_PAYMENT    
,'' HOUSE_VALUE     
,'' CREDIT_CARDS    
,(select trim(lib1) from bknom bn, bkempl be, bkprfcli bp where bn.ctab = '040' and be.emp=bp.emp and bp.cli=bc.cli and bn.cacc=be.cpay  fetch first 1 row only ) E_COUNTRY
,'' CCY_PERS_INCEXP 
,'' CONVERSION_STATUS_FLAG 
,'' ERR_MSG  
,'' MAINTENANCE_SEQ_NO     
,'' SOURCE_SEQ_NO   
,age BRANCH_CODE     
,'' SOURCE_CODE  
from bkcli bc;   
