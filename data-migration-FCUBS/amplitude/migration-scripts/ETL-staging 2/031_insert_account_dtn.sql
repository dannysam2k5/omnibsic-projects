create or replace procedure insert_account_dtn /* (aa number)*/ as 
a number;
begin
--a:=aa;

---XXX1
dbms_output.put_line('---populating sttb_upload_cust_account : starting');
for i in ( 

select 
trim(b.account_auto_closed)  account_auto_closed,         --1   ACCOUNT_AUTO_CLOSED
trim(b.account_class)  account_class,         --2   ACCOUNT_CLASS
null  account_type,         --3   ACCOUNT_TYPE
trim(b.acc_status)  acc_status,         --4   ACC_STATUS
trim(b.acc_stmt_day2)  acc_stmt_day2,         --5   ACC_STMT_DAY2
trim(b.acc_stmt_day3)  acc_stmt_day3,         --6   ACC_STMT_DAY3
trim(b.acc_stmt_type2)  acc_stmt_type2,         --7   ACC_STMT_TYPE2
trim(b.acc_stmt_type3)  acc_stmt_type3,         --8   ACC_STMT_TYPE3
trim(b.action_code)  action_code,         --9   ACTION_CODE
trim(b.ac_desc)  ac_desc,         --10   AC_DESC
to_date((b.ac_open_date),'rrrr/mm/dd')  ac_open_date,         --11   AC_OPEN_DATE
trim(b.ac_stat_block)  ac_stat_block,         --12   AC_STAT_BLOCK
null  ac_stat_cr_ovd,         --13   AC_STAT_CR_OVD
trim(b.ac_stat_de_post)  ac_stat_de_post,         --14   AC_STAT_DE_POST
trim(b.ac_stat_dormant)  ac_stat_dormant,         --15   AC_STAT_DORMANT
null  ac_stat_dr_ovd,         --16   AC_STAT_DR_OVD
trim(b.ac_stat_frozen)  ac_stat_frozen,         --17   AC_STAT_FROZEN
trim(b.ac_stat_no_cr)  ac_stat_no_cr,         --18   AC_STAT_NO_CR
trim(b.ac_stat_no_dr)  ac_stat_no_dr,         --19   AC_STAT_NO_DR
trim(b.ac_stat_stop_pay)  ac_stat_stop_pay,         --20   AC_STAT_STOP_PAY
trim(b.ac_stmt_cycle)  ac_stmt_cycle,         --21   AC_STMT_CYCLE
trim(b.ac_stmt_cycle2)  ac_stmt_cycle2,         --22   AC_STMT_CYCLE2
trim(b.ac_stmt_cycle3)  ac_stmt_cycle3,         --23   AC_STMT_CYCLE3
trim(b.ac_stmt_day)  ac_stmt_day,         --24   AC_STMT_DAY
trim(b.ac_stmt_type)  ac_stmt_type,         --25   AC_STMT_TYPE
trim(b.address1)  address1,         --26   ADDRESS1
trim(b.address2)  address2,         --27   ADDRESS2
trim(b.address3)  address3,         --28   ADDRESS3
trim(b.address4)  address4,         --29   ADDRESS4
trim(b.allow_back_period_entry)  allow_back_period_entry,         --30   ALLOW_BACK_PERIOD_ENTRY
trim(b.alt_ac_no)  alt_ac_no,         --31   ALT_AC_NO
trim(b.atm_cust_ac_no)  atm_cust_ac_no,         --32   ATM_CUST_AC_NO
trim(b.atm_dly_amt_limit)  atm_dly_amt_limit,         --33   ATM_DLY_AMT_LIMIT
trim(b.atm_dly_count_limit)  atm_dly_count_limit,         --34   ATM_DLY_COUNT_LIMIT
trim(b.atm_facility)  atm_facility,         --35   ATM_FACILITY
'A'   auth_stat,         --36   AUTH_STAT
null  auto_chqbk_request,         --37   AUTO_CHQBK_REQUEST
null  auto_create_pool,         --38   AUTO_CREATE_POOL
null  auto_dc_request,         --39   AUTO_DC_REQUEST
null  auto_deposit,         --40   AUTO_DEPOSIT
trim(b.auto_deposits_bal)  auto_deposits_bal,         --41   AUTO_DEPOSITS_BAL
trim(b.auto_prov_reqd)  auto_prov_reqd,         --42   AUTO_PROV_REQD
trim(b.auto_reorder_check_leaves)  auto_reorder_check_leaves,         --43   AUTO_REORDER_CHECK_LEAVES
trim(b.auto_reorder_check_level)  auto_reorder_check_level,         --44   AUTO_REORDER_CHECK_LEVEL
trim(b.auto_reorder_check_required)  auto_reorder_check_required,         --45   AUTO_REORDER_CHECK_REQUIRED
trim(b.balance_report_since)  balance_report_since,         --46   BALANCE_REPORT_SINCE
trim(b.balance_report_type)  balance_report_type,         --47   BALANCE_REPORT_TYPE
trim(b.branch_code)  branch_code,         --48   BRANCH_CODE
trim(b.cas_account)  cas_account,         --49   CAS_ACCOUNT
trim(b.ccy)  ccy,         --50   CCY
trim(b.checkbook_name_1)  checkbook_name_1,         --51   CHECKBOOK_NAME_1
trim(b.checkbook_name_2)  checkbook_name_2,         --52   CHECKBOOK_NAME_2
trim(b.checker_dt_stamp)  checker_dt_stamp,         --53   CHECKER_DT_STAMP
trim(b.checker_id)  checker_id,         --54   CHECKER_ID
trim(b.cheque_book_facility)  cheque_book_facility,         --55   CHEQUE_BOOK_FACILITY
trim(b.clearing_ac_no)  clearing_ac_no,         --56   CLEARING_AC_NO
trim(b.clearing_bank_code)  clearing_bank_code,         --57   CLEARING_BANK_CODE
trim(b.consolidation_reqd)  consolidation_reqd,         --58   CONSOLIDATION_REQD
null  contribute_to_pdm,         --59   CONTRIBUTE_TO_PDM
trim(b.country_code)  country_code,         --60   COUNTRY_CODE
trim(b.cr_auto_ex_rate_lmt)  cr_auto_ex_rate_lmt,         --61   CR_AUTO_EX_RATE_LMT
trim(b.cr_cb_line)  cr_cb_line,         --62   CR_CB_LINE
trim(b.cr_gl)  cr_gl,         --63   CR_GL
trim(b.cr_ho_line)  cr_ho_line,         --64   CR_HO_LINE
'DUMMY'  cust_ac_no,         --65   CUST_AC_NO
c.customer_no cust_no,--(select trim(b.customer_no) from sttm_customer where trim(b.ext_ref_no) = trim(b.cust_no))  cust_no,         --66   CUST_NO
trim(b.daylight_limit_amount)  daylight_limit_amount,         --67   DAYLIGHT_LIMIT_AMOUNT
trim(b.defer_recon)  defer_recon,         --68   DEFER_RECON
null  def_seq,         --69   DEF_SEQ
null  direct_banking,         --70   DIRECT_BANKING
trim(b.display_iban_in_advices)  display_iban_in_advices,         --71   DISPLAY_IBAN_IN_ADVICES
trim(b.dormancy_date)  dormancy_date,         --72   DORMANCY_DATE
trim(b.dormancy_days)  dormancy_days,         --73   DORMANCY_DAYS
trim(b.dormant_param)  dormant_param,         --74   DORMANT_PARAM
trim(b.dr_auto_ex_rate_lmt)  dr_auto_ex_rate_lmt,         --75   DR_AUTO_EX_RATE_LMT
trim(b.dr_cb_line)  dr_cb_line,         --76   DR_CB_LINE
trim(b.dr_gl)  dr_gl,         --77   DR_GL
trim(b.dr_ho_line)  dr_ho_line,         --78   DR_HO_LINE
trim(b.escrow_ac_no)  escrow_ac_no,         --79   ESCROW_AC_NO
trim(b.escrow_branch_code)  escrow_branch_code,         --80   ESCROW_BRANCH_CODE
trim(b.escrow_percentage)  escrow_percentage,         --81   ESCROW_PERCENTAGE
trim(b.escrow_transfer)  escrow_transfer,         --82   ESCROW_TRANSFER
null  exclude_from_distribution,         --83   EXCLUDE_FROM_DISTRIBUTION
trim(b.excl_sameday_rvrtrns_fm_stmt)  excl_sameday_rvrtrns_fm_stmt,         --84   EXCL_SAMEDAY_RVRTRNS_FM_STMT
trim(b.exposure_category)  exposure_category,         --85   EXPOSURE_CATEGORY
trim(b.funding)  funding,         --86   FUNDING
trim(b.funding_account)  funding_account,         --87   FUNDING_ACCOUNT
trim(b.funding_branch)  funding_branch,         --88   FUNDING_BRANCH
trim(b.fund_id)  fund_id,         --89   FUND_ID
trim(b.gen_balance_report)  gen_balance_report,         --90   GEN_BALANCE_REPORT
trim(b.gen_interim_stmt)  gen_interim_stmt,         --91   GEN_INTERIM_STMT
trim(b.gen_interim_stmt_on_mvmt)  gen_interim_stmt_on_mvmt,         --92   GEN_INTERIM_STMT_ON_MVMT
trim(b.gen_stmt_only_on_mvmt)  gen_stmt_only_on_mvmt,         --93   GEN_STMT_ONLY_ON_MVMT
trim(b.gen_stmt_only_on_mvmt2)  gen_stmt_only_on_mvmt2,         --94   GEN_STMT_ONLY_ON_MVMT2
trim(b.gen_stmt_only_on_mvmt3)  gen_stmt_only_on_mvmt3,         --95   GEN_STMT_ONLY_ON_MVMT3
null  goal_ref_no,         --96   GOAL_REF_NO
trim(b.iban_acc)  iban_acc,         --97   IBAN_ACC
trim(b.iban_ac_no)  iban_ac_no,         --98   IBAN_AC_NO
trim(b.iban_bank_code)  iban_bank_code,         --99   IBAN_BANK_CODE
trim(b.iban_reqd)  iban_reqd,         --100   IBAN_REQD
null  iban_required,         --101   IBAN_REQUIRED
null  inf_acc_opening_amt,         --102   INF_ACC_OPENING_AMT
null  inf_offset_account,         --103   INF_OFFSET_ACCOUNT
null  inf_offset_branch,         --104   INF_OFFSET_BRANCH
null  inf_pay_in_option,         --105   INF_PAY_IN_OPTION
null  inf_waive_acc_open_charge,         --106   INF_WAIVE_ACC_OPEN_CHARGE
trim(b.inherit_reporting)  inherit_reporting,         --107   INHERIT_REPORTING
trim(b.interim_credit_amt)  interim_credit_amt,         --108   INTERIM_CREDIT_AMT
trim(b.interim_debit_amt)  interim_debit_amt,         --109   INTERIM_DEBIT_AMT
trim(b.interim_report_since)  interim_report_since,         --110   INTERIM_REPORT_SINCE
trim(b.interim_report_type)  interim_report_type,         --111   INTERIM_REPORT_TYPE
trim(b.interim_stmt_day_count)  interim_stmt_day_count,         --112   INTERIM_STMT_DAY_COUNT
trim(b.interim_stmt_ytd_count)  interim_stmt_ytd_count,         --113   INTERIM_STMT_YTD_COUNT
null  intermediary_required,         --114   INTERMEDIARY_REQUIRED
trim(b.joint_ac_indicator)  joint_ac_indicator,         --115   JOINT_AC_INDICATOR
null  last_generation_date,         --116   LAST_GENERATION_DATE
null  last_statement_no,         --117   LAST_STATEMENT_NO
trim(b.limit_ccy)  limit_ccy,         --118   LIMIT_CCY
trim(b.line_id)  line_id,         --119   LINE_ID
trim(b.linked_dep_acc)  linked_dep_acc,         --120   LINKED_DEP_ACC
trim(b.linked_dep_branch)  linked_dep_branch,         --121   LINKED_DEP_BRANCH
trim(b.location)  location,         --122   LOCATION
trim(b.lodgement_book_facility)  lodgement_book_facility,         --123   LODGEMENT_BOOK_FACILITY
trim(b.maintenance_seq_no)  maintenance_seq_no,         --124   MAINTENANCE_SEQ_NO
trim(b.maker_dt_stamp)  maker_dt_stamp,         --125   MAKER_DT_STAMP
trim(b.maker_id)  maker_id,         --126   MAKER_ID
trim(b.master_account_no)  master_account_no,         --127   MASTER_ACCOUNT_NO
trim(b.max_no_cheque_rejections)  max_no_cheque_rejections,         --128   MAX_NO_CHEQUE_REJECTIONS
trim(b.media)  media,         --129   MEDIA
trim(b.min_reqd_bal)  min_reqd_bal,         --130   MIN_REQD_BAL
trim(b.mod9_validation_reqd)  mod9_validation_reqd,         --131   MOD9_VALIDATION_REQD
null  mode_of_operation,         --132   MODE_OF_OPERATION
trim(b.mod_no)  mod_no,         --133   MOD_NO
trim(b.mt210_reqd)  mt210_reqd,         --134   MT210_REQD
trim(b.mudarabah_accounts)  mudarabah_accounts,         --135   MUDARABAH_ACCOUNTS
null  multi_ccy_ac_no,         --136   MULTI_CCY_AC_NO
null  multi_ccy_iban_ac_no,         --137   MULTI_CCY_IBAN_AC_NO
trim(b.netting_required)  netting_required,         --138   NETTING_REQUIRED
trim(b.nominee1)  nominee1,         --139   NOMINEE1
trim(b.nominee2)  nominee2,         --140   NOMINEE2
trim(b.no_cheque_rejections)  no_cheque_rejections,         --141   NO_CHEQUE_REJECTIONS
trim(b.no_of_chq_rej_reset_on)  no_of_chq_rej_reset_on,         --142   NO_OF_CHQ_REJ_RESET_ON
trim(b.offline_limit)  offline_limit,         --143   OFFLINE_LIMIT
trim(b.once_auth)  once_auth,         --144   ONCE_AUTH
trim(b.otherdet)  otherdet,         --145   OTHERDET
trim(b.overdraft_since)  overdraft_since,         --146   OVERDRAFT_SINCE
trim(b.overline_od_since)  overline_od_since,         --147   OVERLINE_OD_SINCE
trim(b.passbook_facility)  passbook_facility,         --148   PASSBOOK_FACILITY
null  pincode,         --149   PINCODE
trim(b.positive_pay_ac)  positive_pay_ac,         --150   POSITIVE_PAY_AC
trim(b.previous_statement_balance)  previous_statement_balance,         --151   PREVIOUS_STATEMENT_BALANCE
trim(b.previous_statement_balance2)  previous_statement_balance2,         --152   PREVIOUS_STATEMENT_BALANCE2
trim(b.previous_statement_balance3)  previous_statement_balance3,         --153   PREVIOUS_STATEMENT_BALANCE3
trim(b.previous_statement_date)  previous_statement_date,         --154   PREVIOUS_STATEMENT_DATE
trim(b.previous_statement_date2)  previous_statement_date2,         --155   PREVIOUS_STATEMENT_DATE2
trim(b.previous_statement_date3)  previous_statement_date3,         --156   PREVIOUS_STATEMENT_DATE3
trim(b.previous_statement_no)  previous_statement_no,         --157   PREVIOUS_STATEMENT_NO
trim(b.previous_statement_no2)  previous_statement_no2,         --158   PREVIOUS_STATEMENT_NO2
trim(b.previous_statement_no3)  previous_statement_no3,         --159   PREVIOUS_STATEMENT_NO3
trim(b.prev_ovd_date)  prev_ovd_date,         --160   PREV_OVD_DATE
trim(b.prev_tod_since)  prev_tod_since,         --161   PREV_TOD_SINCE
trim(b.product_list)  product_list,         --162   PRODUCT_LIST
trim(b.prov_ccy_type)  prov_ccy_type,         --163   PROV_CCY_TYPE
trim(b.record_stat)  record_stat,         --164   RECORD_STAT
trim(b.referral_required)  referral_required,         --165   REFERRAL_REQUIRED
trim(b.regd_end_date)  regd_end_date,         --166   REGD_END_DATE
trim(b.regd_periodicity)  regd_periodicity,         --167   REGD_PERIODICITY
trim(b.regd_start_date)  regd_start_date,         --168   REGD_START_DATE
trim(b.reg_cc_availability)  reg_cc_availability,         --169   REG_CC_AVAILABILITY
trim(b.reg_d_applicable)  reg_d_applicable,         --170   REG_D_APPLICABLE
trim(b.repl_cust_sig)  repl_cust_sig,         --171   REPL_CUST_SIG
trim(b.risk_free_exp_amount)  risk_free_exp_amount,         --172   RISK_FREE_EXP_AMOUNT
null  rtl_required,         --173   RTL_REQUIRED
trim(b.salary_account)  salary_account,         --174   SALARY_ACCOUNT
trim(b.sod_notification_percent)  sod_notification_percent,         --175   SOD_NOTIFICATION_PERCENT
trim(b.source_code)  source_code,         --176   SOURCE_CODE
trim(b.maintenance_seq_no)  source_seq_no,         --177   SOURCE_SEQ_NO
trim(b.special_condition_product)  special_condition_product,         --178   SPECIAL_CONDITION_PRODUCT
trim(b.special_condition_txncode)  special_condition_txncode,         --179   SPECIAL_CONDITION_TXNCODE
null  spend_analysis_reqd,         --180   SPEND_ANALYSIS_REQD
null  spl_ac_gen,         --181   SPL_AC_GEN
trim(b.stale_days)  stale_days,         --182   STALE_DAYS
trim(b.statement_account)  statement_account,         --183   STATEMENT_ACCOUNT
trim(b.status_change_automatic)  status_change_automatic,         --184   STATUS_CHANGE_AUTOMATIC
trim(b.status_since)  status_since,         --185   STATUS_SINCE
null  stmt_of_fees_cycle,         --186   STMT_OF_FEES_CYCLE
null  stmt_of_fees_del_channel,         --187   STMT_OF_FEES_DEL_CHANNEL
null  stmt_of_fees_on,         --188   STMT_OF_FEES_ON
null  stmt_of_fees_req,         --189   STMT_OF_FEES_REQ
trim(b.sublimit)  sublimit,         --190   SUBLIMIT
null  sweep_out,         --191   SWEEP_OUT
null  sweep_required,         --192   SWEEP_REQUIRED
trim(b.sweep_type)  sweep_type,         --193   SWEEP_TYPE
trim(b.tod_limit)  tod_limit,         --194   TOD_LIMIT
trim(b.tod_limit_end_date)  tod_limit_end_date,         --195   TOD_LIMIT_END_DATE
trim(b.tod_limit_start_date)  tod_limit_start_date,         --196   TOD_LIMIT_START_DATE
trim(b.tod_since)  tod_since,         --197   TOD_SINCE
trim(b.track_receivable)  track_receivable,         --198   TRACK_RECEIVABLE
trim(b.txn_code_list)  txn_code_list,         --199   TXN_CODE_LIST
trim(b.type_of_chq)  type_of_chq,         --200   TYPE_OF_CHQ
null  uncoll_funds_end_dt,         --201   UNCOLL_FUNDS_END_DT
trim(b.uncoll_funds_limit)  uncoll_funds_limit,         --202   UNCOLL_FUNDS_LIMIT
null  uncoll_funds_start_dt,         --203   UNCOLL_FUNDS_START_DT
trim(b.validation_digit)  validation_digit,         --204   VALIDATION_DIGIT
trim(b.xref)  xref,         --205   XREF
trim(b.zakat_exemption)  zakat_exemption          --206   ZAKAT_EXEMPTION
from  sttb_upload_cust_account@to_dtn b,
sttm_customer c
where trim(b.alt_ac_no) not in (select trim(a.alt_ac_no) from sttm_cust_account a where a.alt_ac_no is not null)
and  trim(c.ext_ref_no) = trim(b.cust_no)
--and rownum < a
)
loop
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
begin

