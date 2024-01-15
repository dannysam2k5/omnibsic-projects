/*
-- AML_Customer_group is Mandatory if AML_required = Y
update sttm_upload_customer@ampdblink set aml_required='N'
where aml_required = 'Y' and aml_customer_grp is null;
commit;


*/

-- Location code is mandatory for all customer

define date_param = '31-JUL-22';

update sttm_upload_customer@ampdblink set loc_code='DFT' where maintenance_seq_no in (
select maintenance_seq_no from sttm_upload_customer@ampdblink where loc_code is null);
commit;

-- Frozen deceased whereabouts_unknown should be N
update sttm_upload_customer@ampdblink
set frozen = 'N',deceased = 'N', whereabouts_unknown='N'
where frozen <> 'N' or deceased <> 'N' or whereabouts_unknown <> 'N' or whereabouts_unknown is null;
commit;

-- Risk Category 5 should be reclassified to 4
update sttm_upload_customer@ampdblink
set risk_category=4 where risk_category = '5';
commit;

-- The Status Frozen, Deceased, Whereabouts Unknown cannot be checked together or individually for the new customer


-- Unique Idetifier should be NULL
update sttm_upload_customer@ampdblink set unique_id_name = NULL, unique_id_value = null;
commit;

-- Wrong Prefixes

update sttm_upload_cust_personal@ampdblink set customer_prefix = 'Ms.' where customer_prefix = 'Other' and sex = 'F';
commit;
update sttm_upload_cust_personal@ampdblink set customer_prefix = 'Mr.' where customer_prefix = 'Other' and sex <> 'F';
commit;

-- Invalid Language Code
update sttm_upload_customer@ampdblink set language = 'FRC' where maintenance_seq_no in (
select maintenance_seq_no from sttm_upload_customer@ampdblink 
where nvl(language,'XXX') not in (select lang_code from smtb_language where once_auth='Y' and record_stat = 'O'));
commit;

-- Customer is a minor but no legal_guardian
update sttm_upload_cust_personal@ampdblink set legal_guardian = 'DL_Guardian' where maintenance_seq_no in (
select maintenance_seq_no from sttm_upload_cust_personal@ampdblink where date_of_birth > add_months(to_date('&date_param','DD-MM-RRRR'),(-18 * 12)) --- a minor but not made a minor
and  maintenance_seq_no in (select a.maintenance_seq_no from sttm_upload_customer@ampdblink a where a.customer_type = 'I')
and legal_guardian is null
);
commit;

------------------------------
-- 12. Customer should be made a minor
------------------------------
update sttm_upload_cust_personal@ampdblink set minor = 'Y' , legal_guardian = 'DL_Guardian'
where maintenance_seq_no in (
select maintenance_seq_no from sttm_upload_cust_personal@ampdblink where date_of_birth > add_months(to_date('&date_param','DD-MM-RRRR'),(-18 * 12)) --- a minor but not made a minor
and  maintenance_seq_no in (select a.maintenance_seq_no from sttm_upload_customer@ampdblink a where a.customer_type = 'I')
and minor <> 'Y'

);

commit;

-- Passport_no / Ppt_iss_date / Ppt_exp_date inconsistency
update sttm_upload_cust_personal@ampdblink set passport_no=NULL, ppt_iss_date=NULL, ppt_exp_date=NULL where maintenance_seq_no in (
select maintenance_seq_no from sttm_upload_cust_personal@ampdblink where 
((passport_no is not null and (ppt_iss_date is null or ppt_exp_date is null))
or (ppt_iss_date is not null and (passport_no is null or ppt_exp_date is null))
or (ppt_exp_date is not null and (ppt_iss_date is null or passport_no is null)))
);
commit;

--ppt_exp_date is less than system date
update sttm_upload_cust_personal@ampdblink set ppt_exp_date='01-JAN-25' where maintenance_seq_no in (
select maintenance_seq_no from sttm_upload_cust_personal@ampdblink WHERE ppt_exp_date < sysdate);
commit;

-- 4. Nationality should be null for customer type B and C customer type
update sttm_upload_customer@ampdblink set nationality = null where nationality is not null and customer_type in ('C','B');
commit;

-- 5. Nationality can not be null for Individual customer type
update sttm_upload_customer@ampdblink set nationality='GH' where nationality is null and customer_type = 'I';
commit;

