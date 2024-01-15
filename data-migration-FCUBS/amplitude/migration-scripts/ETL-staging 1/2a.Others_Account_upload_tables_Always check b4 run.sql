


---Mstm_Cust_Acc_Address
Truncate table Mstm_Cust_Acc_Address ;

Insert into Mstm_Cust_Acc_Address 
Select --acc.age,acc.ncp,acc.dev,ca.ALT_AC_NO,ca.branch_code,
ca.ALT_AC_NO CUST_AC_NO,
FF_LOCATION_CODE((select regn from bkcli where cli=acc.cli)) LOCATION,
'MAIL' MEDIA,
FF_GE_ADDRESS_COMPTE_LINE1(acc.age,acc.ncp,acc.dev,acc.cli) ADDRESS1,
FF_GE_ADDRESS_COMPTE_LINE2(acc.age,acc.ncp,acc.dev,acc.cli) ADDRESS2,
FF_GE_ADDRESS_COMPTE_LINE3(acc.age,acc.ncp,acc.dev,acc.cli) ADDRESS3,
'1' ADDRESS4,
FF_LANGUE_CLI_TIERS_ISO2(NVL((select max(lang) from bkacp where age=acc.age and ncp=acc.ncp and dev=acc.dev),(select lang from bkcli where cli=acc.cli)),'C') LANGUAGE,
'1' TEST_KEYWORD,
FF_NAT_CLI_TIERS_ISO2(NVL((select max(cpay) from bkacp where age=acc.age and ncp=acc.ncp and dev=acc.dev),(select payn from bkcli where cli=acc.cli))) COUNTRY,
acc.inti NAME,
'' ANSWERBACK,
'' TEST_REQUIRED,
sysdate CHECKER_DT_STAMP,
1 MOD_NO,
'O' RECORD_STAT,
'A' AUTH_STAT,
'Y' ONCE_AUTH,
sysdate MAKER_DT_STAMP,
'MIG_USER1' MAKER_ID,
'MIG_USER2' CHECKER_ID,
'N' TOBE_EMAILED,
'' DELIVERY_BY,
'' HOLD_MAIL,
ca.BRANCH_CODE CUST_AC_BRN,
FF_GE_ADDRESS_COMPTE_LINE1(acc.age,acc.ncp,acc.dev,acc.cli) DEFAULT_ADDRESS
From bkcom acc, STTB_UPLOAD_CUST_ACCOUNT_TD ca
where acc.age||acc.ncp||acc.clc=ca.ALT_AC_NO; --and acc.ncp='02000027885'
---------

Insert into Mstm_Cust_Acc_Address 
Select --acc.age,acc.ncp,acc.dev,ca.ALT_AC_NO,ca.branch_code,
ca.ALT_AC_NO CUST_AC_NO,
FF_LOCATION_CODE((select regn from bkcli where cli=acc.cli)) LOCATION,
'MAIL' MEDIA,
FF_GE_ADDRESS_COMPTE_LINE1(acc.age,acc.ncp,acc.dev,acc.cli) ADDRESS1,
FF_GE_ADDRESS_COMPTE_LINE2(acc.age,acc.ncp,acc.dev,acc.cli) ADDRESS2,
FF_GE_ADDRESS_COMPTE_LINE3(acc.age,acc.ncp,acc.dev,acc.cli) ADDRESS3,
'1' ADDRESS4,
FF_LANGUE_CLI_TIERS_ISO2(NVL((select max(lang) from bkacp where age=acc.age and ncp=acc.ncp and dev=acc.dev),(select lang from bkcli where cli=acc.cli)),'C') LANGUAGE,
'1' TEST_KEYWORD,
FF_NAT_CLI_TIERS_ISO2(NVL((select max(cpay) from bkacp where age=acc.age and ncp=acc.ncp and dev=acc.dev),(select payn from bkcli where cli=acc.cli))) COUNTRY,
acc.inti NAME,
'' ANSWERBACK,
'' TEST_REQUIRED,
sysdate CHECKER_DT_STAMP,
1 MOD_NO,
'O' RECORD_STAT,
'A' AUTH_STAT,
'Y' ONCE_AUTH,
sysdate MAKER_DT_STAMP,
'MIG_USER1' MAKER_ID,
'MIG_USER2' CHECKER_ID,
'N' TOBE_EMAILED,
'' DELIVERY_BY,
'' HOLD_MAIL,
ca.BRANCH_CODE CUST_AC_BRN,
FF_GE_ADDRESS_COMPTE_LINE1(acc.age,acc.ncp,acc.dev,acc.cli) DEFAULT_ADDRESS
From bkcom acc, STTB_UPLOAD_CUST_ACCOUNT_CASA ca
where acc.age||acc.ncp||acc.clc=ca.ALT_AC_NO; --and acc.ncp='02000027885'

