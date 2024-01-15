create or replace procedure insert_si_dot as 
a number;
sys_date date;
maker_idd varchar2(50);
checker_idd varchar2(50);
in_source_code varchar2(100);


begin

maker_idd:='MIG_USER01';
checker_idd:='MIG_USER02';
in_source_code := 'DTN_CUST_UPD';
select today into sys_date from sttm_dates where branch_CODE ='000';

---XXX1
dbms_output.put_line('---populating sitb_upload_master : starting');
for i in (
select 
trim(action_code)  action_code,         --1   ACTION_CODE
trim(action_code_amt)  action_code_amt,         --2   ACTION_CODE_AMT
trim(apply_chg_pexc)  apply_chg_pexc,         --3   APPLY_CHG_PEXC
trim(apply_chg_rejt)  apply_chg_rejt,         --4   APPLY_CHG_REJT
trim(apply_chg_suxs)  apply_chg_suxs,         --5   APPLY_CHG_SUXS
trim(authorize)  authorize,         --6   AUTHORIZE
to_date(trim(book_date), 'RRRR-MM-DD')  book_date,         --7   BOOK_DATE
trim(branch_code)  branch_code,         --8   BRANCH_CODE
trim(charge_whom)  charge_whom,         --9   CHARGE_WHOM
trim(contract_ref_no)  contract_ref_no,         --10   CONTRACT_REF_NO
trim(conv_status)  conv_status,         --11   CONV_STATUS
case  when trim(product_type)='O' then (select z.cust_no from sttm_cust_account z where (trim(z.alt_ac_no) in (select trim(y.dr_account) dr_account from sitb_upload_master@to_dtn y)) and z.alt_ac_no=trim(dr_account))
      when trim(product_type)='P' then (select z.cust_no from sttm_cust_account z where (trim(z.alt_ac_no) in (select trim(y.dr_account) dr_account from sitb_upload_master@to_dtn y)) and z.alt_ac_no=trim(dr_account))
      when trim(product_type)='I' then (select z.cust_no from sttm_cust_account z where (trim(z.alt_ac_no) in (select trim(y.cr_account) cr_account from sitb_upload_master@to_dtn y)) and z.alt_ac_no=trim(cr_account)) end counterparty,         --12   COUNTERPARTY
decode(trim(cr_account),(select z.alt_ac_no from sttm_cust_account z where (trim(z.alt_ac_no) in (select trim(y.cr_account) cr_account from sitb_upload_master@to_dtn y)) and z.alt_ac_no=trim(cr_account)),(select z.cust_ac_no from sttm_cust_account z where (trim(z.alt_ac_no) in (select trim(y.cr_account) cr_account from sitb_upload_master@to_dtn y)) and z.alt_ac_no=trim(cr_account)),'no_acct')  cr_account,         --13   CR_ACCOUNT
trim(cr_acc_br)  cr_acc_br,         --14   CR_ACC_BR
trim(cr_acc_ccy)  cr_acc_ccy,         --15   CR_ACC_CCY
trim(detail_ref)  detail_ref,         --16   DETAIL_REF
decode(trim(dr_account),(select z.alt_ac_no from sttm_cust_account z where (trim(z.alt_ac_no) in (select trim(y.dr_account) dr_account from sitb_upload_master@to_dtn y)) and z.alt_ac_no=trim(dr_account)),(select z.cust_ac_no from sttm_cust_account z where (trim(z.alt_ac_no) in (select trim(y.dr_account) dr_account from sitb_upload_master@to_dtn y)) and z.alt_ac_no=trim(dr_account)),'no_acct')  dr_account,         --17   DR_ACCOUNT
trim(dr_acc_br)  dr_acc_br,         --18   DR_ACC_BR
trim(dr_acc_ccy)  dr_acc_ccy,         --19   DR_ACC_CCY
trim(err_msg)  err_msg,         --20   ERR_MSG
trim(function_id)  function_id,         --21   FUNCTION_ID
trim(iccf_changed)  iccf_changed,         --22   ICCF_CHANGED
trim(instruction_no)  instruction_no,         --23   INSTRUCTION_NO
trim(internal_remarks)  internal_remarks,         --24   INTERNAL_REMARKS
trim(low_range_bal_lim)  low_range_bal_lim,         --25   LOW_RANGE_BAL_LIM
trim(max_retry_count)  max_retry_count,         --26   MAX_RETRY_COUNT
trim(min_bal_after_sweep)  min_bal_after_sweep,         --27   MIN_BAL_AFTER_SWEEP
trim(min_sweep_amt)  min_sweep_amt,         --28   MIN_SWEEP_AMT
trim(mis_changed)  mis_changed,         --29   MIS_CHANGED
trim(priority)  priority,         --30   PRIORITY
trim(product_code)  product_code,         --31   PRODUCT_CODE
trim(product_type)  product_type,         --32   PRODUCT_TYPE
trim(retry_count_adv)  retry_count_adv,         --33   RETRY_COUNT_ADV
trim(serial_no)  serial_no,         --34   SERIAL_NO
trim(settle_changed)  settle_changed,         --35   SETTLE_CHANGED
trim(si_amt)  si_amt,         --36   SI_AMT
trim(si_amt_ccy)  si_amt_ccy,         --37   SI_AMT_CCY
to_date(trim(si_expiry_date), 'RRRR-MM-DD')  si_expiry_date,         --38   SI_EXPIRY_DATE
trim(source_code)  source_code,         --39   SOURCE_CODE
trim(source_ref)  source_ref,         --40   SOURCE_REF
trim(source_seq_no)  source_seq_no,         --41   SOURCE_SEQ_NO
trim(subsystem_stat)  subsystem_stat,         --42   SUBSYSTEM_STAT
trim(tax_changed)  tax_changed,         --43   TAX_CHANGED
trim(transfer_type)  transfer_type,         --44   TRANSFER_TYPE
trim(ui_cr_account)  ui_cr_account,         --45   UI_CR_ACCOUNT
trim(ui_dr_account)  ui_dr_account,         --46   UI_DR_ACCOUNT
trim(upload_id)  upload_id,         --47   UPLOAD_ID
trim(upp_range_bal_lim)  upp_range_bal_lim,         --48   UPP_RANGE_BAL_LIM
trim(source_ref)  user_ref_number,         --49   USER_REF_NUMBER
trim(version_no)  version_no          --50   VERSION_NO
from  sitb_upload_master@to_dtn
where 1=1
and nvl(trim(source_ref),'yyy') not in (select nvl(trim(user_ref_number),'xxx') user_ref_number from sitbs_contract_master)
--select * from sitb_upload_master@to_dtn
--select * from sitb_upload_master where trim(dr_account) in (select trim(alt_ac_no) from sttm_cust_account)
--select z.alt_ac_no from sttm_cust_account z where (trim(z.alt_ac_no) in (select trim(y.cr_account) cr_account from sitb_upload_master@to_dtn y));
--(select z.cust_ac_no from sttm_cust_account z where trim(z.alt_ac_no) in (select trim(dr_account) from sitb_upload_master@to_dtn) and trim(z.alt_ac_no)=trim(ui_cr_account))

)
loop
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
begin