-- No DOB for individual customers
update sttm_upload_cust_personal@ampdblink set date_of_birth = '01-JAN-91' where date_of_birth is null;
commit;

-- Gender mandatory for Individual customers
update sttm_upload_cust_personal@ampdblink set sex = 'O' 
where 
(trim(maintenance_seq_no) in (select trim(a.maintenance_seq_no) from sttm_upload_customer@ampdblink a where a.customer_type = 'I') and sex not in ('M','F','O')) or 
(trim(maintenance_seq_no) in (select trim(a.maintenance_seq_no) from sttm_upload_customer@ampdblink a where a.customer_type = 'I') and sex is null);

commit;

-- Address Line 1 cannot be NULL
update sttm_upload_customer@ampdblink set address_line1 = 'P.O.Box KN 5569 Kaneshie Accra' where address_line1 is null;
commit;


-- ---==============================================
-- Temporary Patch Fix for MOCK 1 Exceptions
---==============================================
-- A Corporate or Bank Customer Type cannot have an SSN
update sttm_upload_customer@ampdblink set ssn = null 
where customer_type in ('C','B') and ssn is not null;
commit;


-- Tax Country should be NULL and Individual_tax_cert_reqd should be N if no tax number
update sttm_upload_customer@ampdblink set
individual_tax_cert_reqd = 'N'
,taxid_no = NULL
,tax_cntry = NULL
where individual_tax_cert_reqd = 'Y' and taxid_no = '                    ' and tax_cntry ='GH';
commit;



--------------------------------------------
-- Customer Account Patch
---------------------------------------------
/*
-- exposure_category
update sttb_upload_cust_account_casa@ampdblink set exposure_category = NULL;
commit;
update sttb_upload_cust_account_td@ampdblink set exposure_category = NULL;
commit;

-- Display_IBAN_in_advices
update sttb_upload_cust_account_casa@ampdblink set Display_IBAN_in_advices = NULL;
commit;

update sttb_upload_cust_account_td@ampdblink set Display_IBAN_in_advices = NULL;
commit;


-- dormant_param
update sttb_upload_cust_account_casa@ampdblink set dormant_param = 'M';
commit;
update sttb_upload_cust_account_td@ampdblink set dormant_param = 'M';
commit;

-- Account class UNKNOW
delete from sttb_upload_cust_account_casa@ampdblink where account_class = 'UNKNOW';
delete from sttb_upload_cust_account_td@ampdblink where account_class = 'UNKNOW';

commit;
*/

Patch script for DUMMY value for all CASA and TD account number
should be done



-----------------------------------------------------
-- 55. Ristricted Customer Category for Account Class
-----------------------------------------------------
-- create table
drop table restrict_cus_account_class purge;
create table restrict_cus_account_class as
select ab.* 
from 
(select 
a.alt_ac_no,
a.cust_no,
b.ext_ref_no,
a.account_class,
b.customer_category,
a.ccy,
bc.cpro
from sttb_upload_cust_account_casa@ampdblink a,
sttm_customer b,
bkcom@ampdblink bc
where trim(b.ext_ref_no) = trim(a.cust_no)
and bc.age||bc.ncp||bc.clc = a.alt_ac_no
and trim(bc.cli)=a.cust_no
and decode(bc.dev,'936','GHS',
'124','CAD',
'756','CHF',
'826','GBP',
'840','USD',
'952','XOF',
'156','CNY',
'392','JPY',
'978','EUR') = a.ccy) ab 
where 1=1
and ab.account_class||ab.customer_category not in 

(-------
select cd.account_class||cd.cust_cat from 
(select
(select b.account_class from sttm_account_class b where b.account_class = a.account_class) account_class,
(select b.description from sttm_account_class b where b.account_class = a.account_class) description,
a.cust_cat,
(select b.cust_cat_desc from sttm_customer_cat b where b.cust_cat = a.cust_cat ) cust_cat_desc,
(select b.cuscat_list from sttm_account_class b where b.account_class = a.account_class) cuscat_list
from
sttm_accls_cat_restr a) cd
)
;

-- Saving account
update RESTRICT_CUS_ACCOUNT_CLASS set account_class='SAD'
where cpro in ('026','027','020','021');
commit;