insert into sttb_upload_cust_account (
account_auto_closed,         --1   ACCOUNT_AUTO_CLOSED
account_class,         --2   ACCOUNT_CLASS
account_type,         --3   ACCOUNT_TYPE
acc_status,         --4   ACC_STATUS
acc_stmt_day2,         --5   ACC_STMT_DAY2
acc_stmt_day3,         --6   ACC_STMT_DAY3
acc_stmt_type2,         --7   ACC_STMT_TYPE2
acc_stmt_type3,         --8   ACC_STMT_TYPE3
action_code,         --9   ACTION_CODE
ac_desc,         --10   AC_DESC
ac_open_date,         --11   AC_OPEN_DATE
ac_stat_block,         --12   AC_STAT_BLOCK
ac_stat_cr_ovd,         --13   AC_STAT_CR_OVD
ac_stat_de_post,         --14   AC_STAT_DE_POST
ac_stat_dormant,         --15   AC_STAT_DORMANT
ac_stat_dr_ovd,         --16   AC_STAT_DR_OVD
ac_stat_frozen,         --17   AC_STAT_FROZEN
ac_stat_no_cr,         --18   AC_STAT_NO_CR
ac_stat_no_dr,         --19   AC_STAT_NO_DR
ac_stat_stop_pay,         --20   AC_STAT_STOP_PAY
ac_stmt_cycle,         --21   AC_STMT_CYCLE
ac_stmt_cycle2,         --22   AC_STMT_CYCLE2
ac_stmt_cycle3,         --23   AC_STMT_CYCLE3
ac_stmt_day,         --24   AC_STMT_DAY
ac_stmt_type,         --25   AC_STMT_TYPE
address1,         --26   ADDRESS1
address2,         --27   ADDRESS2
address3,         --28   ADDRESS3
address4,         --29   ADDRESS4
allow_back_period_entry,         --30   ALLOW_BACK_PERIOD_ENTRY
alt_ac_no,         --31   ALT_AC_NO
atm_cust_ac_no,         --32   ATM_CUST_AC_NO
atm_dly_amt_limit,         --33   ATM_DLY_AMT_LIMIT
atm_dly_count_limit,         --34   ATM_DLY_COUNT_LIMIT
atm_facility,         --35   ATM_FACILITY
auth_stat,         --36   AUTH_STAT
auto_chqbk_request,         --37   AUTO_CHQBK_REQUEST
auto_create_pool,         --38   AUTO_CREATE_POOL
auto_dc_request,         --39   AUTO_DC_REQUEST
auto_deposit,         --40   AUTO_DEPOSIT
auto_deposits_bal,         --41   AUTO_DEPOSITS_BAL
auto_prov_reqd,         --42   AUTO_PROV_REQD
auto_reorder_check_leaves,         --43   AUTO_REORDER_CHECK_LEAVES
auto_reorder_check_level,         --44   AUTO_REORDER_CHECK_LEVEL
auto_reorder_check_required,         --45   AUTO_REORDER_CHECK_REQUIRED
balance_report_since,         --46   BALANCE_REPORT_SINCE
balance_report_type,         --47   BALANCE_REPORT_TYPE
branch_code,         --48   BRANCH_CODE
cas_account,         --49   CAS_ACCOUNT
ccy,         --50   CCY
checkbook_name_1,         --51   CHECKBOOK_NAME_1
checkbook_name_2,         --52   CHECKBOOK_NAME_2
checker_dt_stamp,         --53   CHECKER_DT_STAMP
checker_id,         --54   CHECKER_ID
cheque_book_facility,         --55   CHEQUE_BOOK_FACILITY
clearing_ac_no,         --56   CLEARING_AC_NO
clearing_bank_code,         --57   CLEARING_BANK_CODE
consolidation_reqd,         --58   CONSOLIDATION_REQD
contribute_to_pdm,         --59   CONTRIBUTE_TO_PDM
country_code,         --60   COUNTRY_CODE
cr_auto_ex_rate_lmt,         --61   CR_AUTO_EX_RATE_LMT
cr_cb_line,         --62   CR_CB_LINE
cr_gl,         --63   CR_GL
cr_ho_line,         --64   CR_HO_LINE
cust_ac_no,         --65   CUST_AC_NO
cust_no,         --66   CUST_NO
daylight_limit_amount,         --67   DAYLIGHT_LIMIT_AMOUNT
defer_recon,         --68   DEFER_RECON
def_seq,         --69   DEF_SEQ
direct_banking,         --70   DIRECT_BANKING
display_iban_in_advices,         --71   DISPLAY_IBAN_IN_ADVICES
dormancy_date,         --72   DORMANCY_DATE
dormancy_days,         --73   DORMANCY_DAYS
dormant_param,         --74   DORMANT_PARAM
dr_auto_ex_rate_lmt,         --75   DR_AUTO_EX_RATE_LMT
dr_cb_line,         --76   DR_CB_LINE
dr_gl,         --77   DR_GL
dr_ho_line,         --78   DR_HO_LINE
escrow_ac_no,         --79   ESCROW_AC_NO
escrow_branch_code,         --80   ESCROW_BRANCH_CODE
escrow_percentage,         --81   ESCROW_PERCENTAGE
escrow_transfer,         --82   ESCROW_TRANSFER
exclude_from_distribution,         --83   EXCLUDE_FROM_DISTRIBUTION
excl_sameday_rvrtrns_fm_stmt,         --84   EXCL_SAMEDAY_RVRTRNS_FM_STMT
exposure_category,         --85   EXPOSURE_CATEGORY
funding,         --86   FUNDING
funding_account,         --87   FUNDING_ACCOUNT
funding_branch,         --88   FUNDING_BRANCH
fund_id,         --89   FUND_ID
gen_balance_report,         --90   GEN_BALANCE_REPORT
gen_interim_stmt,         --91   GEN_INTERIM_STMT
gen_interim_stmt_on_mvmt,         --92   GEN_INTERIM_STMT_ON_MVMT
gen_stmt_only_on_mvmt,         --93   GEN_STMT_ONLY_ON_MVMT
gen_stmt_only_on_mvmt2,         --94   GEN_STMT_ONLY_ON_MVMT2
gen_stmt_only_on_mvmt3,         --95   GEN_STMT_ONLY_ON_MVMT3
goal_ref_no,         --96   GOAL_REF_NO
iban_acc,         --97   IBAN_ACC
iban_ac_no,         --98   IBAN_AC_NO
iban_bank_code,         --99   IBAN_BANK_CODE
iban_reqd,         --100   IBAN_REQD
iban_required,         --101   IBAN_REQUIRED
inf_acc_opening_amt,         --102   INF_ACC_OPENING_AMT
inf_offset_account,         --103   INF_OFFSET_ACCOUNT
inf_offset_branch,         --104   INF_OFFSET_BRANCH
inf_pay_in_option,         --105   INF_PAY_IN_OPTION
inf_waive_acc_open_charge,         --106   INF_WAIVE_ACC_OPEN_CHARGE
inherit_reporting,         --107   INHERIT_REPORTING
interim_credit_amt,         --108   INTERIM_CREDIT_AMT
interim_debit_amt,         --109   INTERIM_DEBIT_AMT
interim_report_since,         --110   INTERIM_REPORT_SINCE
interim_report_type,         --111   INTERIM_REPORT_TYPE
interim_stmt_day_count,         --112   INTERIM_STMT_DAY_COUNT
interim_stmt_ytd_count,         --113   INTERIM_STMT_YTD_COUNT
intermediary_required,         --114   INTERMEDIARY_REQUIRED
joint_ac_indicator,         --115   JOINT_AC_INDICATOR
last_generation_date,         --116   LAST_GENERATION_DATE
last_statement_no,         --117   LAST_STATEMENT_NO
limit_ccy,         --118   LIMIT_CCY
line_id,         --119   LINE_ID
linked_dep_acc,         --120   LINKED_DEP_ACC
linked_dep_branch,         --121   LINKED_DEP_BRANCH
location,         --122   LOCATION
lodgement_book_facility,         --123   LODGEMENT_BOOK_FACILITY
maintenance_seq_no,         --124   MAINTENANCE_SEQ_NO
maker_dt_stamp,         --125   MAKER_DT_STAMP
maker_id,         --126   MAKER_ID
master_account_no,         --127   MASTER_ACCOUNT_NO
max_no_cheque_rejections,         --128   MAX_NO_CHEQUE_REJECTIONS
media,         --129   MEDIA
min_reqd_bal,         --130   MIN_REQD_BAL
mod9_validation_reqd,         --131   MOD9_VALIDATION_REQD
mode_of_operation,         --132   MODE_OF_OPERATION
mod_no,         --133   MOD_NO
mt210_reqd,         --134   MT210_REQD
mudarabah_accounts,         --135   MUDARABAH_ACCOUNTS
multi_ccy_ac_no,         --136   MULTI_CCY_AC_NO
multi_ccy_iban_ac_no,         --137   MULTI_CCY_IBAN_AC_NO
netting_required,         --138   NETTING_REQUIRED
nominee1,         --139   NOMINEE1
nominee2,         --140   NOMINEE2
no_cheque_rejections,         --141   NO_CHEQUE_REJECTIONS
no_of_chq_rej_reset_on,         --142   NO_OF_CHQ_REJ_RESET_ON
offline_limit,         --143   OFFLINE_LIMIT
once_auth,         --144   ONCE_AUTH
otherdet,         --145   OTHERDET
overdraft_since,         --146   OVERDRAFT_SINCE
overline_od_since,         --147   OVERLINE_OD_SINCE
passbook_facility,         --148   PASSBOOK_FACILITY
pincode,         --149   PINCODE
positive_pay_ac,         --150   POSITIVE_PAY_AC
previous_statement_balance,         --151   PREVIOUS_STATEMENT_BALANCE
previous_statement_balance2,         --152   PREVIOUS_STATEMENT_BALANCE2
previous_statement_balance3,         --153   PREVIOUS_STATEMENT_BALANCE3
previous_statement_date,         --154   PREVIOUS_STATEMENT_DATE
previous_statement_date2,         --155   PREVIOUS_STATEMENT_DATE2
previous_statement_date3,         --156   PREVIOUS_STATEMENT_DATE3
previous_statement_no,         --157   PREVIOUS_STATEMENT_NO
previous_statement_no2,         --158   PREVIOUS_STATEMENT_NO2
previous_statement_no3,         --159   PREVIOUS_STATEMENT_NO3
prev_ovd_date,         --160   PREV_OVD_DATE
prev_tod_since,         --161   PREV_TOD_SINCE
product_list,         --162   PRODUCT_LIST
prov_ccy_type,         --163   PROV_CCY_TYPE
record_stat,         --164   RECORD_STAT
referral_required,         --165   REFERRAL_REQUIRED
regd_end_date,         --166   REGD_END_DATE
regd_periodicity,         --167   REGD_PERIODICITY
regd_start_date,         --168   REGD_START_DATE
reg_cc_availability,         --169   REG_CC_AVAILABILITY
reg_d_applicable,         --170   REG_D_APPLICABLE
repl_cust_sig,         --171   REPL_CUST_SIG
risk_free_exp_amount,         --172   RISK_FREE_EXP_AMOUNT
rtl_required,         --173   RTL_REQUIRED
salary_account,         --174   SALARY_ACCOUNT
sod_notification_percent,         --175   SOD_NOTIFICATION_PERCENT
source_code,         --176   SOURCE_CODE
source_seq_no,         --177   SOURCE_SEQ_NO
special_condition_product,         --178   SPECIAL_CONDITION_PRODUCT
special_condition_txncode,         --179   SPECIAL_CONDITION_TXNCODE
spend_analysis_reqd,         --180   SPEND_ANALYSIS_REQD
spl_ac_gen,         --181   SPL_AC_GEN
stale_days,         --182   STALE_DAYS
statement_account,         --183   STATEMENT_ACCOUNT
status_change_automatic,         --184   STATUS_CHANGE_AUTOMATIC
status_since,         --185   STATUS_SINCE
stmt_of_fees_cycle,         --186   STMT_OF_FEES_CYCLE
stmt_of_fees_del_channel,         --187   STMT_OF_FEES_DEL_CHANNEL
stmt_of_fees_on,         --188   STMT_OF_FEES_ON
stmt_of_fees_req,         --189   STMT_OF_FEES_REQ
sublimit,         --190   SUBLIMIT
sweep_out,         --191   SWEEP_OUT
sweep_required,         --192   SWEEP_REQUIRED
sweep_type,         --193   SWEEP_TYPE
tod_limit,         --194   TOD_LIMIT
tod_limit_end_date,         --195   TOD_LIMIT_END_DATE
tod_limit_start_date,         --196   TOD_LIMIT_START_DATE
tod_since,         --197   TOD_SINCE
track_receivable,         --198   TRACK_RECEIVABLE
txn_code_list,         --199   TXN_CODE_LIST
type_of_chq,         --200   TYPE_OF_CHQ
uncoll_funds_end_dt,         --201   UNCOLL_FUNDS_END_DT
uncoll_funds_limit,         --202   UNCOLL_FUNDS_LIMIT
uncoll_funds_start_dt,         --203   UNCOLL_FUNDS_START_DT
validation_digit,         --204   VALIDATION_DIGIT
xref,         --205   XREF
zakat_exemption)         --206   ZAKAT_EXEMPTION