insert into sitb_upload_master (
action_code,         --1   ACTION_CODE
action_code_amt,         --2   ACTION_CODE_AMT
apply_chg_pexc,         --3   APPLY_CHG_PEXC
apply_chg_rejt,         --4   APPLY_CHG_REJT
apply_chg_suxs,         --5   APPLY_CHG_SUXS
authorize,         --6   AUTHORIZE
book_date,         --7   BOOK_DATE
branch_code,         --8   BRANCH_CODE
charge_whom,         --9   CHARGE_WHOM
contract_ref_no,         --10   CONTRACT_REF_NO
conv_status,         --11   CONV_STATUS
counterparty,         --12   COUNTERPARTY
cr_account,         --13   CR_ACCOUNT
cr_acc_br,         --14   CR_ACC_BR
cr_acc_ccy,         --15   CR_ACC_CCY
detail_ref,         --16   DETAIL_REF
dr_account,         --17   DR_ACCOUNT
dr_acc_br,         --18   DR_ACC_BR
dr_acc_ccy,         --19   DR_ACC_CCY
err_msg,         --20   ERR_MSG
function_id,         --21   FUNCTION_ID
iccf_changed,         --22   ICCF_CHANGED
instruction_no,         --23   INSTRUCTION_NO
internal_remarks,         --24   INTERNAL_REMARKS
low_range_bal_lim,         --25   LOW_RANGE_BAL_LIM
max_retry_count,         --26   MAX_RETRY_COUNT
min_bal_after_sweep,         --27   MIN_BAL_AFTER_SWEEP
min_sweep_amt,         --28   MIN_SWEEP_AMT
mis_changed,         --29   MIS_CHANGED
priority,         --30   PRIORITY
product_code,         --31   PRODUCT_CODE
product_type,         --32   PRODUCT_TYPE
retry_count_adv,         --33   RETRY_COUNT_ADV
serial_no,         --34   SERIAL_NO
settle_changed,         --35   SETTLE_CHANGED
si_amt,         --36   SI_AMT
si_amt_ccy,         --37   SI_AMT_CCY
si_expiry_date,         --38   SI_EXPIRY_DATE
source_code,         --39   SOURCE_CODE
source_ref,         --40   SOURCE_REF
source_seq_no,         --41   SOURCE_SEQ_NO
subsystem_stat,         --42   SUBSYSTEM_STAT
tax_changed,         --43   TAX_CHANGED
transfer_type,         --44   TRANSFER_TYPE
ui_cr_account,         --45   UI_CR_ACCOUNT
ui_dr_account,         --46   UI_DR_ACCOUNT
upload_id,         --47   UPLOAD_ID
upp_range_bal_lim,         --48   UPP_RANGE_BAL_LIM
user_ref_number,         --49   USER_REF_NUMBER
version_no)         --50   VERSION_NO