-- Current ACCOUNT
update RESTRICT_CUS_ACCOUNT_CLASS set account_class='CAD'
where cpro in ('001','002','003','004','005','050','052');
commit;

-- update fix
update sttb_upload_cust_account_casa@ampdblink ac
set account_class = (select account_class from RESTRICT_CUS_ACCOUNT_CLASS rc
where rc.alt_ac_no=ac.alt_ac_no
)
where ac.alt_ac_no in (select rc.alt_ac_no from RESTRICT_CUS_ACCOUNT_CLASS rc);
commit;

-----------------------------------------------------
-- 56. Ristricted Currency for Account Class
-----------------------------------------------------
-- create table
drop table restrict_cus_account_currency purge;
create table restrict_cus_account_currency as
select ab.* from 
(select 
a.alt_ac_no,
a.cust_no,
b.ext_ref_no,
a.account_class,
b.customer_category,
a.ccy,
bc.cpro
from sttb_upload_cust_account_casa@ampdblink a,
sttm_customer b,
bkcom@ampdblink bc
where trim(b.ext_ref_no) = trim(a.cust_no)
and bc.age||bc.ncp||bc.clc = a.alt_ac_no
and trim(bc.cli)=a.cust_no
and decode(bc.dev,'936','GHS',
'124','CAD',
'756','CHF',
'826','GBP',
'840','USD',
'952','XOF',
'156','CNY',
'392','JPY',
'978','EUR') = a.ccy
)ab 
where 1=1
and ab.account_class||ab.ccy not in 
(-------
select cd.account_class||cd.ccy_code from 
(select 
(select b.account_class from sttm_account_class b where b.account_class = a.account_class) account_class,
(select b.description from sttm_account_class b where b.account_class = a.account_class) description,
a.ccy_code,
(select b.ccy_name from cytm_ccy_defn_master b where b.ccy_code = a.ccy_code ) cust_cat_desc,
(select b.ccy_list from sttm_account_class b where b.account_class = a.account_class) ccy_list
from sttms_accls_ccy_restr a) cd
);

-- Saving account
update RESTRICT_CUS_ACCOUNT_CURRENCY set account_class='SAD'
where cpro = '020';
commit;

-- Current ACCOUNT
update RESTRICT_CUS_ACCOUNT_CURRENCY set account_class='CAD'
where cpro in ('001','002','003','005','050','052');
commit;

-- update fix
update sttb_upload_cust_account_casa@ampdblink ac
set account_class = (select account_class from RESTRICT_CUS_ACCOUNT_CURRENCY rc
where rc.alt_ac_no=ac.alt_ac_no
)
where ac.alt_ac_no in (select rc.alt_ac_no from RESTRICT_CUS_ACCOUNT_CURRENCY rc);
commit;


-----------------------------------------------------
-- Invalid Location for Accounts
-----------------------------------------------------
update sttb_upload_cust_account_casa@ampdblink set location='DFT' 
where location is null;
commit;

-- TD ACCOUNT
update sttb_upload_cust_account_td@ampdblink set location='DFT' 
where location is null;
commit;

-----------------------------------------------------
-- Account open date is less than CIF creation date
-----------------------------------------------------
update sttb_upload_cust_account_casa@ampdblink ca
set ca.ac_open_date = (select cif_creation_date from sttm_upload_customer@ampdblink bc where ca.cust_no = trim(bc.ext_ref_no))
where exists (select 1
                from sttm_upload_customer@ampdblink bc
                where ca.cust_no = trim(bc.ext_ref_no)
                and ca.ac_open_date < bc.cif_creation_date);
commit;

------------------------------
-- 71. Account Class Disallowed For The Branch
------------------------------
-- Deletion of Nostro Accounts from Customer Accounts table.
-- These records must also be deleted from the Customer Balance table -- 
delete from sttb_upload_cust_account_casa@ampdblink where alt_ac_no in 
('001070500002606249',
'006020500002607271',
'001020500002605350',
'001110500002605455',
'001060500002605720',
'007010500002606971',
'001080500002605905',
'001010500002606373',
'004010500002605896',
'001040500002605535',
'001010500004246934',
'001090500002606143',
'001060500002606690',
'001100500002985748',
'001110500002985889',
'001120500002985933',
'001050500002605676',
'008010500002607006',
'006010500002607130',
'001030500002606461',
'001120500002606566',
'001100500002606769',
'001010500004046047',
'001010500003642236');

