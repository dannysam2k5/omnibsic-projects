--select * from catm_check_details where account||'~'||check_book_no not in (select account||'~'||first_check_no from catm_check_book);

insert into CATM_CHECK_BOOK (
ACCOUNT,                  --1   ACCOUNT
APPLY_CHARGE,             --2   APPLY_CHARGE
AUTH_STAT,                --3   AUTH_STAT
BRANCH,                   --4   BRANCH
CHECKER_DT_STAMP,         --5   CHECKER_DT_STAMP
CHECKER_ID,               --6   CHECKER_ID
CHECK_LEAVES,             --7   CHECK_LEAVES
CHEQUE_BOOK_TYPE,         --8   CHEQUE_BOOK_TYPE
CHQBOOK_DELIVERD,         --9   CHQBOOK_DELIVERD
CHQ_TYPE,                 --10   CHQ_TYPE
DELIVERY_ADD1,            --11   DELIVERY_ADD1
DELIVERY_ADD2,            --12   DELIVERY_ADD2
DELIVERY_ADD3,            --13   DELIVERY_ADD3
DELIVERY_ADD4,            --14   DELIVERY_ADD4
DELIVERY_DATE,            --15   DELIVERY_DATE
DELIVERY_MODE,            --16   DELIVERY_MODE
DELIVERY_REF_NO,          --17   DELIVERY_REF_NO
EXTERNAL_REF_NO,          --18   EXTERNAL_REF_NO
FIRST_CHECK_NO,           --19   FIRST_CHECK_NO
INCL_FOR_CHKBOOK_PRINTING,--20   INCL_FOR_CHKBOOK_PRINTING
ISSUE_DATE,               --21   ISSUE_DATE
ISSUING_BRANCH,           --22   ISSUING_BRANCH
LANGUAGE_CODE,            --23   LANGUAGE_CODE
MAKER_DT_STAMP,           --24   MAKER_DT_STAMP
MAKER_ID,                 --25   MAKER_ID
MOD_NO,                   --26   MOD_NO
ONCE_AUTH,                --27   ONCE_AUTH
ORDER_DATE,               --28   ORDER_DATE
ORDER_DETAILS,            --29   ORDER_DETAILS
PRINT_STATUS,             --30   PRINT_STATUS
RECORD_STAT,              --31   RECORD_STAT
REQUEST_MODE,             --32   REQUEST_MODE
REQUEST_STATUS,           --33   REQUEST_STATUS
SEQ_NO,                   --34   SEQ_NO
TRN_REF_NO)               --35   TRN_REF_NO

