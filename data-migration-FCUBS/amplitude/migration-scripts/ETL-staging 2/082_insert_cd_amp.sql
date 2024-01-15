create or replace procedure insert_cd_amp as 
a number;
sys_date date;
maker_idd varchar2(50);
checker_idd varchar2(50);
in_source_code varchar2(100);


begin

maker_idd:='MIG_USER01';
checker_idd:='MIG_USER02';
in_source_code := 'CD_UPLOAD';
select today into sys_date from sttm_dates where branch_code ='000';

---XXX1
dbms_output.put_line('---populating ldtb_upload_master : starting');
for i in (
select 
trim(action_code)  action_code,         --1   ACTION_CODE
trim(action_flag)  action_flag,         --2   ACTION_FLAG
trim(allow_prepay)  allow_prepay,         --3   ALLOW_PREPAY
trim(amortisation_type)  amortisation_type,         --4   AMORTISATION_TYPE
trim(amount)  amount,         --5   AMOUNT
trim(annuity_loan)  annuity_loan,         --6   ANNUITY_LOAN
trim(apply_charge)  apply_charge,         --7   APPLY_CHARGE
trim(apply_contract_hol_ccy)  apply_contract_hol_ccy,         --8   APPLY_CONTRACT_HOL_CCY
trim(apply_facility_hol_ccy)  apply_facility_hol_ccy,         --9   APPLY_FACILITY_HOL_CCY
trim(apply_local_hol_ccy)  apply_local_hol_ccy,         --10   APPLY_LOCAL_HOL_CCY
trim(apply_tax_on_rollover)  apply_tax_on_rollover,         --11   APPLY_TAX_ON_ROLLOVER
trim(assigned_contract)  assigned_contract,         --12   ASSIGNED_CONTRACT
trim(auto_create_cr_acc)  auto_create_cr_acc,         --13   AUTO_CREATE_CR_ACC
trim(auto_create_dr_acc)  auto_create_dr_acc,         --14   AUTO_CREATE_DR_ACC
trim(auto_prov_reqd)  auto_prov_reqd,         --15   AUTO_PROV_REQD
to_date('31/07/2022', 'dd/mm/rrrr')   booking_date,         --16   BOOKING_DATE
trim(branch)  branch,         --17   BRANCH
trim(broker_amt)  broker_amt,         --18   BROKER_AMT
trim(broker_ccy)  broker_ccy,         --19   BROKER_CCY
trim(broker_code)  broker_code,         --20   BROKER_CODE
trim(broker_confirm_status)  broker_confirm_status,         --21   BROKER_CONFIRM_STATUS
trim(cascade_schedules)  cascade_schedules,         --22   CASCADE_SCHEDULES
trim(ccy_decimals)  ccy_decimals,         --23   CCY_DECIMALS
trim(ccy_round_rule)  ccy_round_rule,         --24   CCY_ROUND_RULE
trim(ccy_round_unit)  ccy_round_unit,         --25   CCY_ROUND_UNIT
trim(chk_rate_code_ccy)  chk_rate_code_ccy,         --26   CHK_RATE_CODE_CCY
trim(cluster_id)  cluster_id,         --27   CLUSTER_ID
trim(cluster_size)  cluster_size,         --28   CLUSTER_SIZE
trim(consider_branch_holiday)  consider_branch_holiday,         --29   CONSIDER_BRANCH_HOLIDAY
trim(contract_ref_no)  contract_ref_no,         --30   CONTRACT_REF_NO
trim(contract_schedule_type)  contract_schedule_type,         --31   CONTRACT_SCHEDULE_TYPE
(select customer_no from sttm_customer where ext_ref_no = trim(counterparty)) counterparty,        --32   COUNTERPARTY
trim(cparty_confirm_status)  cparty_confirm_status,         --33   CPARTY_CONFIRM_STATUS
trim(credit_line)  credit_line,         --34   CREDIT_LINE
trim(currency)  currency,         --35   CURRENCY
null  cust_margin,         --36   CUST_MARGIN
trim(dealer)  dealer,         --37   DEALER
trim(dealing_method)  dealing_method,         --38   DEALING_METHOD
trim(deal_date)  deal_date,         --39   DEAL_DATE
trim(deduct_tax_on_capitalisation)  deduct_tax_on_capitalisation,         --40   DEDUCT_TAX_ON_CAPITALISATION
trim(demand_basis)  demand_basis,         --41   DEMAND_BASIS
(select cust_ac_no from sttm_cust_account where trim(alt_ac_no) =  trim(dflt_settle_ac)) dflt_settle_ac,         --42   DFLT_SETTLE_AC
trim(dflt_settle_ac_branch)  dflt_settle_ac_branch,         --43   DFLT_SETTLE_AC_BRANCH
trim(dflt_settle_ccy)  dflt_settle_ccy,         --44   DFLT_SETTLE_CCY
trim(differential_amount)  differential_amount,         --45   DIFFERENTIAL_AMOUNT
trim(drawdown_no)  drawdown_no,         --46   DRAWDOWN_NO
(select cust_ac_no from sttm_cust_account where trim(alt_ac_no) =  trim(dr_setl_ac))  dr_setl_ac,        --47   DR_SETL_AC
trim(dr_setl_ac_br)  dr_setl_ac_br,         --48   DR_SETL_AC_BR
trim(dr_setl_ccy)  dr_setl_ccy,         --49   DR_SETL_CCY
trim(event_seq_no)  event_seq_no,         --50   EVENT_SEQ_NO
trim(exposure_category)  exposure_category,         --51   EXPOSURE_CATEGORY
trim(ext_contract_ref_no)  ext_contract_ref_no,         --52   EXT_CONTRACT_REF_NO
'CDDTRONL'  function_id,         --53   FUNCTION_ID
trim(funding_method)  funding_method,         --54   FUNDING_METHOD
null  fund_id,         --55   FUND_ID
trim(holiday_ccy)  holiday_ccy,         --56   HOLIDAY_CCY
trim(holiday_months)  holiday_months,         --57   HOLIDAY_MONTHS
trim(holiday_months_flag)  holiday_months_flag,         --58   HOLIDAY_MONTHS_FLAG
trim(ignore_holidays)  ignore_holidays,         --59   IGNORE_HOLIDAYS
trim(interface_ref_no)  interface_ref_no,         --60   INTERFACE_REF_NO
trim(int_period_basis)  int_period_basis,         --61   INT_PERIOD_BASIS
null  last_sanction_date,         --62   LAST_SANCTION_DATE
trim(liquidate_od_schedules)  liquidate_od_schedules,         --63   LIQUIDATE_OD_SCHEDULES
trim(liq_back_valued_schedules)  liq_back_valued_schedules,         --64   LIQ_BACK_VALUED_SCHEDULES
trim(loan_stmt_cycle)  loan_stmt_cycle,         --65   LOAN_STMT_CYCLE
trim(loan_stmt_type)  loan_stmt_type,         --66   LOAN_STMT_TYPE
null  margin,         --67   MARGIN
to_date(trim(maturity_date), 'dd/mm/rrrr')   maturity_date,         --68   MATURITY_DATE
trim(maturity_type)  maturity_type,         --69   MATURITY_TYPE
trim(max_drawdown_amount)  max_drawdown_amount,         --70   MAX_DRAWDOWN_AMOUNT
null  max_rate,         --71   MAX_RATE
null  max_spread,         --72   MAX_SPREAD
null  min_rate,         --73   MIN_RATE
null  min_spread,         --74   MIN_SPREAD
trim(module)  module,         --75   MODULE
trim(move_across_month)  move_across_month,         --76   MOVE_ACROSS_MONTH
trim(move_comm_redn_sch)  move_comm_redn_sch,         --77   MOVE_COMM_REDN_SCH
trim(move_disburse_sch)  move_disburse_sch,         --78   MOVE_DISBURSE_SCH
trim(move_payment_sch)  move_payment_sch,         --79   MOVE_PAYMENT_SCH
trim(move_revision_sch)  move_revision_sch,         --80   MOVE_REVISION_SCH
trim(multiple_cif)  multiple_cif,         --81   MULTIPLE_CIF
trim(m_sch_apply_contract_hol_ccy)  m_sch_apply_contract_hol_ccy,         --82   M_SCH_APPLY_CONTRACT_HOL_CCY
trim(m_sch_apply_facility_hol_ccy)  m_sch_apply_facility_hol_ccy,         --83   M_SCH_APPLY_FACILITY_HOL_CCY
trim(m_sch_apply_local_hol_ccy)  m_sch_apply_local_hol_ccy,         --84   M_SCH_APPLY_LOCAL_HOL_CCY
trim(m_sch_ignore_holidays)  m_sch_ignore_holidays,         --85   M_SCH_IGNORE_HOLIDAYS
trim(m_sch_move_across_month)  m_sch_move_across_month,         --86   M_SCH_MOVE_ACROSS_MONTH
trim(m_sch_schedule_movement)  m_sch_schedule_movement,         --87   M_SCH_SCHEDULE_MOVEMENT
null  net_negative_interest,         --88   NET_NEGATIVE_INTEREST
trim(new_components_allowed)  new_components_allowed,         --89   NEW_COMPONENTS_ALLOWED
trim(notc_reqd)  notc_reqd,         --90   NOTC_REQD
trim(notice_days)  notice_days,         --91   NOTICE_DAYS
trim(offset_no)  offset_no,         --92   OFFSET_NO
to_date(trim(original_start_date), 'dd/mm/rrrr')  original_start_date,         --93   ORIGINAL_START_DATE
trim(parent_contract_ref_no)  parent_contract_ref_no,         --94   PARENT_CONTRACT_REF_NO
trim(parent_ext_contract_ref_no)  parent_ext_contract_ref_no,         --95   PARENT_EXT_CONTRACT_REF_NO
null  partial_closure,         --96   PARTIAL_CLOSURE
trim(partial_payment_mliq)  partial_payment_mliq,         --97   PARTIAL_PAYMENT_MLIQ
trim(payind)  payind,         --98   PAYIND
'B' payment_method,--trim(payment_method)  payment_method,         --99   PAYMENT_METHOD
trim(pay_to)  pay_to,         --100   PAY_TO
trim(pay_to_acc)  pay_to_acc,         --101   PAY_TO_ACC
trim(principal_liquidation)  principal_liquidation,         --102   PRINCIPAL_LIQUIDATION
trim(process_id)  process_id,         --103   PROCESS_ID
trim(product)  product,         --104   PRODUCT
null  product_type,         --105   PRODUCT_TYPE
trim(prov_ccy_type)  prov_ccy_type,         --106   PROV_CCY_TYPE
null  rate_type,         --107   RATE_TYPE
trim(recind)  recind,         --108   RECIND
trim(ref_rate)  ref_rate,         --109   REF_RATE
null  rej_reason,         --110   REJ_REASON
trim(rel_reference)  rel_reference,         --111   REL_REFERENCE
trim(remarks)  remarks,         --112   REMARKS
trim(revolving_commitment)  revolving_commitment,         --113   REVOLVING_COMMITMENT
trim(risk_free_exp_amount)  risk_free_exp_amount,         --114   RISK_FREE_EXP_AMOUNT
'N' rollover_allowed,--trim(rollover_allowed)  rollover_allowed,         --115   ROLLOVER_ALLOWED
trim(rollover_amount_type)  rollover_amount_type,         --116   ROLLOVER_AMOUNT_TYPE
trim(rollover_amt)  rollover_amt,         --117   ROLLOVER_AMT
trim(rollover_iccf_from)  rollover_iccf_from,         --118   ROLLOVER_ICCF_FROM
trim(rollover_maturity_date)  rollover_maturity_date,         --119   ROLLOVER_MATURITY_DATE
trim(rollover_maturity_days)  rollover_maturity_days,         --120   ROLLOVER_MATURITY_DAYS
trim(rollover_maturity_type)  rollover_maturity_type,         --121   ROLLOVER_MATURITY_TYPE
trim(rollover_mechanism)  rollover_mechanism,         --122   ROLLOVER_MECHANISM
trim(rollover_method)  rollover_method,         --123   ROLLOVER_METHOD
trim(rollover_notice_days)  rollover_notice_days,         --124   ROLLOVER_NOTICE_DAYS
trim(rollover_type)  rollover_type,         --125   ROLLOVER_TYPE
trim(roll_by)  roll_by,         --126   ROLL_BY
trim(roll_reset_tenor)  roll_reset_tenor,         --127   ROLL_RESET_TENOR
trim(rounding_reqd)  rounding_reqd,         --128   ROUNDING_REQD
null  sanction_status,         --129   SANCTION_STATUS
trim(schedule_definition_basis)  schedule_definition_basis,         --130   SCHEDULE_DEFINITION_BASIS
trim(schedule_movement)  schedule_movement,         --131   SCHEDULE_MOVEMENT
trim(sgen_reqd)  sgen_reqd,         --132   SGEN_REQD
trim(source_code)  source_code,         --133   SOURCE_CODE
trim(source_seq_no)  source_seq_no,         --134   SOURCE_SEQ_NO
trim(statement_day)  statement_day,         --135   STATEMENT_DAY
trim(status_control)  status_control,         --136   STATUS_CONTROL
trim(subsidy_allowed)  subsidy_allowed,         --137   SUBSIDY_ALLOWED
trim(subsystem_stat)  subsystem_stat,         --138   SUBSYSTEM_STAT
trim(syndication_ref_no)  syndication_ref_no,         --139   SYNDICATION_REF_NO
decode(trim(product),'FCFY','WTH_TX','FCLY','WTH_TX', null)  tax_scheme,         --140   TAX_SCHEME
trim(track_receivable_aliq)  track_receivable_aliq,         --141   TRACK_RECEIVABLE_ALIQ
trim(track_receivable_mliq)  track_receivable_mliq,         --142   TRACK_RECEIVABLE_MLIQ
null  trade_date,         --143   TRADE_DATE
trim(tranche_ref_no)  tranche_ref_no,         --144   TRANCHE_REF_NO
trim(treat_spl_amt_as)  treat_spl_amt_as,         --145   TREAT_SPL_AMT_AS
trim(update_utilisation_on_rollover)  update_utilisation_on_rollover,         --146   UPDATE_UTILISATION_ON_ROLLOVER
trim(upload_id)  upload_id,         --147   UPLOAD_ID
trim(upload_status)  upload_status,         --148   UPLOAD_STATUS
trim(user_defined_sched)  user_defined_sched,         --149   USER_DEFINED_SCHED
trim(user_defined_status)  user_defined_status,         --150   USER_DEFINED_STATUS
trim(user_input_maturity_date)  user_input_maturity_date,         --151   USER_INPUT_MATURITY_DATE
trim(ext_contract_ref_no)   user_ref_no,         --152   USER_REF_NO
to_date(trim(value_date), 'dd/mm/rrrr')  value_date,         --153   VALUE_DATE
trim(verify_funds)  verify_funds,         --154   VERIFY_FUNDS
trim(verify_funds_for_interest)  verify_funds_for_interest,         --155   VERIFY_FUNDS_FOR_INTEREST
trim(verify_funds_for_penaltyamt)  verify_funds_for_penaltyamt,         --156   VERIFY_FUNDS_FOR_PENALTYAMT
trim(verify_funds_for_principal)  verify_funds_for_principal,         --157   VERIFY_FUNDS_FOR_PRINCIPAL
trim(version_no)  version_no,         --158   VERSION_NO
trim(workflow_status)  workflow_status          --159   WORKFLOW_STATUS
from  ldtb_upload_master@ampdblink
where 1=1
and trim(ext_contract_ref_no) not  in (select nvl(trim(USER_REF_NO),'xxx') from  ldtb_contract_master)
--select * from ldtb_upload_master@ampdblink
--select * from ldtb_upload_master@to_dtn
)
loop
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
begin
insert into ldtb_upload_master (
action_code,         --1   ACTION_CODE
action_flag,         --2   ACTION_FLAG
allow_prepay,         --3   ALLOW_PREPAY
amortisation_type,         --4   AMORTISATION_TYPE
amount,         --5   AMOUNT
annuity_loan,         --6   ANNUITY_LOAN
apply_charge,         --7   APPLY_CHARGE
apply_contract_hol_ccy,         --8   APPLY_CONTRACT_HOL_CCY
apply_facility_hol_ccy,         --9   APPLY_FACILITY_HOL_CCY
apply_local_hol_ccy,         --10   APPLY_LOCAL_HOL_CCY
apply_tax_on_rollover,         --11   APPLY_TAX_ON_ROLLOVER
assigned_contract,         --12   ASSIGNED_CONTRACT
auto_create_cr_acc,         --13   AUTO_CREATE_CR_ACC
auto_create_dr_acc,         --14   AUTO_CREATE_DR_ACC
auto_prov_reqd,         --15   AUTO_PROV_REQD
booking_date,         --16   BOOKING_DATE
branch,         --17   BRANCH
broker_amt,         --18   BROKER_AMT
broker_ccy,         --19   BROKER_CCY
broker_code,         --20   BROKER_CODE
broker_confirm_status,         --21   BROKER_CONFIRM_STATUS
cascade_schedules,         --22   CASCADE_SCHEDULES
ccy_decimals,         --23   CCY_DECIMALS
ccy_round_rule,         --24   CCY_ROUND_RULE
ccy_round_unit,         --25   CCY_ROUND_UNIT
chk_rate_code_ccy,         --26   CHK_RATE_CODE_CCY
cluster_id,         --27   CLUSTER_ID
cluster_size,         --28   CLUSTER_SIZE
consider_branch_holiday,         --29   CONSIDER_BRANCH_HOLIDAY
contract_ref_no,         --30   CONTRACT_REF_NO
contract_schedule_type,         --31   CONTRACT_SCHEDULE_TYPE
counterparty,         --32   COUNTERPARTY
cparty_confirm_status,         --33   CPARTY_CONFIRM_STATUS
credit_line,         --34   CREDIT_LINE
currency,         --35   CURRENCY
cust_margin,         --36   CUST_MARGIN
dealer,         --37   DEALER
dealing_method,         --38   DEALING_METHOD
deal_date,         --39   DEAL_DATE
deduct_tax_on_capitalisation,         --40   DEDUCT_TAX_ON_CAPITALISATION
demand_basis,         --41   DEMAND_BASIS
dflt_settle_ac,         --42   DFLT_SETTLE_AC
dflt_settle_ac_branch,         --43   DFLT_SETTLE_AC_BRANCH
dflt_settle_ccy,         --44   DFLT_SETTLE_CCY
differential_amount,         --45   DIFFERENTIAL_AMOUNT
drawdown_no,         --46   DRAWDOWN_NO
dr_setl_ac,         --47   DR_SETL_AC
dr_setl_ac_br,         --48   DR_SETL_AC_BR
dr_setl_ccy,         --49   DR_SETL_CCY
event_seq_no,         --50   EVENT_SEQ_NO
exposure_category,         --51   EXPOSURE_CATEGORY
ext_contract_ref_no,         --52   EXT_CONTRACT_REF_NO
function_id,         --53   FUNCTION_ID
funding_method,         --54   FUNDING_METHOD
fund_id,         --55   FUND_ID
holiday_ccy,         --56   HOLIDAY_CCY
holiday_months,         --57   HOLIDAY_MONTHS
holiday_months_flag,         --58   HOLIDAY_MONTHS_FLAG
ignore_holidays,         --59   IGNORE_HOLIDAYS
interface_ref_no,         --60   INTERFACE_REF_NO
int_period_basis,         --61   INT_PERIOD_BASIS
last_sanction_date,         --62   LAST_SANCTION_DATE
liquidate_od_schedules,         --63   LIQUIDATE_OD_SCHEDULES
liq_back_valued_schedules,         --64   LIQ_BACK_VALUED_SCHEDULES
loan_stmt_cycle,         --65   LOAN_STMT_CYCLE
loan_stmt_type,         --66   LOAN_STMT_TYPE
margin,         --67   MARGIN
maturity_date,         --68   MATURITY_DATE
maturity_type,         --69   MATURITY_TYPE
max_drawdown_amount,         --70   MAX_DRAWDOWN_AMOUNT
max_rate,         --71   MAX_RATE
max_spread,         --72   MAX_SPREAD
min_rate,         --73   MIN_RATE
min_spread,         --74   MIN_SPREAD
module,         --75   MODULE
move_across_month,         --76   MOVE_ACROSS_MONTH
move_comm_redn_sch,         --77   MOVE_COMM_REDN_SCH
move_disburse_sch,         --78   MOVE_DISBURSE_SCH
move_payment_sch,         --79   MOVE_PAYMENT_SCH
move_revision_sch,         --80   MOVE_REVISION_SCH
multiple_cif,         --81   MULTIPLE_CIF
m_sch_apply_contract_hol_ccy,         --82   M_SCH_APPLY_CONTRACT_HOL_CCY
m_sch_apply_facility_hol_ccy,         --83   M_SCH_APPLY_FACILITY_HOL_CCY
m_sch_apply_local_hol_ccy,         --84   M_SCH_APPLY_LOCAL_HOL_CCY
m_sch_ignore_holidays,         --85   M_SCH_IGNORE_HOLIDAYS
m_sch_move_across_month,         --86   M_SCH_MOVE_ACROSS_MONTH
m_sch_schedule_movement,         --87   M_SCH_SCHEDULE_MOVEMENT
net_negative_interest,         --88   NET_NEGATIVE_INTEREST
new_components_allowed,         --89   NEW_COMPONENTS_ALLOWED
notc_reqd,         --90   NOTC_REQD
notice_days,         --91   NOTICE_DAYS
offset_no,         --92   OFFSET_NO
original_start_date,         --93   ORIGINAL_START_DATE
parent_contract_ref_no,         --94   PARENT_CONTRACT_REF_NO
parent_ext_contract_ref_no,         --95   PARENT_EXT_CONTRACT_REF_NO
partial_closure,         --96   PARTIAL_CLOSURE
partial_payment_mliq,         --97   PARTIAL_PAYMENT_MLIQ
payind,         --98   PAYIND
payment_method,         --99   PAYMENT_METHOD
pay_to,         --100   PAY_TO
pay_to_acc,         --101   PAY_TO_ACC
principal_liquidation,         --102   PRINCIPAL_LIQUIDATION
process_id,         --103   PROCESS_ID
product,         --104   PRODUCT
product_type,         --105   PRODUCT_TYPE
prov_ccy_type,         --106   PROV_CCY_TYPE
rate_type,         --107   RATE_TYPE
recind,         --108   RECIND
ref_rate,         --109   REF_RATE
rej_reason,         --110   REJ_REASON
rel_reference,         --111   REL_REFERENCE
remarks,         --112   REMARKS
revolving_commitment,         --113   REVOLVING_COMMITMENT
risk_free_exp_amount,         --114   RISK_FREE_EXP_AMOUNT
rollover_allowed,         --115   ROLLOVER_ALLOWED
rollover_amount_type,         --116   ROLLOVER_AMOUNT_TYPE
rollover_amt,         --117   ROLLOVER_AMT
rollover_iccf_from,         --118   ROLLOVER_ICCF_FROM
rollover_maturity_date,         --119   ROLLOVER_MATURITY_DATE
rollover_maturity_days,         --120   ROLLOVER_MATURITY_DAYS
rollover_maturity_type,         --121   ROLLOVER_MATURITY_TYPE
rollover_mechanism,         --122   ROLLOVER_MECHANISM
rollover_method,         --123   ROLLOVER_METHOD
rollover_notice_days,         --124   ROLLOVER_NOTICE_DAYS
rollover_type,         --125   ROLLOVER_TYPE
roll_by,         --126   ROLL_BY
roll_reset_tenor,         --127   ROLL_RESET_TENOR
rounding_reqd,         --128   ROUNDING_REQD
sanction_status,         --129   SANCTION_STATUS
schedule_definition_basis,         --130   SCHEDULE_DEFINITION_BASIS
schedule_movement,         --131   SCHEDULE_MOVEMENT
sgen_reqd,         --132   SGEN_REQD
source_code,         --133   SOURCE_CODE
source_seq_no,         --134   SOURCE_SEQ_NO
statement_day,         --135   STATEMENT_DAY
status_control,         --136   STATUS_CONTROL
subsidy_allowed,         --137   SUBSIDY_ALLOWED
subsystem_stat,         --138   SUBSYSTEM_STAT
syndication_ref_no,         --139   SYNDICATION_REF_NO
tax_scheme,         --140   TAX_SCHEME
track_receivable_aliq,         --141   TRACK_RECEIVABLE_ALIQ
track_receivable_mliq,         --142   TRACK_RECEIVABLE_MLIQ
trade_date,         --143   TRADE_DATE
tranche_ref_no,         --144   TRANCHE_REF_NO
treat_spl_amt_as,         --145   TREAT_SPL_AMT_AS
update_utilisation_on_rollover,         --146   UPDATE_UTILISATION_ON_ROLLOVER
upload_id,         --147   UPLOAD_ID
upload_status,         --148   UPLOAD_STATUS
user_defined_sched,         --149   USER_DEFINED_SCHED
user_defined_status,         --150   USER_DEFINED_STATUS
user_input_maturity_date,         --151   USER_INPUT_MATURITY_DATE
user_ref_no,         --152   USER_REF_NO
value_date,         --153   VALUE_DATE
verify_funds,         --154   VERIFY_FUNDS
verify_funds_for_interest,         --155   VERIFY_FUNDS_FOR_INTEREST
verify_funds_for_penaltyamt,         --156   VERIFY_FUNDS_FOR_PENALTYAMT
verify_funds_for_principal,         --157   VERIFY_FUNDS_FOR_PRINCIPAL
version_no,         --158   VERSION_NO
workflow_status)         --159   WORKFLOW_STATUS