values (
i.account_auto_closed,         --1   ACCOUNT_AUTO_CLOSED
i.account_class,         --2   ACCOUNT_CLASS
i.account_type,         --3   ACCOUNT_TYPE
i.acc_status,         --4   ACC_STATUS
i.acc_stmt_day2,         --5   ACC_STMT_DAY2
i.acc_stmt_day3,         --6   ACC_STMT_DAY3
i.acc_stmt_type2,         --7   ACC_STMT_TYPE2
i.acc_stmt_type3,         --8   ACC_STMT_TYPE3
i.action_code,         --9   ACTION_CODE
i.ac_desc,         --10   AC_DESC
i.ac_open_date,         --11   AC_OPEN_DATE
i.ac_stat_block,         --12   AC_STAT_BLOCK
i.ac_stat_cr_ovd,         --13   AC_STAT_CR_OVD
i.ac_stat_de_post,         --14   AC_STAT_DE_POST
i.ac_stat_dormant,         --15   AC_STAT_DORMANT
i.ac_stat_dr_ovd,         --16   AC_STAT_DR_OVD
i.ac_stat_frozen,         --17   AC_STAT_FROZEN
i.ac_stat_no_cr,         --18   AC_STAT_NO_CR
i.ac_stat_no_dr,         --19   AC_STAT_NO_DR
i.ac_stat_stop_pay,         --20   AC_STAT_STOP_PAY
i.ac_stmt_cycle,         --21   AC_STMT_CYCLE
i.ac_stmt_cycle2,         --22   AC_STMT_CYCLE2
i.ac_stmt_cycle3,         --23   AC_STMT_CYCLE3
i.ac_stmt_day,         --24   AC_STMT_DAY
i.ac_stmt_type,         --25   AC_STMT_TYPE
i.address1,         --26   ADDRESS1
i.address2,         --27   ADDRESS2
i.address3,         --28   ADDRESS3
i.address4,         --29   ADDRESS4
i.allow_back_period_entry,         --30   ALLOW_BACK_PERIOD_ENTRY
i.alt_ac_no,         --31   ALT_AC_NO
i.atm_cust_ac_no,         --32   ATM_CUST_AC_NO
i.atm_dly_amt_limit,         --33   ATM_DLY_AMT_LIMIT
i.atm_dly_count_limit,         --34   ATM_DLY_COUNT_LIMIT
i.atm_facility,         --35   ATM_FACILITY
i.auth_stat,         --36   AUTH_STAT
i.auto_chqbk_request,         --37   AUTO_CHQBK_REQUEST
i.auto_create_pool,         --38   AUTO_CREATE_POOL
i.auto_dc_request,         --39   AUTO_DC_REQUEST
i.auto_deposit,         --40   AUTO_DEPOSIT
i.auto_deposits_bal,         --41   AUTO_DEPOSITS_BAL
i.auto_prov_reqd,         --42   AUTO_PROV_REQD
i.auto_reorder_check_leaves,         --43   AUTO_REORDER_CHECK_LEAVES
i.auto_reorder_check_level,         --44   AUTO_REORDER_CHECK_LEVEL
i.auto_reorder_check_required,         --45   AUTO_REORDER_CHECK_REQUIRED
i.balance_report_since,         --46   BALANCE_REPORT_SINCE
i.balance_report_type,         --47   BALANCE_REPORT_TYPE
i.branch_code,         --48   BRANCH_CODE
i.cas_account,         --49   CAS_ACCOUNT
i.ccy,         --50   CCY
i.checkbook_name_1,         --51   CHECKBOOK_NAME_1
i.checkbook_name_2,         --52   CHECKBOOK_NAME_2
i.checker_dt_stamp,         --53   CHECKER_DT_STAMP
i.checker_id,         --54   CHECKER_ID
i.cheque_book_facility,         --55   CHEQUE_BOOK_FACILITY
i.clearing_ac_no,         --56   CLEARING_AC_NO
i.clearing_bank_code,         --57   CLEARING_BANK_CODE
i.consolidation_reqd,         --58   CONSOLIDATION_REQD
i.contribute_to_pdm,         --59   CONTRIBUTE_TO_PDM
i.country_code,         --60   COUNTRY_CODE
i.cr_auto_ex_rate_lmt,         --61   CR_AUTO_EX_RATE_LMT
i.cr_cb_line,         --62   CR_CB_LINE
i.cr_gl,         --63   CR_GL
i.cr_ho_line,         --64   CR_HO_LINE
i.cust_ac_no,         --65   CUST_AC_NO
i.cust_no,         --66   CUST_NO
i.daylight_limit_amount,         --67   DAYLIGHT_LIMIT_AMOUNT
i.defer_recon,         --68   DEFER_RECON
i.def_seq,         --69   DEF_SEQ
i.direct_banking,         --70   DIRECT_BANKING
i.display_iban_in_advices,         --71   DISPLAY_IBAN_IN_ADVICES
i.dormancy_date,         --72   DORMANCY_DATE
i.dormancy_days,         --73   DORMANCY_DAYS
i.dormant_param,         --74   DORMANT_PARAM
i.dr_auto_ex_rate_lmt,         --75   DR_AUTO_EX_RATE_LMT
i.dr_cb_line,         --76   DR_CB_LINE
i.dr_gl,         --77   DR_GL
i.dr_ho_line,         --78   DR_HO_LINE
i.escrow_ac_no,         --79   ESCROW_AC_NO
i.escrow_branch_code,         --80   ESCROW_BRANCH_CODE
i.escrow_percentage,         --81   ESCROW_PERCENTAGE
i.escrow_transfer,         --82   ESCROW_TRANSFER
i.exclude_from_distribution,         --83   EXCLUDE_FROM_DISTRIBUTION
i.excl_sameday_rvrtrns_fm_stmt,         --84   EXCL_SAMEDAY_RVRTRNS_FM_STMT
i.exposure_category,         --85   EXPOSURE_CATEGORY
i.funding,         --86   FUNDING
i.funding_account,         --87   FUNDING_ACCOUNT
i.funding_branch,         --88   FUNDING_BRANCH
i.fund_id,         --89   FUND_ID
i.gen_balance_report,         --90   GEN_BALANCE_REPORT
i.gen_interim_stmt,         --91   GEN_INTERIM_STMT
i.gen_interim_stmt_on_mvmt,         --92   GEN_INTERIM_STMT_ON_MVMT
i.gen_stmt_only_on_mvmt,         --93   GEN_STMT_ONLY_ON_MVMT
i.gen_stmt_only_on_mvmt2,         --94   GEN_STMT_ONLY_ON_MVMT2
i.gen_stmt_only_on_mvmt3,         --95   GEN_STMT_ONLY_ON_MVMT3
i.goal_ref_no,         --96   GOAL_REF_NO
i.iban_acc,         --97   IBAN_ACC
i.iban_ac_no,         --98   IBAN_AC_NO
i.iban_bank_code,         --99   IBAN_BANK_CODE
i.iban_reqd,         --100   IBAN_REQD
i.iban_required,         --101   IBAN_REQUIRED
i.inf_acc_opening_amt,         --102   INF_ACC_OPENING_AMT
i.inf_offset_account,         --103   INF_OFFSET_ACCOUNT
i.inf_offset_branch,         --104   INF_OFFSET_BRANCH
i.inf_pay_in_option,         --105   INF_PAY_IN_OPTION
i.inf_waive_acc_open_charge,         --106   INF_WAIVE_ACC_OPEN_CHARGE
i.inherit_reporting,         --107   INHERIT_REPORTING
i.interim_credit_amt,         --108   INTERIM_CREDIT_AMT
i.interim_debit_amt,         --109   INTERIM_DEBIT_AMT
i.interim_report_since,         --110   INTERIM_REPORT_SINCE
i.interim_report_type,         --111   INTERIM_REPORT_TYPE
i.interim_stmt_day_count,         --112   INTERIM_STMT_DAY_COUNT
i.interim_stmt_ytd_count,         --113   INTERIM_STMT_YTD_COUNT
i.intermediary_required,         --114   INTERMEDIARY_REQUIRED
i.joint_ac_indicator,         --115   JOINT_AC_INDICATOR
i.last_generation_date,         --116   LAST_GENERATION_DATE
i.last_statement_no,         --117   LAST_STATEMENT_NO
i.limit_ccy,         --118   LIMIT_CCY
i.line_id,         --119   LINE_ID
i.linked_dep_acc,         --120   LINKED_DEP_ACC
i.linked_dep_branch,         --121   LINKED_DEP_BRANCH
i.location,         --122   LOCATION
i.lodgement_book_facility,         --123   LODGEMENT_BOOK_FACILITY
i.maintenance_seq_no,         --124   MAINTENANCE_SEQ_NO
i.maker_dt_stamp,         --125   MAKER_DT_STAMP
i.maker_id,         --126   MAKER_ID
i.master_account_no,         --127   MASTER_ACCOUNT_NO
i.max_no_cheque_rejections,         --128   MAX_NO_CHEQUE_REJECTIONS
i.media,         --129   MEDIA
i.min_reqd_bal,         --130   MIN_REQD_BAL
i.mod9_validation_reqd,         --131   MOD9_VALIDATION_REQD
i.mode_of_operation,         --132   MODE_OF_OPERATION
i.mod_no,         --133   MOD_NO
i.mt210_reqd,         --134   MT210_REQD
i.mudarabah_accounts,         --135   MUDARABAH_ACCOUNTS
i.multi_ccy_ac_no,         --136   MULTI_CCY_AC_NO
i.multi_ccy_iban_ac_no,         --137   MULTI_CCY_IBAN_AC_NO
i.netting_required,         --138   NETTING_REQUIRED
i.nominee1,         --139   NOMINEE1
i.nominee2,         --140   NOMINEE2
i.no_cheque_rejections,         --141   NO_CHEQUE_REJECTIONS
i.no_of_chq_rej_reset_on,         --142   NO_OF_CHQ_REJ_RESET_ON
i.offline_limit,         --143   OFFLINE_LIMIT
i.once_auth,         --144   ONCE_AUTH
i.otherdet,         --145   OTHERDET
i.overdraft_since,         --146   OVERDRAFT_SINCE
i.overline_od_since,         --147   OVERLINE_OD_SINCE
i.passbook_facility,         --148   PASSBOOK_FACILITY
i.pincode,         --149   PINCODE
i.positive_pay_ac,         --150   POSITIVE_PAY_AC
i.previous_statement_balance,         --151   PREVIOUS_STATEMENT_BALANCE
i.previous_statement_balance2,         --152   PREVIOUS_STATEMENT_BALANCE2
i.previous_statement_balance3,         --153   PREVIOUS_STATEMENT_BALANCE3
i.previous_statement_date,         --154   PREVIOUS_STATEMENT_DATE
i.previous_statement_date2,         --155   PREVIOUS_STATEMENT_DATE2
i.previous_statement_date3,         --156   PREVIOUS_STATEMENT_DATE3
i.previous_statement_no,         --157   PREVIOUS_STATEMENT_NO
i.previous_statement_no2,         --158   PREVIOUS_STATEMENT_NO2
i.previous_statement_no3,         --159   PREVIOUS_STATEMENT_NO3
i.prev_ovd_date,         --160   PREV_OVD_DATE
i.prev_tod_since,         --161   PREV_TOD_SINCE
i.product_list,         --162   PRODUCT_LIST
i.prov_ccy_type,         --163   PROV_CCY_TYPE
i.record_stat,         --164   RECORD_STAT
i.referral_required,         --165   REFERRAL_REQUIRED
i.regd_end_date,         --166   REGD_END_DATE
i.regd_periodicity,         --167   REGD_PERIODICITY
i.regd_start_date,         --168   REGD_START_DATE
i.reg_cc_availability,         --169   REG_CC_AVAILABILITY
i.reg_d_applicable,         --170   REG_D_APPLICABLE
i.repl_cust_sig,         --171   REPL_CUST_SIG
i.risk_free_exp_amount,         --172   RISK_FREE_EXP_AMOUNT
i.rtl_required,         --173   RTL_REQUIRED
i.salary_account,         --174   SALARY_ACCOUNT
i.sod_notification_percent,         --175   SOD_NOTIFICATION_PERCENT
i.source_code,         --176   SOURCE_CODE
i.source_seq_no,         --177   SOURCE_SEQ_NO
i.special_condition_product,         --178   SPECIAL_CONDITION_PRODUCT
i.special_condition_txncode,         --179   SPECIAL_CONDITION_TXNCODE
i.spend_analysis_reqd,         --180   SPEND_ANALYSIS_REQD
i.spl_ac_gen,         --181   SPL_AC_GEN
i.stale_days,         --182   STALE_DAYS
i.statement_account,         --183   STATEMENT_ACCOUNT
i.status_change_automatic,         --184   STATUS_CHANGE_AUTOMATIC
i.status_since,         --185   STATUS_SINCE
i.stmt_of_fees_cycle,         --186   STMT_OF_FEES_CYCLE
i.stmt_of_fees_del_channel,         --187   STMT_OF_FEES_DEL_CHANNEL
i.stmt_of_fees_on,         --188   STMT_OF_FEES_ON
i.stmt_of_fees_req,         --189   STMT_OF_FEES_REQ
i.sublimit,         --190   SUBLIMIT
i.sweep_out,         --191   SWEEP_OUT
i.sweep_required,         --192   SWEEP_REQUIRED
i.sweep_type,         --193   SWEEP_TYPE
i.tod_limit,         --194   TOD_LIMIT
i.tod_limit_end_date,         --195   TOD_LIMIT_END_DATE
i.tod_limit_start_date,         --196   TOD_LIMIT_START_DATE
i.tod_since,         --197   TOD_SINCE
i.track_receivable,         --198   TRACK_RECEIVABLE
i.txn_code_list,         --199   TXN_CODE_LIST
i.type_of_chq,         --200   TYPE_OF_CHQ
i.uncoll_funds_end_dt,         --201   UNCOLL_FUNDS_END_DT
i.uncoll_funds_limit,         --202   UNCOLL_FUNDS_LIMIT
i.uncoll_funds_start_dt,         --203   UNCOLL_FUNDS_START_DT
i.validation_digit,         --204   VALIDATION_DIGIT
i.xref,         --205   XREF
i.zakat_exemption);         --206   ZAKAT_EXEMPTION