values(
i.action_code,         --1   ACTION_CODE
i.action_code_amt,         --2   ACTION_CODE_AMT
i.apply_chg_pexc,         --3   APPLY_CHG_PEXC
i.apply_chg_rejt,         --4   APPLY_CHG_REJT
i.apply_chg_suxs,         --5   APPLY_CHG_SUXS
i.authorize,         --6   AUTHORIZE
sys_date,         --7   BOOK_DATE
i.branch_code,         --8   BRANCH_CODE
i.charge_whom,         --9   CHARGE_WHOM
i.contract_ref_no,         --10   CONTRACT_REF_NO
i.conv_status,         --11   CONV_STATUS
i.counterparty,         --12   COUNTERPARTY
i.cr_account,         --13   CR_ACCOUNT
i.cr_acc_br,         --14   CR_ACC_BR
i.cr_acc_ccy,         --15   CR_ACC_CCY
i.detail_ref,         --16   DETAIL_REF
i.dr_account,         --17   DR_ACCOUNT
i.dr_acc_br,         --18   DR_ACC_BR
i.dr_acc_ccy,         --19   DR_ACC_CCY
i.err_msg,         --20   ERR_MSG
i.function_id,         --21   FUNCTION_ID
i.iccf_changed,         --22   ICCF_CHANGED
i.instruction_no,         --23   INSTRUCTION_NO
i.internal_remarks,         --24   INTERNAL_REMARKS
i.low_range_bal_lim,         --25   LOW_RANGE_BAL_LIM
i.max_retry_count,         --26   MAX_RETRY_COUNT
i.min_bal_after_sweep,         --27   MIN_BAL_AFTER_SWEEP
i.min_sweep_amt,         --28   MIN_SWEEP_AMT
i.mis_changed,         --29   MIS_CHANGED
i.priority,         --30   PRIORITY
i.product_code,         --31   PRODUCT_CODE
i.product_type,         --32   PRODUCT_TYPE
i.retry_count_adv,         --33   RETRY_COUNT_ADV
i.serial_no,         --34   SERIAL_NO
i.settle_changed,         --35   SETTLE_CHANGED
i.si_amt,         --36   SI_AMT
i.si_amt_ccy,         --37   SI_AMT_CCY
i.si_expiry_date,         --38   SI_EXPIRY_DATE
'SI_UPD',         --39   SOURCE_CODE
i.source_ref,         --40   SOURCE_REF
i.source_seq_no,         --41   SOURCE_SEQ_NO
i.subsystem_stat,         --42   SUBSYSTEM_STAT
i.tax_changed,         --43   TAX_CHANGED
i.transfer_type,         --44   TRANSFER_TYPE
i.ui_cr_account,         --45   UI_CR_ACCOUNT
i.ui_dr_account,         --46   UI_DR_ACCOUNT
i.upload_id,         --47   UPLOAD_ID
i.upp_range_bal_lim,         --48   UPP_RANGE_BAL_LIM
i.user_ref_number,         --49   USER_REF_NUMBER
i.version_no);         --50   VERSION_NO
commit; 