------------------------------
-- 70. Cheque book should be selected if cheque book preferences are provide
------------------------------
update sttb_upload_cust_account_casa@ampdblink
set auto_reorder_check_required = 'N'
where cheque_book_facility = 'N' and auto_reorder_check_required = 'Y';
commit;

------------------------------
-- 72. Account Opening date is a Holiday
------------------------------

update sttb_upload_cust_account_casa@ampdblink ac
set ac.ac_open_date = (select nextwdate from fc_calender@ampdblink fc 
                        where isholiday = 'H' and fc.actualdate = ac.ac_open_date)
where ac.ac_open_date in (select actualdate from fc_calender@ampdblink where isholiday = 'H');
commit;


---------------------------------------------------
-- The A/c class you selected is for major customer.
---------------------------------------------------
update sttb_upload_cust_account_casa@ampdblink ac
set account_class = 'SAD'
where maintenance_seq_no in ( 

with clientinfo (category, customer_type, minor, ext_ref_no) as
( select customer_category, customer_type, minor, trim(ext_ref_no)
from sttm_upload_customer@ampdblink c 
join sttm_upload_cust_personal@ampdblink p
on c.maintenance_seq_no = p.maintenance_seq_no
)
select maintenance_seq_no from
(select
maintenance_seq_no,
cust_no,
category
,customer_type
,minor

,account_class
from
sttb_upload_cust_account_casa@ampdblink ca 
join clientinfo ci  on ca.cust_no = ci.ext_ref_no ) ab,
(select account_class account_class2,minor_major from sttm_account_class) cd
where ab.account_class = cd.account_class2
and ab.minor = 'Y' and cd.minor_major='MJ');
commit;


------------------------------
-- 32. Individual customer cannot have record in sttm_upload_corp_directors
------------------------------
delete from sttm_upload_corp_directors@ampdblink where maintenance_seq_no in (
select maintenance_seq_no from sttm_upload_corp_directors@ampdblink where 
maintenance_seq_no in (select a.maintenance_seq_no from sttm_upload_customer@ampdblink a where a.customer_type = 'I'));

commit;

------------------------------
-- 41. Local branch is mandatory for All Customers
------------------------------
update sttm_upload_customer@ampdblink set local_branch = '000', branch_code = '000' where local_branch is null;
update sttm_upload_cust_corporate@ampdblink set branch_code = '000' where branch_code is null;

commit;

------------------------------
-- 10. Incorp date cannot be greater than system date
------------------------------
update sttm_upload_cust_corporate@ampdblink set incorp_date = '01-JAN-15'
where incorp_date > '&date_param' ;
COMMIT;

------------------------------
-- 74. No Data Found for Joint Holder Customer Id
------------------------------
update sttb_upload_cust_account_casa@ampdblink set joint_ac_indicator = 'S' where
joint_ac_indicator = 'J' and maintenance_seq_no not in (
select maintenance_seq_no from sttb_upload_linked_entities@ampdblink);
commit;

------------------------------
-- 75. Customer Record not found
------------------------------
delete from sttb_upload_cust_account_casa@ampdblink where 
cust_no not in (select trim(ext_ref_no) from sttm_upload_customer@ampdblink);
commit;

---------------------------------------------------
-- 100. Disable auto Reorder checkbook
---------------------------------------------------
update sttb_upload_cust_account_casa@ampdblink set auto_reorder_check_required = 'N'
,auto_reorder_check_level=null
,auto_reorder_check_leaves=null
where auto_reorder_check_required = 'Y';
commit;


---------------------------------------------------
-- 77. Removal of all Nostro Accounts from Casa table
---------------------------------------------------
delete from sttb_upload_cust_account_casa@ampdblink where account_type = 'N';
commit;


---------------------------------------------------
-- 78. Account_type should be null CASA -- should be lastly run
---------------------------------------------------
update sttb_upload_cust_account_casa@ampdblink set account_type = NULL where account_type <> 'N';
commit;