values(
i.action_code,         --1   ACTION_CODE
i.action_flag,         --2   ACTION_FLAG
i.allow_prepay,         --3   ALLOW_PREPAY
i.amortisation_type,         --4   AMORTISATION_TYPE
i.amount,         --5   AMOUNT
i.annuity_loan,         --6   ANNUITY_LOAN
i.apply_charge,         --7   APPLY_CHARGE
i.apply_contract_hol_ccy,         --8   APPLY_CONTRACT_HOL_CCY
i.apply_facility_hol_ccy,         --9   APPLY_FACILITY_HOL_CCY
i.apply_local_hol_ccy,         --10   APPLY_LOCAL_HOL_CCY
i.apply_tax_on_rollover,         --11   APPLY_TAX_ON_ROLLOVER
i.assigned_contract,         --12   ASSIGNED_CONTRACT
i.auto_create_cr_acc,         --13   AUTO_CREATE_CR_ACC
i.auto_create_dr_acc,         --14   AUTO_CREATE_DR_ACC
i.auto_prov_reqd,         --15   AUTO_PROV_REQD
i.booking_date,         --16   BOOKING_DATE
i.branch,         --17   BRANCH
i.broker_amt,         --18   BROKER_AMT
i.broker_ccy,         --19   BROKER_CCY
i.broker_code,         --20   BROKER_CODE
i.broker_confirm_status,         --21   BROKER_CONFIRM_STATUS
i.cascade_schedules,         --22   CASCADE_SCHEDULES
i.ccy_decimals,         --23   CCY_DECIMALS
i.ccy_round_rule,         --24   CCY_ROUND_RULE
i.ccy_round_unit,         --25   CCY_ROUND_UNIT
i.chk_rate_code_ccy,         --26   CHK_RATE_CODE_CCY
i.cluster_id,         --27   CLUSTER_ID
i.cluster_size,         --28   CLUSTER_SIZE
i.consider_branch_holiday,         --29   CONSIDER_BRANCH_HOLIDAY
i.contract_ref_no,         --30   CONTRACT_REF_NO
i.contract_schedule_type,         --31   CONTRACT_SCHEDULE_TYPE
i.counterparty,         --32   COUNTERPARTY
i.cparty_confirm_status,         --33   CPARTY_CONFIRM_STATUS
i.credit_line,         --34   CREDIT_LINE
i.currency,         --35   CURRENCY
i.cust_margin,         --36   CUST_MARGIN
i.dealer,         --37   DEALER
i.dealing_method,         --38   DEALING_METHOD
i.deal_date,         --39   DEAL_DATE
i.deduct_tax_on_capitalisation,         --40   DEDUCT_TAX_ON_CAPITALISATION
i.demand_basis,         --41   DEMAND_BASIS
i.dflt_settle_ac,         --42   DFLT_SETTLE_AC
i.dflt_settle_ac_branch,         --43   DFLT_SETTLE_AC_BRANCH
i.dflt_settle_ccy,         --44   DFLT_SETTLE_CCY
i.differential_amount,         --45   DIFFERENTIAL_AMOUNT
i.drawdown_no,         --46   DRAWDOWN_NO
i.dr_setl_ac,         --47   DR_SETL_AC
i.dr_setl_ac_br,         --48   DR_SETL_AC_BR
i.dr_setl_ccy,         --49   DR_SETL_CCY
i.event_seq_no,         --50   EVENT_SEQ_NO
i.exposure_category,         --51   EXPOSURE_CATEGORY
i.ext_contract_ref_no,         --52   EXT_CONTRACT_REF_NO
'CDDTRONL',--i.function_id,         --53   FUNCTION_ID
i.funding_method,         --54   FUNDING_METHOD
i.fund_id,         --55   FUND_ID
i.holiday_ccy,         --56   HOLIDAY_CCY
i.holiday_months,         --57   HOLIDAY_MONTHS
i.holiday_months_flag,         --58   HOLIDAY_MONTHS_FLAG
i.ignore_holidays,         --59   IGNORE_HOLIDAYS
i.interface_ref_no,         --60   INTERFACE_REF_NO
i.int_period_basis,         --61   INT_PERIOD_BASIS
i.last_sanction_date,         --62   LAST_SANCTION_DATE
i.liquidate_od_schedules,         --63   LIQUIDATE_OD_SCHEDULES
i.liq_back_valued_schedules,         --64   LIQ_BACK_VALUED_SCHEDULES
i.loan_stmt_cycle,         --65   LOAN_STMT_CYCLE
i.loan_stmt_type,         --66   LOAN_STMT_TYPE
i.margin,         --67   MARGIN
i.maturity_date,         --68   MATURITY_DATE
i.maturity_type,         --69   MATURITY_TYPE
i.max_drawdown_amount,         --70   MAX_DRAWDOWN_AMOUNT
i.max_rate,         --71   MAX_RATE
i.max_spread,         --72   MAX_SPREAD
i.min_rate,         --73   MIN_RATE
i.min_spread,         --74   MIN_SPREAD
i.module,         --75   MODULE
i.move_across_month,         --76   MOVE_ACROSS_MONTH
i.move_comm_redn_sch,         --77   MOVE_COMM_REDN_SCH
i.move_disburse_sch,         --78   MOVE_DISBURSE_SCH
i.move_payment_sch,         --79   MOVE_PAYMENT_SCH
i.move_revision_sch,         --80   MOVE_REVISION_SCH
i.multiple_cif,         --81   MULTIPLE_CIF
i.m_sch_apply_contract_hol_ccy,         --82   M_SCH_APPLY_CONTRACT_HOL_CCY
i.m_sch_apply_facility_hol_ccy,         --83   M_SCH_APPLY_FACILITY_HOL_CCY
i.m_sch_apply_local_hol_ccy,         --84   M_SCH_APPLY_LOCAL_HOL_CCY
i.m_sch_ignore_holidays,         --85   M_SCH_IGNORE_HOLIDAYS
i.m_sch_move_across_month,         --86   M_SCH_MOVE_ACROSS_MONTH
i.m_sch_schedule_movement,         --87   M_SCH_SCHEDULE_MOVEMENT
i.net_negative_interest,         --88   NET_NEGATIVE_INTEREST
i.new_components_allowed,         --89   NEW_COMPONENTS_ALLOWED
i.notc_reqd,         --90   NOTC_REQD
i.notice_days,         --91   NOTICE_DAYS
i.offset_no,         --92   OFFSET_NO
i.original_start_date,         --93   ORIGINAL_START_DATE
i.parent_contract_ref_no,         --94   PARENT_CONTRACT_REF_NO
i.parent_ext_contract_ref_no,         --95   PARENT_EXT_CONTRACT_REF_NO
i.partial_closure,         --96   PARTIAL_CLOSURE
i.partial_payment_mliq,         --97   PARTIAL_PAYMENT_MLIQ
i.payind,         --98   PAYIND
i.payment_method,         --99   PAYMENT_METHOD
i.pay_to,         --100   PAY_TO
i.pay_to_acc,         --101   PAY_TO_ACC
i.principal_liquidation,         --102   PRINCIPAL_LIQUIDATION
i.process_id,         --103   PROCESS_ID
i.product,         --104   PRODUCT
i.product_type,         --105   PRODUCT_TYPE
i.prov_ccy_type,         --106   PROV_CCY_TYPE
i.rate_type,         --107   RATE_TYPE
i.recind,         --108   RECIND
i.ref_rate,         --109   REF_RATE
i.rej_reason,         --110   REJ_REASON
i.rel_reference,         --111   REL_REFERENCE
i.remarks,         --112   REMARKS
i.revolving_commitment,         --113   REVOLVING_COMMITMENT
i.risk_free_exp_amount,         --114   RISK_FREE_EXP_AMOUNT
i.rollover_allowed,         --115   ROLLOVER_ALLOWED
i.rollover_amount_type,         --116   ROLLOVER_AMOUNT_TYPE
i.rollover_amt,         --117   ROLLOVER_AMT
i.rollover_iccf_from,         --118   ROLLOVER_ICCF_FROM
i.rollover_maturity_date,         --119   ROLLOVER_MATURITY_DATE
i.rollover_maturity_days,         --120   ROLLOVER_MATURITY_DAYS
i.rollover_maturity_type,         --121   ROLLOVER_MATURITY_TYPE
i.rollover_mechanism,         --122   ROLLOVER_MECHANISM
i.rollover_method,         --123   ROLLOVER_METHOD
i.rollover_notice_days,         --124   ROLLOVER_NOTICE_DAYS
i.rollover_type,         --125   ROLLOVER_TYPE
i.roll_by,         --126   ROLL_BY
i.roll_reset_tenor,         --127   ROLL_RESET_TENOR
i.rounding_reqd,         --128   ROUNDING_REQD
i.sanction_status,         --129   SANCTION_STATUS
i.schedule_definition_basis,         --130   SCHEDULE_DEFINITION_BASIS
i.schedule_movement,         --131   SCHEDULE_MOVEMENT
i.sgen_reqd,         --132   SGEN_REQD
in_source_code,         --133   SOURCE_CODE
i.source_seq_no,         --134   SOURCE_SEQ_NO
i.statement_day,         --135   STATEMENT_DAY
i.status_control,         --136   STATUS_CONTROL
i.subsidy_allowed,         --137   SUBSIDY_ALLOWED
i.subsystem_stat,         --138   SUBSYSTEM_STAT
i.syndication_ref_no,         --139   SYNDICATION_REF_NO
i.tax_scheme,         --140   TAX_SCHEME
i.track_receivable_aliq,         --141   TRACK_RECEIVABLE_ALIQ
i.track_receivable_mliq,         --142   TRACK_RECEIVABLE_MLIQ
i.trade_date,         --143   TRADE_DATE
i.tranche_ref_no,         --144   TRANCHE_REF_NO
i.treat_spl_amt_as,         --145   TREAT_SPL_AMT_AS
i.update_utilisation_on_rollover,         --146   UPDATE_UTILISATION_ON_ROLLOVER
i.upload_id,         --147   UPLOAD_ID
i.upload_status,         --148   UPLOAD_STATUS
i.user_defined_sched,         --149   USER_DEFINED_SCHED
i.user_defined_status,         --150   USER_DEFINED_STATUS
i.user_input_maturity_date,         --151   USER_INPUT_MATURITY_DATE
i.user_ref_no,         --152   USER_REF_NO
i.value_date,         --153   VALUE_DATE
i.verify_funds,         --154   VERIFY_FUNDS
i.verify_funds_for_interest,         --155   VERIFY_FUNDS_FOR_INTEREST
i.verify_funds_for_penaltyamt,         --156   VERIFY_FUNDS_FOR_PENALTYAMT
i.verify_funds_for_principal,         --157   VERIFY_FUNDS_FOR_PRINCIPAL
i.version_no,         --158   VERSION_NO
i.workflow_status);         --159   WORKFLOW_STATUS
commit; 

