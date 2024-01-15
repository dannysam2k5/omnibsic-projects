create or replace procedure z_insert_customer_ampl as 
a number;
sys_date date;
maker_idd varchar2(50);
checker_idd varchar2(50);
in_source_code varchar2(100);


begin

maker_idd:='MIG_USER01';
checker_idd:='MIG_USER02';
in_source_code := 'DTN_CUST_UPD';

---XXX1
dbms_output.put_line('---populating sttm_upload_customer : starting');
for i in (
select 
trim(action_code)  action_code,         --1   ACTION_CODE
trim(address_line1)  address_line1,         --2   ADDRESS_LINE1
trim(address_line2)  address_line2,         --3   ADDRESS_LINE2
trim(address_line3)  address_line3,         --4   ADDRESS_LINE3
trim(address_line4)  address_line4,         --5   ADDRESS_LINE4
trim(alg_id)  alg_id,         --6   ALG_ID
trim(allow_vrtl_accnts)  allow_vrtl_accnts,         --7   ALLOW_VRTL_ACCNTS
trim(aml_customer_grp)  aml_customer_grp,         --8   AML_CUSTOMER_GRP
trim(aml_required)  aml_required,         --9   AML_REQUIRED
trim(ar_ap_tracking)  ar_ap_tracking,         --10   AR_AP_TRACKING
trim(autogen_stmtplan)  autogen_stmtplan,         --11   AUTOGEN_STMTPLAN
trim(auto_create_account)  auto_create_account,         --12   AUTO_CREATE_ACCOUNT
trim(auto_cust_ac_no)  auto_cust_ac_no,         --13   AUTO_CUST_AC_NO
trim(branch_code)  branch_code,         --14   BRANCH_CODE
trim(cas_cust)  cas_cust,         --15   CAS_CUST
trim(charge_group)  charge_group,         --16   CHARGE_GROUP
trim(checker_dt_stamp)  checker_dt_stamp,         --17   CHECKER_DT_STAMP
trim(checker_id)  checker_id,         --18   CHECKER_ID
trim(chk_digit_valid_reqd)  chk_digit_valid_reqd,         --19   CHK_DIGIT_VALID_REQD
trim(cif_creation_date)  cif_creation_date,         --20   CIF_CREATION_DATE
trim(cif_status)  cif_status,         --21   CIF_STATUS
trim(cif_status_since)  cif_status_since,         --22   CIF_STATUS_SINCE
trim(cls_ccy_allowed)  cls_ccy_allowed,         --23   CLS_CCY_ALLOWED
trim(cls_participant)  cls_participant,         --24   CLS_PARTICIPANT
trim(consol_tax_cert_reqd)  consol_tax_cert_reqd,         --25   CONSOL_TAX_CERT_REQD
trim(conversion_status_flag)  conversion_status_flag,         --26   CONVERSION_STATUS_FLAG
trim(country)  country,         --27   COUNTRY
trim(credit_rating)  credit_rating,         --28   CREDIT_RATING
trim(crm_customer)  crm_customer,         --29   CRM_CUSTOMER
trim(crs_type)  crs_type,         --30   CRS_TYPE
trim(customer_category)  customer_category,         --31   CUSTOMER_CATEGORY
trim(customer_name1)  customer_name1,         --32   CUSTOMER_NAME1
trim(customer_no)  customer_no,         --33   CUSTOMER_NO
trim(customer_type)  customer_type,         --34   CUSTOMER_TYPE
trim(cust_classification)  cust_classification,         --35   CUST_CLASSIFICATION
trim(cust_clg_group)  cust_clg_group,         --36   CUST_CLG_GROUP
trim(cust_unadvised)  cust_unadvised,         --37   CUST_UNADVISED
trim(debtor_category)  debtor_category,         --38   DEBTOR_CATEGORY
trim(deceased)  deceased,         --39   DECEASED
trim(default_media)  default_media,         --40   DEFAULT_MEDIA
trim(elcm_customer)  elcm_customer,         --41   ELCM_CUSTOMER
trim(err_msg)  err_msg,         --42   ERR_MSG
trim(exposure_category)  exposure_category,         --43   EXPOSURE_CATEGORY
trim(exposure_country)  exposure_country,         --44   EXPOSURE_COUNTRY
trim(ext_ref_no)  ext_ref_no,         --45   EXT_REF_NO
trim(fax_number)  fax_number,         --46   FAX_NUMBER
trim(frequency)  frequency,         --47   FREQUENCY
trim(frozen)  frozen,         --48   FROZEN
trim(ft_accting_as_of)  ft_accting_as_of,         --49   FT_ACCTING_AS_OF
trim(full_name)  full_name,         --50   FULL_NAME
trim(fx_clean_risk_limit)  fx_clean_risk_limit,         --51   FX_CLEAN_RISK_LIMIT
trim(fx_cust_clean_risk_limit)  fx_cust_clean_risk_limit,         --52   FX_CUST_CLEAN_RISK_LIMIT
trim(fx_netting_customer)  fx_netting_customer,         --53   FX_NETTING_CUSTOMER
trim(generate_mt920)  generate_mt920,         --54   GENERATE_MT920
trim(group_code)  group_code,         --55   GROUP_CODE
trim(ho_ac_no)  ho_ac_no,         --56   HO_AC_NO
trim(individual_tax_cert_reqd)  individual_tax_cert_reqd,         --57   INDIVIDUAL_TAX_CERT_REQD
trim(introducer)  introducer,         --58   INTRODUCER
trim(invest_cust)  invest_cust,         --59   INVEST_CUST
trim(issuer_customer)  issuer_customer,         --60   ISSUER_CUSTOMER
trim(joint_venture)  joint_venture,         --61   JOINT_VENTURE
trim(kyc_details)  kyc_details,         --62   KYC_DETAILS
trim(kyc_ref_no)  kyc_ref_no,         --63   KYC_REF_NO
trim(language)  language,         --64   LANGUAGE
trim(lc_collateral_pct)  lc_collateral_pct,         --65   LC_COLLATERAL_PCT
trim(liability_no)  liability_no,         --66   LIABILITY_NO
trim(liab_br)  liab_br,         --67   LIAB_BR
trim(liab_node)  liab_node,         --68   LIAB_NODE
trim(liab_unadvised)  liab_unadvised,         --69   LIAB_UNADVISED
trim(limit_ccy)  limit_ccy,         --70   LIMIT_CCY
trim(local_branch)  local_branch,         --71   LOCAL_BRANCH
trim(loc_code)  loc_code,         --72   LOC_CODE
trim(mailers_required)  mailers_required,         --73   MAILERS_REQUIRED
trim(maintenance_seq_no)  maintenance_seq_no,         --74   MAINTENANCE_SEQ_NO
trim(maker_dt_stamp)  maker_dt_stamp,         --75   MAKER_DT_STAMP
trim(maker_id)  maker_id,         --76   MAKER_ID
trim(mfi_customer)  mfi_customer,         --77   MFI_CUSTOMER
trim(nationality)  nationality,         --78   NATIONALITY
trim(overall_limit)  overall_limit,         --79   OVERALL_LIMIT
trim(past_due_flag)  past_due_flag,         --80   PAST_DUE_FLAG
trim(pincode)  pincode,         --81   PINCODE
trim(private_customer)  private_customer,         --82   PRIVATE_CUSTOMER
trim(revision_date)  revision_date,         --83   REVISION_DATE
trim(risk_category)  risk_category,         --84   RISK_CATEGORY
trim(risk_profile)  risk_profile,         --85   RISK_PROFILE
trim(rm_id)  rm_id,         --86   RM_ID
trim(rp_customer)  rp_customer,         --87   RP_CUSTOMER
trim(sec_clean_risk_limit)  sec_clean_risk_limit,         --88   SEC_CLEAN_RISK_LIMIT
trim(sec_cust_clean_risk_limit)  sec_cust_clean_risk_limit,         --89   SEC_CUST_CLEAN_RISK_LIMIT
trim(sec_cust_pstl_risk_limit)  sec_cust_pstl_risk_limit,         --90   SEC_CUST_PSTL_RISK_LIMIT
trim(sec_pstl_risk_limit)  sec_pstl_risk_limit,         --91   SEC_PSTL_RISK_LIMIT
trim(short_name)  short_name,         --92   SHORT_NAME
trim(short_name2)  short_name2,         --93   SHORT_NAME2
trim(source_code)  source_code,         --94   SOURCE_CODE
trim(source_seq_no)  source_seq_no,         --95   SOURCE_SEQ_NO
trim(special_cust)  special_cust,         --96   SPECIAL_CUST
trim(ssn)  ssn,         --97   SSN
trim(staff)  staff,         --98   STAFF
trim(stmt_day)  stmt_day,         --99   STMT_DAY
trim(swift_code)  swift_code,         --100   SWIFT_CODE
trim(taxid_no)  taxid_no,         --101   TAXID_NO
trim(tax_cntry)  tax_cntry,         --102   TAX_CNTRY
trim(tax_group)  tax_group,         --103   TAX_GROUP
trim(track_limits)  track_limits,         --104   TRACK_LIMITS
trim(treasury_customer)  treasury_customer,         --105   TREASURY_CUSTOMER
trim(udf_1)  udf_1,         --106   UDF_1
trim(udf_2)  udf_2,         --107   UDF_2
trim(udf_3)  udf_3,         --108   UDF_3
trim(udf_4)  udf_4,         --109   UDF_4
trim(udf_5)  udf_5,         --110   UDF_5
trim(unique_id_name)  unique_id_name,         --111   UNIQUE_ID_NAME
trim(unique_id_value)  unique_id_value,         --112   UNIQUE_ID_VALUE
trim(utility_provider)  utility_provider,         --113   UTILITY_PROVIDER
trim(utility_provider_id)  utility_provider_id,         --114   UTILITY_PROVIDER_ID
trim(utility_provider_type)  utility_provider_type,         --115   UTILITY_PROVIDER_TYPE
trim(vrtl_customer_id)  vrtl_customer_id,         --116   VRTL_CUSTOMER_ID
trim(whereabouts_unknown)  whereabouts_unknown,         --117   WHEREABOUTS_UNKNOWN
trim(wht_pct)  wht_pct,         --118   WHT_PCT
trim(withholding_tax)  withholding_tax          --119   WITHHOLDING_TAX
from  sttm_upload_customer@ampdblink
where trim(ext_ref_no) not in (select trim(a.ext_ref_no) from sttm_customer a where a.ext_ref_no is not null)/*where rownum < 1001*/)
loop
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
begin

