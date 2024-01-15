--Insert into ISTM_INSTR (BRANCH,MODULE,COUNTERPARTY,CURRENCY,PAY_ACCOUNT,RECV_ACCOUNT,PAY_AC_BRANCH,RECV_AC_BRANCH,PAY_ACCOUNT_CCY,RECV_ACCOUNT_CCY,COVER_REQUIRED,CHARGES_DETAILS,INT_REIM_INST1,INT_REIM_INST2,INT_REIM_INST3,INT_REIM_INST4,RCVR_CORRESP1,RCVR_CORRESP2,RCVR_CORRESP3,RCVR_CORRESP4,INTERMEDIARY1,INTERMEDIARY2,INTERMEDIARY3,INTERMEDIARY4,ACC_WITH_INSTN1,ACC_WITH_INSTN2,ACC_WITH_INSTN3,ACC_WITH_INSTN4,RECV_INTERMEDIARY1,RECV_INTERMEDIARY2,RECV_INTERMEDIARY3,RECV_INTERMEDIARY4,SNDR_TO_RCVR_INFO1,SNDR_TO_RCVR_INFO2,SNDR_TO_RCVR_INFO3,SNDR_TO_RCVR_INFO4,SNDR_TO_RCVR_INFO5,SNDR_TO_RCVR_INFO6,MOD_NO,RECORD_STAT,MAKER_ID,MAKER_DT_STAMP,CHECKER_ID,CHECKER_DT_STAMP,ONCE_AUTH,AUTH_STAT,ERI_CCY,COUNTERPARTY_TYPE,RECV_INTERMEDIARY5,ACC_WITH_INSTN5,INTERMEDIARY5,INT_REIM_INST5,RCVR_CORRESP5,BENEF_INSTITUTION5,BENEF_INSTITUTION1,BENEF_INSTITUTION2,BENEF_INSTITUTION3,BENEF_INSTITUTION4,RECEIVER,BENEF_INST1_FOR_COVER,BENEF_INST2_FOR_COVER,BENEF_INST3_FOR_COVER,BENEF_INST4_FOR_COVER,BENEF_INST5_FOR_COVER,COVER_BY,EXT_PAY_CPTY_AC_PREFIX,EXT_RECV_CPTY_AC_PREFIX,EXT_COVER_BANK_CODE,EXT_COVER_PARTYNAME,EXT_COVER_ACCOUNT,EXT_COVER_CPTY_AC_PREFIX,EXT_PAY_BANK_CODE,EXT_PAY_PARTYNAME,EXT_PAY_ACCOUNT,EXT_RECV_BANK_CODE,EXT_RECV_PARTYNAME,EXT_RECV_ACCOUNT,PAYMENT_BY_PAY,PAYMENT_BY_REC,BANK_OPER_CODE,INSTR_CODE,TRAN_TYPE_CODE,REGULATORY_REP1,REGULATORY_REP2,REGULATORY_REP3,PRODUCT_CODE,EXT_PAY_CLG_NETWORK,EXT_COVER_CLG_NETWORK,SETTLEMENT_SEQ_NO,RTGS_PAYMENT,RTGS_NETWORK,BENEF_INST6_FOR_COVER,INT_REIM_INST6,INTERMEDIARY6,RCVR_CORRESP6,ACC_WITH_INSTN6,RECV_INTERMEDIARY6,BENEF_INSTITUTION6,SETTLEMENT_SEQ_NO_DESC,UI_PAY_ACCOUNT,UI_RECV_ACCOUNT) values ('ALL','FA','0000001','*.*','240113001','240113001','000','000','GHS','GHS','N','O',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,1,'O','TAKEON01',to_date('29-APR-2022','DD-MON-RRRR'),'ADMINUSER2',to_date('29-APR-2022','DD-MON-RRRR'),'Y','A',null,'C',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'M','M',null,null,null,null,null,null,'ALL',null,null,0,'N',null,null,null,null,null,null,null,null,'DEFAULT','240113001','240113001');


