------PAYOUT SCRIPT TO BE RUN AFTER STTB_UPLOAD_CUST_ACCOUNT_td UPLOAD
TRUNCATE TABLE ICTM_UPLOAD_TDPAYIN_DET;
INSERT INTO  ICTM_UPLOAD_TDPAYIN_DET
Select 
ACC.BRANCH_CODE BRN ,
'DUMMY' ACC,
ACC.CCY CCY,
'S' MULTIMODE_PAYOPT ,
DAT.MONT MULTIMODE_TDAMOUNT,
ACC.BRANCH_CODE MULTIMODE_OFFSET_BRN ,
ACC.ALT_AC_NO MULTIMODE_TDOFFSET_ACC ,
ACC.CCY MULTIMODE_TDOFFSET_CCY ,
NULL REFERENCE_NO ,
100 MULTIMODE_PERCENTAGE,
NULL MULITMODE_XRATE,
1 SEQNO                ,
ACC.MAINTENANCE_SEQ_NO MAINTENANCE_SEQ_NO,
ACC.SOURCE_CODE SOURCE_CODE,
ACC.SOURCE_SEQ_NO SOURCE_SEQ_NO, NULL CHQ_INSTUMENTNO, NULL 	CLG_BANK_CODE, NULL 	CLG_BRANCH_CODE,
 NULL 	CLG_PRODUCT_CODE, NULL 	CHQ_INSTRUMENT_DATE, NULL 	DRAWEE_AC_NO, NULL 	ROUTING_NO
From 
BKDAT DAT, STTB_UPLOAD_CUST_ACCOUNT_td ACC, BKCOM COM
where ACC.ALT_AC_NO = DAT.age||DAT.ncpd||com.clc and com.ncp=DAT.ncpd 
and DAT.eta in ('VA','FO');	

----- END PAYIN------------------------------
------ ICTM_UPLOAD_TDPAYOUT_DET -------------
TRUNCATE TABLE ICTM_UPLOAD_TDPAYOUT_DET;
INSERT INTO  ICTM_UPLOAD_TDPAYOUT_DET
Select 
ACC.BRANCH_CODE BRN ,
'DUMMY' ACC,
ACC.CCY CCY,
'S' PAYOUTTYPE ,
'' BANKCODE,
ACC.BRANCH_CODE OFFSET_BRN,                             
ACC.ALT_AC_NO OFFSET_ACC  ,                         
ACC.ALT_AC_NO OFFSET_CCY  , 
100 PERCENTAGE,
DAT.MONT REDMAMT   ,
ROUND((DAT.dech-DAT.dco)*DAT.tau*DAT.mont/36500 ,3)Interet,                         
'' BENFNAME   ,                          
'' BENFADD1   ,                         
'' BENFADD2    ,                        
'' OTHERDETS   ,                        
'' NARRATIVE     ,                       
NULL XRATE   ,                             
NULL REF_NO  ,                             
1 SEQNO     ,         
ACC.MAINTENANCE_SEQ_NO     MAINTENANCE_SEQ_NO,                      
ACC.SOURCE_CODE    SOURCE_CODE,                               
ACC.SOURCE_SEQ_NO     SOURCE_SEQ_NO,                                
'I' PAYOUT_COMPONENT,
'' INSTNO,
'' WAIVE_ISSUE_CHG
From 
BKDAT DAT, STTB_UPLOAD_CUST_ACCOUNT_td ACC, BKCOM COM
where ACC.ALT_AC_NO = DAT.age||DAT.ncpd||com.clc and com.ncp=DAT.ncpd 
and DAT.eta in ('VA','FO');	
Union ALL
Select 
ACC.BRANCH_CODE BRN ,
'DUMMY' ACC,
ACC.CCY CCY,
'S' PAYOUTTYPE ,
'' BANKCODE,
ACC.BRANCH_CODE OFFSET_BRN,                             
ACC.ALT_AC_NO OFFSET_ACC  ,                         
ACC.ALT_AC_NO OFFSET_CCY  , 
100 PERCENTAGE,
DAT.MONT REDMAMT   ,                         
'' BENFNAME   ,                          
'' BENFADD1   ,                         
'' BENFADD2    ,                        
'' OTHERDETS   ,                        
'' NARRATIVE     ,                       
NULL XRATE   ,                             
NULL REF_NO  ,                             
1 SEQNO     ,         
ACC.MAINTENANCE_SEQ_NO     MAINTENANCE_SEQ_NO,                      
ACC.SOURCE_CODE    SOURCE_CODE,                               
ACC.SOURCE_SEQ_NO     SOURCE_SEQ_NO,                                
'P' PAYOUT_COMPONENT,
'' INSTNO,
'' WAIVE_ISSUE_CHG
From 
BKDAT DAT, STTB_UPLOAD_CUST_ACCOUNT_td ACC, BKCOM COM
where ACC.ALT_AC_NO = DAT.age||DAT.ncpd||com.clc and com.ncp=DAT.ncpd 
and DAT.eta in ('VA','FO');	