insert into sttm_upload_customer (
action_code,         --1   ACTION_CODE
address_line1,         --2   ADDRESS_LINE1
address_line2,         --3   ADDRESS_LINE2
address_line3,         --4   ADDRESS_LINE3
address_line4,         --5   ADDRESS_LINE4
alg_id,         --6   ALG_ID
allow_vrtl_accnts,         --7   ALLOW_VRTL_ACCNTS
aml_customer_grp,         --8   AML_CUSTOMER_GRP
aml_required,         --9   AML_REQUIRED
ar_ap_tracking,         --10   AR_AP_TRACKING
autogen_stmtplan,         --11   AUTOGEN_STMTPLAN
auto_create_account,         --12   AUTO_CREATE_ACCOUNT
auto_cust_ac_no,         --13   AUTO_CUST_AC_NO
branch_code,         --14   BRANCH_CODE
cas_cust,         --15   CAS_CUST
charge_group,         --16   CHARGE_GROUP
checker_dt_stamp,         --17   CHECKER_DT_STAMP
checker_id,         --18   CHECKER_ID
chk_digit_valid_reqd,         --19   CHK_DIGIT_VALID_REQD
cif_creation_date,         --20   CIF_CREATION_DATE
cif_status,         --21   CIF_STATUS
cif_status_since,         --22   CIF_STATUS_SINCE
cls_ccy_allowed,         --23   CLS_CCY_ALLOWED
cls_participant,         --24   CLS_PARTICIPANT
consol_tax_cert_reqd,         --25   CONSOL_TAX_CERT_REQD
conversion_status_flag,         --26   CONVERSION_STATUS_FLAG
country,         --27   COUNTRY
credit_rating,         --28   CREDIT_RATING
crm_customer,         --29   CRM_CUSTOMER
crs_type,         --30   CRS_TYPE
customer_category,         --31   CUSTOMER_CATEGORY
customer_name1,         --32   CUSTOMER_NAME1
customer_no,         --33   CUSTOMER_NO
customer_type,         --34   CUSTOMER_TYPE
cust_classification,         --35   CUST_CLASSIFICATION
cust_clg_group,         --36   CUST_CLG_GROUP
cust_unadvised,         --37   CUST_UNADVISED
debtor_category,         --38   DEBTOR_CATEGORY
deceased,         --39   DECEASED
default_media,         --40   DEFAULT_MEDIA
elcm_customer,         --41   ELCM_CUSTOMER
err_msg,         --42   ERR_MSG
exposure_category,         --43   EXPOSURE_CATEGORY
exposure_country,         --44   EXPOSURE_COUNTRY
ext_ref_no,         --45   EXT_REF_NO
fax_number,         --46   FAX_NUMBER
frequency,         --47   FREQUENCY
frozen,         --48   FROZEN
ft_accting_as_of,         --49   FT_ACCTING_AS_OF
full_name,         --50   FULL_NAME
fx_clean_risk_limit,         --51   FX_CLEAN_RISK_LIMIT
fx_cust_clean_risk_limit,         --52   FX_CUST_CLEAN_RISK_LIMIT
fx_netting_customer,         --53   FX_NETTING_CUSTOMER
generate_mt920,         --54   GENERATE_MT920
group_code,         --55   GROUP_CODE
ho_ac_no,         --56   HO_AC_NO
individual_tax_cert_reqd,         --57   INDIVIDUAL_TAX_CERT_REQD
introducer,         --58   INTRODUCER
invest_cust,         --59   INVEST_CUST
issuer_customer,         --60   ISSUER_CUSTOMER
joint_venture,         --61   JOINT_VENTURE
kyc_details,         --62   KYC_DETAILS
kyc_ref_no,         --63   KYC_REF_NO
language,         --64   LANGUAGE
lc_collateral_pct,         --65   LC_COLLATERAL_PCT
liability_no,         --66   LIABILITY_NO
liab_br,         --67   LIAB_BR
liab_node,         --68   LIAB_NODE
liab_unadvised,         --69   LIAB_UNADVISED
limit_ccy,         --70   LIMIT_CCY
local_branch,         --71   LOCAL_BRANCH
loc_code,         --72   LOC_CODE
mailers_required,         --73   MAILERS_REQUIRED
maintenance_seq_no,         --74   MAINTENANCE_SEQ_NO
maker_dt_stamp,         --75   MAKER_DT_STAMP
maker_id,         --76   MAKER_ID
mfi_customer,         --77   MFI_CUSTOMER
nationality,         --78   NATIONALITY
overall_limit,         --79   OVERALL_LIMIT
past_due_flag,         --80   PAST_DUE_FLAG
pincode,         --81   PINCODE
private_customer,         --82   PRIVATE_CUSTOMER
revision_date,         --83   REVISION_DATE
risk_category,         --84   RISK_CATEGORY
risk_profile,         --85   RISK_PROFILE
rm_id,         --86   RM_ID
rp_customer,         --87   RP_CUSTOMER
sec_clean_risk_limit,         --88   SEC_CLEAN_RISK_LIMIT
sec_cust_clean_risk_limit,         --89   SEC_CUST_CLEAN_RISK_LIMIT
sec_cust_pstl_risk_limit,         --90   SEC_CUST_PSTL_RISK_LIMIT
sec_pstl_risk_limit,         --91   SEC_PSTL_RISK_LIMIT
short_name,         --92   SHORT_NAME
short_name2,         --93   SHORT_NAME2
source_code,         --94   SOURCE_CODE
source_seq_no,         --95   SOURCE_SEQ_NO
special_cust,         --96   SPECIAL_CUST
ssn,         --97   SSN
staff,         --98   STAFF
stmt_day,         --99   STMT_DAY
swift_code,         --100   SWIFT_CODE
taxid_no,         --101   TAXID_NO
tax_cntry,         --102   TAX_CNTRY
tax_group,         --103   TAX_GROUP
track_limits,         --104   TRACK_LIMITS
treasury_customer,         --105   TREASURY_CUSTOMER
udf_1,         --106   UDF_1
udf_2,         --107   UDF_2
udf_3,         --108   UDF_3
udf_4,         --109   UDF_4
udf_5,         --110   UDF_5
unique_id_name,         --111   UNIQUE_ID_NAME
unique_id_value,         --112   UNIQUE_ID_VALUE
utility_provider,         --113   UTILITY_PROVIDER
utility_provider_id,         --114   UTILITY_PROVIDER_ID
utility_provider_type,         --115   UTILITY_PROVIDER_TYPE
vrtl_customer_id,         --116   VRTL_CUSTOMER_ID
whereabouts_unknown,         --117   WHEREABOUTS_UNKNOWN
wht_pct,         --118   WHT_PCT
withholding_tax)         --119   WITHHOLDING_TAX