---------------------------------------------------
-- 79. Ristricted Customer Category for Account Class (Linked Entities)
---------------------------------------------------
update  sttb_upload_cust_account_casa@ampdblink set account_class = 'SAD' where maintenance_seq_no in (
select maintenance_seq_no from 
(select
f.maintenance_seq_no,
f.joint_holder_code,
(select customer_type from sttm_upload_customer@ampdblink where trim(ext_ref_no) = trim(f.joint_holder_code)) customer_type,
--(select minor from sttm_upload_cust_personal@ampdblink where customer_no = f.joint_holder_code) minor,
(select customer_category from sttm_upload_customer@ampdblink where trim(ext_ref_no) = trim(f.joint_holder_code)) category,
(select g.account_class from sttb_upload_cust_account_casa@ampdblink g where g.maintenance_seq_no = f.maintenance_seq_no) account_class
from sttb_upload_linked_entities@ampdblink f) ab
where ab.account_class||ab.category not in  

------ Account class restriction

(-------
select cd.account_class||cd.cust_cat from 
(select
(select b.account_class from sttm_account_class b where b.account_class = a.account_class) account_class,
(select b.description from sttm_account_class b where b.account_class = a.account_class) description,
a.cust_cat,
(select b.cust_cat_desc from sttm_customer_cat b where b.cust_cat = a.cust_cat ) cust_cat_desc,
(select b.cuscat_list from sttm_account_class b where b.account_class = a.account_class) cuscat_list
from
sttm_accls_cat_restr a) cd
)
);
commit;

-- Handle the joint holders in the Linked Entities table.


-----------------------------------------------------
-- 64. Mismatch DR_HO CR_HO | DR_CB CR_CB
-----------------------------------------------------
update sttb_upload_cust_account_casa@ampdblink a
set a.dr_cb_line = (select dr_cb_line from sttm_account_class_status b
where b.account_class = a.account_class and b.status = 'NORM')
--
,a.dr_ho_line = (select dr_ho_line from sttm_account_class_status b
where b.account_class = a.account_class and b.status = 'NORM')
--
,a.cr_cb_line = (select cr_cb_line from sttm_account_class_status b
where b.account_class = a.account_class and b.status = 'NORM')
--
,a.cr_ho_line = (select cr_ho_line from sttm_account_class_status b
where b.account_class = a.account_class and b.status = 'NORM')
--
,a.dr_gl = (select dr_gl from sttm_account_class_status b
where b.account_class = a.account_class and b.status = 'NORM')
--
,a.cr_gl = (select cr_gl from sttm_account_class_status b
where b.account_class = a.account_class and b.status = 'NORM')
--
;
commit;


---------------------------------------------------
-- 82. Missing Check Detail Accounts from CheckBook Accounts
---------------------------------------------------
delete from catm_upload_check_details@ampdblink a where trim(a.account_no) not in 
(select trim(b.account_no) from catm_upload_check_book@ampdblink b);
commit;


---------------------------------------------------
-- 81. Missing Checkbook Detail Accounts From Base Accounts
---------------------------------------------------
delete from catm_upload_check_details@ampdblink a where trim(a.account_no) not in
(select trim(b.alt_ac_no) from sttb_upload_cust_account_casa@ampdblink b);
commit;

---------------------------------------------------
-- 80. Missing Checkbook Accounts From Base Account
---------------------------------------------------
delete from catm_upload_check_book@ampdblink a where trim(a.account_no) not in
(select trim(b.alt_ac_no) from sttb_upload_cust_account_casa@ampdblink b);
commit;

---------------------------------------------------
-- 83. Missing Check Book Accounts From Check Detail Accounts
---------------------------------------------------
delete from catm_upload_check_book@ampdblink a where trim(a.account_no) not in 
(select trim(b.account_no) from catm_upload_check_details@ampdblink b);
commit;

---------------------------------------------------
-- 85. Invalid HOLD_CODE for Amount Block
---------------------------------------------------

update catm_upload_amount_blocks@ampdblink set hold_code = 'BNKLIN'
where hold_code not in 
(SELECT hold_code FROM sttm_hold_master WHERE once_auth = 'Y' AND record_stat = 'O');
commit;

---------------------------------------------------
-- 86. Missing Stop payment accounts from Base Accounts 
---------------------------------------------------
delete from catm_upload_stop_payments@ampdblink where  trim(account_no) not in 
(select trim(alt_ac_no) from sttb_upload_cust_account_casa@ampdblink );
commit;

-- 86 Missing Stop payment accounts from Check Book Accounts
---------------------------------------------------
delete from catm_upload_stop_payments@ampdblink where account_no not in 
(select account_no from catm_upload_check_book@ampdblink);