------- END OF ICTM_UPLOAD_TDPAYOUT_DET -----------
---------------------------------------------------
Truncate TABLE ICTM_ACC_EFFDT_UPLOAD;
Insert into ICTM_ACC_EFFDT_UPLOAD
Select
ACC.MAINTENANCE_SEQ_NO MAINTENANCE_SEQ_NO,
ACC.SOURCE_CODE SOURCE_CODE,
ACC.BRANCH_CODE BRN,
'DUMMY' ACC,
'TTTT' PROD,
DAT.DVI UDE_EFF_DT,
'O' RECORD_STAT,
'Y' ONCE_AUTH,
ACC.SOURCE_SEQ_NO SOURCE_SEQ_NO,
ACC.BRANCH_CODE BRANCH_CODE
From 
BKDAT DAT, STTB_UPLOAD_CUST_ACCOUNT_td ACC, BKCOM COM
where ACC.ALT_AC_NO = DAT.age||DAT.ncpd||com.clc and com.ncp=DAT.ncpd 
and DAT.eta in ('VA','FO') and ctr not in ('9','7','6');

------------------ICTM_UPLOAD_TD_DETAILS----------------
--------------------------------------------------------

---- BEGIN Ictm_Acc_Udevals_Upload ---------
--------------------------------------
TRUNCATE TABLE Ictm_Acc_Udevals_Upload;
Insert into Ictm_Acc_Udevals_Upload
Select 
ACC.MAINTENANCE_SEQ_NO MAINTENANCE_SEQ_NO,
ACC.SOURCE_CODE SOURCE_CODE,
ACC.BRANCH_CODE BRN,
ACC.ALT_AC_NO ACC,
'TTTT' PROD,
DAT.DVI UDE_EFF_DT,
'RATE_1' UDE_ID,
DAT.TAU UDE_VALUE,
'' RATE_CODE,
'A' AUTH_STAT,
'O' RECORD_STAT,
ACC.SOURCE_SEQ_NO SOURCE_SEQ_NO,
BRANCH_CODE , '' BASE_RATE, ''	BASE_SPREAD, ''	TD_RATE_CODE,
'' UDE_VARIANCE
From 
BKDAT DAT, STTB_UPLOAD_CUST_ACCOUNT_td ACC, BKCOM COM
where ACC.ALT_AC_NO = DAT.age||DAT.ncpd||com.clc and com.ncp=DAT.ncpd 
and DAT.eta in ('VA','FO') and ctr not in ('9','7','6');	

------ END Ictm_Acc_Udevals_Upload ----------

----- BEGIN ICTM_ACC_PR_UPLOAD --------------
TRUNCATE TABLE Ictm_Acc_Udevals_Upload;
Insert into Ictm_Acc_Udevals_Upload
Select 
ACC.MAINTENANCE_SEQ_NO MAINTENANCE_SEQ_NO,
ACC.SOURCE_CODE SOURCE_CODE,
ACC.BRANCH_CODE BRN,
ACC.ALT_AC_NO ACC,
'TTTT' PROD,
'N'	WAIVE,
'N'	GEN_UCA,
'O'	RECORD_STAT,
'Y' ONCE_AUTH,
NULL	UDE_CCY,
NULL	MIN_AMT,
NULL	MAX_AMT,
NULL	FREE_TXN,
NULL	PROCESS_STATUS,
ACC.SOURCE_SEQ_NO	SOURCE_SEQ_NO	,
ACC.BRANCH_CODE	BRANCH_CODE	,
'N' CONT_VAR_ROLL

