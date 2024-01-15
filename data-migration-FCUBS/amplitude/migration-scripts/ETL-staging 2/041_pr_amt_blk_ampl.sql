--xxxx------------------------------------------------
create or replace procedure pr_amt_blk_ampl as
a number;
begin
a:=1;

--execute immediate 'drop SEQUENCE gl_seq';
--execute immediate 'CREATE SEQUENCE GL_SEQ   MINVALUE 1   MAXVALUE 999999999999999999999999999    START WITH 10001   INCREMENT BY 1    CACHE 20';




for i in (
select 
decode(a.account_no,(select b.alt_ac_no from sttm_cust_account b where trim(b.alt_ac_no) = trim(a.account_no)),(select c.cust_ac_no from sttm_cust_account c where trim(c.alt_ac_no) = trim(a.account_no)), null)  cust_ac_no,--b.cust_ac_no                 ,--1                 
trim(a.ACCOUNT_NO)  ACCOUNT_NO,         --1   ACCOUNT_NO
'NEW' ACTION_CODE,--trim(a.ACTION_CODE)  ACTION_CODE,         --2   ACTION_CODE
trim(a.AMOUNT)  AMOUNT,         --3   AMOUNT
'AB'||casq_amount_block.nextval amount_block_no ,--trim(a.AMOUNT_BLOCK_NO)  AMOUNT_BLOCK_NO,         --4   AMOUNT_BLOCK_NO
'F' AMOUNT_BLOCK_TYPE,--trim(a.AMOUNT_BLOCK_TYPE)  AMOUNT_BLOCK_TYPE,         --5   AMOUNT_BLOCK_TYPE
trim(a.BRANCH_CODE)  BRANCH_CODE,         --6   BRANCH_CODE
to_date(EFFECTIVE_DATE,'dd/mm/rrrr') EFFECTIVE_DATE,--to_date('25/09/2021','dd/mm/rrrr') EFFECTIVE_DATE,--trim(a.EFFECTIVE_DATE)  EFFECTIVE_DATE,         --7   EFFECTIVE_DATE
trim(a.ERRMSG)  ERRMSG,         --8   ERRMSG
trim(a.EXPIRY_DATE)  EXPIRY_DATE,         --9   EXPIRY_DATE
'N' FUND_AVL_CHECK,--trim(a.FUND_AVL_CHECK)  FUND_AVL_CHECK,         --10   FUND_AVL_CHECK
trim(a.HOLD_CODE)  HOLD_CODE,         --11   HOLD_CODE
trim(a.MAINTENANCE_SEQ_NO)  MAINTENANCE_SEQ_NO,         --12   MAINTENANCE_SEQ_NO
trim(a.REFERENCE_NO)  REFERENCE_NO,         --13   REFERENCE_NO
trim(a.REMARKS)  REMARKS,         --14   REMARKS
'DTN_AMT_BLK_UPD' SOURCE_CODE,--trim(a.SOURCE_CODE)  SOURCE_CODE,         --15   SOURCE_CODE
'U' UPLOAD_STATUS_FLAG--trim(a.UPLOAD_STATUS_FLAG)  UPLOAD_STATUS_FLAG          --16   UPLOAD_STATUS_FLAG
from  CATM_UPLOAD_AMOUNT_BLOCKS@ampdblink a
where trim(a.REFERENCE_NO) not in (select trim(b.REFERENCE_NO) from CATM_AMOUNT_BLOCKS b ))loop

/*
select * from CATM_UPLOAD_AMOUNT_BLOCKS@ampdblink;
select * from sttm_cust_account where trim(alt_ac_no) = '00500039412' 
*/

begin

insert into CATM_UPLOAD_AMOUNT_BLOCKS (
ACCOUNT_NO,         --1   ACCOUNT_NO
ACTION_CODE,         --2   ACTION_CODE
AMOUNT,         --3   AMOUNT
AMOUNT_BLOCK_NO,         --4   AMOUNT_BLOCK_NO
AMOUNT_BLOCK_TYPE,         --5   AMOUNT_BLOCK_TYPE
BRANCH_CODE,         --6   BRANCH_CODE
EFFECTIVE_DATE,         --7   EFFECTIVE_DATE
ERRMSG,         --8   ERRMSG
EXPIRY_DATE,         --9   EXPIRY_DATE
FUND_AVL_CHECK,         --10   FUND_AVL_CHECK
HOLD_CODE,         --11   HOLD_CODE
MAINTENANCE_SEQ_NO,         --12   MAINTENANCE_SEQ_NO
REFERENCE_NO,         --13   REFERENCE_NO
REMARKS,         --14   REMARKS
SOURCE_CODE,         --15   SOURCE_CODE
UPLOAD_STATUS_FLAG)         --16   UPLOAD_STATUS_FLAG