exception
when no_data_found then 
insert into si_upload_log  values(i.source_ref,'sitb_upload_master');
commit;

when others then
insert into si_upload_log  values(i.source_ref,'sitb_upload_master');
commit;

--select * from cif_upload_log;
--create table SI_upload_log(maint_seq_no number, table_name varchar(100));  
end;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end loop;

dbms_output.put_line('---populating sitb_upload_master : completed');





begin
---XXX2
dbms_output.put_line('---populating SITB_UPLOAD_INSTRUCTION : starting');
for i in ( 
select 
trim(b.action_code)  action_code,         --1   ACTION_CODE
trim(b.auth_status)  auth_status,         --2   AUTH_STATUS
to_date(trim(b.book_date), 'RRRR-MM-DD') book_date,--trim(b.book_date)  book_date,         --3   BOOK_DATE  --trim(b.to_date(trim(b.REVISION_DATE), 'RRRR-MM-DD')) 
trim(b.branch_code)  branch_code,         --4   BRANCH_CODE
trim(b.cal_hol_excp)  cal_hol_excp,         --5   CAL_HOL_EXCP
trim(b.conv_status)  conv_status,         --6   CONV_STATUS
(select trim(z.counterparty) counterparty from sitb_upload_master z where trim(z.source_ref) = b.source_ref) COUNTERPARTY,  --trim(b.counterparty)  counterparty,         --7   COUNTERPARTY
trim(b.err_msg)  err_msg,         --8   ERR_MSG
trim(b.exec_days)  exec_days,         --9   EXEC_DAYS
trim(b.exec_mths)  exec_mths,         --10   EXEC_MTHS
trim(b.exec_yrs)  exec_yrs,         --11   EXEC_YRS
to_date(trim(b.first_exec_date), 'RRRR-MM-DD') first_exec_date, -- first_exec_date,         --12   FIRST_EXEC_DATE
to_date(trim(b.first_value_date), 'RRRR-MM-DD') first_value_date, --first_value_date,         --13   FIRST_VALUE_DATE
trim(b.function_id)  function_id,         --14   FUNCTION_ID
trim(b.gen_mesg)  gen_mesg,         --15   GEN_MESG
trim(b.goal_ref_no)  goal_ref_no,         --16   GOAL_REF_NO
trim(b.group_code)  group_code,         --17   GROUP_CODE
trim(b.instruction_no)  instruction_no,         --18   INSTRUCTION_NO
trim(b.inst_status)  inst_status,         --19   INST_STATUS
trim(b.inst_version_no)  inst_version_no,         --20   INST_VERSION_NO
trim(b.latest_cycle_date)  latest_cycle_date,         --21   LATEST_CYCLE_DATE
trim(b.latest_cycle_no)  latest_cycle_no,         --22   LATEST_CYCLE_NO
to_date(trim(b.latest_version_date), 'RRRR-MM-DD')  latest_version_date,         --23   LATEST_VERSION_DATE
trim(b.month_end_flag)  month_end_flag,         --24   MONTH_END_FLAG
to_date(trim(b.next_exec_date), 'RRRR-MM-DD')  next_exec_date,         --25   NEXT_EXEC_DATE
to_date(trim(b.next_value_date), 'RRRR-MM-DD')  next_value_date,         --26   NEXT_VALUE_DATE
trim(b.operation)  operation,         --27   OPERATION
trim(b.processing_time)  processing_time,         --28   PROCESSING_TIME
trim(b.product_code)  product_code,         --29   PRODUCT_CODE
trim(b.product_type)  product_type,         --30   PRODUCT_TYPE
trim(b.rate_type)  rate_type,         --31   RATE_TYPE
trim(b.serial_no)  serial_no,         --32   SERIAL_NO
trim(b.si_type)  si_type,         --33   SI_TYPE
trim(b.source_code)  source_code,         --34   SOURCE_CODE
trim(b.source_ref)  source_ref,         --35   SOURCE_REF
trim(b.source_seq_no)  source_seq_no,         --36   SOURCE_SEQ_NO
trim(b.suspend_execution)  suspend_execution,         --37   SUSPEND_EXECUTION
trim(b.upload_id)  upload_id,         --38   UPLOAD_ID
trim(b.user_inst_no)  user_inst_no          --39   USER_INST_NO
from  sitb_upload_instruction@to_dtn b
where 1=1
and nvl(trim(b.source_ref),'yyy' ) not in (select nvl(trim(source_inst_no),'xxx') source_inst_no  from sitbs_instruction)
)
loop