exception
when no_data_found then 
insert into cd_upload_log  values(i.source_seq_no,'LDTB_UPLOAD_MASTER_amp');
commit;

when others then
insert into cd_upload_log  values(i.source_seq_no,'LDTB_UPLOAD_MASTER_amp');
commit;

--select * from cif_upload_log;
--drop table cd_upload_log
--create table cd_upload_log(maint_seq_no varchar(100), table_name varchar(100));  
end;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end loop;

dbms_output.put_line('---populating ldtb_upload_master : completed');





begin
---XXX2
dbms_output.put_line('---populating ldtb_upload_schedules : starting');
for i in ( 
select 
'NEW'  action_code,         --1   ACTION_CODE
trim(amount)  amount,         --2   AMOUNT
trim(branch_code)  branch_code,         --3   BRANCH_CODE
trim(component)  component,         --4   COMPONENT
trim(ext_contract_ref_no)  ext_contract_ref_no,         --5   EXT_CONTRACT_REF_NO
trim(frequency)  frequency,         --6   FREQUENCY
trim(frequency_unit)  frequency_unit,         --7   FREQUENCY_UNIT
'CDDTRONL',--trim(function_id)  function_id,         --8   FUNCTION_ID
trim(no_of_schedules)  no_of_schedules,         --9   NO_OF_SCHEDULES
trim(schedule_type)  schedule_type,         --10   SCHEDULE_TYPE
trim(source_code)  source_code,         --11   SOURCE_CODE
trim(source_seq_no)  source_seq_no,         --12   SOURCE_SEQ_NO
to_date(trim(start_date), 'dd/mm/rrrr')  start_date,         --13   START_DATE
trim(upload_id)  upload_id          --14   UPLOAD_ID
from  ldtb_upload_schedules@ampdblink
where 1=1
--and source_seq_no not in ('31000398','31000339','31000708')
)
loop