values(
i.cust_ac_no,--- ACCOUNT_NO,         --1   ACCOUNT_NO
i.ACTION_CODE,--- ACTION_CODE,         --2   ACTION_CODE
i.AMOUNT,--- AMOUNT,         --3   AMOUNT
i.AMOUNT_BLOCK_NO,--- AMOUNT_BLOCK_NO,         --4   AMOUNT_BLOCK_NO
i.AMOUNT_BLOCK_TYPE,--- AMOUNT_BLOCK_TYPE,         --5   AMOUNT_BLOCK_TYPE
i.BRANCH_CODE,--- BRANCH_CODE,         --6   BRANCH_CODE
i.EFFECTIVE_DATE,--- EFFECTIVE_DATE,         --7   EFFECTIVE_DATE
i.ERRMSG,--- ERRMSG,         --8   ERRMSG
i.EXPIRY_DATE,--- EXPIRY_DATE,         --9   EXPIRY_DATE
i.FUND_AVL_CHECK,--- FUND_AVL_CHECK,         --10   FUND_AVL_CHECK
i.HOLD_CODE,--- HOLD_CODE,         --11   HOLD_CODE
i.MAINTENANCE_SEQ_NO,--- MAINTENANCE_SEQ_NO,         --12   MAINTENANCE_SEQ_NO
i.REFERENCE_NO,--- REFERENCE_NO,         --13   REFERENCE_NO
i.REMARKS,--- REMARKS,         --14   REMARKS
i.SOURCE_CODE,--- SOURCE_CODE,         --15   SOURCE_CODE
i.UPLOAD_STATUS_FLAG);--- UPLOAD_STATUS_FLAG          --16   UPLOAD_STATUS_FLAG

exception
when others then
--create table chq_err_log(cust_ac_no varchar(20), account varchar(20),check_book_no number, check_no number,remark varchar(100));
insert into  chq_err_log values(i.cust_ac_no,i.account_no,'11111','11111','AMT_BLOCK_A'); commit;
end;
end loop;
commit;



--CA-AB005            38 Effective date cannot be in the past
update ertb_msgs set type = 'O' where err_code = 'CA-AB005';
COMMIT;


end;


















/*

execute pr_amt_blk_ampl();


exception
when others then
--create table chq_err_log(cust_ac_no varchar(20), account varchar(20),check_book_no number, check_no number,remark varchar(100));
insert into  chq_err_log values(i.cust_ac_no,i.account_no,'11111','11111','Amt Block'); commit;
end;

end;

select * from chq_err_log where remark = 'AMT_BLOCK';
delete from chq_err_log where remark = 'AMT_BLOCK';

select upload_status, count(*) from  sttb_upload_master group by upload_status;
select ab.* from (select branch_code, upload_status, count(*) cnt from sttb_upload_master group by branch_code, upload_status) ab order by ab.cnt desc;




select b.*, a.message from
ertb_msgs a,
(select distinct error_code, COUNT(*) CT from CSTB_UPLOAD_EXCEPTION GROUP BY error_code) b
where b.error_code = a.err_code
and a.langUAGE = 'ENG' order by ct desc;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
update STTM_CUST_ACCOUNT set master_account_no = null;
update ertb_msgs set type = 'O' where err_code = 'CA-AB005';
commit;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
select master_account_no from sttm_cust_account;


select * from user_triggers where table_name = 'STTM_CUST_ACCOUNT';

update sttm_cust_account set 
---------------------------------------------------
---------------------------------------------------
---------------------------------------------------
execute pr_amt_blk_dtn();
execute pr_amt_blk_ampl();

]


select * from sttb_upload_master;
select * from catm_upload_amount_blocks;
select * from catm_upload_amount_blocks@ampdblink;
select * from sttm_cust_account where trim(alt_ac_no) = '00500039412';

select * from catm_upload_amount_blocks@ampdblink where trim(account_no)  in (select trim(alt_ac_no) from sttm_cust_account);

select * from catm_upload_amount_blocks@ampdblink where trim(account_no) in 
(select trim(alt_ac_no) from sttb_upload_cust_account_casa@ampdblink);


select * from sttb_upload_master;  
select * from chq_err_log where remark = 'AMT_BLOCK';

select * from chq_err_log where remark = 'AMT_BLOCK' and account in (select b.account from catm_upload_amount_blocks b); 
select * from catm_upload_amount_blocks@to_dtn b where b.account_no in (select account_no from chq_err_log where remark = 'AMT_BLOCK');

truncate table catm_upload_amount_blocks;
truncate table sttb_upload_master;
delete from chq_err_log where remark = 'AMT_BLOCK';
commit;
---------------------------------------------------
---------------------------------------------------
---------------------------------------------------

*/