----Cstb_Relationship_Upload
Truncate table Cstb_Relationship_Upload ;
Insert into Cstb_Relationship_Upload
(REF_NO,CATEGORY,CUSTOMER_NO,RELATION,INHERIT,BRANCH,BRANCH_CODE,SOURCE_CODE,SOURCE_REF
)
Select distinct
--FF_SEQ_COMPTE_FLEX.nextval MAINTENANCE_SEQ_NO	,
'' REF_NO, --fasyl value
'A' CATEGORY, --fasyl
acc.cli CUSTOMER_NO, --
'PRIMARY' RELATION, --	
'N' INHERIT,--
FF_BRANCH_CODE(acc.age)   BRANCH,
--FF_SEQ_COMPTE_FLEX.nextval SOURCE_SEQ_NO
FF_BRANCH_CODE(acc.age) BRANCH_CODE,
'AMPL_ACCT_UPD' SOURCE_CODE,
'AMPL_ACCT_UPD' SOURCE_REF

From bkcom acc
where acc.cli is not null and acc.cli not like ' _%';	
commit;


--  Sttb_Upload_Linked_Entities linked entites
TRuncate TABLE STTB_UPLOAD_LINKED_ENTITIES;
--CREATE TABLE Sttb_Upload_Linked_Entities as
insert into Sttb_Upload_Linked_Entities
Select
FF_BRANCH_CODE(acc.age) BRANCH_CODE,
acc.age||acc.ncp||acc.clc CUST_AC_NO,
coj.cli JOINT_HOLDER_CODE,
coj.nom||' '||coj.pre JOINT_HOLDER_DESCRIPTION,
(case when coj.tco='C' then 'CUS' else 'AUS' end) JOINT_HOLDER,
ca.MAINTENANCE_SEQ_NO MAINTENANCE_SEQ_NO,
ca.SOURCE_SEQ_NO SOURCE_SEQ_NO,
ca.SOURCE_CODE,
sysdate START_DATE,
sysdate END_DATE

From bkcom acc, STTB_UPLOAD_CUST_ACCOUNT_Casa ca,bkcoj coj
where acc.age||acc.ncp||acc.clc=ca.ALT_AC_NO and coj.tco='C' --- update 05112021 Only Customer
and coj.clip=acc.cli and acc.cptcoj='O';
commit;




----- td en
insert into Sttb_Upload_Linked_Entities
Select
FF_BRANCH_CODE(acc.age) BRANCH_CODE,
acc.age||acc.ncp||acc.clc CUST_AC_NO,
coj.cli JOINT_HOLDER_CODE,
coj.nom||' '||coj.pre JOINT_HOLDER_DESCRIPTION,
(case when coj.tco='C' then 'CUS' else 'AUS' end) JOINT_HOLDER,
ca.MAINTENANCE_SEQ_NO MAINTENANCE_SEQ_NO,
ca.SOURCE_SEQ_NO SOURCE_SEQ_NO,
ca.SOURCE_CODE,
sysdate START_DATE,
sysdate END_DATE

From bkcom acc, STTB_UPLOAD_CUST_ACCOUNT_TD ca,bkcoj coj
where acc.age||acc.ncp||acc.clc=ca.ALT_AC_NO and coj.tco='C' --update 05112021
and coj.clip=acc.cli and acc.cptcoj='O';