commit; 

exception
when no_data_found then 
insert into acct_upload_log  values(i.maintenance_seq_no,'STTB_UPLOAD_CUST_ACCOUNT');
commit;

when others then
insert into acct_upload_log  values(i.maintenance_seq_no,'STTB_UPLOAD_CUST_ACCOUNT');
commit;

--select * from cif_upload_log;
--create table acct_upload_log(maint_seq_no number, table_name varchar(100));  
end;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end loop;

dbms_output.put_line('---populating sttb_upload_cust_account : completed');





begin
---XXX2
dbms_output.put_line('---populating sttb_upload_linked_entities : starting');
for i in (select 
trim(a.branch_code)  branch_code,         --1   BRANCH_CODE
trim(a.cust_ac_no)  cust_ac_no,         --2   CUST_AC_NO
trim(a.end_date)  end_date,         --3   END_DATE
trim(a.joint_holder)  joint_holder,         --4   JOINT_HOLDER
trim(c.customer_no)  joint_holder_code,--trim(a.joint_holder_code)  joint_holder_code,         --5   JOINT_HOLDER_CODE
trim(a.joint_holder_description)  joint_holder_description,         --6   JOINT_HOLDER_DESCRIPTION
trim(a.maintenance_seq_no)  maintenance_seq_no,         --7   MAINTENANCE_SEQ_NO
trim(a.source_code)  source_code,         --8   SOURCE_CODE
trim(a.source_seq_no)  source_seq_no,         --9   SOURCE_SEQ_NO
trim(a.start_date)  start_date          --10   START_DATE
from sttb_upload_linked_entities@to_dtn a,
--sttb_upload_cust_account b,
sttm_customer c
where 1=1 --and trim(a.maintenance_seq_no) = trim(b.maintenance_seq_no)
and trim(c.ext_ref_no) =  trim(a.joint_holder_code))
loop