insert into FATB_CONTRACT_MASTER_UPLOAD (
ACQUIRED_DEPRECIATION,         --1   ACQUIRED_DEPRECIATION
ACQUISITION_DATE,         --2   ACQUISITION_DATE
ACTION_CODE,         --3   ACTION_CODE
ASSET_CCY,         --4   ASSET_CCY
ASSET_COST,         --5   ASSET_COST
ASSET_REF_NO,         --6   ASSET_REF_NO
BOOKING_DATE,         --7   BOOKING_DATE
BRANCH_CODE,         --8   BRANCH_CODE
CAPITALIZATION_DATE,         --9   CAPITALIZATION_DATE
CATEGORY,         --10   CATEGORY
CHARGE_STATUS,         --11   CHARGE_STATUS
DESCRIPTION,         --12   DESCRIPTION
EFFECTIVE_DEPRECIATION_DATE,         --13   EFFECTIVE_DEPRECIATION_DATE
ERROR_CODE,         --14   ERROR_CODE
EVENT_SEQ_NO,         --15   EVENT_SEQ_NO
EXTERNAL_REF_NO,         --16   EXTERNAL_REF_NO
FUNCTION_ID,         --17   FUNCTION_ID
FUND_ID,         --18   FUND_ID
LOAN_REFERENCE_NO,         --19   LOAN_REFERENCE_NO
LOCATION,         --20   LOCATION
MODULE_CODE,         --21   MODULE_CODE
ORIGINAL_REF_NO,         --22   ORIGINAL_REF_NO
PRODUCT_CODE,         --23   PRODUCT_CODE
RESIDUAL_VALUE,         --24   RESIDUAL_VALUE
SERIAL_NO,         --25   SERIAL_NO
SETTLEMENT_STATUS,         --26   SETTLEMENT_STATUS
SOURCE_CODE,         --27   SOURCE_CODE
SOURCE_SEQ_NO,         --28   SOURCE_SEQ_NO
STATUS,         --29   STATUS
SUBSYSTEM_STAT,         --30   SUBSYSTEM_STAT
SUSPEND_DEPRECIATION,         --31   SUSPEND_DEPRECIATION
SUSPENSION_DATE,         --32   SUSPENSION_DATE
UPLOAD_ID,         --33   UPLOAD_ID
UPLOAD_STATUS,         --34   UPLOAD_STATUS
USEFUL_LIFE,         --35   USEFUL_LIFE
USEFUL_LIFE_UNIT,         --36   USEFUL_LIFE_UNIT
USER_REF_NO,         --37   USER_REF_NO
VERSION_NO)         --38   VERSION_NO