begin
insert into sitb_upload_instruction (
action_code,         --1   ACTION_CODE
auth_status,         --2   AUTH_STATUS
book_date,         --3   BOOK_DATE
branch_code,         --4   BRANCH_CODE
cal_hol_excp,         --5   CAL_HOL_EXCP
conv_status,         --6   CONV_STATUS
counterparty,         --7   COUNTERPARTY
err_msg,         --8   ERR_MSG
exec_days,         --9   EXEC_DAYS
exec_mths,         --10   EXEC_MTHS
exec_yrs,         --11   EXEC_YRS
first_exec_date,         --12   FIRST_EXEC_DATE
first_value_date,         --13   FIRST_VALUE_DATE
function_id,         --14   FUNCTION_ID
gen_mesg,         --15   GEN_MESG
goal_ref_no,         --16   GOAL_REF_NO
group_code,         --17   GROUP_CODE
instruction_no,         --18   INSTRUCTION_NO
inst_status,         --19   INST_STATUS
inst_version_no,         --20   INST_VERSION_NO
latest_cycle_date,         --21   LATEST_CYCLE_DATE
latest_cycle_no,         --22   LATEST_CYCLE_NO
latest_version_date,         --23   LATEST_VERSION_DATE
month_end_flag,         --24   MONTH_END_FLAG
next_exec_date,         --25   NEXT_EXEC_DATE
next_value_date,         --26   NEXT_VALUE_DATE
operation,         --27   OPERATION
processing_time,         --28   PROCESSING_TIME
product_code,         --29   PRODUCT_CODE
product_type,         --30   PRODUCT_TYPE
rate_type,         --31   RATE_TYPE
serial_no,         --32   SERIAL_NO
si_type,         --33   SI_TYPE
source_code,         --34   SOURCE_CODE
source_ref,         --35   SOURCE_REF
source_seq_no,         --36   SOURCE_SEQ_NO
suspend_execution,         --37   SUSPEND_EXECUTION
upload_id,         --38   UPLOAD_ID
user_inst_no)         --39   USER_INST_NO


values(
i.action_code,         --1   ACTION_CODE
i.auth_status,         --2   AUTH_STATUS
sys_date,              --3   BOOK_DATE
i.branch_code,         --4   BRANCH_CODE
i.cal_hol_excp,         --5   CAL_HOL_EXCP
i.conv_status,         --6   CONV_STATUS
i.counterparty,         --7   COUNTERPARTY
i.err_msg,         --8   ERR_MSG
i.exec_days,         --9   EXEC_DAYS
i.exec_mths,         --10   EXEC_MTHS
i.exec_yrs,         --11   EXEC_YRS
i.first_exec_date,         --12   FIRST_EXEC_DATE
i.first_value_date,         --13   FIRST_VALUE_DATE
i.function_id,         --14   FUNCTION_ID
i.gen_mesg,         --15   GEN_MESG
i.goal_ref_no,         --16   GOAL_REF_NO
i.group_code,         --17   GROUP_CODE
i.instruction_no,         --18   INSTRUCTION_NO
i.inst_status,         --19   INST_STATUS
i.inst_version_no,         --20   INST_VERSION_NO
i.latest_cycle_date,         --21   LATEST_CYCLE_DATE
i.latest_cycle_no,         --22   LATEST_CYCLE_NO
i.latest_version_date,         --23   LATEST_VERSION_DATE
i.month_end_flag,         --24   MONTH_END_FLAG
i.next_exec_date,         --25   NEXT_EXEC_DATE
i.next_value_date,         --26   NEXT_VALUE_DATE
i.operation,         --27   OPERATION
i.processing_time,         --28   PROCESSING_TIME
i.product_code,         --29   PRODUCT_CODE
i.product_type,         --30   PRODUCT_TYPE
i.rate_type,         --31   RATE_TYPE
i.serial_no,         --32   SERIAL_NO
i.si_type,         --33   SI_TYPE
'SI_UPD',         --34   SOURCE_CODE
i.source_ref,         --35   SOURCE_REF
i.source_seq_no,         --36   SOURCE_SEQ_NO
i.suspend_execution,         --37   SUSPEND_EXECUTION
i.upload_id,         --38   UPLOAD_ID
i.user_inst_no);         --39   USER_INST_NO
commit; 