values (
i.action_code,         --1   ACTION_CODE
i.address_line1,         --2   ADDRESS_LINE1
i.address_line2,         --3   ADDRESS_LINE2
i.address_line3,         --4   ADDRESS_LINE3
i.address_line4,         --5   ADDRESS_LINE4
i.alg_id,         --6   ALG_ID
null,         --7   ALLOW_VRTL_ACCNTS
i.aml_customer_grp,         --8   AML_CUSTOMER_GRP
i.aml_required,         --9   AML_REQUIRED
i.ar_ap_tracking,         --10   AR_AP_TRACKING
null,         --11   AUTOGEN_STMTPLAN
i.auto_create_account,         --12   AUTO_CREATE_ACCOUNT
i.auto_cust_ac_no,         --13   AUTO_CUST_AC_NO
i.branch_code,         --14   BRANCH_CODE
i.cas_cust,         --15   CAS_CUST
i.charge_group,         --16   CHARGE_GROUP
i.checker_dt_stamp,         --17   CHECKER_DT_STAMP
i.checker_id,         --18   CHECKER_ID
i.chk_digit_valid_reqd,         --19   CHK_DIGIT_VALID_REQD
i.cif_creation_date,         --20   CIF_CREATION_DATE
i.cif_status,         --21   CIF_STATUS
i.cif_status_since,         --22   CIF_STATUS_SINCE
i.cls_ccy_allowed,         --23   CLS_CCY_ALLOWED
i.cls_participant,         --24   CLS_PARTICIPANT
i.consol_tax_cert_reqd,         --25   CONSOL_TAX_CERT_REQD
i.conversion_status_flag,         --26   CONVERSION_STATUS_FLAG
i.country,         --27   COUNTRY
i.credit_rating,         --28   CREDIT_RATING
i.crm_customer,         --29   CRM_CUSTOMER
i.crs_type,         --30   CRS_TYPE
i.customer_category,         --31   CUSTOMER_CATEGORY
i.customer_name1,         --32   CUSTOMER_NAME1
i.customer_no,         --33   CUSTOMER_NO
i.customer_type,         --34   CUSTOMER_TYPE
i.cust_classification,         --35   CUST_CLASSIFICATION
i.cust_clg_group,         --36   CUST_CLG_GROUP
i.cust_unadvised,         --37   CUST_UNADVISED
i.debtor_category,         --38   DEBTOR_CATEGORY
i.deceased,         --39   DECEASED
i.default_media,         --40   DEFAULT_MEDIA
null,         --41   ELCM_CUSTOMER
i.err_msg,         --42   ERR_MSG
i.exposure_category,         --43   EXPOSURE_CATEGORY
i.exposure_country,         --44   EXPOSURE_COUNTRY
i.ext_ref_no,         --45   EXT_REF_NO
i.fax_number,         --46   FAX_NUMBER
null,         --47   FREQUENCY
i.frozen,         --48   FROZEN
i.ft_accting_as_of,         --49   FT_ACCTING_AS_OF
i.full_name,         --50   FULL_NAME
i.fx_clean_risk_limit,         --51   FX_CLEAN_RISK_LIMIT
i.fx_cust_clean_risk_limit,         --52   FX_CUST_CLEAN_RISK_LIMIT
i.fx_netting_customer,         --53   FX_NETTING_CUSTOMER
null,         --54   GENERATE_MT920
i.group_code,         --55   GROUP_CODE
i.ho_ac_no,         --56   HO_AC_NO
i.individual_tax_cert_reqd,         --57   INDIVIDUAL_TAX_CERT_REQD
i.introducer,         --58   INTRODUCER
null,         --59   INVEST_CUST
i.issuer_customer,         --60   ISSUER_CUSTOMER
null,         --61   JOINT_VENTURE
null,         --62   KYC_DETAILS
i.kyc_ref_no,         --63   KYC_REF_NO
i.language,         --64   LANGUAGE
i.lc_collateral_pct,         --65   LC_COLLATERAL_PCT
i.liability_no,         --66   LIABILITY_NO
i.liab_br,         --67   LIAB_BR
i.liab_node,         --68   LIAB_NODE
i.liab_unadvised,         --69   LIAB_UNADVISED
i.limit_ccy,         --70   LIMIT_CCY
i.local_branch,         --71   LOCAL_BRANCH
i.loc_code,         --72   LOC_CODE
i.mailers_required,         --73   MAILERS_REQUIRED
i.maintenance_seq_no,         --74   MAINTENANCE_SEQ_NO
i.maker_dt_stamp,         --75   MAKER_DT_STAMP
i.maker_id,         --76   MAKER_ID
null,         --77   MFI_CUSTOMER
i.nationality,         --78   NATIONALITY
i.overall_limit,         --79   OVERALL_LIMIT
i.past_due_flag,         --80   PAST_DUE_FLAG
null,         --81   PINCODE
null,         --82   PRIVATE_CUSTOMER
i.revision_date,         --83   REVISION_DATE
i.risk_category,         --84   RISK_CATEGORY
i.risk_profile,         --85   RISK_PROFILE
null,         --86   RM_ID
null,         --87   RP_CUSTOMER
i.sec_clean_risk_limit,         --88   SEC_CLEAN_RISK_LIMIT
i.sec_cust_clean_risk_limit,         --89   SEC_CUST_CLEAN_RISK_LIMIT
i.sec_cust_pstl_risk_limit,         --90   SEC_CUST_PSTL_RISK_LIMIT
i.sec_pstl_risk_limit,         --91   SEC_PSTL_RISK_LIMIT
i.short_name,         --92   SHORT_NAME
i.short_name2,         --93   SHORT_NAME2
in_source_code,         --94   SOURCE_CODE
i.source_seq_no,         --95   SOURCE_SEQ_NO
i.special_cust,         --96   SPECIAL_CUST
i.ssn,         --97   SSN
i.staff,         --98   STAFF
null,         --99   STMT_DAY
i.swift_code,         --100   SWIFT_CODE
i.taxid_no,         --101   TAXID_NO
i.tax_cntry,         --102   TAX_CNTRY
i.tax_group,         --103   TAX_GROUP
i.track_limits,         --104   TRACK_LIMITS
i.treasury_customer,         --105   TREASURY_CUSTOMER
i.udf_1,         --106   UDF_1
i.udf_2,         --107   UDF_2
i.udf_3,         --108   UDF_3
i.udf_4,         --109   UDF_4
i.udf_5,         --110   UDF_5
i.unique_id_name,         --111   UNIQUE_ID_NAME
i.unique_id_value,         --112   UNIQUE_ID_VALUE
i.utility_provider,         --113   UTILITY_PROVIDER
i.utility_provider_id,         --114   UTILITY_PROVIDER_ID
null,         --115   UTILITY_PROVIDER_TYPE
null,         --116   VRTL_CUSTOMER_ID
i.whereabouts_unknown,         --117   WHEREABOUTS_UNKNOWN
null,         --118   WHT_PCT
i.withholding_tax);         --119   WITHHOLDING_TAX