select 
--decode(trim(a.account_no),(select trim(b.alt_ac_no) from sttm_cust_account b where trim(b.alt_ac_no) = trim(a.account_no)),(select trim(c.cust_ac_no) from sttm_cust_account c where trim(c.alt_ac_no) = trim(a.account_no)), null) cust_ac_no, --b.cust_ac_no                                       ,--1               ACCOUNT
--decode(trim(a.account_no),(select trim(d.alt_ac_no) from sttm_cust_account d where trim(d.alt_ac_no) = trim(a.account_no)),(select trim(e.branch_code) from sttm_cust_account e where trim(e.alt_ac_no) = trim(a.account_no)), null) branch_code, --,--20b             ISSUING_BRANCH               ,--20b     
trim(b.cust_ac_no) account,--a.account_no  ACCOUNT,trim(a.account_no)  ACCOUNT,         --1   ACCOUNT
'N'  APPLY_CHARGE,                   --2   APPLY_CHARGE
'A'  AUTH_STAT,                     --3   AUTH_STAT
trim(b.branch_code)  BRANCH,--trim(a.BRANCH_code)  BRANCH,         --4   BRANCH
to_date('31/01/2022','dd/mm/rrrr')  CHECKER_DT_STAMP,         --5   CHECKER_DT_STAMP
'MIG_USER01'  CHECKER_ID,         --6   CHECKER_ID
trim(a.CHECK_LEAVES)  CHECK_LEAVES,         --7   CHECK_LEAVES
null  CHEQUE_BOOK_TYPE,         --8   CHEQUE_BOOK_TYPE
null  CHQBOOK_DELIVERD,         --9   CHQBOOK_DELIVERD
'COMM'  CHQ_TYPE,         --10   CHQ_TYPE
null  DELIVERY_ADD1,         --11   DELIVERY_ADD1
null  DELIVERY_ADD2,         --12   DELIVERY_ADD2
null  DELIVERY_ADD3,         --13   DELIVERY_ADD3
null  DELIVERY_ADD4,         --14   DELIVERY_ADD4
null  DELIVERY_DATE,         --15   DELIVERY_DATE
'B'   DELIVERY_MODE,         --16   DELIVERY_MODE
null  DELIVERY_REF_NO,         --17   DELIVERY_REF_NO
trim(a.EXTERNAL_REF_NO)  EXTERNAL_REF_NO,         --18   EXTERNAL_REF_NO
lpad(trim(a.FIRST_CHECK_NO),6,0)  FIRST_CHECK_NO,         --19   FIRST_CHECK_NO
'N'  INCL_FOR_CHKBOOK_PRINTING,         --20   INCL_FOR_CHKBOOK_PRINTING
to_date(trim(A.ISSUE_DATE),'rrrr/mm/dd') ISSUE_DATE,--trim(a.ISSUE_DATE)  ISSUE_DATE,         --21   ISSUE_DATE
trim(a.branch_code) ISSUING_BRANCH,--trim(a.BRANCH_code)  ISSUING_BRANCH,         --22   ISSUING_BRANCH
trim(a.LANGUAGE_CODE)  LANGUAGE_CODE,         --23   LANGUAGE_CODE
to_date('31/01/2022','dd/mm/rrrr')  MAKER_DT_STAMP,         --24   MAKER_DT_STAMP
'MIG_USER01'  MAKER_ID,         --25   MAKER_ID
1  MOD_NO,                                           --26   MOD_NO
'Y'  ONCE_AUTH,                                      --27   ONCE_AUTH
to_date(trim(A.ORDER_DATE),'rrrr/mm/dd') ORDER_DATE, --trim(a.ORDER_DATE)     ORDER_DATE,                      --28   ORDER_DATE
trim(a.ORDER_DETAILS)  ORDER_DETAILS,                --29   ORDER_DETAILS
null  PRINT_STATUS,                                  --30   PRINT_STATUS
'O'  RECORD_STAT,                                    --31   RECORD_STAT
trim(a.REQUEST_MODE)  REQUEST_MODE,                  --32   REQUEST_MODE
'Delivered' REQUEST_STATUS,--trim(a.REQUEST_STATUS)  REQUEST_STATUS,              --33   REQUEST_STATUS
casq_check_book.nextval  SEQ_NO,                                        --34   SEQ_NO
null  TRN_REF_NO                                     --35   TRN_REF_NO
from  catm_upload_check_book@to_dtn a,
sttm_cust_account b
where trim(b.alt_ac_no) = trim(a.account_no);