-----Ictm_Upload_Acc
/*
Select 
ca.SOURCE_CODE SOURCE_CODE,
ca.BRANCH_CODE BRANCH
'IC' MODULE
ca.BRANCH_CODE BRN
acc.ncp ACC,
acc.ncp CALC_ACC,
acc.ncp BOOK_ACC,
'' HAS_IS,-- has an Interest Statement
''  INT_START_DATE,
'' LAST_IS_DATE,
FF_ACCOUNT_TYPE() ACC_TYPE,-- N :- Nostro  D :- Miscellaneous Debit  C :- Miscellaneous Credit  S :- Savings U :- Current Y :- Deposit L :- Loan Account
ca.BRANCH_CODE BOOK_BRN,
'U' CONV_STATUS,
NULL ERR_MSG,
ca.BRANCH_CODE CHARGE_BOOK_BRN,
acc.ncp CHARGE_BOOK_ACC,
'N' AUTO_ROLLOVER,
FF_CLOSE_ON_MATURITY(acc.age,acc.ncp,acc.dev) CLOSE_ON_MATURITY,--a caculer
'N' MOVE_INT_TO_UNCLAIMED,
'N' MOVE_PRIC_TO_UNCLAIMED,
FF_MATURITY_DATE(acc.age,acc.ncp,acc.dev) MATURITY_DATE,--- if define for 
acc.ncp PRINC_LIQ_AC,  -- a calculer
'P' ROLLOVER_TYPE, -- a confirmer 
'' ROLLOVER_AMT,
ca.BRANCH_CODE PRINC_LIQ_BRANCH, --if liquidation account
'' NEXT_MATURITY_DATE,
rtrim(ltrim(FF_DEVISE_ISO3LETTRE(acc.dev))) BOOK_CCY,
'' HAS_DRCR_ADV,---a definir 
'' RD_FLAG, --- valeurs de fasyl
'' RD_AUTO_PMNT_TAKEDOWN,
'' RD_MOVE_MAT_TO_UNCLAIMED,
'' RD_MOVE_FUNDS_ON_OVD,
'' RD_TAKEDOWN_DAYS,
'' RD_TAKEDOWN_MONTHS,
'' RD_TAKEDOWN_YEARS,
'' RD_PAYMENT_ACC,
'' RD_PAYMENT_BRN,
'' RD_PAYMENT_CCY,
'' RD_INSTALLMENT_AMT,
'' RD_PAY_SCHDT,
'' CHG_START_DATE,
ca.SOURCE_CODE SOURCE_CODE,
ca.MAINTENANCE_SEQ_NO MAINTENANCE_SEQ_NO
/*,

'' TENOR_CODE	,
'' AUTO_EXTENSION,
'' LIQUIDATION_AMT	,
'' LAST_ROLLOVER_DATE,	
'' ALLOW_PREPAYMENT	,
FF_INTEREST_RATE	 INTEREST_RATE,
FF_MATURITY_AMOUNT   MATURITY_AMOUNT,	
'N' INTRATE_CUMAMT_REQD	,
'' INTRATE_CUMAMT_ROLL_REQD,	
'' ROLL_TENOR_PREF,	--FASY VALUE
ORIG_TENOR_DAYS,	--- FASYL EXPIREXPLAIN
0 ORIG_TENOR_MONTHS	,-- 
0 ORIG_TENOR_YEARS	,
'' ROLL_TENOR_DAYS	,
'' ROLL_TENOR_MONTHS,	
'' ROLL_TENOR_YEARS,	
'' DEP_TENOR_PREF,	
'Y' CASCADE_MONTH,	
'' ADD_FUNDS	,
'' ADDITIONAL_AMT

ca.MAINTENANCE_SEQ_NO MAINTENANCE_SEQ_NO

From bkcom acc, STTB_UPLOAD_CUST_ACCOUNT_CASA ca
where acc.ncp=ca.ALT_AC_NO;
*/
---Mstm_Msg_Acc_Address
Select 
'' MSG_TYPE,
'' MODULE,
'' BRANCH,
'' LOCATION,
'MAIL' MEDIA,
1 NO_OF_COPIES,
'' FORMAT,
'' CUST_AC_NO,
FF_GE_ADDRESS_COMPTE_LINE1(acc.age,acc.ncp,acc.dev) PRIMARY_ADDRESS,
ca.SOURCE_SEQ_NO SOURCE_SEQ_NO,
ca.SOURCE_CODE SOURCE_CODE,
ca.MAINTENANCE_SEQ_NO MAINTENANCE_SEQ_NO