commit; 

exception
when no_data_found then 
insert into cif_upload_log  values(i.maintenance_seq_no,'STTM_UPLOAD_CUSTOMER');
commit;

when others then
insert into cif_upload_log  values(i.maintenance_seq_no,'STTM_UPLOAD_CUSTOMER');
commit;

--select * from cif_upload_log;
--create table cif_upload_log(maint_seq_no number, table_name varchar(100));  
end;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end loop;

dbms_output.put_line('---populating sttm_upload_customer : completed');





begin
---XXX2
dbms_output.put_line('---populating sttm_upload_cust_personal : starting');
for i in ( 
select 
a.CUSTOMER_PREFIX           ,
a.FIRST_NAME                ,
a.MIDDLE_NAME               ,
a.LAST_NAME                 ,
a.date_of_birth, ---to_date(a.date_of_birth,'dd/mm/rrrr') date_of_birth,
a.LEGAL_GUARDIAN            ,
a.MINOR                     ,
a.SEX                       ,
a.P_NATIONAL_ID             ,
a.PASSPORT_NO               ,
a.PPT_ISS_DATE              ,
a.PPT_EXP_DATE              ,
a.D_ADDRESS1                ,
a.D_ADDRESS2                ,
a.D_ADDRESS3                ,
a.TELEPHONE                 ,
a.FAX                       ,
a.E_MAIL                    ,
a.P_ADDRESS1                ,
a.P_ADDRESS3                ,
a.P_ADDRESS2                ,
a.CUSTOMER_NO               ,
a.D_COUNTRY                 ,
a.P_COUNTRY                 ,
a.RESIDENT_STATUS           ,
a.CONVERSION_STATUS_FLAG    ,
a.ERR_MSG                   ,
a.MAINTENANCE_SEQ_NO        ,
a.CUSTOMER_PREFIX1          ,
a.CUSTOMER_PREFIX2          ,
a.SOURCE_SEQ_NO             ,
a.BRANCH_CODE               ,
a.SOURCE_CODE               ,
a.AGE_PROOF_SUBMITTED       ,
a.P_ADDRESS4                ,
a.D_ADDRESS4                ,
a.PLACE_OF_BIRTH            ,
a.BIRTH_COUNTRY             ,
a.TEL_ISD_NO                ,
a.MOB_ISD_NO                ,
a.FAX_ISD_NO                ,
a.US_RES_STATUS             ,
a.PA_ISSUED                 ,
a.PA_HOLDER_NAME            ,
a.PA_HOLDER_NATIONALTY      ,
a.PA_HOLDER_ADDR            ,
a.PA_HOLDER_ADDR_COUNTRY    ,
a.PA_HOLDER_TEL_ISD         ,
a.PA_HOLDER_TEL_NO          ,
a.VST_US_PREV               ,
a.MOBILE_NUMBER             ,
a.CUST_COMM_MODE            ,
a.HOME_TEL_NO               ,
a.HOME_TEL_ISD              ,
a.P_PINCODE                 ,
a.PREF_CONTACT_DT           ,
a.PREF_CONTACT_TIME         ,
a.D_PINCODE                 ,
a.MOTHER_MAIDEN_NAME                 
from  
sttm_upload_cust_personal@ampdblink a,
sttm_upload_customer b
where a.maintenance_seq_no = b.maintenance_seq_no
--and a.maintenance_seq_no in ('12000026','12000126','12001570')
)
loop