exception
when no_data_found then 
insert into si_upload_log  values(i.source_ref,'SITB_UPLOAD_INSTRUCTION');
commit;

when others then
insert into si_upload_log  values(i.source_ref,'SITB_UPLOAD_INSTRUCTION');
commit;

end;

end loop;
dbms_output.put_line('---populating sttm_upload_cust_personal : completed');
end;

end;

/*
------------------------------------------------------------
execute insert_si_dot();
update sitb_upload_master set ui_dr_account = dr_account, ui_cr_account=cr_account;
update sitb_contract_master set ui_dr_account = dr_account, ui_cr_account=cr_account where UI_DR_ACCOUNT is null;
commit;
select * from sitb_upload_master;
select * from sitb_upload_instruction;
select * from Cstb_Ext_Contract_Stat where source = 'SI_UPD';
select * from si_upload_log;
select * from sttm_customer where ext_ref_no in '6000746';
select * from ertb_msgs where err_code ='SI-RESP-004';
select * from ertb_msgs where err_code ='SI-RESP-002';   ---->
select * from ertb_msgs where err_code ='ST-SAVE-054';--SI-DEF-002
select * from ertb_msgs where err_code ='SI-VALS-011;   --$1 is not a valid Account of Branch $2
select * from ertb_msgs where err_code ='SI-VALS-016';  --Action Code Should be Ignore for Sweep In, Sweep Out and Range Balancing Sweep Product Type
select * from ertb_msgs where err_code ='SI-VALS-035';--SI-VALS-016
select * from ertb_msgs where err_code ='SI-VALS-016';--SI-CON040
select * from ertb_msgs where err_code ='SI-DEF-005';
select * from ertb_msgs where err_code ='SI-CON040';---SI-RESP-004
select * from ertb_msgs where err_code ='SI-RESP-004';
------------------------------------------------------------
truncate table sitb_upload_master;
truncate table sitb_upload_instruction;
delete from Cstb_Ext_Contract_Stat where source = 'SI_UPD';-------------- and IMPORT_STATUS <> 'P' ;
truncate table si_upload_log;
-----------------------------------------------------------
select * from SITBS_INSTRUCTION;
select * from Sitbs_Contract_Master;

-----------------------------------------------------------------------------------------
create table sitb_upload_master_flx_moc3 as select * from sitb_upload_master;
create table sitb_upload_instruction_flx_moc3 as select * from sitb_upload_instruction;
create table Cstb_Ext_Contract_Stat_flx_moc3 as select * from Cstb_Ext_Contract_Stat;
-----------------------------------------------------------------------------------------









select source_ref, count(*) from sitb_upload_master group by source_ref;
--------
select * from sitb_upload_master where dr_acc_br||'~'||dr_account  in (select branch_code||'~'||cust_ac_no from sttm_cust_account) and dr_account = '0010211485015';
select * from sitb_upload_master where cr_acc_br||'~'||cr_account  not in (select branch_code||'~'||cust_ac_no from sttm_cust_account);
select source_seq_no from sitb_upload_master where dr_acc_br||'~'||dr_account  not in (select branch_code||'~'||cust_ac_no from sttm_cust_account);
select source_seq_no from sitb_upload_master where cr_acc_br||'~'||cr_account  not in (select branch_code||'~'||cust_ac_no from sttm_cust_account);

select dr_acc_br||'~'||dr_account from sitb_upload_master@to_dtn where dr_acc_br||'~'||dr_account  not in (select branch_code||'~'||trim(alt_ac_no) from sttm_cust_account);
select * from sitb_upload_master@to_dtn where cr_acc_br||'~'||cr_account  not in (select branch_code||'~'||trim(alt_ac_no) from sttm_cust_account);

select * from sitb_upload_master@ampdblink;

select * from sttm_cust_account where trim(alt_ac_no) in ('1126070394700');


-------
select source_seq_no from sitb_upload_master where dr_acc_ccy||'~'||dr_account  not in (select ccy||'~'||cust_ac_no from sttm_cust_account);
select * from sitb_upload_master where cr_acc_ccy||'~'||cr_account  not in (select ccy||'~'||cust_ac_no from sttm_cust_account);
---------------------
-----------------------------------------------------------------------------------------------------------------------------------
select source_seq_no,source_ref, dr_acc_br,dr_account,cr_acc_br,cr_account from sitb_upload_master@to_dtn where source_seq_no in 
('61000053','61000033','61000009','61000051','61000037','61000064','61000006','61000041','61000015','61000038',
'61000039','61000027','61000028','61000003','61000050','61000019','61000011','61000040','61000044','61000021',
'61000022','61000023','61000024','61000025','61000017','61000018','61000012','61000055','61000068');
-----------------------------------------------------------------------------------------------------------------------------------

update sitb_upload_master 
set counterparty = case  when trim(product_type)='O' then (select z.cust_no from sttm_cust_account z where (trim(z.alt_ac_no) in (select trim(y.dr_account) dr_account from sitb_upload_master@to_dtn y)) and z.alt_ac_no=trim(dr_account)) when trim(product_type)='I' then (select z.cust_no from sttm_cust_account z where (trim(z.alt_ac_no) in (select trim(y.cr_account) cr_account from sitb_upload_master@to_dtn y)) and z.alt_ac_no=trim(cr_account)) end;


select product_type,  from sitb_upload_master;
select * from sitb_upload_master where source_ref not in ('9731','9701','2548','9685','9861','9955','10029','10030','10031','9984',
'9266','9811','9897','9833','10003','9689','9663','9679','10048','9672',
'10028','9784','9960','9892','9753','9762','9812','9851','6546','10055',
'10054','9916','6812','6540','9840','1643','9677')

9719/104/0010143012015  104/0010143012026

select * from sttm_cust_account where cust_ac_no in ('61000053','61000053');

select * from cotm_source where source_code = 'SI_UPD';
select * from cotm_source_pref where source_code = 'SI_UPD';
------------------------------------------------------------------------
select * from cotm_source@to_uat_dev where source_code = 'SI_UPD';
select * from cotm_source_pref@to_uat_dev where source_code = 'SI_UPD';
------------------------------------------------------------------------
desc sttm_cust_account;
*/

