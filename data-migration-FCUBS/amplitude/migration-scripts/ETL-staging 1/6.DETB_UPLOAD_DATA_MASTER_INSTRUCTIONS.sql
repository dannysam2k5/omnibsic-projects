--Inserting in the master table DETB_UPLOAD_MASTER
alter session set nls_date_format = 'dd/mm/yyyy';

--Select 
define DATE_PARAM='31/07/2022';

TRUNCATE TABLE DETB_UPLOAD_MASTER;

INSERT INTO DETB_UPLOAD_MASTER
Select 
FF_BRANCH_CODE(acc.age) BRANCH_CODE		,	--bank mapping
'AMPL_ACC_DE ' SOURCE_CODE		,	--AMP_DE
FF_BRANCH_CODE(acc.age)||'A' BATCH_NO		,	--BRANCH_CODE||A
sum((case when acc.sde <>0 then 1 else 0 end )) TOTAL_ENTRIES		,	
NULL UPLOADED_ENTRIES		,	--NULL
'Y' BALANCING		,	--defaut=Y
'Migration of customer account balance' BATCH_DESC		,	--Migration of customer account balance'
NULL MIS_REQUIRED		,--	NULL
'Y' AUTO_AUTH		,	--Y
'N' GL_OFFSET_ENTRY_REQD		,	--N
'N' UDF_UPLOAD_REQD		,	--N
NULL OFFSET_GL		,	--NULL
'MIA' TXN_CODE		,	--MIA
sum(case when acc.sde <0 then 1 else 0 end) DR_ENT_TOTAL		,--	
sum(case when acc.sde >0 then 1 else 0 end ) CR_ENT_TOTAL		,--	
'MIG_USER1' USER_ID		,	--user migration USER_MIG1
'U' UPLOAD_STAT		,--	U
1 JOBNO		,	--1
'N' SYSTEM_BATCH		,	--N
NULL POSITION_REQD		,	--NULL
'MIG_USER1' MAKER_ID		,	--MIG_USER1
sysdate MAKER_DT_STAMP		,--	Date migration
'MIG_USER2' CHECKER_ID		,	--MIG_USER2
sysdate CHECKER_DT_STAMP		,--	Date migration
NULL MOD_NO		,	--NULL
'A' AUTH_STAT		,--	A
'O' RECORD_STAT		,	--O
'Y' ONCE_AUTH		,	--Y
NULL UPLOAD_DATE		,	--NULL
NULL UPLOAD_FILE_NAME		--*NULL
FROM BKSLD acc , BKCOM COM where acc.dco='&DATE_PARAM' and com.age=acc.age and com.ncp=acc.ncp and com.dev=acc.dev and com.cfe <> 'O' and
 --CUSTOMER_TYPE(com.cli) in ('C','B') 
 (com.cha like '251%' or com.cha like '253%' or com.cha like '15_%')
and FF_ACCOUNT_CLASS(acc.age, acc.ncp,com.cli,com.cpro) is not null
group by acc.age --,dev
having sum(case when acc.sde >0 then 1 else 0 end )> 0 or 
sum(case when acc.sde <0 then 1 else 0 end)>0 
order by acc.age--,dev
;

commit;

DROP SEQUENCE FF_SEQ_DE_OB_BRN_702;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_702  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;

DROP SEQUENCE FF_SEQ_DE_OB_BRN_801;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_801  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;


DROP SEQUENCE FF_SEQ_DE_OB_BRN_301;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_301  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;

DROP SEQUENCE FF_SEQ_DE_OB_BRN_403;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_403  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;


DROP SEQUENCE FF_SEQ_DE_OB_BRN_601;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_601  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;


DROP SEQUENCE FF_SEQ_DE_OB_BRN_602;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_602  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;


DROP SEQUENCE FF_SEQ_DE_OB_BRN_000;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_000  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;

DROP SEQUENCE FF_SEQ_DE_OB_BRN_112;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_112  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;


DROP SEQUENCE FF_SEQ_DE_OB_BRN_115;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_115  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;


DROP SEQUENCE FF_SEQ_DE_OB_BRN_118;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_118  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;


DROP SEQUENCE FF_SEQ_DE_OB_BRN_120;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_120  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;


DROP SEQUENCE FF_SEQ_DE_OB_BRN_121;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_121  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;


DROP SEQUENCE FF_SEQ_DE_OB_BRN_122;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_122  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;