From bkcom acc, STTB_UPLOAD_CUST_ACCOUNT_CASA ca
where acc.ncp=ca.ALT_AC_NO;
commit;
/*
CREATE TABLE  ICTM_UPLOAD_ACC
(
SOURCE_CODE	VARCHAR2(12)	,
BRANCH	VARCHAR2(3)	,
MODULE	VARCHAR2(2)	,
BRN	VARCHAR2(3)	,
ACC	VARCHAR2(20)	,
CALC_ACC	VARCHAR2(20)	,
BOOK_ACC	VARCHAR2(20)	,
HAS_IS	CHAR(1)	,
INT_START_DATE	DATE	,
LAST_IS_DATE	DATE	,
ACC_TYPE	CHAR(1)	,
BOOK_BRN	VARCHAR2(3)	,
CONV_STATUS	CHAR(1)	,
ERR_MSG	VARCHAR2(255)	,
CHARGE_BOOK_BRN	VARCHAR2(3)	,
CHARGE_BOOK_ACC	VARCHAR2(20)	,
AUTO_ROLLOVER	VARCHAR2(1)	,
CLOSE_ON_MATURITY	VARCHAR2(1)	,
MOVE_INT_TO_UNCLAIMED	VARCHAR2(1)	,
MOVE_PRIC_TO_UNCLAIMED	VARCHAR2(1)	,
MATURITY_DATE	DATE	,
PRINC_LIQ_AC	VARCHAR2(20)	,
ROLLOVER_TYPE	VARCHAR2(1)	,
ROLLOVER_AMT	NUMBER	,
PRINC_LIQ_BRANCH	VARCHAR2(3)	,
NEXT_MATURITY_DATE	DATE	,
BOOK_CCY	VARCHAR2(3)	,
HAS_DRCR_ADV	VARCHAR2(1)	,
RD_FLAG	VARCHAR2(1)	,
RD_AUTO_PMNT_TAKEDOWN	VARCHAR2(1)	,
RD_MOVE_MAT_TO_UNCLAIMED	VARCHAR2(1)	,
RD_MOVE_FUNDS_ON_OVD	VARCHAR2(1)	,
RD_TAKEDOWN_DAYS	VARCHAR2(5)	,
RD_TAKEDOWN_MONTHS	VARCHAR2(5)	,
RD_TAKEDOWN_YEARS	VARCHAR2(5)	,
RD_PAYMENT_ACC	VARCHAR2(20)	,
RD_PAYMENT_BRN	VARCHAR2(3)	,
RD_PAYMENT_CCY	VARCHAR2(3)	,
RD_INSTALLMENT_AMT	NUMBER(22,3)	,
RD_PAY_SCHDT	DATE	,
CHG_START_DATE	DATE	,
SOURCE_SEQ_NO	NUMBER	,
MAINTENANCE_SEQ_NO	VARCHAR2(16),	
TENOR_CODE	VARCHAR2(16),
AUTO_EXTENSION VARCHAR2(16),
LIQUIDATION_AMT	NUMBER(19,4),
LAST_ROLLOVER_DATE DATE,	
ALLOW_PREPAYMENT VARCHAR2(16)	,
INTEREST_RATE number(19,4),
MATURITY_AMOUNT number(19,4),	
INTRATE_CUMAMT_REQD	VARCHAR2(10),
INTRATE_CUMAMT_ROLL_REQD VARCHAR2(10),	
ROLL_TENOR_PREF VARCHAR2(10),	--FASY VALUE
ORIG_TENOR_DAYS VARCHAR2(10),	--- FASYL EXPIREXPLAIN
ORIG_TENOR_MONTHS VARCHAR2(10)	,-- 
ORIG_TENOR_YEARS	VARCHAR2(10),
ROLL_TENOR_DAYS	VARCHAR2(10),
ROLL_TENOR_MONTHS VARCHAR2(10),	
ROLL_TENOR_YEARS VARCHAR2(10),	
DEP_TENOR_PREF VARCHAR2(10),	
CASCADE_MONTH VARCHAR2(10),	
ADD_FUNDS	VARCHAR2(10),
ADDITIONAL_AMT
);
*/