commit;

---------------------------------------------------
-- 87. Missing Stop payment accounts from Check Detail Accounts 
---------------------------------------------------
delete from catm_upload_stop_payments@ampdblink where trim(account_no) not in 
(select trim(account_no) from catm_upload_check_details@ampdblink);
commit;


------------------------------------------
-- 44. Duplicate Identification ID Number
------------------------------------------
update  z_udf@ampdblink set identification_id_number = trim(identification_id_number)||'_'||trim(customer_no)
where identification_id_number in (
select id_no from 
(
select identification_id_number id_no, count(*) cnt 
from z_udf@ampdblink
group by identification_id_number 
having count(*) > 1) ab);

commit;


---------------------------------------------------
-- 45. Removal of all Nostro Accounts from Corporate Customers
---------------------------------------------------
delete from sttm_upload_cust_corporate@ampdblink where maintenance_seq_no not in (select maintenance_seq_no from sttm_upload_customer@ampdblink);
commit;

---------------------------------------------------
-- 87. Missing cust account balance from base accounts
---------------------------------------------------
delete from detb_upload_detail@ampdblink
where nvl(trim(account),'xxx') not in (select nvl(trim(alt_ac_no),'yyy') from sttb_upload_cust_account_casa@ampdblink);
commit;

------------------------------
-- 56. AC_STAT_DR_OVD field should be N
------------------------------
update sttb_upload_cust_account_casa@ampdblink set AC_STAT_DR_OVD = 'N' where AC_STAT_DR_OVD <> 'N';
commit;

---------------------------------------------------
-- 100. Payment_method should be defaulted to B
---------------------------------------------------
update ldtb_upload_master@ampdblink set Payment_method = 'B'  where Payment_method <> 'B';
commit;

---------------------------------------------------
-- 101. Rollover_allowed should be defaulted to N
---------------------------------------------------
update ldtb_upload_master@ampdblink set Rollover_allowed = 'N' where rollover_allowed <> 'N';
commit;


---------------------------------------------------
-- 102. Partial_payment_mliq should be defaulted to N
---------------------------------------------------
update ldtb_upload_master@ampdblink set Partial_payment_mliq = 'N' where Partial_payment_mliq <> 'N';
commit;

---------------------------------------------------
-- 103. Schedule_movement should be defaulted to N
---------------------------------------------------
update ldtb_upload_master@ampdblink set Schedule_movement = 'N' where Schedule_movement <> 'N';
commit;

---------------------------------------------------
-- 104. Demand_basis should be defaulted to S
---------------------------------------------------
update ldtb_upload_master@ampdblink set Demand_basis = 'S' where Demand_basis <> 'S';
commit;

---------------------------------------------------
-- 105. sgen_reqd should be defaulted to Y
---------------------------------------------------
update ldtb_upload_master@ampdblink set sgen_reqd = 'Y' where sgen_reqd <> 'Y';
commit;

---------------------------------------------------
-- 106. contract_ref_no should be defaulted to NULL
---------------------------------------------------
update ldtb_upload_master@ampdblink set contract_ref_no = NULL where contract_ref_no is not NULL;
commit;


---------------------------------------------------
-- 107. rollover_type should be defaulted to NULL
---------------------------------------------------
update ldtb_upload_master@ampdblink set rollover_type = NULL where rollover_type is not NULL;
commit;

---------------------------------------------------
-- 108. apply_tax_on_rollover should be defaulted to NULL
---------------------------------------------------
update ldtb_upload_master@ampdblink set apply_tax_on_rollover = NULL where apply_tax_on_rollover is not NULL;
commit;

-----------------------------------------------
-- Duplicate Standing Instructions Source Ref
-----------------------------------------------

declare
a number;
begin

for i in (select source_seq_no from sitb_upload_instruction@ampdblink having count(*)> 1 group by source_seq_no ) loop
a:=0;
for ii in (select source_seq_no from sitb_upload_instruction@ampdblink where source_seq_no = i.source_seq_no) loop
a:=a+1;

if a =1 then
update sitb_upload_instruction@ampdblink set source_ref = source_ref||'A'
where source_seq_no = ii.source_seq_no and rownum < 2;
commit;
end if;

end loop;
end loop;
end;
/