select 
trim(A.ACQUIRED_DEPRECIATION)  ACQUIRED_DEPRECIATION,         --1   ACQUIRED_DEPRECIATION
to_date((A.ACQUISITION_DATE),'rrrr/mm/dd')  ACQUISITION_DATE,         --2   ACQUISITION_DATE
trim(A.ACTION_CODE)  ACTION_CODE,         --3   ACTION_CODE
trim(A.ASSET_CCY)  ASSET_CCY,         --4   ASSET_CCY
trim(A.ASSET_COST)  ASSET_COST,         --5   ASSET_COST
trim(A.ASSET_REF_NO)  ASSET_REF_NO,         --6   ASSET_REF_NO
to_date((A.BOOKING_DATE),'rrrr/mm/dd')  BOOKING_DATE,         --7   BOOKING_DATE
trim(A.BRANCH_CODE)  BRANCH_CODE,         --8   BRANCH_CODE
to_date((A.CAPITALIZATION_DATE),'rrrr/mm/dd')  CAPITALIZATION_DATE,         --9   CAPITALIZATION_DATE
trim(A.CATEGORY)  CATEGORY,         --10   CATEGORY
trim(A.CHARGE_STATUS)  CHARGE_STATUS,         --11   CHARGE_STATUS
trim(SUBSTR(A.DESCRIPTION,1,35))  DESCRIPTION,         --12   DESCRIPTION
to_date((A.EFFECTIVE_DEPRECIATION_DATE),'rrrr/mm/dd')  EFFECTIVE_DEPRECIATION_DATE,         --13   EFFECTIVE_DEPRECIATION_DATE
trim(A.ERROR_CODE)  ERROR_CODE,         --14   ERROR_CODE
trim(A.EVENT_SEQ_NO)  EVENT_SEQ_NO,         --15   EVENT_SEQ_NO
trim(A.EXTERNAL_REF_NO) EXTERNAL_REF_NO,--'XXXX'||ROWNUM  EXTERNAL_REF_NO,--trim(A.EXTERNAL_REF_NO)  EXTERNAL_REF_NO,         --16   EXTERNAL_REF_NO
trim(A.FUNCTION_ID)  FUNCTION_ID,         --17   FUNCTION_ID
trim(A.FUND_ID)  FUND_ID,         --18   FUND_ID
trim(A.LOAN_REFERENCE_NO)  LOAN_REFERENCE_NO,         --19   LOAN_REFERENCE_NO
trim(A.LOCATION)  LOCATION,         --20   LOCATION
trim(A.MODULE_CODE)  MODULE_CODE,         --21   MODULE_CODE
trim(A.ORIGINAL_REF_NO)  ORIGINAL_REF_NO,         --22   ORIGINAL_REF_NO
trim(A.PRODUCT_CODE)  PRODUCT_CODE,         --23   PRODUCT_CODE
trim(A.RESIDUAL_VALUE)  RESIDUAL_VALUE,         --24   RESIDUAL_VALUE
trim(A.SERIAL_NO)  SERIAL_NO,         --25   SERIAL_NO
trim(A.SETTLEMENT_STATUS)  SETTLEMENT_STATUS,         --26   SETTLEMENT_STATUS
trim(A.SOURCE_CODE)  SOURCE_CODE,         --27   SOURCE_CODE
trim(A.SOURCE_SEQ_NO)  SOURCE_SEQ_NO,         --28   SOURCE_SEQ_NO
trim(A.STATUS)  STATUS,         --29   STATUS
trim(A.SUBSYSTEM_STAT)  SUBSYSTEM_STAT,         --30   SUBSYSTEM_STAT
trim(A.SUSPEND_DEPRECIATION)  SUSPEND_DEPRECIATION,         --31   SUSPEND_DEPRECIATION
to_date((A.SUSPENSION_DATE),'rrrr/mm/dd')  SUSPENSION_DATE,         --32   SUSPENSION_DATE
trim(A.UPLOAD_ID)  UPLOAD_ID,         --33   UPLOAD_ID
trim(A.UPLOAD_STATUS)  UPLOAD_STATUS,         --34   UPLOAD_STATUS
trim(A.USEFUL_LIFE)  USEFUL_LIFE,         --35   USEFUL_LIFE
trim(A.USEFUL_LIFE_UNIT)  USEFUL_LIFE_UNIT,         --36   USEFUL_LIFE_UNIT
trim(A.USER_REF_NO)  USER_REF_NO,         --37   USER_REF_NO
trim(A.VERSION_NO)  VERSION_NO          --38   VERSION_NO
from  FATB_CONTRACT_MASTER_UPLOAD@to_dtn A;
---------------------------------------------------------------------------------------------


insert into FATB_ASSET_ITEMS_UPLOAD (
ACTION_CODE,         --1   ACTION_CODE
BRANCH_CODE,         --2   BRANCH_CODE
DELIVERED,         --3   DELIVERED
DESCRIPTION,         --4   DESCRIPTION
EXPECTED_DELIVERY_DATE,         --5   EXPECTED_DELIVERY_DATE
EXTERNAL_REF_NO,         --6   EXTERNAL_REF_NO
FUNCTION_ID,         --7   FUNCTION_ID
INSPECTED,         --8   INSPECTED
ITEM_COST,         --9   ITEM_COST
ITEM_IDENTIFICATION_NO,         --10   ITEM_IDENTIFICATION_NO
REMARKS,         --11   REMARKS
SOURCE_CODE,         --12   SOURCE_CODE
SOURCE_SEQ_NO,         --13   SOURCE_SEQ_NO
UPLOAD_ID)         --14   UPLOAD_ID