begin
insert into sttb_upload_linked_entities (
branch_code,         --1   BRANCH_CODE
cust_ac_no,         --2   CUST_AC_NO
end_date,         --3   END_DATE
joint_holder,         --4   JOINT_HOLDER
joint_holder_code,         --5   JOINT_HOLDER_CODE
joint_holder_description,         --6   JOINT_HOLDER_DESCRIPTION
maintenance_seq_no,         --7   MAINTENANCE_SEQ_NO
source_code,         --8   SOURCE_CODE
source_seq_no,         --9   SOURCE_SEQ_NO
start_date)         --10   START_DATE

values (
i.branch_code,         --1   BRANCH_CODE
i.cust_ac_no,         --2   CUST_AC_NO
i.end_date,         --3   END_DATE
i.joint_holder,         --4   JOINT_HOLDER
i.joint_holder_code,         --5   JOINT_HOLDER_CODE
i.joint_holder_description,         --6   JOINT_HOLDER_DESCRIPTION
i.maintenance_seq_no,         --7   MAINTENANCE_SEQ_NO
i.source_code,         --8   SOURCE_CODE
i.maintenance_seq_no,         --9   SOURCE_SEQ_NO
i.start_date);         --10   START_DATE


commit; 
exception
when no_data_found then 
insert into acct_upload_log  values(i.maintenance_seq_no,'STTB_UPLOAD_LINKED_ENTITIES');
commit;

