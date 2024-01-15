-- STTM_UPLOAD_CUST_CORPORATE
select 
cli	CUSTOMER_NO     
,rso CORPORATE_NAME  
,nrc C_NATIONAL_ID   
,(select ba.adr1 from bkadcli ba where ba.cli = bc.cli fetch first 1 row only ) R_ADDRESS1  -- bkadcli.adr1
,(select ba.adr2 from bkadcli ba where ba.cli = bc.cli fetch first 1 row only ) R_ADDRESS2 -- bkadcli.adr2
,(select ba.adr3 from bkadcli ba where ba.cli = bc.cli fetch first 1 row only ) R_ADDRESS3  -- bkadcli.adr3  
,datc INCORP_DATE     
,'' CAPITAL  
,'' NETWORTH 
,(select lib1 from bknom bn where bn.ctab = '077' and bn.cacc=bc.nchc) BUSINESS_DESCRIPTION   
,(select trim(lib4) from bknom bn where ctab = '040' and bn.cacc = bc.res)  INCORP_COUNTRY  
,(select trim(lib4) from bknom bn where ctab = '040' and bn.cacc = bc.res) R_COUNTRY
,'' AMOUNTS_CCY     
,'' CONVERSION_STATUS_FLAG 
,'' ERR_MSG  
,'' MAINTENANCE_SEQ_NO     
,'' SOURCE_SEQ_NO   
,age BRANCH_CODE     
,'' SOURCE_CODE     
,'' R_ADDRESS4
,dmo MODIFIED_DATE     
from bkcli bc where  bc.tcli = 2 and dmo <= '12-Sep-21';