select 
trim(A.ACTION_CODE)  ACTION_CODE,         --1   ACTION_CODE
trim(A.BRANCH_CODE)  BRANCH_CODE,         --2   BRANCH_CODE
trim(A.DELIVERED)  DELIVERED,         --3   DELIVERED
trim(SUBSTR(A.DESCRIPTION,1,35))  DESCRIPTION,         --4   DESCRIPTION
to_date((A.EXPECTED_DELIVERY_DATE),'rrrr/mm/dd')   EXPECTED_DELIVERY_DATE,         --5   EXPECTED_DELIVERY_DATE
trim(A.EXTERNAL_REF_NO)   EXTERNAL_REF_NO,         --6   EXTERNAL_REF_NO
trim(A.FUNCTION_ID)  FUNCTION_ID,         --7   FUNCTION_ID
trim(A.INSPECTED)  INSPECTED,         --8   INSPECTED
trim(A.ITEM_COST)  ITEM_COST,         --9   ITEM_COST
trim(A.ITEM_IDENTIFICATION_NO)  ITEM_IDENTIFICATION_NO,         --10   ITEM_IDENTIFICATION_NO
trim(A.REMARKS)  REMARKS,         --11   REMARKS
trim(A.SOURCE_CODE)  SOURCE_CODE,         --12   SOURCE_CODE
trim(A.SOURCE_SEQ_NO)  SOURCE_SEQ_NO,         --13   SOURCE_SEQ_NO
trim(A.UPLOAD_ID)  UPLOAD_ID          --14   UPLOAD_ID
from  FATB_ASSET_ITEMS_UPLOAD@to_dtn A;
--FATB_CONTRACT_MASTER_UPLOAD B
--WHERE 1=1
--AND A.SOURCE_SEQ_NO = B.SOURCE_SEQ_NO;



/*
delete from cstb_ext_contract_stat   where source = 'FA_UPD';
truncate table fatb_contract_master_upload;
truncate table fatb_asset_items_upload;

select * from fatb_asset_items_upload;
select * from fatb_contract_master_upload;


FATB_CONTRACT_MASTER_UPLOAD
select * from cotm_source where SOURCE_CODE = 'FA_UPD';
select * from cotm_source_Pref where MODULE_CODE = 'FA';

*/



create or replace procedure pr_fa_upld(p_brn varchar2) as
  l_upload_id varchar2(100);
  p_err_code  varchar2(100);
  p_err_param varchar2(100);
begin
  --global.pr_init(p_brn, 'ADMINUSER2');
  global.pr_init(p_brn, 'MIG_USER02');  
  debug.pr_debug('FA', 'Flexcube uplaod');
  --global.set_conversion_run('Y');
  --global.set_conversion_gl('299905000'); --use migration gl accordingly
  --global.pr_init(i.branch, 'ADMINUSER4');
  global.set_conversion_run('Y');


 --select * from fatb_contract_master_upload;
 
   for i in (select source_code,
                     branch_code,--branch
                     EXTERNAL_REF_NO,--ext_contract_ref_no,
                     function_id,
                     action_code,
                     source_seq_no
                from fatb_contract_master_upload
               where source_code = 'FA_UPD'
                --and  external_ref_no = '2'--p_source
                 --and branch_code = p_brn--nvl(p_brn, branch)
                 --and ext_contract_ref_no = nvl(p_cont, ext_contract_ref_no)
                 and upload_status = 'U') loop

        if not GWPKS_UPLOADFACONTRACT.fn_upload(i.source_code,
                                                i.function_id,
                                                i.action_code,
                                                l_upload_id,
                                                p_err_code,
                                                p_err_param,
                                                i.external_ref_no) then
          debug.pr_debug('FA','failed:' || i.external_ref_no || '~' ||p_err_code);
                         dbms_output.put_line('FAIL');
        else
          dbms_output.put_line('SUCC');
          debug.pr_debug('FA', 'success:' || i.external_ref_no);
       end if;
 

    end loop;
COMMIT;
end;



set serveroutput OFF;
execute pr_fa_upld('000');



select 'execute pr_fa_upld('''||a.BRANCH_CODE||''');' from (select distinct branch_code branch_code from cstb_ext_contract_stat where module = 'FA') a;