when others then
insert into acct_upload_log  values(i.maintenance_seq_no,'STTB_UPLOAD_LINKED_ENTITIES');
commit;

end;

end loop;
dbms_output.put_line('---populating sttb_upload_linked_entities : completed');
end;








end;

/*

truncate table sttb_upload_master;
truncate table sttb_upload_cust_account;
truncate table sttb_upload_linked_entities;
truncate table acct_upload_log;
execute  insert_account_dtn(101);


select * from sttb_upload_master;
select  * from sttb_upload_cust_account;
select  * from sttb_upload_linked_entities;
select  * from acct_upload_log;
-----------------------

select * from sttb_upload_cust_account where maintenance_seq_no = '21088538';
select  * from sttb_upload_linked_entities where maintenance_seq_no = '21088538';

truncate table cif_upload_log;
truncate table  sttb_upload_master;
truncate table  STTM_UPLOAD_CUSTOMER;
truncate table  STTM_UPLOAD_CUST_PERSONAL;
truncate table STTM_UPLOAD_CUST_CORPORATE;
execute insert_customer_dtn();
select * from sttm_upload_customer where ext_ref_no in (select a.ext_ref_no from sttm_customer a);

select  * from cif_upload_log;
select * from sttm_upload_customer;
select * from STTM_UPLOAD_CUST_PERSONAL;
select * from STTM_UPLOAD_CUST_CORPORATE;
select  count(*) from cif_upload_log;
truncate
 
select table_name, count(*) from cif_upload_log group by table_name;
select * from sttm_upload_customer;


select distinct table_name from cif_upload_log;
select maintenance_seq_no,branch_code from  sttm_upload_customer_ft@ampdblink where maintenance_seq_no in (select maint_seq_no from cif_upload_log where table_name = 'STTM_UPLOAD_CUSTOMER'); 
select maintenance_seq_no,tel_isd_no from  STTM_UPLOAD_CUST_PERSONALTG@AMPDBLINK where maintenance_seq_no in (select maint_seq_no from cif_upload_log where table_name = 'STTM_UPLOAD_CUST_PERSONAL'); 
select * from STTM_UPLOAD_CUST_CORPORATETG@AMPDBLINK where maintenance_seq_no in (select maint_seq_no from cif_upload_log where table_name = 'STTM_UPLOAD_CUST_CORPORATE');

tel_isd_no


select * from STTM_UPLOAD_CUST_PERSONAL;


-------------------------------------------------
truncate table  cvtb_upload_master;
truncate table  sttb_upload_master;
truncate table  cstb_upload_exception;
-------------------------------------------------
truncate table  STTM_UPLOAD_CUSTOMER;
truncate table  STTM_UPLOAD_CUST_PERSONAL;
truncate table  STTM_UPLOAD_CUST_PROFESSIONAL;
truncate table  STTM_UPLOAD_CORP_DIRECTORS;
truncate table  STTM_UPLOAD_CUST_CORPORATE;
truncate table  STTM_UPLOAD_CUST_DOMESTIC;
truncate table  STTM_AUTO_LIAB_UPLOAD;
-------------------------------------------------
select * from sttm_trn_code;
select * from STTM_UPLOAD_CUST_DOMESTIC;
SELECT * FROM STTM_UPLOAD_CORP_DIRECTORS_FT@AMPDBLINK;
*/