begin
insert into ldtb_upload_schedules (
action_code,         --1   ACTION_CODE
amount,         --2   AMOUNT
branch_code,         --3   BRANCH_CODE
component,         --4   COMPONENT
ext_contract_ref_no,         --5   EXT_CONTRACT_REF_NO
frequency,         --6   FREQUENCY
frequency_unit,         --7   FREQUENCY_UNIT
function_id,         --8   FUNCTION_ID
no_of_schedules,         --9   NO_OF_SCHEDULES
schedule_type,         --10   SCHEDULE_TYPE
source_code,         --11   SOURCE_CODE
source_seq_no,         --12   SOURCE_SEQ_NO
start_date,         --13   START_DATE
upload_id)         --14   UPLOAD_ID


values(
i.action_code,         --1   ACTION_CODE
i.amount,         --2   AMOUNT
i.branch_code,         --3   BRANCH_CODE
i.component,         --4   COMPONENT
i.ext_contract_ref_no,         --5   EXT_CONTRACT_REF_NO
i.frequency,         --6   FREQUENCY
i.frequency_unit,         --7   FREQUENCY_UNIT
'CDDTRONL',--i.function_id,         --8   FUNCTION_ID
i.no_of_schedules,         --9   NO_OF_SCHEDULES
i.schedule_type,         --10   SCHEDULE_TYPE
in_source_code,--i.SOURCE_CODE,         --11   SOURCE_CODE
i.source_seq_no,         --12   SOURCE_SEQ_NO
i.start_date,         --13   START_DATE
i.upload_id);          --14   UPLOAD_ID
commit; 