--/*

insert into CATM_CHECK_DETAILS (
ACCOUNT,         --1   ACCOUNT
AMOUNT,         --2   AMOUNT
AUTH_STAT,         --3   AUTH_STAT
BENEFICIARY,         --4   BENEFICIARY
BRANCH,         --5   BRANCH
CHECKER_DT_STAMP,         --6   CHECKER_DT_STAMP
CHECKER_ID,         --7   CHECKER_ID
CHECK_BOOK_NO,         --8   CHECK_BOOK_NO
CHECK_DIGIT,         --9   CHECK_DIGIT
CHECK_NO,         --10   CHECK_NO
CLAIM_AMOUNT,         --11   CLAIM_AMOUNT
MAKER_DT_STAMP,         --12   MAKER_DT_STAMP
MAKER_ID,         --13   MAKER_ID
MOD_NO,         --14   MOD_NO
ONCE_AUTH,         --15   ONCE_AUTH
PRESENTATION_DATE,         --16   PRESENTATION_DATE
RECORD_STAT,         --17   RECORD_STAT
REJECT_CODE,         --18   REJECT_CODE
REMARKS,         --19   REMARKS
STATUS,         --20   STATUS
UPDATE_MODE,         --21   UPDATE_MODE
VALUE_DATE)         --22   VALUE_DATE



select 
--decode(trim(a.account_no),(select trim(b.alt_ac_no) from sttm_cust_account b where trim(b.alt_ac_no) = trim(a.account_no)),(select trim(c.cust_ac_no) from sttm_cust_account c where trim(c.alt_ac_no) = trim(a.account_no)), null) cust_ac_no, --b.cust_ac_no                                       ,--1               ACCOUNT
--decode(trim(a.account_no),(select trim(d.alt_ac_no) from sttm_cust_account d where trim(d.alt_ac_no) = trim(a.account_no)),(select trim(e.branch_code) from sttm_cust_account e where trim(e.alt_ac_no) = trim(a.account_no)), null) branch_code,
trim(b.cust_ac_no) account,--a.account_no  ACCOUNT,ACCOUNT_no  ACCOUNT,                       --1   ACCOUNT
trim(a.AMOUNT)  AMOUNT,                      --2   AMOUNT
'A'  AUTH_STAT,                            --3   AUTH_STAT
trim(a.BENEFICIARY)  BENEFICIARY,            --4   BENEFICIARY
trim(a.branch_code)  BRANCH,                             --5   BRANCH
to_date('31/01/2022','dd/mm/rrrr')  CHECKER_DT_STAMP,         --6   CHECKER_DT_STAMP
'MIG_USER01'  CHECKER_ID,         --7   CHECKER_ID
lpad(trim(a.CHECK_BOOK_NO),6,0)  CHECK_BOOK_NO,         --8   CHECK_BOOK_NO
0  CHECK_DIGIT,         --9   CHECK_DIGIT
lpad(trim(a.CHECK_NO),6,0)  CHECK_NO,         --10   CHECK_NO  --lpad(i.check_book_no,10,'0')
null  CLAIM_AMOUNT,         --11   CLAIM_AMOUNT
to_date('31/01/2022','dd/mm/rrrr')  MAKER_DT_STAMP,         --12   MAKER_DT_STAMP
'MIG_USER01'  MAKER_ID,         --13   MAKER_ID
trim(a.MOD_NO)  MOD_NO,         --14   MOD_NO
'Y'  ONCE_AUTH,         --15   ONCE_AUTH
trim(a.PRESENTATION_DATE)  PRESENTATION_DATE,         --16   PRESENTATION_DATE
'O'  RECORD_STAT,         --17   RECORD_STAT
null  REJECT_CODE,         --18   REJECT_CODE
trim(a.REMARKS)  REMARKS,         --19   REMARKS
trim(a.STATUS) STATUS,--case when amount > 0 then 'U' else 'N' end STATUS,--trim(STATUS)  STATUS,         --20   STATUS
null  UPDATE_MODE,         --21   UPDATE_MODE
trim(a.VALUE_DATE)  VALUE_DATE          --22   VALUE_DATE
from  CATM_UPLOAD_CHECK_DETAILS@to_dtn a,
sttm_cust_account b
where trim(b.alt_ac_no) = trim(a.account_no);




insert into fbtb_check_details
( 
BRANCH,                          ----1 BRANCH                  
ACCOUNT,                         ----2 ACCOUNT
CHECK_BOOK_NO,                   ----3 CHECK_BOOK_NO
CHECK_NO,                        ----4 CHECK_NO
STATUS,                          ----5 STATUS
STOP_PMT_EFFECTIVEDATE,          ----6 STOP_PMT_EFFECTIVEDATE
STOP_PMT_EXPIRYDATE              ----7 STOP_PMT_EXPIRYDATE
)

select 
trim(a.BRANCH_CODE)  BRANCH,                  ----1 BRANCH                   
trim(b.cust_ac_no) account,                   ----2 ACCOUNT
lpad(trim(a.CHECK_BOOK_NO),6,0)  CHECK_BOOK_NO,    ----3 CHECK_BOOK_NO
lpad(trim(a.CHECK_NO),6,0)  CHECK_NO,        ----4 CHECK_NO
trim(STATUS) STATUS,-                     ----5 STATUS
null,                           ----6 STOP_PMT_EFFECTIVEDATE
null                            ----7 STOP_PMT_EXPIRYDATE
from  catm_upload_check_details@to_dtn a,
sttm_cust_account b
where trim(b.alt_ac_no) = trim(a.account_no);



insert into CATM_STOP_PAYMENTS (
ACCOUNT,         --1   ACCOUNT
ADVICE_REQUIRED_IND,         --2   ADVICE_REQUIRED_IND
AMOUNT,         --3   AMOUNT
APPLY_CHARGE,         --4   APPLY_CHARGE
AUTH_STAT,         --5   AUTH_STAT
BRANCH,         --6   BRANCH
CHECKER_DT_STAMP,         --7   CHECKER_DT_STAMP
CHECKER_ID,         --8   CHECKER_ID
CONFIRMED,         --9   CONFIRMED
DOC_ID,         --10   DOC_ID
EFFECTIVE_DATE,         --11   EFFECTIVE_DATE
END_CHECK_NO,         --12   END_CHECK_NO
EXPIRY_DATE,         --13   EXPIRY_DATE
MAKER_DT_STAMP,         --14   MAKER_DT_STAMP
MAKER_ID,         --15   MAKER_ID
MOD_NO,         --16   MOD_NO
ONCE_AUTH,         --17   ONCE_AUTH
RECORD_STAT,         --18   RECORD_STAT
REMARKS,         --19   REMARKS
SCODE,         --20   SCODE
START_CHECK_NO,         --21   START_CHECK_NO
STOP_PAYMENT_NO,         --22   STOP_PAYMENT_NO
STOP_PAYMENT_TYPE,         --23   STOP_PAYMENT_TYPE
TRN_REF_NO,         --24   TRN_REF_NO
XREF)         --25   XREF



 
select 
trim(ab.cust_ac_no)  ACCOUNT                    ,--1  ACCOUNT,         --1   ACCOUNT
null  advice_required_ind,         --2   ADVICE_REQUIRED_IND
trim(ab.amount)  amount,         --3   AMOUNT
trim(ab.apply_charge)  apply_charge,         --4   APPLY_CHARGE
trim(ab.auth_stat)  auth_stat,         --5   AUTH_STAT
trim(ab.branch_code)  branch,         --6   BRANCH
to_date('31/01/2022','dd/mm/rrrr')  checker_dt_stamp,         --7   CHECKER_DT_STAMP
'MIG_USER02'  checker_id,         --8   CHECKER_ID
trim(ab.confirmed)  confirmed,         --9   CONFIRMED
null  doc_id,         --10   DOC_ID
to_date(trim(to_date(substr(ab.effective_date,1,9), 'dd/mm/rrrr')),'dd/mm/rrrr') effective_date,         --11   EFFECTIVE_DATE  --to_date(trim(ab.effective_date),'rrrr/mm/dd')
lpad(trim(ab.end_check_no),6,0)  end_check_no,         --12   END_CHECK_NO
to_date(trim(to_date(substr(ab.expiry_date,1,9), 'dd/mm/rrrr')),'dd/mm/rrrr') expiry_date,         --13   EXPIRY_DATE
to_date('31/01/2022','dd/mm/rrrr')  maker_dt_stamp,         --14   MAKER_DT_STAMP
'MIG_USER01'  maker_id,         --15   MAKER_ID
trim(ab.mod_no)  mod_no,         --16   MOD_NO
trim(ab.once_auth)  once_auth,         --17   ONCE_AUTH
trim(ab.record_stat)  record_stat,         --18   RECORD_STAT
'no remarks'  remarks,         --19   REMARKS
null  scode,         --20   SCODE
lpad(trim(ab.start_check_no),6,0)  start_check_no,         --21   START_CHECK_NO
'SP'||CASQ_STOP_PAYMENT.NEXTVAL stop_payment_no ,--trim(ab.stop_payment_no)  stop_payment_no,         --22   STOP_PAYMENT_NO
decode(trim(ab.stop_payment_type),'L','C',trim(ab.stop_payment_type))  stop_payment_type,         --23   STOP_PAYMENT_TYPE
trim(ab.trn_ref_no)  trn_ref_no,         --24   TRN_REF_NO
trim(ab.xref)  xref
from
(select b.cust_ac_no, a.* from catm_upload_stop_payments@to_dtn a, sttm_cust_account b where trim(b.alt_ac_no) = trim(a.account_no)) ab;