Truncate Table ICTM_UPLOAD_ACC;
Insert Into ICTM_UPLOAD_ACC
Select 
--ca.SOURCE_CODE
'AMPL_ACC_UPD' SOURCE_CODE,
ca.BRANCH_CODE BRANCH,
'TD' MODULE,
ca.BRANCH_CODE BRN,
com.age||acc.ncpd||com.clc ACC,
com.age||acc.ncpd||com.clc CALC_ACC,
com.age||acc.ncpd||com.clc BOOK_ACC,
'' HAS_IS,-- has an Interest Statement
''  INT_START_DATE,
'' LAST_IS_DATE,
'Y'  ACC_TYPE,--FF_ACCOUNT_TYPE() N :- Nostro  D :- Miscellaneous Debit  C :- Miscellaneous Credit  S :- Savings U :- Current Y :- Deposit L :- Loan Account
ca.BRANCH_CODE BOOK_BRN,
'U' CONV_STATUS,
NULL ERR_MSG,
ca.BRANCH_CODE CHARGE_BOOK_BRN,
com.age||acc.ncpd||com.clc CHARGE_BOOK_ACC,
'N' AUTO_ROLLOVER,
(case when acc.renouv='S' then 'Y' else 'N' end) CLOSE_ON_MATURITY,
--FF_CLOSE_ON_MATURITY(acc.age,acc.ncpd,acc.dev) CLOSE_ON_MATURITY,--a caculer
'N' MOVE_INT_TO_UNCLAIMED,
'N' MOVE_PRIC_TO_UNCLAIMED,
acc.dech MATURITY_DATE,--- if define for 
com.age||acc.ncpd||com.clc PRINC_LIQ_AC,  -- a calculer
'P' ROLLOVER_TYPE, -- a confirmer 
'' ROLLOVER_AMT,
ca.BRANCH_CODE PRINC_LIQ_BRANCH, --if liquidation account
'' NEXT_MATURITY_DATE,
rtrim(ltrim(FF_DEVISE_ISO3LETTRE(acc.dev))) BOOK_CCY,
'' HAS_DRCR_ADV,---a definir 
'' RD_FLAG, --- valeurs de fasyl
'' RD_AUTO_PMNT_TAKEDOWN,
'' RD_MOVE_MAT_TO_UNCLAIMED,
'' RD_MOVE_FUNDS_ON_OVD,
'' RD_TAKEDOWN_DAYS,
'' RD_TAKEDOWN_MONTHS,
'' RD_TAKEDOWN_YEARS,
'' RD_PAYMENT_ACC,
'' RD_PAYMENT_BRN,
'' RD_PAYMENT_CCY,
'' RD_INSTALLMENT_AMT,
'' RD_PAY_SCHDT,
'' CHG_START_DATE,
ca.MAINTENANCE_SEQ_NO SOURCE_SEQ_NO,
--ca.SOURCE_CODE SOURCE_CODE,
ca.MAINTENANCE_SEQ_NO MAINTENANCE_SEQ_NO,


'' TENOR_CODE	,
'' AUTO_EXTENSION,
'' LIQUIDATION_AMT	,
'' LAST_ROLLOVER_DATE,	
'' ALLOW_PREPAYMENT	,
acc.tau	 INTEREST_RATE,
''   MATURITY_AMOUNT,	
'N' INTRATE_CUMAMT_REQD	,
'' INTRATE_CUMAMT_ROLL_REQD,	
'' ROLL_TENOR_PREF,	--FASY VALUE
'' ORIG_TENOR_DAYS,	--- FASYL EXPIREXPLAIN
0 ORIG_TENOR_MONTHS	,-- 
0 ORIG_TENOR_YEARS	,
'' ROLL_TENOR_DAYS	,
'' ROLL_TENOR_MONTHS,	
'' ROLL_TENOR_YEARS,	
'' DEP_TENOR_PREF,	
'Y' CASCADE_MONTH,	
'' ADD_FUNDS	,
'' ADDITIONAL_AMT


From BKDAT acc, STTB_UPLOAD_CUST_ACCOUNT_td ca, BKCOM COM
where ca.ALT_AC_NO = acc.age||acc.ncpd||com.clc and com.ncp=acc.ncpd 
and acc.eta in ('VA','FO');


--
--select * from ICTM_UPLOAD_ACC