begin
insert into sttm_upload_cust_personal (
age_proof_submitted,         --1   AGE_PROOF_SUBMITTED
birth_country,         --2   BIRTH_COUNTRY
branch_code,         --3   BRANCH_CODE
conversion_status_flag,         --4   CONVERSION_STATUS_FLAG
customer_no,         --5   CUSTOMER_NO
customer_prefix,         --6   CUSTOMER_PREFIX
customer_prefix1,         --7   CUSTOMER_PREFIX1
customer_prefix2,         --8   CUSTOMER_PREFIX2
cust_comm_mode,         --9   CUST_COMM_MODE
date_of_birth,         --10   DATE_OF_BIRTH
d_address1,         --11   D_ADDRESS1
d_address2,         --12   D_ADDRESS2
d_address3,         --13   D_ADDRESS3
d_address4,         --14   D_ADDRESS4
d_country,         --15   D_COUNTRY
d_pincode,         --16   D_PINCODE
err_msg,         --17   ERR_MSG
e_mail,         --18   E_MAIL
fax,         --19   FAX
fax_isd_no,         --20   FAX_ISD_NO
first_name,         --21   FIRST_NAME
home_tel_isd,         --22   HOME_TEL_ISD
home_tel_no,         --23   HOME_TEL_NO
last_name,         --24   LAST_NAME
legal_guardian,         --25   LEGAL_GUARDIAN
maintenance_seq_no,         --26   MAINTENANCE_SEQ_NO
middle_name,         --27   MIDDLE_NAME
minor,         --28   MINOR
mobile_number,         --29   MOBILE_NUMBER
mob_isd_no,         --30   MOB_ISD_NO
mother_maiden_name,         --31   MOTHER_MAIDEN_NAME
passport_no,         --32   PASSPORT_NO
pa_holder_addr,         --33   PA_HOLDER_ADDR
pa_holder_addr_country,         --34   PA_HOLDER_ADDR_COUNTRY
pa_holder_name,         --35   PA_HOLDER_NAME
pa_holder_nationalty,         --36   PA_HOLDER_NATIONALTY
pa_holder_tel_isd,         --37   PA_HOLDER_TEL_ISD
pa_holder_tel_no,         --38   PA_HOLDER_TEL_NO
pa_issued,         --39   PA_ISSUED
place_of_birth,         --40   PLACE_OF_BIRTH
ppt_exp_date,         --41   PPT_EXP_DATE
ppt_iss_date,         --42   PPT_ISS_DATE
pref_contact_dt,         --43   PREF_CONTACT_DT
pref_contact_time,         --44   PREF_CONTACT_TIME
p_address1,         --45   P_ADDRESS1
p_address2,         --46   P_ADDRESS2
p_address3,         --47   P_ADDRESS3
p_address4,         --48   P_ADDRESS4
p_country,         --49   P_COUNTRY
p_national_id,         --50   P_NATIONAL_ID
p_pincode,         --51   P_PINCODE
resident_status,         --52   RESIDENT_STATUS
sex,         --53   SEX
source_code,         --54   SOURCE_CODE
source_seq_no,         --55   SOURCE_SEQ_NO
telephone,         --56   TELEPHONE
tel_isd_no,         --57   TEL_ISD_NO
us_res_status,         --58   US_RES_STATUS
vst_us_prev)         --59   VST_US_PREV


values(
i.age_proof_submitted,         --1   AGE_PROOF_SUBMITTED
i.birth_country,         --2   BIRTH_COUNTRY
i.branch_code,         --3   BRANCH_CODE
i.conversion_status_flag,         --4   CONVERSION_STATUS_FLAG
i.customer_no,         --5   CUSTOMER_NO
i.customer_prefix,         --6   CUSTOMER_PREFIX
i.customer_prefix1,         --7   CUSTOMER_PREFIX1
i.customer_prefix2,         --8   CUSTOMER_PREFIX2
i.cust_comm_mode,         --9   CUST_COMM_MODE
i.date_of_birth,         --10   DATE_OF_BIRTH
i.d_address1,         --11   D_ADDRESS1
i.d_address2,         --12   D_ADDRESS2
i.d_address3,         --13   D_ADDRESS3
i.d_address4,         --14   D_ADDRESS4
i.d_country,         --15   D_COUNTRY
null,         --16   D_PINCODE
i.err_msg,         --17   ERR_MSG
i.e_mail,         --18   E_MAIL
i.fax,         --19   FAX
i.fax_isd_no,         --20   FAX_ISD_NO
i.first_name,         --21   FIRST_NAME
null,         --22   HOME_TEL_ISD
null,         --23   HOME_TEL_NO
i.last_name,         --24   LAST_NAME
i.legal_guardian,         --25   LEGAL_GUARDIAN
i.maintenance_seq_no,         --26   MAINTENANCE_SEQ_NO
i.middle_name,         --27   MIDDLE_NAME
i.minor,         --28   MINOR
i.mobile_number,         --29   MOBILE_NUMBER
i.mob_isd_no,         --30   MOB_ISD_NO
null,         --31   MOTHER_MAIDEN_NAME
i.passport_no,         --32   PASSPORT_NO
i.pa_holder_addr,         --33   PA_HOLDER_ADDR
i.pa_holder_addr_country,         --34   PA_HOLDER_ADDR_COUNTRY
i.pa_holder_name,         --35   PA_HOLDER_NAME
i.pa_holder_nationalty,         --36   PA_HOLDER_NATIONALTY
i.pa_holder_tel_isd,         --37   PA_HOLDER_TEL_ISD
i.pa_holder_tel_no,         --38   PA_HOLDER_TEL_NO
i.pa_issued,         --39   PA_ISSUED
i.place_of_birth,         --40   PLACE_OF_BIRTH
i.ppt_exp_date,         --41   PPT_EXP_DATE
i.ppt_iss_date,         --42   PPT_ISS_DATE
null,         --43   PREF_CONTACT_DT
null,         --44   PREF_CONTACT_TIME
i.p_address1,         --45   P_ADDRESS1
i.p_address2,         --46   P_ADDRESS2
i.p_address3,         --47   P_ADDRESS3
i.p_address4,         --48   P_ADDRESS4
i.p_country,         --49   P_COUNTRY
i.p_national_id,         --50   P_NATIONAL_ID
null,         --51   P_PINCODE
i.resident_status,         --52   RESIDENT_STATUS
i.sex,         --53   SEX
in_source_code,         --54   SOURCE_CODE
i.source_seq_no,         --55   SOURCE_SEQ_NO
i.telephone,         --56   TELEPHONE
i.tel_isd_no,         --57   TEL_ISD_NO
i.us_res_status,         --58   US_RES_STATUS
i.vst_us_prev);         --59   VST_US_PREV

commit; 
exception
when no_data_found then 
insert into cif_upload_log  values(i.maintenance_seq_no,'STTM_UPLOAD_CUST_PERSONAL');
commit;

when others then
insert into cif_upload_log  values(i.maintenance_seq_no,'STTM_UPLOAD_CUST_PERSONAL');
commit;

end;

end loop;
dbms_output.put_line('---populating sttm_upload_cust_personal : completed');
end;






begin
---XXX3
dbms_output.put_line('---populating sttm_upload_cust_corporate : starting');
for i in (select a.* 
from  
sttm_upload_cust_corporate@ampdblink a,
sttm_upload_customer b
where a.maintenance_seq_no = b.maintenance_seq_no

/*
select * from sttm_upload_customer@ampdblink where maintenance_seq_no not in  (select maintenance_seq_no from sttm_upload_cust_corporate@ampdblink);
select * from sttm_upload_cust_corporate@ampdblink where maintenance_seq_no not in  (select maintenance_seq_no from sttm_upload_customer@ampdblink);
select * from sttm_upload_customer@ampdblink where maintenance_seq_no in ('12043283','12036788','12044575','12037486','12039870','12040058','12032223','12032224',
'12032225','12032226','12032227','12032244','12032245','12032247','12045303','12042116','12042151','12042324');
*/
)
loop