exception
when no_data_found then 
insert into cd_upload_log  values(i.source_seq_no,'LDTB_UPLOAD_SCHEDULES_amp');
commit;

when others then
insert into cd_upload_log  values(i.source_seq_no,'LDTB_UPLOAD_SCHEDULES_amp');
commit;

end;

end loop;
dbms_output.put_line('---populating ldtb_upload_schedules : completed');
end;







begin
---XXX2
dbms_output.put_line('---populating cftb_upload_interest : starting');
for i in ( 
select 
trim(acquired_amount)  acquired_amount,         --1   ACQUIRED_AMOUNT
trim(basis_366)  basis_366,         --2   BASIS_366
trim(borrow_lend_ind)  borrow_lend_ind,         --3   BORROW_LEND_IND
trim(branch_code)  branch_code,         --4   BRANCH_CODE
'CD_MAINCOM'  component,         --5   COMPONENT
trim(conv_status)  conv_status,         --6   CONV_STATUS
trim(cust_margin)  cust_margin,         --7   CUST_MARGIN
trim(denominator_basis)  denominator_basis,         --8   DENOMINATOR_BASIS
trim(disc_accr_applicable)  disc_accr_applicable,         --9   DISC_ACCR_APPLICABLE
trim(err_msg)  err_msg,         --10   ERR_MSG
trim(flat_amount)  flat_amount,         --11   FLAT_AMOUNT
trim(interest_basis)  interest_basis,         --12   INTEREST_BASIS
trim(margin)  margin,         --13   MARGIN
trim(max_rate)  max_rate,         --14   MAX_RATE
trim(min_rate)  min_rate,         --15   MIN_RATE
null  negative_interest_allowed,         --16   NEGATIVE_INTEREST_ALLOWED
trim(no_of_int_period)  no_of_int_period,         --17   NO_OF_INT_PERIOD
trim(no_of_units)  no_of_units,         --18   NO_OF_UNITS
trim(rate)  rate,         --19   RATE
trim(rate_calc_type)  rate_calc_type,         --20   RATE_CALC_TYPE
trim(rate_code)  rate_code,         --21   RATE_CODE
trim(rate_code_usage)  rate_code_usage,         --22   RATE_CODE_USAGE
trim(rate_type)  rate_type,         --23   RATE_TYPE
trim(reset_tenor)  reset_tenor,         --24   RESET_TENOR
trim(source_code)  source_code,         --25   SOURCE_CODE
trim(source_seq_no) source_ref,--trim(source_ref)  source_ref,         --26   SOURCE_REF
trim(source_seq_no)  source_seq_no,         --27   SOURCE_SEQ_NO
trim(spread)  spread,         --28   SPREAD
null  spread_adj,         --29   SPREAD_ADJ
trim(unit)  unit,         --30   UNIT
trim(waiver)  waiver          --31   WAIVER
from  cftb_upload_interest@ampdblink
where 1=1
--and source_seq_no not in ('31000398','31000339','31000708')
)
loop