From 
BKDAT DAT, STTB_UPLOAD_CUST_ACCOUNT_td ACC, BKCOM COM
where ACC.ALT_AC_NO = DAT.age||DAT.ncpd||com.clc and com.ncp=DAT.ncpd 
and DAT.eta in ('VA','FO') and ctr not in ('9','7','6');	


-----END END -------------------------------
TRUNCATE TABLE ICTM_UPLOAD_TD_DETAILS;
INSERT INTO ICTM_UPLOAD_TD_DETAILS
Select
ACC.MAINTENANCE_SEQ_NO MAINTENANCE_SEQ_NO,
ACC.SOURCE_CODE SOURCE_CODE,
ACC.BRANCH_CODE BRN ,
ACC.ALT_AC_NO OFFSET_ACC  ,                         
ACC.CCY OFFSET_CCY  , 
'S' PAYIN_OPTION,
DAT.MONT TD_AMOUNT,
ACC.BRANCH_CODE OFFSET_BRN,
ACC.ALT_AC_NO  TD_OFFSET_ACC,
'' REFERENCE_NO,
ACC.SOURCE_SEQ_NO SOURCE_SEQ_NO,
ACC.BRANCH_CODE BRANCH_CODE,
'' CERTIFICATE_NO,
'' DUPLICATE_ISSUE,
'' STOCK_CATLOG_CD,
'' TARGET_AMOUNT

From 
BKDAT DAT, STTB_UPLOAD_CUST_ACCOUNT_td ACC, BKCOM COM
where ACC.ALT_AC_NO = DAT.age||DAT.ncpd||com.clc and com.ncp=DAT.ncpd 
and DAT.eta in ('VA','FO') and ctr not in ('9','7','6');	



Select
ACC.MAINTENANCE_SEQ_NO MAINTENANCE_SEQ_NO,
ACC.SOURCE_CODE SOURCE_CODE,
ACC.BRANCH_CODE BRN,
'DUMMY' ACC,
'TTTT' PROD,
DAT.DVI UDE_EFF_DT,
'O' RECORD_STAT,
'Y' ONCE_AUTH,
ACC.SOURCE_SEQ_NO SOURCE_SEQ_NO,
ACC.BRANCH_CODE BRANCH_CODE
From 
BKDAT DAT, STTB_UPLOAD_CUST_ACCOUNT_td ACC, BKCOM COM
where ACC.ALT_AC_NO = DAT.age||DAT.ncpd||com.clc and com.ncp=DAT.ncpd 
and DAT.eta in ('VA','FO') and ctr not in ('9','7','6');

/*
Select
ACC.MAINTENANCE_SEQ_NO MAINTENANCE_SEQ_NO,
ACC.SOURCE_CODE SOURCE_CODE,
ACC.BRANCH_CODE BRN ,
ACC.ALT_AC_NO OFFSET_ACC  ,                         
ACC.CCY OFFSET_CCY  , 
'S' PAYIN_OPTION,
DAT.MONT TD_AMOUNT,
ACC.BRANCH_CODE OFFSET_BRN,
ACC.ALT_AC_NO  TD_OFFSET_ACC,
'' REFERENCE_NO,
ACC.SOURCE_SEQ_NO SOURCE_SEQ_NO,
ACC.BRANCH_CODE BRANCH_CODE,
'' CERTIFICATE_NO,
'' DUPLICATE_ISSUE,
'' STOCK_CATLOG_CD,
'' TARGET_AMOUNT

From 
BKDAT DAT, STTB_UPLOAD_CUST_ACCOUNT_td ACC, BKCOM COM
where ACC.ALT_AC_NO = DAT.age||DAT.ncpd||com.clc and com.ncp=DAT.ncpd 
and DAT.eta in ('VA','FO') and ctr not in ('9','7','6');	
*/
---------------------------------------------------------------------------------
----------------------------------------