begin
insert into sttm_upload_cust_corporate (
amounts_ccy,         --1   AMOUNTS_CCY
branch_code,         --2   BRANCH_CODE
business_description,         --3   BUSINESS_DESCRIPTION
capital,         --4   CAPITAL
conversion_status_flag,         --5   CONVERSION_STATUS_FLAG
corporate_name,         --6   CORPORATE_NAME
customer_no,         --7   CUSTOMER_NO
c_national_id,         --8   C_NATIONAL_ID
err_msg,         --9   ERR_MSG
incorp_country,         --10   INCORP_COUNTRY
incorp_date,         --11   INCORP_DATE
maintenance_seq_no,         --12   MAINTENANCE_SEQ_NO
networth,         --13   NETWORTH
ownership_type,         --14   OWNERSHIP_TYPE
pref_contact_dt,         --15   PREF_CONTACT_DT
pref_contact_time,         --16   PREF_CONTACT_TIME
r_address1,         --17   R_ADDRESS1
r_address2,         --18   R_ADDRESS2
r_address3,         --19   R_ADDRESS3
r_address4,         --20   R_ADDRESS4
r_country,         --21   R_COUNTRY
r_pincode,         --22   R_PINCODE
source_code,         --23   SOURCE_CODE
source_seq_no)         --24   SOURCE_SEQ_NO



values(
i.amounts_ccy,         --1   AMOUNTS_CCY
i.branch_code,         --2   BRANCH_CODE
i.business_description,         --3   BUSINESS_DESCRIPTION
0 ,         --4   CAPITAL                                                                            ---- daneil to fix
'U',         --5   CONVERSION_STATUS_FLAG
i.corporate_name,         --6   CORPORATE_NAME
i.customer_no,         --7   CUSTOMER_NO
i.c_national_id,         --8   C_NATIONAL_ID
i.err_msg,         --9   ERR_MSG
i.incorp_country,         --10   INCORP_COUNTRY
i.incorp_date,         --11   INCORP_DATE
i.maintenance_seq_no,         --12   MAINTENANCE_SEQ_NO
0,         --13   NETWORTH                                                                           ----NETWORTH
null,         --14   OWNERSHIP_TYPE
null,         --15   PREF_CONTACT_DT
null,         --16   PREF_CONTACT_TIME
i.r_address1,         --17   R_ADDRESS1
i.r_address2,         --18   R_ADDRESS2
i.r_address3,         --19   R_ADDRESS3
i.r_address4,         --20   R_ADDRESS4
'GH',         --21   R_COUNTRY
null,         --22   R_PINCODE
in_source_code,         --23   SOURCE_CODE
i.source_seq_no);         --24   SOURCE_SEQ_NO

commit; 
exception
when no_data_found then 
insert into cif_upload_log  values(i.maintenance_seq_no,'STTM_UPLOAD_CUST_CORPORATE');
commit;

when others then
insert into cif_upload_log  values(i.maintenance_seq_no,'STTM_UPLOAD_CUST_CORPORATE');
commit;

end;

end loop;
dbms_output.put_line('---populating sttm_upload_cust_corporate : completed');
end;


/*

begin
---XXX4
dbms_output.put_line('---populating sttm_upload_corp_directors : starting');
for i in (
select a.* 
from sttm_upload_corp_directors@ampdblink a,
sttm_upload_customer b
where a.maintenance_seq_no = b.maintenance_seq_no
)
loop

begin

insert into sttm_upload_corp_directors (
address_line1,         --1   ADDRESS_LINE1
address_line2,         --2   ADDRESS_LINE2
address_line3,         --3   ADDRESS_LINE3
address_line4,         --4   ADDRESS_LINE4
addr_country,         --5   ADDR_COUNTRY
birth_country,         --6   BIRTH_COUNTRY
branch_code,         --7   BRANCH_CODE
conversion_status_flag,         --8   CONVERSION_STATUS_FLAG
customer_no,         --9   CUSTOMER_NO
date_of_birth,         --10   DATE_OF_BIRTH
director_name,         --11   DIRECTOR_NAME
err_msg,         --12   ERR_MSG
e_mail,         --13   E_MAIL
home_tel_isd,         --14   HOME_TEL_ISD
home_tel_no,         --15   HOME_TEL_NO
maintenance_seq_no,         --16   MAINTENANCE_SEQ_NO
mobile_number,         --17   MOBILE_NUMBER
mob_isd_no,         --18   MOB_ISD_NO
nationality,         --19   NATIONALITY
ownership_type,         --20   OWNERSHIP_TYPE
pct_holding,         --21   PCT_HOLDING
pincode,         --22   PINCODE
place_of_birth,         --23   PLACE_OF_BIRTH
p_address1,         --24   P_ADDRESS1
p_address2,         --25   P_ADDRESS2
p_address3,         --26   P_ADDRESS3
p_address4,         --27   P_ADDRESS4
p_country,         --28   P_COUNTRY
p_pincode,         --29   P_PINCODE
slno,         --30   SLNO
source_code,         --31   SOURCE_CODE
source_seq_no,         --32   SOURCE_SEQ_NO
tax_cntry,         --33   TAX_CNTRY
tax_id,         --34   TAX_ID
telephone,         --35   TELEPHONE
tel_isd_no,         --36   TEL_ISD_NO
us_res_status)         --37   US_RES_STATUS


values( 
i.address_line1,         --1   ADDRESS_LINE1
i.address_line2,         --2   ADDRESS_LINE2
i.address_line3,         --3   ADDRESS_LINE3
i.address_line4,         --4   ADDRESS_LINE4
i.addr_country,         --5   ADDR_COUNTRY
i.birth_country,         --6   BIRTH_COUNTRY
i.branch_code,         --7   BRANCH_CODE
i.conversion_status_flag,         --8   CONVERSION_STATUS_FLAG
i.customer_no,         --9   CUSTOMER_NO
i.date_of_birth,         --10   DATE_OF_BIRTH
i.director_name,         --11   DIRECTOR_NAME
i.err_msg,         --12   ERR_MSG
i.e_mail,         --13   E_MAIL
null,         --14   HOME_TEL_ISD
null,         --15   HOME_TEL_NO
i.maintenance_seq_no,         --16   MAINTENANCE_SEQ_NO
i.mobile_number,         --17   MOBILE_NUMBER
i.mob_isd_no,         --18   MOB_ISD_NO
i.nationality,         --19   NATIONALITY
i.ownership_type,         --20   OWNERSHIP_TYPE
i.pct_holding,         --21   PCT_HOLDING
null,         --22   PINCODE
i.place_of_birth,         --23   PLACE_OF_BIRTH
i.p_address1,         --24   P_ADDRESS1
i.p_address2,         --25   P_ADDRESS2
i.p_address3,         --26   P_ADDRESS3
i.p_address4,         --27   P_ADDRESS4
i.p_country,         --28   P_COUNTRY
null,         --29   P_PINCODE
i.slno,         --30   SLNO
in_source_code,         --31   SOURCE_CODE
i.source_seq_no,         --32   SOURCE_SEQ_NO
i.tax_cntry,         --33   TAX_CNTRY
i.tax_id,         --34   TAX_ID
i.telephone,         --35   TELEPHONE
i.tel_isd_no,         --36   TEL_ISD_NO
i.us_res_status);         --37   US_RES_STATUS


commit; 
exception
when no_data_found then 
insert into cif_upload_log  values(i.maintenance_seq_no,'STTM_UPLOAD_CORP_DIRECTORS');
commit;

when others then
insert into cif_upload_log  values(i.maintenance_seq_no,'STTM_UPLOAD_CORP_DIRECTORS');
commit;

end;

end loop;
dbms_output.put_line('---populating sttm_upload_corp_directors : completed');
end;

*/