begin

insert into cftb_upload_interest (
acquired_amount,         --1   ACQUIRED_AMOUNT
basis_366,         --2   BASIS_366
borrow_lend_ind,         --3   BORROW_LEND_IND
branch_code,         --4   BRANCH_CODE
component,         --5   COMPONENT
conv_status,         --6   CONV_STATUS
cust_margin,         --7   CUST_MARGIN
denominator_basis,         --8   DENOMINATOR_BASIS
disc_accr_applicable,         --9   DISC_ACCR_APPLICABLE
err_msg,         --10   ERR_MSG
flat_amount,         --11   FLAT_AMOUNT
interest_basis,         --12   INTEREST_BASIS
margin,         --13   MARGIN
max_rate,         --14   MAX_RATE
min_rate,         --15   MIN_RATE
negative_interest_allowed,         --16   NEGATIVE_INTEREST_ALLOWED
no_of_int_period,         --17   NO_OF_INT_PERIOD
no_of_units,         --18   NO_OF_UNITS
rate,         --19   RATE
rate_calc_type,         --20   RATE_CALC_TYPE
rate_code,         --21   RATE_CODE
rate_code_usage,         --22   RATE_CODE_USAGE
rate_type,         --23   RATE_TYPE
reset_tenor,         --24   RESET_TENOR
source_code,         --25   SOURCE_CODE
source_ref,         --26   SOURCE_REF
source_seq_no,         --27   SOURCE_SEQ_NO
spread,         --28   SPREAD
spread_adj,         --29   SPREAD_ADJ
unit,         --30   UNIT
waiver)         --31   WAIVER