DROP SEQUENCE FF_SEQ_DE_OB_BRN_123;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_123  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;


DROP SEQUENCE FF_SEQ_DE_OB_BRN_124;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_124  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;


DROP SEQUENCE FF_SEQ_DE_OB_BRN_125;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_125  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;


DROP SEQUENCE FF_SEQ_DE_OB_BRN_126;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_126  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;


DROP SEQUENCE FF_SEQ_DE_OB_BRN_127;
CREATE SEQUENCE  FF_SEQ_DE_OB_BRN_127  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;


DROP SEQUENCE FF_SEQ_DE_OPENING_BALANCE_FLEX;
CREATE SEQUENCE  "FF_SEQ_DE_OPENING_BALANCE_FLEX"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 102000001 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;

--Inserting in the master table DETB_UPLOAD_DETAIL

TRUNCATE TABLE DETB_UPLOAD_DETAIL;
INSERT INTO DETB_UPLOAD_DETAIL
(
INSTRUMENT_NO		,
FIN_CYCLE		,
PERIOD_CODE		,
MIS_CODE		,
REL_CUST		,
ADDL_TEXT		,
MIS_GROUP		,
DW_AC_NO		,
ACCOUNT_NEW		,
TXN_MIS_1		,
TXN_MIS_2		,
TXN_MIS_3		,
TXN_MIS_4		,
TXN_MIS_5		,
TXN_MIS_6		,
TXN_MIS_7		,
TXN_MIS_8		,
TXN_MIS_9		,
TXN_MIS_10		,
COMP_MIS_1		,
COMP_MIS_2		,
COMP_MIS_3		,
COMP_MIS_4		,
COMP_MIS_5		,
COMP_MIS_6		,
COMP_MIS_7		,
COMP_MIS_8		,
COMP_MIS_9		,
COMP_MIS_10		,
COST_CODE1		,
COST_CODE2		,
COST_CODE3		,
COST_CODE4		,
COST_CODE5		,
MIS_HEAD		,
RELATED_ACCOUNT		,
RELATED_REF		,
POOL_CODE		,
REF_RATE		,
CALC_METHOD		,
BATCH_NO		,
MIS_FLAG		,
MIS_GROUP_TXN		,
BRANCH_CODE		,
SOURCE_CODE		,
CURR_NO   ,
UPLOAD_STAT		,
CCY_CD		,
INITIATION_DATE		,
AMOUNT		,
ACCOUNT		,
ACCOUNT_BRANCH		,
TXN_CODE		,
DR_CR		,
LCY_EQUIVALENT		,
EXCH_RATE		,
VALUE_DATE		,
EXTERNAL_REF_NO		,
RESERVED_FUNDS_REF		,
DELETE_STAT		,
UPLOAD_DATE		,
TXT_FILE_NAME		)
Select 
NULL INSTRUMENT_NO		,	--Indicates the Instrument Number --- default=NULL
'FY2021' FIN_CYCLE		,	--Financial Cycle that period code belongs to.
'M10' PERIOD_CODE		,	--Indicates the Period code for the Branch 
'' MIS_CODE		,	--Indicates the MIS code 
acc.cli REL_CUST		,	--Indicates the Related Customer --Old customer in Legacy
'Migrate customer account balance' ADDL_TEXT		,	--Specifies additional description --default='Migrate customer account balance'
'' MIS_GROUP		,	--Indicates the MIS Group 
NULL DW_AC_NO		,	--Specifies the Drawer accont number 
NULL ACCOUNT_NEW		,	--specifies the new account 
NULL TXN_MIS_1		,	--Indicates the Transaction MIS Code 1 
NULL TXN_MIS_2		,	--Indicates the Transaction MIS Code 2 
NULL TXN_MIS_3		,	--Indicates the Transaction MIS Code 3 
NULL TXN_MIS_4		,	--Indicates the Transaction MIS Code 4 
NULL TXN_MIS_5		,	--Indicates the Transaction MIS Code 5 
NULL TXN_MIS_6		,	--Indicates the Transaction MIS Code 6
NULL TXN_MIS_7		,	--Indicates the Transaction MIS Code 7 
NULL TXN_MIS_8		,	--Indicates the Transaction MIS Code 8 
NULL TXN_MIS_9		,	--Indicates the Transaction MIS Code 9 
NULL TXN_MIS_10		,	--Indicates the Transaction MIS Code 10 
NULL COMP_MIS_1		,	--Indicates the Composite MIS Code 1 
NULL COMP_MIS_2		,	--Indicates the Composite MIS Code 2 
NULL COMP_MIS_3		,	--Indicates the Composite MIS Code 3 
NULL COMP_MIS_4		,	--Indicates the Composite MIS Code 4 
NULL COMP_MIS_5		,	--Indicates the Composite MIS Code 5 
NULL COMP_MIS_6		,	--Indicates the Composite MIS Code 6 
NULL COMP_MIS_7		,	--Indicates the Composite MIS Code 7 
NULL COMP_MIS_8		,	--Indicates the Composite MIS Code 8 
NULL COMP_MIS_9		,	--Indicates the Composite MIS Code 9 
NULL COMP_MIS_10		,	--Indicates the Composite MIS Code 10 
NULL COST_CODE1		,	--Indicates the Cost Code 1
NULL COST_CODE2		,	--Indicates the Cost Code 2 
NULL COST_CODE3		,	--Indicates the Cost Code 3 
NULL COST_CODE4		,	--Indicates the Cost Code 4 
NULL COST_CODE5		,	--Indicates the Cost Code 5 
NULL MIS_HEAD		,	--Indicates the MIS head 
acc.age||acc.ncp||com.clc RELATED_ACCOUNT		,	--Indicates the Related account number 
NULL RELATED_REF		,	--Indicates the Related reference number 
NULL POOL_CODE		,	--Indicates the Pool Code 
NULL REF_RATE		,	--Indicates the Reference Rate 
NULL CALC_METHOD		,	--Indicates the Calculation Method 
FF_BRANCH_CODE(acc.age)||'a' BATCH_NO		,	--Indicates the Batch No 
NULL MIS_FLAG		,	--Indicates the MIS flag, Y/N 
NULL MIS_GROUP_TXN		,--	Indicates the MIS group transaction code 
FF_BRANCH_CODE(acc.age) BRANCH_CODE		,	--Indicates the Branch code 
'AMPL_ACC_DE' SOURCE_CODE 		,--	Indicates the Source Code 
FF_CUR_VAL_BRANCH(FF_BRANCH_CODE(acc.age)) CURR_NO		,	--Current Number in accounting entry 
'U' UPLOAD_STAT		,--	This indicates the status of the uploaded entry. E  Error S - Posted to Suspense U - Un Processed Y - Uploaded Successfully
rtrim(ltrim(FF_DEVISE_ISO3LETTRE(acc.dev))) CCY_CD		,	--This field indicates the currency of the gl codeac 
acc.dco INITIATION_DATE		,--	Indicates the Initiation date 
abs(round(acc.sde,2)) AMOUNT		,	--Indicates the Provision Amount 
acc.age||acc.ncp||com.clc ACCOUNT		,	--Indicates the Account 
FF_BRANCH_CODE(acc.age) ACCOUNT_BRANCH		,--	Indicates the Account Branch 
'' TXN_CODE		,--	Indicates the Transaction code 
(case when acc.sde <0 then 'D' else 'C' end ) DR_CR		,	--Indicates the Debit/Credit 
abs(round(acc.sdecv,2)) LCY_EQUIVALENT		,--	Indicates the Local currency equivalent 
acc.txind EXCH_RATE		, --FF_EXCH_RATE(acc.dev,acc.dco) EXCH_RATE		,	--Indicates the Currency Exchange Rate 
acc.dco VALUE_DATE		,	--Indicates the Value Date 
NULL EXTERNAL_REF_NO		,	--Indicates the External reference number 
NULL RESERVED_FUNDS_REF		,	--Indicates the Reference number 
NULL DELETE_STAT		,	--Indicates the Delete Status , D - Deleted,Blank Space - Not deleted 
sysdate UPLOAD_DATE		,	--Indicates the Upload date 
'' TXT_FILE_NAME			--Indicates the Transaction File Name 
FROM BKSLD acc, BKCOM COM where com.age=acc.age and com.ncp=acc.ncp and acc.dco='&DATE_PARAM' and acc.sde <>0 and 1=1 and  com.cfe <> 'O'  --and age='00101';
and
 (com.cha like '251%' or com.cha like '253%' or com.cha like '15_%')
and FF_ACCOUNT_CLASS(acc.age, acc.ncp,com.cli,com.cpro) is not null
order by acc.age;
commit;