/*

begin
---XXX4
dbms_output.put_line('---populating sttm_upload_cust_shareholder : starting');
for i in (
select 
trim(BRANCH_CODE)  BRANCH_CODE,         --1   BRANCH_CODE
trim(CONVERSION_STATUS_FLAG)  CONVERSION_STATUS_FLAG,         --2   CONVERSION_STATUS_FLAG
trim(CUSTOMER_NO)  CUSTOMER_NO,         --3   CUSTOMER_NO
trim(ERR_MSG)  ERR_MSG,         --4   ERR_MSG
trim(MAINTENANCE_SEQ_NO)  MAINTENANCE_SEQ_NO,         --5   MAINTENANCE_SEQ_NO
trim(PERCENTAGE_HOLDING)  PERCENTAGE_HOLDING,         --6   PERCENTAGE_HOLDING
trim(SHAREHOLDER_ID)  SHAREHOLDER_ID,         --7   SHAREHOLDER_ID
trim(SOURCE_CODE)  SOURCE_CODE,         --8   SOURCE_CODE
trim(SOURCE_SEQ_NO)  SOURCE_SEQ_NO          --9   SOURCE_SEQ_NO
from  STTM_UPLOAD_CUST_SHAREHOLDER@ampdblink

)


--/*
loop

begin

insert into STTM_UPLOAD_CUST_SHAREHOLDER (
BRANCH_CODE,         --1   BRANCH_CODE
CONVERSION_STATUS_FLAG,         --2   CONVERSION_STATUS_FLAG
CUSTOMER_NO,         --3   CUSTOMER_NO
ERR_MSG,         --4   ERR_MSG
MAINTENANCE_SEQ_NO,         --5   MAINTENANCE_SEQ_NO
PERCENTAGE_HOLDING,         --6   PERCENTAGE_HOLDING
SHAREHOLDER_ID,         --7   SHAREHOLDER_ID
SOURCE_CODE,         --8   SOURCE_CODE
SOURCE_SEQ_NO)         --9   SOURCE_SEQ_NO


values( 
i.BRANCH_CODE  ,                    --1   BRANCH_CODE
i.CONVERSION_STATUS_FLAG,           --2   CONVERSION_STATUS_FLAG
i.CUSTOMER_NO  ,                    --3   CUSTOMER_NO
i.ERR_MSG  ,                        --4   ERR_MSG
i.MAINTENANCE_SEQ_NO  ,             --5   MAINTENANCE_SEQ_NO
i.PERCENTAGE_HOLDING  ,             --6   PERCENTAGE_HOLDING
i.SHAREHOLDER_ID  ,                 --7   SHAREHOLDER_ID
i.SOURCE_CODE  ,                    --8   SOURCE_CODE
i.SOURCE_SEQ_NO );                  --9   SOURCE_SEQ_NO



commit; 
exception
when no_data_found then 
insert into cif_upload_log  values(i.MAINTENANCE_SEQ_NO,'STTM_UPLOAD_CUST_SHAREHOLDER');
commit;

when others then
insert into cif_upload_log  values(i.MAINTENANCE_SEQ_NO,'STTM_UPLOAD_CUST_SHAREHOLDER');
commit;

end;

end loop;
dbms_output.put_line('---populating sttm_upload_cust_shareholder : completed');
end;

*/



begin
---XXX4
dbms_output.put_line('---populating sttm_upload_personal_joint : starting');
for i in (
select 
trim(a.address1)  address1,         --1   ADDRESS1
trim(a.address2)  address2,         --2   ADDRESS2
trim(a.address3)  address3,         --3   ADDRESS3
trim(a.branch_code)  branch_code,         --4   BRANCH_CODE
trim(a.conversion_status_flag)  conversion_status_flag,         --5   CONVERSION_STATUS_FLAG
trim(a.customer_no)  customer_no,         --6   CUSTOMER_NO
trim(a.customer_prefix)  customer_prefix,         --7   CUSTOMER_PREFIX
a.date_of_birth,         --8   DATE_OF_BIRTH
trim(a.deceased)  deceased,         --9   DECEASED
trim(a.err_msg)  err_msg,         --10   ERR_MSG
trim(a.e_mail)  e_mail,         --11   E_MAIL
trim(a.first_name)  first_name,         --12   FIRST_NAME
trim(a.last_name)  last_name,         --13   LAST_NAME
trim(a.maintenance_seq_no)  maintenance_seq_no,         --14   MAINTENANCE_SEQ_NO
trim(a.middle_name)  middle_name,         --15   MIDDLE_NAME
trim(a.passport_no)  passport_no,         --16   PASSPORT_NO
trim(a.ppt_exp_date)  ppt_exp_date,         --17   PPT_EXP_DATE
trim(a.ppt_iss_date)  ppt_iss_date,         --18   PPT_ISS_DATE
trim(a.record_no)  record_no,         --19   RECORD_NO
trim(a.resident_status)  resident_status,         --20   RESIDENT_STATUS
trim(a.sex)  sex,         --21   SEX
trim(a.source_code)  source_code,         --22   SOURCE_CODE
trim(a.source_seq_no)  source_seq_no,         --23   SOURCE_SEQ_NO
trim(a.ssn)  ssn,         --24   SSN
trim(a.telephone)  telephone          --25   TELEPHONE
from  sttm_upload_personal_joint@ampdblink a,
sttm_upload_customer b
where a.maintenance_seq_no = b.maintenance_seq_no
)
loop

begin

insert into sttm_upload_personal_joint (
address1,         --1   ADDRESS1
address2,         --2   ADDRESS2
address3,         --3   ADDRESS3
branch_code,         --4   BRANCH_CODE
conversion_status_flag,         --5   CONVERSION_STATUS_FLAG
customer_no,         --6   CUSTOMER_NO
customer_prefix,         --7   CUSTOMER_PREFIX
date_of_birth,         --8   DATE_OF_BIRTH
deceased,         --9   DECEASED
err_msg,         --10   ERR_MSG
e_mail,         --11   E_MAIL
first_name,         --12   FIRST_NAME
last_name,         --13   LAST_NAME
maintenance_seq_no,         --14   MAINTENANCE_SEQ_NO
middle_name,         --15   MIDDLE_NAME
passport_no,         --16   PASSPORT_NO
ppt_exp_date,         --17   PPT_EXP_DATE
ppt_iss_date,         --18   PPT_ISS_DATE
record_no,         --19   RECORD_NO
resident_status,         --20   RESIDENT_STATUS
sex,         --21   SEX
source_code,         --22   SOURCE_CODE
source_seq_no,         --23   SOURCE_SEQ_NO
ssn,         --24   SSN
telephone)         --25   TELEPHONE