values(
i.acquired_amount,         --1   ACQUIRED_AMOUNT
i.basis_366,         --2   BASIS_366
i.borrow_lend_ind,         --3   BORROW_LEND_IND
i.branch_code,         --4   BRANCH_CODE
i.component,         --5   COMPONENT
i.conv_status,         --6   CONV_STATUS
i.cust_margin,         --7   CUST_MARGIN
i.denominator_basis,         --8   DENOMINATOR_BASIS
i.disc_accr_applicable,         --9   DISC_ACCR_APPLICABLE
i.err_msg,         --10   ERR_MSG
i.flat_amount,         --11   FLAT_AMOUNT
i.interest_basis,         --12   INTEREST_BASIS
i.margin,         --13   MARGIN
i.max_rate,         --14   MAX_RATE
i.min_rate,         --15   MIN_RATE
i.negative_interest_allowed,         --16   NEGATIVE_INTEREST_ALLOWED
i.no_of_int_period,         --17   NO_OF_INT_PERIOD
i.no_of_units,         --18   NO_OF_UNITS
i.rate,         --19   RATE
i.rate_calc_type,         --20   RATE_CALC_TYPE
i.rate_code,         --21   RATE_CODE
i.rate_code_usage,         --22   RATE_CODE_USAGE
i.rate_type,         --23   RATE_TYPE
i.reset_tenor,         --24   RESET_TENOR
in_source_code,--i.SOURCE_CODE,         --25   SOURCE_CODE
i.source_ref,         --26   SOURCE_REF
i.source_seq_no,         --27   SOURCE_SEQ_NO
i.spread,         --28   SPREAD
i.spread_adj,         --29   SPREAD_ADJ
i.unit,         --30   UNIT
i.waiver);         --31   WAIVER
commit; 

exception
when no_data_found then 
insert into cd_upload_log  values(i.source_seq_no,'CFTB_UPLOAD_INTEREST_amp');
commit;

when others then
insert into cd_upload_log  values(i.source_seq_no,'CFTB_UPLOAD_INTEREST_amp');
commit;

end;

end loop;
dbms_output.put_line('---populating cftb_upload_interest : completed');
end;