/*
0010571603017	52000001	AMPL_AMTBLK_UPD	120	02000018698
0010606237017	52000002	AMPL_AMTBLK_UPD	602	00100007954
0010602145019	52000003	AMPL_AMTBLK_UPD	801	02000038590
0010571567015	52000004	AMPL_AMTBLK_UPD	801	02000002399

select * from sttm_cust_account where cust_ac_no in ('0010571603017','0010606237017','0010602145019','0010571567015','0010000043104');
select AUTO_DEP_AC_CLASS,ACCCLS_AUTODEP_LIST from sttm_account_class where account_class in ('CURIND','TEST_A');
update sttm_account_class set ACCCLS_AUTODEP_LIST ='D' where account_class in ('CURIND');
 
select * from sttm_account_class where account_class in ('CURIND','TEST_A');

select * from sttm_cust_account where cust_ac_no in ('0010000043057');

select 
decode(a.account_no,(select b.alt_ac_no from sttm_cust_account b where b.alt_ac_no = a.account_no),(select c.cust_ac_no from sttm_cust_account c where c.alt_ac_no = a.account_no), null)  cust_ac_no,         --1   ACCOUNT_NO
a.* 
from catm_upload_amount_blocks@ampdblink a;

select * from catm_upload_amount_blocks@ampdblink a;

desc sttm_account_class;

CAPKS_CADAMBLK_UTILS


select * from user_objects where object_name like  '%CADAMBLK%';
select * from user_objects where object_name like  'CAPKS_CADAMBLK_UTILS';
select * from  catm_upload_amount_blocks@to_dtn;
select * from  CATM_UPLOAD_AMOUNT_BLOCKS@ampdblink;

--CADAMBLK



commit;

--CA-AB005            38 Effective date cannot be in the past
update ertb_msgs set type = 'O' where err_code = 'CA-AB005';
COMMIT;

--truncate table catm_upload_amount_blocks;
--SELECT * FROM CATM_AMOUNT_BLOCKS@to_legacy2b;
--DESC CATM_UPLOAD_AMOUNT_BLOCKS';
--select 'AB'||casq_amount_block.nextval from dual;

--select * from CATM_UPLOAD_AMOUNT_BLOCKS@to_dtn;

--select * from CATM_AMOUNT_BLOCKS;
select * from catm_upload_amount_blocks@ampdblink;


end;
-------------------------------------------
truncate table  cvtb_upload_master;
truncate table  cstb_upload_exception;
truncate table  sttb_upload_master;
truncate table  catm_upload_amount_blocks;
--------------------------------------------
select * from sttb_upload_master;
select * from catm_upload_amount_blocks where account='0010000083018';
select * from catm_amount_blocks where account='0010000083018';

--------------------------------------------
desc catm_upload_amount_blocks;
--------------------------------------------



execute pr_amt_blk();
execute pr_amt_blk_ampl();
------------------------------------------
select * from catm_upload_amount_blocks;
select * from catm_amount_blocks;
select * from sttb_upload_master;        

truncate table catm_upload_amount_blocks;
truncate table sttb_upload_master;
------------------------------------------
delete from catm_upload_amount_blocks where account_no is null;
delete from sttb_upload_master where maintenance_seq_no not in (select a.maintenance_seq_no from catm_upload_amount_blocks a)

insert into cotm_source select * from cotm_source@to_devone where source_code = 'AMT_UPD';
insert into cotm_source_pref select * from cotm_source_pref@to_devone where source_code = 'AMT_UPD';

update cotm_source set source_code = 'DTN_AMT_BLK_UPD' where source_code = 'AMT_UPD';
update cotm_source_pref set source_code = 'DTN_AMT_BLK_UPD' where source_code = 'AMT_UPD';

select * from 


insert into cotm_source select * from cotm_source@to_devone where source_code = 'AMT_UPD';
insert into cotm_source_pref select * from cotm_source_pref@to_devone where source_code = 'AMT_UPD';

update cotm_source set source_code = 'AMP_ACCT_UPD' where source_code = 'AMPL_ACCT_UPD';
update cotm_source_pref set source_code = 'AMP_ACCT_UPD' where source_code = 'AMPL_ACCT_UPD'
*/