values( 
i.address1,         --1   ADDRESS1
i.address2,         --2   ADDRESS2
i.address3,         --3   ADDRESS3
i.branch_code,         --4   BRANCH_CODE
i.conversion_status_flag,         --5   CONVERSION_STATUS_FLAG
i.customer_no,         --6   CUSTOMER_NO
i.customer_prefix,         --7   CUSTOMER_PREFIX
i.date_of_birth,         --8   DATE_OF_BIRTH
i.deceased,         --9   DECEASED
i.err_msg,         --10   ERR_MSG
i.e_mail,         --11   E_MAIL
i.first_name,         --12   FIRST_NAME
i.last_name,         --13   LAST_NAME
i.maintenance_seq_no,         --14   MAINTENANCE_SEQ_NO
i.middle_name,         --15   MIDDLE_NAME
i.passport_no,         --16   PASSPORT_NO
i.ppt_exp_date,         --17   PPT_EXP_DATE
i.ppt_iss_date,         --18   PPT_ISS_DATE
i.record_no,         --19   RECORD_NO
i.resident_status,         --20   RESIDENT_STATUS
i.sex,         --21   SEX
in_source_code,         --22   SOURCE_CODE
i.source_seq_no,         --23   SOURCE_SEQ_NO
i.ssn,         --24   SSN
i.telephone);         --25   TELEPHONE



commit; 
exception
when no_data_found then 
insert into cif_upload_log  values(i.maintenance_seq_no,'sttm_upload_personal_joint');
commit;

when others then
insert into cif_upload_log  values(i.maintenance_seq_no,'sttm_upload_personal_joint');
commit;

end;

end loop;
dbms_output.put_line('---populating sttm_upload_personal_joint : completed');
end;













begin
---XXX3
dbms_output.put_line('---populating sttm_upload_cust_domestic : starting');
for i in (
select 
trim(a.ACCOMODATION)  ACCOMODATION,         --1   ACCOMODATION
trim(a.CONVERSION_STATUS_FLAG)  CONVERSION_STATUS_FLAG,         --2   CONVERSION_STATUS_FLAG
trim(a.CUSTOMER_NO)  CUSTOMER_NO,         --3   CUSTOMER_NO
trim(a.DEPENDENT_CHILDREN)  DEPENDENT_CHILDREN,         --4   DEPENDENT_CHILDREN
trim(a.DEPENDENT_OTHERS)  DEPENDENT_OTHERS,         --5   DEPENDENT_OTHERS
trim(a.EDUCATIONAL_STATUS)  EDUCATIONAL_STATUS,         --6   EDUCATIONAL_STATUS
trim(a.ERR_MSG)  ERR_MSG,         --7   ERR_MSG
trim(a.MAINTENANCE_SEQ_NO)  MAINTENANCE_SEQ_NO,         --8   MAINTENANCE_SEQ_NO
trim(a.MARITAL_STATUS)  MARITAL_STATUS,         --9   MARITAL_STATUS
trim(a.MOTHER_MAIDEN_NAME)  MOTHER_MAIDEN_NAME,         --10   MOTHER_MAIDEN_NAME
trim(a.SPOUSE_EMP_STATUS)  SPOUSE_EMP_STATUS,         --11   SPOUSE_EMP_STATUS
trim(a.SPOUSE_NAME)  SPOUSE_NAME          --12   SPOUSE_NAME
from  STTM_UPLOAD_CUST_DOMESTIC@ampdblink a,
sttm_upload_customer b where a.maintenance_seq_no = b.maintenance_seq_no

)
loop

begin

insert into STTM_UPLOAD_CUST_DOMESTIC (
ACCOMODATION,         --1   ACCOMODATION
CONVERSION_STATUS_FLAG,         --2   CONVERSION_STATUS_FLAG
CUSTOMER_NO,         --3   CUSTOMER_NO
DEPENDENT_CHILDREN,         --4   DEPENDENT_CHILDREN
DEPENDENT_OTHERS,         --5   DEPENDENT_OTHERS
EDUCATIONAL_STATUS,         --6   EDUCATIONAL_STATUS
ERR_MSG,         --7   ERR_MSG
MAINTENANCE_SEQ_NO,         --8   MAINTENANCE_SEQ_NO
MARITAL_STATUS,         --9   MARITAL_STATUS
MOTHER_MAIDEN_NAME,         --10   MOTHER_MAIDEN_NAME
SPOUSE_EMP_STATUS,         --11   SPOUSE_EMP_STATUS
SPOUSE_NAME)         --12   SPOUSE_NAME



values(
i.ACCOMODATION,         --1   ACCOMODATION
i.CONVERSION_STATUS_FLAG,         --2   CONVERSION_STATUS_FLAG
i.CUSTOMER_NO,         --3   CUSTOMER_NO
i.DEPENDENT_CHILDREN,         --4   DEPENDENT_CHILDREN
i.DEPENDENT_OTHERS,         --5   DEPENDENT_OTHERS
i.EDUCATIONAL_STATUS,         --6   EDUCATIONAL_STATUS
i.ERR_MSG,         --7   ERR_MSG
i.MAINTENANCE_SEQ_NO,         --8   MAINTENANCE_SEQ_NO
i.MARITAL_STATUS,         --9   MARITAL_STATUS
i.MOTHER_MAIDEN_NAME,         --10   MOTHER_MAIDEN_NAME
i.SPOUSE_EMP_STATUS,         --11   SPOUSE_EMP_STATUS
i.SPOUSE_NAME) ;        --12   SPOUSE_NAME      --24   SOURCE_SEQ_NO

commit; 
exception
when no_data_found then 
insert into cif_upload_log  values(i.maintenance_seq_no,'STTM_UPLOAD_CUST_DOMESTIC');
commit;

when others then
insert into cif_upload_log  values(i.maintenance_seq_no,'STTM_UPLOAD_CUST_DOMESTIC');
commit;

end;

end loop;
dbms_output.put_line('---populating sttm_upload_cust_DOMESTIC : completed');
end;



end;

























/*
  CREATE DATABASE LINK AMPDBLINK
   CONNECT TO "FRONT_PROD_GHA" IDENTIFIED BY VALUES 'oracle'
   USING 'DB12UTF8';
*/



/*
truncate table cif_upload_log;
execute insert_customer();
select * from sttm_upload_customer where ext_ref_no in (select a.ext_ref_no from sttm_customer a);

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


select * from sttm_upload_cust_personal where date_of_birth > add_months(to_date('25/05/2021','DD-MM-RRRR'),(-18 * 12)) --- a minor but not made a minor
and  maintenance_seq_no in (select a.maintenance_seq_no from sttm_upload_customer a where a.customer_type = 'I')
and minor <> 'Y'


select * from sttm_upload_cust_personal where birth_country not in (select a.country_code from sttm_country a)
select * from sttm_upload_customer where customer_type = 'I' and trim(maintenance_seq_no) not in (select trim(maintenance_seq_no) from sttm_upload_cust_personal a);---
select * from sttm_upload_customer where customer_type = 'I' and trim(maintenance_seq_no) not in (select trim(maintenance_seq_no) from sttm_upload_cust_personal a);---
select * from sttm_upload_customer where customer_type = 'I' and trim(maintenance_seq_no) not in (select trim(maintenance_seq_no) from sttm_upload_cust_personal a);


select distinct joint_venture from  sttm_upload_customer;

desc sttm_upload_customer;


*/