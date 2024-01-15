-- ATM CARD EXTRACT
alter session set nls_date_format = 'dd/mm/yyyy';
define DATE_PARAM = '30/04/2022';

--------------------------
-- STTM_CARD_CUSTOMER
--------------------------
truncate table STTM_CARD_CUSTOMER;

insert into STTM_CARD_CUSTOMER
select 
'' CUSTOMER_ID
,gc.first_name||' '||gc.family_name CUSTOMER_NAME
,'MIG_USER1' MAKER_ID
,SYSDATE MAKER_DT_STAMP
,'MIG_USER2' CHECKER_ID
,SYSDATE CHECKER_DT_STAMP
,1 MOD_NO
,'O' RECORD_STAT
,'A' AUTH_STAT
,'Y' ONCE_AUTH
from ghlink_card gc where expiry_date > '&DATE_PARAM';

commit;

------------------------
-- STTM_CARD_ACCOUNT
------------------------
truncate table STTM_CARD_ACCOUNT;
insert into STTM_CARD_ACCOUNT
select
ca.branch_code BRANCH_CODE
,gc.source_account_number CUST_AC_NO
,'O' RECORD_STAT
,'A' AUTH_STAT
,'Y' ONCE_AUTH
,1 MOD_NO
,'MIG_USER1' MAKER_ID
,SYSDATE MAKER_DT_STAMP
,'MIG_USER2' CHECKER_ID
,SYSDATE CHECKER_DT_STAMP
,'' CUSTOMER_ID
,'D' DR_CR_IND
from ghlink_card gc, sttb_upload_cust_account_casa ca  
where gc.source_account_number = ca.alt_ac_no
and gc.expiry_date > '&DATE_PARAM';

commit;

---------------------
-- SWTM_CARD_DETAILS
----------------------
truncate table SWTM_CARD_DETAILS;

insert into SWTM_CARD_DETAILS
select 
ca.alt_ac_no ATM_ACC_NO
,gc.card_number ATM_CARD_NO
,ca.branch_code FCC_ACC_BRN -- Find out from DEJI
,'' FCC_ACC_NO -- Find out from DEJI
,'MIG_USER1' MAKER_ID
,SYSDATE MAKER_DT_STAMP
,'MIG_USER2' CHECKER_ID
,SYSDATE CHECKER_DT_STAMP
,'O' RECORD_STAT
,'A' AUTH_STAT
,'Y' ONCE_AUTH
,'1' MOD_NO
,'' CARD_TYPE
,'' CATEGORY
,'' ATM_DLY_TXN_LIMIT
,'' ATM_DLY_COUNT_LIMIT
,'' POS_DLY_TXN_LIMIT
,'' POS_DLY_COUNT_LIMIT
,ca.ccy CCY_CODE
,'' ATM_UTILIZED_LIMIT
,'' ATM_UTILIZED_COUNT
,'' POS_UTILIZED_LIMIT
,'' POS_UTILIZED_COUNT
,'' LAST_TXN_DATE
,'' ATM_MAX_TXN_LIMIT
,'' POS_MAX_TXN_LIMIT
from ghlink_card gc, sttb_upload_cust_account_casa ca  
where gc.source_account_number = ca.alt_ac_no
and gc.expiry_date > '&DATE_PARAM';

commit;

------------------------
-- STTM_DEBIT_CARD_MASTER
-------------------------
truncate table STTM_DEBIT_CARD_MASTER;
insert into STTM_DEBIT_CARD_MASTER
select 
ca.branch_code BRANCH_CODE
,gc.reference_number REQUEST_REFERENCE_NO
,gc.card_number CARD_NO
,'' CARD_SEQ_NO
,'' CUST_NO
,gc.source_account_number CUST_AC_NO
,'GHLK' CARD_PRODUCT
,'Y' PRIMARY_CARD
,gc.first_name||' '||gc.family_name NAME_ON_CARD
,NULL OWNER_ID_NO
,NULL ADDL_HOLDER_IDNO
,'' CARD_APPL_DATE
,gc.delivery_card_date CARD_ISSUED_DT
,'' CARD_RENEWAL_DT
,gc.card_expiration_date CARD_EXPIRY_DT
,gc.activation_date ACTIVATION_DT
,'' DISPATCH_STATUS
,'' PIN_MAILED_STATUS
,'A' CARD_STATUS -- A: Active B: Block
,SYSDATE LAST_STATUS_UPDATED
,'' LAST_OPERATION
,'' FEE_CODE
,'' RENEWAL_CODE
,'' REMARKS
,'Y' RENEWAL_UNIT
,'D' ATM_LIMIT_UNIT
,10 ATM_COUNT_LIMIT
,3000 ATM_AMOUNT_LIMIT
,'D' POS_LIMIT_UNIT
,0 POS_COUNT_LIMIT
,0 POS_AMOUNT_LIMIT
,'' REM_ATM_LIMIT_UNIT
,10 REM_ATM_COUNT_LIMIT
,3000 REM_ATM_AMOUNT_LIMIT
,'D' REM_POS_LIMIT_UNIT
,0 REM_POS_COUNT_LIMIT
,0 REM_POS_AMOUNT_LIMIT
,'O' RECORD_STAT
,'A' AUTH_STAT
,'Y' ONCE_AUTH
,1 MOD_NO
,'MIG_USER1' MAKER_ID
,SYSDATE MAKER_DT_STAMP
,'MIG_USER2' CHECKER_ID
,SYSDATE CHECKER_DT_STAMP
,50780404 CARD_BIN
,2 RENEWAL_CYCLE
,'' PRIMARY_CARD_NO
,'' OWNER_ID_TYPE
,'' ADDL_HOLDER_ID_TYPE
,'' ISSUER
,'' BILL_CYCLE
,'' PLASTIC_TYPE
,'' CARD_BLOCKED
,'' CREDIT_CARD_LIMIT
,'' HOLD_BILL_INDICATOR
,'' RECOVERY_ACCOUNT
,'' DEL_CHNL_CARD
,'' DEL_CHNL_PIN
,'' ADDL_HOLDER_DOB
,'' ADDL_HOLDER_RELATION
,'D' DR_CR_INDICATOR
,'GH-LINK' CARD_TYPE
from ghlink_card gc, sttb_upload_cust_account_casa ca  
where gc.source_account_number = ca.alt_ac_no
and gc.expiry_date > '&DATE_PARAM';

commit;
