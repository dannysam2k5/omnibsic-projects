-- STTM_UPLOAD_CUSTOMER
select
'CUST_UPD_A' SOURCE_CODE
,'' MAINTENANCE_SEQ_NO
,cli CUSTOMER_NO
,decode(tcli,1,'Individual',2,'Corporate',3,'Sole Proprietor') CUSTOMER_TYPE     
,nomrest CUSTOMER_NAME1    
,(select ba.adr1 from bkadcli ba where ba.cli = bc.cli fetch first 1 row only ) ADDRESS_LINE1  -- bkadcli.adr1
 ,(select ba.adr2 from bkadcli ba where ba.cli = bc.cli fetch first 1 row only ) ADDRESS_LINE2 -- bkadcli.adr2
 ,(select ba.adr3 from bkadcli ba where ba.cli = bc.cli fetch first 1 row only ) ADDRESS_LINE3 -- bkadcli.adr3     
,(select ba.ville from bkadcli ba where ba.cli = bc.cli fetch first 1 row only ) ADDRESS_LINE4     
--,(select ba.cpay from bkadcli ba where ba.cli = bc.cli fetch first 1 row only) COUNTRY -- t040
,(select trim(lib1) from bknom bn, bkadcli ba where bn.ctab = '040' and bn.cacc=ba.cpay and ba.cli = bc.cli fetch first 1 row only ) COUNTRY    
,cli SHORT_NAME 
,(select trim(lib1) from bknom bn where bn.ctab = '033' and bn.cacc=bc.nat) NATIONALITY
,(select trim(lib1) from bknom bn where bn.ctab = '190' and bn.cacc=bc.lang) LANGUAGE   
,'' EXPOSURE_COUNTRY  
,age LOCAL_BRANCH      
,cli LIABILITY_NO      
,(select trim(lib1) from bknom bn where bn.ctab = '078' and bn.cacc=bc.tid) UNIQUE_ID_NAME    -- t078
,nid UNIQUE_ID_VALUE   
,(case when (select opp from bkoppcli bkoc where bkoc.cli=bc.cli and bkoc.opp='08' and eta='V')='08' then 'Y' end) FROZEN    -- bkoppcli.opp='08'
,(case when (select opp from bkoppcli bkoc where bkoc.cli=bc.cli and bkoc.opp='06' and eta='V')='06' then 'Y' end) DECEASED   -- bkoppcli.opp='06'
,'' WHEREABOUTS_UNKNOWN      
,(select trim(lib1) from bknom bn where bn.ctab='188' and bn.cacc=bc.seg) CUSTOMER_CATEGORY --t188
,'' HO_AC_NO   
,'' FX_CUST_CLEAN_RISK_LIMIT 
,'' OVERALL_LIMIT     
,'' FX_CLEAN_RISK_LIMIT      
,'' CREDIT_RATING     
,'' REVISION_DATE     
,'' LIMIT_CCY  
,'' CAS_CUST   
,'' CONVERSION_STATUS_FLAG   
,'' ERR_MSG    
,'' SEC_CUST_CLEAN_RISK_LIMIT
,'' SEC_CLEAN_RISK_LIMIT     
,'' SEC_CUST_PSTL_RISK_LIMIT 
,'' SEC_PSTL_RISK_LIMIT      
,'' SWIFT_CODE 
,age LIAB_BR    
,'' LIAB_NODE  
,'' PAST_DUE_FLAG     
,'' DEFAULT_MEDIA     
,'' LOC_CODE   
,'' SHORT_NAME2
,nis SSN 
,'' ACTION_CODE
,'' UTILITY_PROVIDER  
,'' UTILITY_PROVIDER_ID      
,(select trim(lib1) from bknom bn where bn.ctab = '044' and bn.cacc=bc.rrc) RISK_PROFILE      
,'' DEBTOR_CATEGORY   
,'' UDF_1      
,'' UDF_2      
,'' UDF_3      
,'' UDF_4      
,'' UDF_5      
,'' MAILERS_REQUIRED  
,'' AML_CUSTOMER_GRP  
,'' AML_REQUIRED      
,'' GROUP_CODE 
,'' EXPOSURE_CATEGORY 
,'' CUST_CLASSIFICATION      
,'' CIF_STATUS 
,'' CIF_STATUS_SINCE  
,'' INTRODUCER 
,'' FT_ACCTING_AS_OF  
,'' CUST_UNADVISED    
,'' LIAB_UNADVISED    
,'' TAX_GROUP  
,'' CONSOL_TAX_CERT_REQD     
,'' INDIVIDUAL_TAX_CERT_REQD 
,'' FX_NETTING_CUSTOMER      
,'' CLS_PARTICIPANT   
,'' CLS_CCY_ALLOWED   
,'' RISK_CATEGORY     
,'' FAX_NUMBER 
,cli EXT_REF_NO 
,'' CRM_CUSTOMER      
,'' ISSUER_CUSTOMER   
,'' TREASURY_CUSTOMER 
,'' CHARGE_GROUP      
,nomrest FULL_NAME  
,'' MAKER_ID   
,'' MAKER_DT_STAMP    
,'' CHECKER_ID 
,'' CHECKER_DT_STAMP  
,'' CUST_CLG_GROUP    
,'' CHK_DIGIT_VALID_REQD     
,'' ALG_ID     
,'' SOURCE_SEQ_NO     
,age BRANCH_CODE
,(case when (select pro from bkprocli bp where bp.cli=bc.cli fetch first 1 row only)='800' 
		then 'Y' else 'N' end) STAFF
,'' KYC_REF_NO
,'' KYC_DETAIL
,'' LC_COLLATERAL_PCT
,'' AR_AP_TRACKING
,'' AUTO_CREATE_ACCOUNT
,'' AUTO_CUST_AC_NO
,'' TRACK_LIMITS
,(case when bc.tcli <> 1
  then nidf else 
  (select vala from bkicli bi where iden='007' and att='G' and bi.cli=bc.cli) end) TAXID_NO
,'' WITHHOLDING_TAX
,'' SPECIAL_CUST
,(select trim(lib1) from bknom bn where bn.ctab='072' and bn.cacc=bc.crs_status) CRS_TYPE
,'' TAX_CNTRY
from bkcli bc;