/*
SELECT * FROM SMTB_USER WHERE USER_ID LIKE 'ADMIN%'

DECLARE
  P_UPLOAD_ID VARCHAR(2000);
  p_err_code  VARCHAR(2000);
  p_err_param VARCHAR(2000);
Begin
 FOR I IN (SELECT DISTINCT BRANCH_CODE FROM CSTB_EXT_CONTRACT_STAT WHERE FUNCTION_ID='SIDTRONL' AND IMPORT_STATUS='U')
   LOOP
     global.pr_init(I.BRANCH_CODE, 'ADMINUSER1');--Change Branch Code here
     debug.pr_debug('SI', 'Starting with SI Upload');
     CSPKS_REQ_GLOBAL.G_HEADER('ACTION') := 'NEW';
     CSPKS_REQ_GLOBAL.G_HEADER('SOURCE') := 'SI_UPD';
     P_UPLOAD_ID := '';
     IF NOT Gwpks_Uploadsicontract.FN_UPLOAD('SI_UPD',
                                          'SIDTRONL',
                                          'NEW',
                                          P_UPLOAD_ID,
                                          P_ERR_CODE,
                                          P_ERR_PARAM) THEN
      debug.pr_debug('SI', 'Failed in SI upload');
      debug.pr_debug('SI', ' Error is ' || P_ERR_CODE || ' ' || P_ERR_PARAM);
    ELSE
      debug.pr_debug('SI', 'Upload Done.');
   END IF;
  END LOOP;
END;
*/