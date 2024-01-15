-- CATM_UPLOAD_CHECK_BOOK  scripts lire ces tables dans amplitude bkdch / bkoppch

DROP SEQUENCE FF_SEQ_CHEQUE_FLEX;
CREATE SEQUENCE  "FF_SEQ_CHEQUE_FLEX"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 42000001 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;

TRUNCATE TABLE CATM_UPLOAD_CHECK_BOOK;

INSERT INTO CATM_UPLOAD_CHECK_BOOK
Select 

'AMPL_CHQ_UPD' SOURCE_CODE,
FF_BRANCH_CODE(acc.age) BRANCH_CODE,
acc.age||acc.ncp||com.clc ACCOUNT_NO,
 LPAD( FF_FIRST_CHECK_NO(acc.age,acc.ncp,acc.eve),6,'0') FIRST_CHECK_NO,
  FF_CHECK_LEAVES(acc.age,acc.ncp,acc.eve) CHECK_LEAVES,
acc.dad ORDER_DATE,
acc.dad ISSUE_DATE,
NULL ORDER_DETAILS,
'U' UPLOAD_STATUS_FLAG,
NULL ERRMSG,
acc.EVE  EXTERNAL_REF_NO,
'C' BOOK_TYPE,-- COMM/EURO (Default to COMM)
--FF_LANGUE_CLI_TIERS_ISO2(NVL((select max(lang) from bkacp where age=acc.age and ncp=acc.ncp),'ENG'),'C') LANGUAGE_CODE,
'ENG' LANGUAGE_CODE,
'REQUEST_MODE' REQUEST_MODE,
(case when acc.sit='D' then 'Requested' else case when acc.sit='P' then 'Generated' 
  else case when acc.sit='R' then 'Delivered' else case when acc.sit='S' then 'Destroyed' 
  else 'Requested' end end end end ) REQUEST_STATUS, --Requested,Generated,Delivered,Destroyed
acc.eve TRN_REF_NO,
'' DELIVERY_REF_NO,
(case when acc.mex='B' then 'B' else case when acc.mex in ('R','C') then 'C' else '0' end end) DELIVERY_MODE, ---B branch, C courriel , Null
nvl(acc.DAR,'') DELIVERY_DATE,
'' CHQBOOK_DELIVERD,
'' CHEQUE_BOOK_TYPE, -- COMM/EURO (Default to COMM)
(case when acc.AGCHQ not like '  %' then 'BRANCH '||FF_BRANCH_CODE(acc.age) 
  else case when acc.TADCH='D' and acc.CODADCH='D' then 'AT HOME' else NULL end end)  DELIVER_ADD1,
'' DELIVER_ADD2,
'' DELIVER_ADD3,
'' DELIVER_ADD4,
'NEW' ACTION_CODE,
'N' PRINT_STATUS,
'N' INCL_FOR_CHKBOOK_PRINTING,
FF_SEQ_CHEQUE_FLEX.nextval SOURCE_SEQ_NO,
'N' APPLY_CHARGE
From bkdch acc , bkcom com where com.ncp=acc.ncp and com.age=acc.age
and acc.sit='R' ;   --- keep only the delivrance check 18112021

commit;

--------

TRUNCATE table CATM_UPLOAD_CHECK_DETAILS ;
Insert into CATM_UPLOAD_CHECK_DETAILS
select 
'AMPL_CHQ_UPD' SOURCE_CODE,
FF_BRANCH_CODE(acc.age) BRANCH_CODE,
acc.age||acc.ncp||FF_COM_CLC(acc.age,acc.ncp)  ACCOUNT_NO,
FF_FIRST_CHECK_NO(acc.age,acc.ncp,acc.eve) CHECK_BOOK_NO,
acc.nche CHECK_NO,
1 MOD_NO,
(case when acc.sit in ('P','R','C','B','K') then 'N' 
 else case when acc.sit='O' then 'S' 
 else case when acc.sit='I' then 'R' 
 else case when acc.sit='S' then 'U'
 else null end 
 end end end) STATUS,
acc.mon AMOUNT,
'' BENEFICIARY,
NULL PRESENTATION_DATE,
NULL VALUE_DATE,
'' REMARKS,
'U' UPLOAD_STATUS_FLAG,
NULL ERRMSG
From bkchq acc--, bkcom com where com.ncp=acc.ncp and com.age=acc.age and 
where acc.sit = 'R' -- not in ('S','P') :dsam 20220526
and serie is not null-- and ncp='27220000001'
order by CHECK_BOOK_NO, CHECK_NO;
COMMIT;