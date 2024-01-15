DROP SEQUENCE FF_SEQ_CHEQUE_FLEX;
CREATE SEQUENCE  "FF_SEQ_CHEQUE_FLEX"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 42000001 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;
Truncate table CATM_UPLOAD_STOP_PAYMENTS;
--FF_SEQ_CHEQUE_FLEX.nextval MAINTENANCE_SEQ_NO	
 --CREATE TABLE CATM_UPLOAD_STOP_PAYMENTS as
Insert into CATM_UPLOAD_STOP_PAYMENTS
Select req1.SOURCE_CODE,req1.branch_code, account_no,stop_payment_no,stop_payment_type, start_check_no,
req1.end_check_no, req1.amount,req1.effective_date,req1.expiry_date,req1.confirmed,req1.mod_no,
NVL((select lib1 from bknom where ctab='207' and cacc=req1.motif),'ERROR') remarks, req1.upload_status_flag,req1.errmsg,req1.xref,req1.AUTH_STAT,req1.ONCE_AUTH,req1.RECORD_STAT,
req1.maker_id,req1.maker_dt_stamp,req1.checker_id,req1.checker_dt_stamp,req1.Trn_ref_no, FF_SEQ_CHEQUE_FLEX.nextval maintenance_seq_no,
FF_SEQ_CHEQUE_FLEX.nextval source_seq_no,req1.action_code,req1.APPLY_CHARGE
FROM (Select 
'AMPL_CHSP_UPD'  SOURCE_CODE	,
FF_BRANCH_CODE(QO.age) branch_code,
QO.age||QO.ncp||COM.clc account_no,
1 stop_payment_no,
(case when QO.mon1=0 then 'C' else 'A' end) stop_payment_type, ---DEJI MODIF 18112021 replace 'L' with 'C'
nche start_check_no,
nche end_check_no,
QO.mon1 amount,  --- whenever 'C' for stop payement then mount is NULL ---DEJI MODIF 18112021
QO.datop effective_date,
NULL expiry_date,
'Y' confirmed,
1 mod_no,motif,
--(select lib1 from bknom where ctab='207' and cacc=max(QO.motif)) remarks, --- very mandatory to be populated
'U' upload_status_flag,
NULL errmsg,
QO.serie||QO.nche xref,
'A' AUTH_STAT,
'Y' ONCE_AUTH,
'O' RECORD_STAT,
'MIG_USER1' maker_id,
qo.datop maker_dt_stamp,
'MIG_USER2' checker_id,
qo.datop checker_dt_stamp,
'TEST' Trn_ref_no, --fasyl
-- FF_SEQ_CHEQUE_FLEX.nextval maintenance_seq_no,
-- FF_SEQ_CHEQUE_FLEX.nextval source_seq_no,
'NEW' action_code,
'N' APPLY_CHARGE

FROM BKCHQO QO, BKCOM COM where QO.age=COM.age and QO.ncp=COM.ncp and com.cfe <> 'O') REQ1;
--group by qo.age,QO.age||QO.ncp||COM.clc,qo.datop )REQ1 );
commit;