end;
/*
------------------------------------------------------------
execute insert_cd_amp();
------------------------
select dflt_settle_ac_branch||'~'||dflt_settle_ac from ldtb_upload_master@ampdblink where (trim(dflt_settle_ac_branch)||'~'||trim(dflt_settle_ac)) 
not in (select  trim(branch_code)||'~'||trim(alt_ac_no) from sttm_cust_account);
------------------------
select dr_setl_ac_br||'~'||dr_setl_ac from ldtb_upload_master@ampdblink where (trim(dr_setl_ac_br)||'~'||trim(dr_setl_ac)) 
not in (select  trim(branch_code)||'~'||trim(alt_ac_no) from sttm_cust_account);
------------------------
select * from sttm_cust_account where branch_code||'~'||alt_ac_no = '120~001010010003414456';
120~001010010003414456
120~001010010003414456
--delete from Cstb_Ext_Contract_Stat where EXTERNAL_REF_NO = '004171';
--delete from ldtb_upload_master where 
update ldtb_upload_master set FUNCTION_ID = 'CDDTRONL',dr_setl_ac= '299905000';
select * from ldtb_upload_master@ampdblink where dflt_settle_ac = '001010010003414456';

select * from bkcom@ampdblink where age||ncp||clc = '001010010003414456';
select * from bkcli@ampdblink where cli = '141011151';

select counterparty,dflt_settle_ac,dr_setl_ac from ldtb_upload_master;
select counterparty,dflt_settle_ac,dr_setl_ac from ldtb_upload_master@ampdblink;
select counterparty,dflt_settle_ac,dr_setl_ac from ldtb_upload_master@ampdblink where trim(dr_setl_ac) in (select alt_ac_no from sttm_cust_account);
select counterparty,dflt_settle_ac,dr_setl_ac from ldtb_upload_master@ampdblink where trim(dflt_settle_ac) in (select alt_ac_no from sttm_cust_account);
select branch,count(*) from ldtb_upload_master group by branch;

select * from ldtb_upload_master where EXT_CONTRACT_REF_NO in ('003347','003367','004168','003945','003381');--
select * from ldtb_upload_schedules;
select * from cftb_upload_interest;
select * from cd_upload_log  where ;
select * from Cstb_Ext_Contract_Stat where source = 'CD_UPLOAD';
select distinct branch_code from Cstb_Ext_Contract_Stat where source = 'CD_UPLOAD' and branch_code<>'601';
-------------
select * from ldtb_upload_master@ampdblink where source_seq_no  in ('31000339','31000708','31000398','31000398');
select * from ldtb_upload_schedules@ampdblink;
select * from cftb_upload_interest@ampdblink where source_seq_no in ('31000708','31000708','31000708');
-------------dflt_settle_ccy, dr_settle_ccy, dr_setl_ac
select * from ldtb_upload_master@ampdblink;
select * from Cstb_Ext_Contract_Stat where source = 'SI_UPD';
select * from si_upload_log;
select * from sttm_customer where ext_ref_no in '6000746';
select * from ertb_msgs where err_code ='SI-RESP-004';
select * from ertb_msgs where err_code ='LD-UPL102';   ---->        Invalid Schedule Movement specified
select * from ertb_msgs where err_code ='LD-UPL-103';  ---->        Field $1 cannot be $2
select * from ertb_msgs where err_code ='LD-UPL-106';  ---->        $1 cannot be authorized when payment is not authorized  (partial payment mliq~Y~)
select * from ertb_msgs where err_code ='LD-C0035';   
select * from ertb_msgs where err_code ='LD-UP0001';     
select * from ertb_msgs where err_code ='LD-UPL-128';
select * from ertb_msgs where err_code ='PD-CSR-001';
select * from ertb_msgs where err_code ='LD-CSR-001';
select * from ertb_msgs where err_code ='LD-UPL-128';
select * from ertb_msgs where err_code ='LD-UP0044';--Rollover Not Allowed for Product $1
select * from ertb_msgs where err_code ='LD-UP0003';--Invalid Payment Method $1
------------------------------------------------------------
truncate table ldtb_upload_master;
truncate table ldtb_upload_schedules;
truncate table cftb_upload_interest;
delete from Cstb_Ext_Contract_Stat where source = 'CD_UPLOAD';
truncate table cd_upload_log;

create table Cstb_Ext_Contract_Stat_dtn as select * from Cstb_Ext_Contract_Stat
create table Cstb_Ext_Contract_Stat_amp_1 as select * from Cstb_Ext_Contract_Stat

-----------------------------------------------------------PK01_LDTB_UPLOAD_MASTER
select * from SITBS_INSTRUCTION;
select * from Sitbs_Contract_Master;


select partial_payment_mliq,m_sch_schedule_movement,schedule_movement from ldtb_upload_master@ampdblink;
select * from ldtb_upload_schedules@ampdblink;
select * from CFTBs_UPLOAD_INTEREST@ampdblink;


120
120
120
403

select source_ref, count(*) from sitb_upload_master group by source_ref;
--------
select * from sitb_upload_master where dr_acc_br||'~'||dr_account  in (select branch_code||'~'||cust_ac_no from sttm_cust_account) and dr_account = '0010211485015';
select * from sitb_upload_master where cr_acc_br||'~'||cr_account  not in (select branch_code||'~'||cust_ac_no from sttm_cust_account);
select source_seq_no from sitb_upload_master where dr_acc_br||'~'||dr_account  not in (select branch_code||'~'||cust_ac_no from sttm_cust_account);
select source_seq_no from sitb_upload_master where cr_acc_br||'~'||cr_account  not in (select branch_code||'~'||cust_ac_no from sttm_cust_account);
-------
select source_seq_no from sitb_upload_master where dr_acc_ccy||'~'||dr_account  not in (select ccy||'~'||cust_ac_no from sttm_cust_account);
select * from sitb_upload_master where cr_acc_ccy||'~'||cr_account  not in (select ccy||'~'||cust_ac_no from sttm_cust_account);
---------------------
select counterparty,dflt_settle_ac,dr_setl_ac from ldtb_upload_master@ampdblink where trim(dr_setl_ac) in(select  trim(alt_ac_no) from sttm_cust_account);
select counterparty,dflt_settle_ac,dr_setl_ac from ldtb_upload_master@ampdblink where dr_setl_ac in (select trim(alt_ac_no) from sttm_cust_account);

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

select * from cotm_source where source_code = 'CD_UPLOAD';
select * from cotm_source_pref where source_code = 'CD_UPLOAD';
------------------------------------------------------------------------
select * from cotm_source@to_uat_dev where source_code = 'SI_UPD';
select * from cotm_source_pref@to_uat_dev where source_code = 'SI_UPD';
------------------------------------------------------------------------
select * from ldtm_product_liq_order
select * from tatm_product;
select * from TATM_PRODUCT_SCHEME;
select * from TATM_PRODUCT_TAX;
select PRODUCT,COMPONENT from LDTM_PRODUCT_DFLT_SCHEDULES
LDTM_PRODUCT_LIQ_ORDER
;

select * from user_objects where object_name like 'LDTM%' and object_name like '%COM%' and object_type ='TABLE';
select * from LDTM_TRS_COMPONENTS;
select * from cols where column_name = 'COMPONENT' AND TABLE_NAME LIKE 'LD%';


*/
