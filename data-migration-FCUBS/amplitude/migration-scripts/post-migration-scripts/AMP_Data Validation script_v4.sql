create or replace procedure AMP_VALIDATIONS as
/*
create table amp_validation_tab (module varchar2(100),comments varchar2(1000),tname varchar2(100), cnt number);

*/

BEGIN

/* Customer Information File (CIF)
Validations Rules
*/


------------------------------
-- 1 Address Line 1 Mandatory
------------------------------

insert into amp_validation_tab values('CIF','Address Line 1 cannot be NULL','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where address_line1 is null)
); 
commit; 

------------------------------
-- 2 Incomplete Passport Information
------------------------------
insert into amp_validation_tab values('CIF','Passport_no / Ppt_iss_date / Ppt_exp_date inconsistency','sttm_upload_cust_personal',
(
select nvl(count(*),0) from sttm_upload_cust_personal@ampdblink where 
((passport_no is not null and (ppt_iss_date is null or ppt_exp_date is null))
or (ppt_iss_date is not null and (passport_no is null or ppt_exp_date is null))
or (ppt_exp_date is not null and (ppt_iss_date is null or passport_no is null)))
)
); 
commit; 

------------------------------
-- 3. No personal record for customer type I
------------------------------
insert into amp_validation_tab values('CIF','No personal record for customer type I','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where customer_type = 'I' and maintenance_seq_no not in (select maintenance_seq_no from sttm_upload_cust_personal@ampdblink a)
)
); 
commit; 

------------------------------
-- 4. Nationality should be null for customer type B and C customer type
------------------------------
insert into amp_validation_tab values('CIF','Nationality should be null for customer type B and C customer type','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where nationality is not null and customer_type in ('C','B'))
); 
commit; 

------------------------------
-- 5. Nationality can not be null for Individual customer type
------------------------------
insert into amp_validation_tab values('CIF','Nationality can not be null for Individual customer type','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where nationality is null and customer_type = 'I')
); 
commit; 

------------------------------
-- 6. Date of Birth Mandoratory for Individual customers
------------------------------
insert into amp_validation_tab values('CIF','No DOB for individual customers','sttm_upload_cust_personal',
(
select nvl(count(*),0) from sttm_upload_cust_personal@ampdblink where date_of_birth is null)
); 
commit;

------------------------------
-- 7. Passport expiry date less than System date
------------------------------
insert into amp_validation_tab values('CIF','ppt_exp_date is less than system date','sttm_upload_cust_personal',
(
select nvl(count(*),0) from sttm_upload_cust_personal@ampdblink WHERE ppt_exp_date < sysdate)
);
commit;

------------------------------
-- 8. Gender mandatory for individual customers
------------------------------
insert into amp_validation_tab values('CIF','Gender mandatory for Individual customers','sttm_upload_cust_personal',
(
select nvl(count(*),0) from sttm_upload_cust_personal@ampdblink where sex = ' ')
);
commit;

------------------------------
-- 9. No corporate record for customer type C/B
------------------------------

insert into amp_validation_tab values('CIF','No corporate record for customer type C/B','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where customer_type in ('B','C') and maintenance_seq_no not in (select maintenance_seq_no from sttm_upload_cust_corporate@ampdblink a))
); 
commit; 

------------------------------
-- 10. Incorp date cannot be greater than system date
------------------------------
insert into amp_validation_tab values('CIF','Incorp date cannot be greater than system date','sttm_upload_cust_corporate',
(
select nvl(count(*),0) from sttm_upload_cust_corporate@ampdblink where incorp_date > sysdate )
);
commit;

------------------------------
-- 11. Customer is not a minor but made a minor
------------------------------

insert into amp_validation_tab values('CIF','Customer is not a minor but made a minor','sttm_upload_cust_personal',
(
select nvl(count(*),0) from sttm_upload_cust_personal@ampdblink where date_of_birth < add_months(to_date(SYSDATE,'DD-MM-RRRR'),(-18 * 12))  --- not a minor made a minor
and  maintenance_seq_no in (select a.maintenance_seq_no from sttm_upload_customer@ampdblink a where a.customer_type = 'I')
and minor <> 'N'
)
); 
commit;

------------------------------
-- 12. Customer should be made a minor
------------------------------
insert into amp_validation_tab values('CIF','Customer should be made a minor','sttm_upload_cust_personal',
(
select nvl(count(*),0) from sttm_upload_cust_personal@ampdblink where date_of_birth > add_months(to_date(SYSDATE,'DD-MM-RRRR'),(-18 * 12)) --- a minor but not made a minor
and  maintenance_seq_no in (select a.maintenance_seq_no from sttm_upload_customer@ampdblink a where a.customer_type = 'I')
and minor <> 'Y'
)
); 
commit;

------------------------------
-- 13. Minor Customer without Legal Guardian
------------------------------
insert into amp_validation_tab values('CIF','Customer is a minor but no legal_guardian','sttm_upload_cust_personal',
(
select nvl(count(*),0) from sttm_upload_cust_personal@ampdblink where date_of_birth > add_months(to_date(SYSDATE,'DD-MM-RRRR'),(-18 * 12)) --- a minor but not made a minor
and  maintenance_seq_no in (select a.maintenance_seq_no from sttm_upload_customer@ampdblink a where a.customer_type = 'I')
and legal_guardian is null
)
); 
commit;

------------------------------
-- 14. Invalid Gender for customer type I
------------------------------
insert into amp_validation_tab values('CIF','Invalid Gender for customer type I','sttm_upload_cust_personal',
(
select nvl(count(*),0) from sttm_upload_cust_personal@ampdblink where 
(maintenance_seq_no in (select a.maintenance_seq_no from sttm_upload_customer@ampdblink a where a.customer_type = 'I') and sex not in ('M','F','O')) or 
(maintenance_seq_no in (select a.maintenance_seq_no from sttm_upload_customer@ampdblink a where a.customer_type = 'I') and sex is null)
)
); 
commit;

------------------------------
-- 15. Country is mandatory for all customers
------------------------------
insert into amp_validation_tab values('CIF','Country is Mandatory for all customers','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where country is null
)
);
commit;

------------------------------
-- 16. Location code is mandatory for all customers
------------------------------
insert into amp_validation_tab values ('CIF','Location code is mandatory for all customer','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where loc_code is null
)
);
commit;

------------------------------
-- 17. AML_Customer_group is Mandatory if AML_required = 'Y'
------------------------------
insert into amp_validation_tab values ('CIF','AML_Customer_group is Mandatory if AML_required = Y','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where aml_required = 'Y' and aml_customer_grp is null
)
);
commit;

------------------------------
-- 18. Invalid Language Code
------------------------------
insert into amp_validation_tab values ('CIF','Invalid Language Code','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where nvl(language,'XXX') not in (select lang_code from smtb_language where once_auth='Y' and record_stat = 'O')
)
);
commit;

------------------------------
-- 19. Invalid Nationality
------------------------------
insert into amp_validation_tab values('CIF','Invalid Nationality','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where nationality not in (select a.country_code from sttm_country a)
)
); 
commit; 

------------------------------
-- 20. Invalid Country
------------------------------
insert into amp_validation_tab values('CIF','Invalid Country','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where nvl(country,'XXX') not in (select a.country_code from sttm_country a)
)
); 
commit; 

------------------------------
-- 21. Invalid exposure_country
------------------------------
insert into amp_validation_tab values('CIF','Invalid exposure_country','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where nvl(exposure_country,'XXX') not in (select a.country_code from sttm_country a)
)
); 
commit; 

------------------------------
-- 22. Invalid Birth_country
------------------------------
insert into amp_validation_tab values('CIF','Invalid Birth_country','sttm_upload_cust_personal',
(
select nvl(count(*),0) from sttm_upload_cust_personal@ampdblink where nvl(birth_country,'XXX') not in (select a.country_code from sttm_country a)
)
); 
commit;

------------------------------
-- 23. Invalid pa_holder_addr_country
------------------------------
insert into amp_validation_tab values('CIF','Invalid pa_holder_addr_country','sttm_upload_cust_personal',
(
select nvl(count(*),0) from sttm_upload_cust_personal@ampdblink where pa_holder_addr_country not in (select a.country_code from sttm_country a)
)
); 
commit;

------------------------------
-- 24. Invalid d_country for personal
------------------------------
insert into amp_validation_tab values('CIF','Invalid d_country','sttm_upload_cust_personal',
(
select nvl(count(*),0) from sttm_upload_cust_personal@ampdblink where d_country not in (select a.country_code from sttm_country a)
)
); 
commit;

------------------------------
-- 25. Invalid p_country for personal
------------------------------
insert into amp_validation_tab values('CIF','Invalid p_country for personal','sttm_upload_cust_personal',
(
select nvl(count(*),0) from sttm_upload_cust_personal@ampdblink where p_country not in (select a.country_code from sttm_country a)
)
); 
commit;

------------------------------
-- 26. Invalid incorp_country
------------------------------
insert into amp_validation_tab values('CIF','Invalid incorp_country','sttm_upload_cust_corporate',
(
select nvl(count(*),0) from sttm_upload_cust_corporate@ampdblink where nvl(incorp_country,'XXX') not in (select a.country_code from sttm_country a)
)
); 
commit;

------------------------------
-- 27. Invalid r_country
------------------------------
insert into amp_validation_tab values('CIF','Invalid r_country','sttm_upload_cust_corporate',
(
select nvl(count(*),0) from sttm_upload_cust_corporate@ampdblink where r_country not in (select a.country_code from sttm_country a)
)
); 
commit;

------------------------------
-- 28. Invalid TEL_ISD_NO for Personal
------------------------------
insert into amp_validation_tab values('CIF','Invalid TEL_ISD_NO for Personal','sttm_upload_cust_personal',
(
select nvl(count(tel_isd_no),0) from sttm_upload_cust_personal@ampdblink 
where tel_isd_no not in (select isd_code from sttm_country)
)
); 
commit;

------------------------------
-- 29. Invalid TEL_ISD_NO for corporate
------------------------------
insert into amp_validation_tab values('CIF','Invalid TEL_ISD_NO for corporate','sttm_upload_corp_directors',
(
select nvl(count(tel_isd_no),0) from sttm_upload_corp_directors@ampdblink 
where tel_isd_no not in (select isd_code from sttm_country)
)
); 
commit;

------------------------------
-- 30. Individual customer cannot have record in sttm_upload_cust_corporate
------------------------------
insert into amp_validation_tab values('CIF','Individual customer cannot have record in sttm_upload_cust_corporate','sttm_upload_cust_corporate',
(
select nvl(count(*),0) from sttm_upload_cust_corporate@ampdblink where maintenance_seq_no in (select a.maintenance_seq_no from sttm_upload_customer@ampdblink a where a.customer_type = 'I')
)
); 
commit;

------------------------------
-- 31. Individual customer cannot have record in sttm_upload_cust_shareholder
------------------------------

insert into amp_validation_tab values('CIF','Individual customer cannot have record in sttm_upload_cust_shareholder','sttm_upload_cust_corporate',
(
select nvl(count(*),0) from sttm_upload_cust_shareholder@ampdblink where maintenance_seq_no in (select a.maintenance_seq_no from sttm_upload_customer@ampdblink a where a.customer_type = 'I')
)
); 
commit;

------------------------------
-- 32. Individual customer cannot have record in sttm_upload_corp_directors
------------------------------

insert into amp_validation_tab values('CIF','Individual customer cannot have record in sttm_upload_corp_directors','sttm_upload_cust_corporate',
(
select nvl(count(*),0) from sttm_upload_corp_directors@ampdblink where maintenance_seq_no in (select a.maintenance_seq_no from sttm_upload_customer@ampdblink a where a.customer_type = 'I')
)
); 
commit;

------------------------------
-- 33. Corporate and Bank type of customer cannot have record in sttm_upload_cust_personal
------------------------------

insert into amp_validation_tab values('CIF','Corporate and Bank type of customer cannot have record in sttm_upload_cust_personal','sttm_upload_cust_personal',
(
select nvl(count(*),0) from sttm_upload_cust_personal@ampdblink where maintenance_seq_no in (select a.maintenance_seq_no from sttm_upload_customer@ampdblink a where a.customer_type in ('B','C'))
)
); 
commit;

------------------------------
-- 34. Corporate customers flagged as Individul customers
------------------------------
insert into amp_validation_tab values('CIF','Corporate customers flagged as Individul customers','sttm_upload_customer',
(
select nvl(count(*),0) from bkcli@ampdblink where tcli = '2' and trim(cli) in (select trim(ext_ref_no) from sttm_upload_customer@ampdblink where customer_type = 'I')
)
);
commit;

------------------------------
-- 35. Individual customers flagged as Corporate customers
------------------------------
insert into amp_validation_tab values('CIF','Individual customers flagged as Corporate customers','sttm_upload_customer',
(
select nvl(count(*),0) from bkcli@ampdblink where tcli = '1' and trim(cli) in (select trim(ext_ref_no) from sttm_upload_customer@ampdblink where customer_type = 'C')
)
);
commit;

------------------------------
-- 36. Invalid Location
------------------------------
insert into amp_validation_tab values('CIF','Invalid Location','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where nvl(loc_code,'XXX') not in (select distinct(loc_code) from sttm_location where once_auth='Y' and record_stat = 'O')
)
);
commit;

------------------------------
-- 37. Invalid Customer Category
------------------------------
insert into amp_validation_tab values('CIF','Invalid Customer Category','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where nvl(customer_category,'XXX') not in (select distinct(cust_cat) from sttms_customer_cat where auth_stat = 'A' and record_stat = 'O')
)
);
commit;

------------------------------
-- 38. Wrong Prefixes
------------------------------

insert into amp_validation_tab values('CIF','Wrong Prefixes','sttm_upload_cust_personal',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where customer_type = 'I' and maintenance_seq_no in (select maintenance_seq_no from sttm_upload_cust_personal@ampdblink a where a.customer_prefix not in (select b.prefix1 from sttms_cust_prefix_details b))
)
); 
commit; 

------------------------------
-- 39. Invalid p_country for directors
------------------------------
insert into amp_validation_tab values('CIF','Invalid p_country for directors','sttm_upload_corp_directors',
(
select nvl(count(*),0) from sttm_upload_corp_directors@ampdblink where p_country not in (select a.country_code from sttm_country a)
)
); 
commit;

------------------------------
-- 40. Frozen deceased whereabouts_unknown should be N
------------------------------
insert into amp_validation_tab values('CIF','Frozen deceased whereabouts_unknown should be N','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where frozen <> 'N' or deceased <> 'N' or whereabouts_unknown <> 'N' or whereabouts_unknown is null
)
);
commit;

------------------------------
-- 41. Local branch is mandatory for All Customers
------------------------------
insert into amp_validation_tab values('CIF','Local branch is mandatory for All Customers','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink  where local_branch is null
)
);
commit;

----------------------------------------------------------
-- 42. A Corporate or Bank Customer Type cannot have an SSN
----------------------------------------------------------
insert into amp_validation_tab values('CIF','A Corporate or Bank Customer Type cannot have an SSN','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where customer_type in ('C','B') and ssn is not null
)
);
commit;

----------------------------------------------------------
-- 43. Tax Country should be NULL and Individual_tax_cert_reqd should be 'N' if no tax number
----------------------------------------------------------
insert into amp_validation_tab values('CIF','Tax Country should be NULL and Individual_tax_cert_reqd should be N if no tax number','sttm_upload_customer',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink where individual_tax_cert_reqd = 'Y' and taxid_no = '                    ' and tax_cntry ='GH'
)
);
commit;

------------------------------------------
-- 44. Duplicate Identification ID Number
------------------------------------------
insert into amp_validation_tab values('CIF','Duplicate Identification ID Number','z_udf',
(
select nvl(count(*),0) from 
(
select identification_id_number id_no, count(*) cnt 
from z_udf@ampdblink 
group by identification_id_number 
having count(*) > 1) ab)
);
commit;

---------------------------------------------------
-- 45. Removal of all Nostro Accounts from Corporate Customers
---------------------------------------------------
insert into amp_validation_tab values('CIF','Removal of all Nostro Accounts from Corporate Customers','sttm_upload_cust_corporate',
(
select nvl(count(*),0) from sttm_upload_cust_corporate@ampdblink where maintenance_seq_no not in (select maintenance_seq_no from sttm_upload_customer@ampdblink)
)
);
commit;

/* Customer Account Validations Rules */ -- CASA ACCOUNTS

------------------------------
-- 46. Exposure category should be NULL
------------------------------

insert into amp_validation_tab values ('ACCOUNT','Exposure category should be NULL','sttb_upload_cust_account_casa',
(
select nvl(count(*),0) from sttb_upload_cust_account_casa@ampdblink where exposure_category is not null
)
);
commit;

------------------------------
-- 47. Display_IBAN_in_advices must be NULL
------------------------------

insert into amp_validation_tab values ('ACCOUNT','Display_IBAN_in_advices must be NULL','sttb_upload_cust_account_casa',
(
select nvl(count(*),0) from sttb_upload_cust_account_casa@ampdblink where display_iban_in_advices is not null
)
);
commit;

------------------------------
-- 48. Dormancy parameter must be 'M'
------------------------------

insert into amp_validation_tab values ('ACCOUNT','Dormancy parameter must be M','sttb_upload_cust_account_casa',
(
select nvl(count(*),0) from sttb_upload_cust_account_casa@ampdblink where dormant_param <> 'M'
)
);
commit;

------------------------------
-- 49. Invalid account class
------------------------------
insert into amp_validation_tab values ('ACCOUNT','Invalid account class','sttb_upload_cust_account_casa',
(
select nvl(count(*),0) from sttb_upload_cust_account_casa@ampdblink where nvl(account_class,'XXX') not in (select account_class from sttm_account_class)
)
);
commit;

---------------------------------------
-- 50. Mismatch DR_HO CR_HO | DR_CB CR_CB
---------------------------------------
insert into amp_validation_tab values ('ACCOUNT','Mismatch DR_HO CR_HO | DR_CB CR_CB','sttb_upload_cust_account_casa',
(
select nvl(count(*),0) from sttb_upload_cust_account_casa@ampdblink a 
where dr_gl||cr_gl||dr_ho_line||cr_ho_line||cr_cb_line||dr_cb_line <> 
(select dr_gl||cr_gl||dr_ho_line||cr_ho_line||cr_cb_line||dr_cb_line from sttm_account_class_status where account_class = a.account_class)
)
);
commit;

------------------------------
-- 51. Ristricted Customer Category for Account Class
------------------------------
insert into amp_validation_tab values ('ACCOUNT','Ristricted Customer Category for Account Class','sttb_upload_cust_account_casa',
(
select nvl(count(*),0) from 
(select 
a.alt_ac_no,
a.cust_no,
b.ext_ref_no,
a.account_class,
b.customer_category,
a.ccy
from sttb_upload_cust_account_casa@ampdblink a,
sttm_customer b
where trim(b.ext_ref_no) = trim(a.cust_no)) ab 
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
)
);
commit;

------------------------------
-- 52. Ristricted Currency for Account Class
------------------------------
insert into amp_validation_tab values ('ACCOUNT','Ristricted Currency for Account Class','sttb_upload_cust_account_casa',
(
select nvl(count(*),0) from 
(select 
a.alt_ac_no,
a.cust_no,
b.ext_ref_no,
a.account_class,
b.customer_category,
a.ccy
from sttb_upload_cust_account_casa@ampdblink a,
sttm_customer b
where trim(b.ext_ref_no) = trim(a.cust_no)) ab 
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
)
)
);
commit;

------------------------------
-- 53. Invalid Location
------------------------------

insert into amp_validation_tab values('ACCOUNT','Invalid Location','sttb_upload_cust_account_casa',
(
--select nvl(count(*),0) from sttm_upload_customer@ampdblink where loc_code not in (select distinct(loc_code) from sttm_location where once_auth='Y' and record_stat = 'O')
select nvl(count(*),0) from sttb_upload_cust_account_casa@ampdblink where nvl(LOCATION,'XXX') not in (select distinct(loc_code) from sttm_location where once_auth='Y' and record_stat = 'O')
)
);
commit;

------------------------------
-- 54. Chequebook_name_1 should be NULL if cheque_book_facility = 'N'
------------------------------
insert into amp_validation_tab values('ACCOUNT','Chequebook_name_1 should be NULL if cheque_book_facility = N','sttb_upload_cust_account_casa',
(
select nvl(count(*),0) from sttb_upload_cust_account_CASA@ampdblink where cheque_book_facility = 'N' and checkbook_name_1 is not null
)
);
commit;

------------------------------
-- 55. Chequebook_name_1 should not be NULL if cheque_book_facility = Y
------------------------------
insert into amp_validation_tab values('ACCOUNT','Chequebook_name_1 should not be NULL if cheque_book_facility = Y','sttb_upload_cust_account_casa',
(
select nvl(count(*),0) from sttb_upload_cust_account_CASA@ampdblink where cheque_book_facility = 'Y' and checkbook_name_1 is null
)
);
commit;



------------------------------
-- TD ACCOUNTS
------------------------------

/* Customer Account Validations Rules */ -- TD ACCOUNTS

------------------------------
-- 56. Exposure category should be NULL
------------------------------

insert into amp_validation_tab values ('ACCOUNT','Exposure category should be NULL','sttb_upload_cust_account_td',
(
select nvl(count(*),0) from sttb_upload_cust_account_td@ampdblink where exposure_category is not null
)
);
commit;

------------------------------
-- 57. Display_IBAN_in_advices must be NULL
------------------------------

insert into amp_validation_tab values ('ACCOUNT','Display_IBAN_in_advices must be NULL','sttb_upload_cust_account_td',
(
select nvl(count(*),0) from sttb_upload_cust_account_td@ampdblink where display_iban_in_advices is not null
)
);
commit;

------------------------------
-- 58. Dormancy parameter must be 'M'
------------------------------

insert into amp_validation_tab values ('ACCOUNT','Dormancy parameter must be M','sttb_upload_cust_account_td',
(
select nvl(count(*),0) from sttb_upload_cust_account_td@ampdblink where dormant_param <> 'M'
)
);
commit;

------------------------------
-- 59. Invalid account class
------------------------------
insert into amp_validation_tab values ('ACCOUNT','Invalid account class','sttb_upload_cust_account_td',
(
select nvl(count(*),0) from sttb_upload_cust_account_td@ampdblink where nvl(account_class,'XXX') not in (select account_class from sttm_account_class)
)
);
commit;

---------------------------------------
-- 60. Mismatch DR_HO CR_HO | DR_CB CR_CB
---------------------------------------
insert into amp_validation_tab values ('ACCOUNT','Mismatch DR_HO CR_HO | DR_CB CR_CB','sttb_upload_cust_account_td',
(
select nvl(count(*),0) from sttb_upload_cust_account_td@ampdblink a 
where dr_gl||cr_gl||dr_ho_line||cr_ho_line||cr_cb_line||dr_cb_line <> 
(select dr_gl||cr_gl||dr_ho_line||cr_ho_line||cr_cb_line||dr_cb_line from sttm_account_class_status where account_class = a.account_class)
)
);
commit;

------------------------------
-- 61. Ristricted Customer Category for Account Class
------------------------------
insert into amp_validation_tab values ('ACCOUNT','Ristricted Customer Category for Account Class','sttb_upload_cust_account_td',
(
select nvl(count(*),0) from 
(select 
a.alt_ac_no,
a.cust_no,
b.ext_ref_no,
a.account_class,
b.customer_category,
a.ccy
from sttb_upload_cust_account_td@ampdblink a,
sttm_customer b
where trim(b.ext_ref_no) = trim(a.cust_no)) ab 
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
)
);
commit;

------------------------------
-- 62. Ristricted Currency for Account Class
------------------------------
insert into amp_validation_tab values ('ACCOUNT','Ristricted Currency for Account Class','sttb_upload_cust_account_td',
(
select nvl(count(*),0) from 
(select 
a.alt_ac_no,
a.cust_no,
b.ext_ref_no,
a.account_class,
b.customer_category,
a.ccy
from sttb_upload_cust_account_td@ampdblink a,
sttm_customer b
where trim(b.ext_ref_no) = trim(a.cust_no)) ab 
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
)
)
);
commit;

------------------------------
-- 63. Invalid Location
------------------------------

insert into amp_validation_tab values('ACCOUNT','Invalid Location','sttb_upload_cust_account_td',
(
--select nvl(count(*),0) from sttm_upload_customer@ampdblink where loc_code not in (select distinct(loc_code) from sttm_location where once_auth='Y' and record_stat = 'O')
select nvl(count(*),0) from sttb_upload_cust_account_td@ampdblink where nvl(LOCATION,'XXX') not in (select distinct(loc_code) from sttm_location where once_auth='Y' and record_stat = 'O')
)
);
commit;

------------------------------
-- 64. Chequebook_name_1 should be NULL if cheque_book_facility = 'N'
------------------------------
insert into amp_validation_tab values('ACCOUNT','Chequebook_name_1 should be NULL if cheque_book_facility = N','sttb_upload_cust_account_td',
(
select nvl(count(*),0) from sttb_upload_cust_account_td@ampdblink where cheque_book_facility = 'N' and checkbook_name_1 is not null
)
);
commit;

------------------------------
-- 65. Chequebook_name_1 should not be NULL if cheque_book_facility = Y
------------------------------
insert into amp_validation_tab values('ACCOUNT','Chequebook_name_1 should not be NULL if cheque_book_facility = Y','sttb_upload_cust_account_td',
(
select nvl(count(*),0) from sttb_upload_cust_account_td@ampdblink where cheque_book_facility = 'Y' and checkbook_name_1 is null
)
);
commit;

-----------------------------
--- END OF TD VALIDATION
-----------------------------

------------------------------
-- 66. Cheque book should be selected if cheque book preferences are provide
------------------------------
insert into amp_validation_tab values('ACCOUNT','Cheque book should be selected if cheque book preferences are provide','sttb_upload_cust_account_casa',
(
select nvl(count(*),0) from sttb_upload_cust_account_casa@ampdblink where cheque_book_facility = 'N' and auto_reorder_check_required = 'Y'
)
);
commit;

------------------------------
-- 67. Account Class Disallowed For The Branch
------------------------------
insert into amp_validation_tab values('ACCOUNT','Account Class Disallowed For The Branch','sttb_upload_cust_account_casa',
(
select nvl(count(*),0) from sttb_upload_cust_account_casa@ampdblink where account_class = 'NOSL' and branch_code <> '000'
)
);
commit;


------------------------------
-- 68. Account Opening date is a Holiday
------------------------------
insert into amp_validation_tab values('ACCOUNT','Account Opening date is a Holiday','sttb_upload_cust_account_casa',
(
select nvl(count(*),0) from sttb_upload_cust_account_casa@ampdblink where ac_open_date in (select actualdate from fc_calender@ampdblink where isholiday = 'H')
)
);
commit;

------------------------------
-- 69. Account open date is less than CIF creation date
------------------------------
insert into amp_validation_tab values('ACCOUNT','Account open date is less than CIF creation date','sttb_upload_cust_account_casa',
(
select nvl(count(*),0) from sttb_upload_cust_account_casa@ampdblink ca, sttm_upload_customer@ampdblink bc where ca.cust_no = trim(bc.ext_ref_no)
and ca.ac_open_date < bc.cif_creation_date
)
);
commit;

------------------------------
-- 70. No Data Found for Joint Holder Customer Id
------------------------------
insert into amp_validation_tab values('ACCOUNT','No Data Found for Joint Holder Customer Id','sttb_upload_cust_account_casa',
(

select nvl(count(*),0) from sttb_upload_cust_account_casa@ampdblink where joint_ac_indicator = 'J' and maintenance_seq_no not in (
select maintenance_seq_no from sttb_upload_linked_entities@ampdblink)
)
);
commit;

------------------------------
-- 71. Customer Record not found
------------------------------
insert into amp_validation_tab values('ACCOUNT','Customer Record not found','sttb_upload_cust_account_casa',(
select nvl(count(*),0) from sttb_upload_cust_account_casa@ampdblink where cust_no not in (select trim(ext_ref_no) from sttm_upload_customer@ampdblink )
)
);
commit;


---------------------------------------------------
-- 72. Disable auto Reorder checkbook
--------------------------------------------------
insert into amp_validation_tab values('ACCOUNT','Disable auto Reorder checkbook','sttb_upload_cust_account_casa',(
select nvl(count(*),0) from sttb_upload_cust_account_casa@ampdblink where auto_reorder_check_required = 'Y'
)
);
commit;

---------------------------------------------------
-- 73. Removal of all Nostro Accounts from Casa table
---------------------------------------------------
insert into amp_validation_tab values('ACCOUNT','Removal of all Nostro Accounts from Casa table','sttb_upload_cust_account_casa',(
select nvl(count(*),0) from sttb_upload_cust_account_casa@ampdblink where account_type = 'N'
)
);
commit;

---------------------------------------------------
-- 74. Account_type should be null CASA
---------------------------------------------------
insert into amp_validation_tab values('ACCOUNT','Account_type should be null','sttb_upload_cust_account_casa',(
select nvl(count(*),0) from sttb_upload_cust_account_casa@ampdblink where account_type is not NULL
)
);
commit;

---------------------------------------------------
-- 75. Ristricted Customer Category for Account Class (Linked Entities)
---------------------------------------------------
insert into amp_validation_tab values('ACCOUNT','Ristricted Customer Category for Account Class','sttb_upload_linked_entities',(
select nvl(count(*),0) from 
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
)
);
commit;

------------------------------
-- 76. The A/c class you selected is for major customer
------------------------------
insert into amp_validation_tab values('ACCOUNT','The A/c class you selected is for major customer','sttb_upload_cust_account_casa',
(
with clientinfo (category, customer_type, minor, ext_ref_no) as
( select customer_category, customer_type, minor, trim(ext_ref_no)
from sttm_upload_customer@ampdblink c 
join sttm_upload_cust_personal@ampdblink p
on c.maintenance_seq_no = p.maintenance_seq_no
)
select nvl(count(*),0) from
(select
maintenance_seq_no,
cust_no,
category
,customer_type
,minor
/*
(select customer_category from sttm_upload_customer@ampdblink where trim(ext_ref_no) = cust_no) category,
(select customer_type from sttm_upload_customer@ampdblink where trim(ext_ref_no) = cust_no) customer_type,
(select minor from sttm_upload_cust_personal@ampdblink p, sttm_upload_customer@ampdblink s 
where p.maintenance_seq_no=s.maintenance_seq_no and trim(s.ext_ref_no)=cust_no ) minor,
*/

,account_class
from
sttb_upload_cust_account_casa@ampdblink ca 
join clientinfo ci  on ca.cust_no = ci.ext_ref_no ) ab,
(select account_class account_class2,minor_major from sttm_account_class) cd
where ab.account_class = cd.account_class2
and ab.minor = 'Y' and cd.minor_major='MJ'
)
);
commit;


------------------------------
-- 77. The A/c class you selected is for minor customer
------------------------------
insert into amp_validation_tab values('ACCOUNT','The A/c class you selected is for minor customer','sttb_upload_cust_account_casa',
(
with clientinfo (category, customer_type, minor, ext_ref_no) as
( select customer_category, customer_type, minor, trim(ext_ref_no)
from sttm_upload_customer@ampdblink c 
join sttm_upload_cust_personal@ampdblink p
on c.maintenance_seq_no = p.maintenance_seq_no
)
select nvl(count(*),0) from
(select
maintenance_seq_no,
cust_no,
category,
customer_type,
minor,
/*
(select customer_category from sttm_upload_customer@ampdblink where trim(ext_ref_no) = cust_no) category,
(select customer_type from sttm_upload_customer@ampdblink where trim(ext_ref_no) = cust_no) customer_type,
(select minor from sttm_upload_cust_personal@ampdblink p, sttm_upload_customer@ampdblink s where p.maintenance_seq_no=s.maintenance_seq_no and trim(s.ext_ref_no)=cust_no ) minor,
*/
account_class
from
sttb_upload_cust_account_casa@ampdblink ca
join clientinfo ci on ca.cust_no = ci.ext_ref_no ) ab,
(select account_class account_class2,minor_major from sttm_account_class) cd
where ab.account_class = cd.account_class2
and ab.minor = 'N' and cd.minor_major='MI'
)
);
commit;


------ END OF ACCOUNT VALIDATION

-- CHECKBOOK VALIDATIONS -- Try and Review Checkbook validations during 2nd RUN
---------------------------------------------------
-- 78. Missing Checkbook Accounts From Base Account
---------------------------------------------------
insert into amp_validation_tab values('CHECKBOOK','Missing Checkbook Accounts From Base Account','catm_upload_check_book',(
select nvl(count(*),0) from catm_upload_check_book@ampdblink a where trim(a.account_no) not in
(select trim(b.alt_ac_no) from sttb_upload_cust_account_casa@ampdblink b)
)
);
commit;

---------------------------------------------------
-- 79. Missing Checkbook Detail Accounts From Base Accounts
---------------------------------------------------
insert into amp_validation_tab values('CHECKBOOK','Missing Checkbook Detail Accounts From Base Accounts','catm_upload_check_details',(
select nvl(count(*),0) from catm_upload_check_details@ampdblink a where trim(a.account_no) not in
(select trim(b.alt_ac_no) from sttb_upload_cust_account_casa@ampdblink b)
)
);
commit;

---------------------------------------------------
-- 80. Missing Check Detail Accounts from CheckBook Accounts
---------------------------------------------------
insert into amp_validation_tab values('CHECKBOOK','Missing Check Detail Accounts from CheckBook Accounts','catm_upload_check_details',(
select nvl(count(*),0) from catm_upload_check_details@ampdblink a where trim(a.account_no) not in 
(select trim(b.account_no) from catm_upload_check_book@ampdblink b)
)
);
commit;

---------------------------------------------------
-- 81. Missing Check Book Accounts From Check Detail Accounts
---------------------------------------------------
insert into amp_validation_tab values('CHECKBOOK','Missing Check Book Accounts From Check Detail Accounts','catm_upload_check_book',(
select nvl(count(*),0) from catm_upload_check_book@ampdblink a where trim(a.account_no) not in 
(select trim(b.account_no) from catm_upload_check_details@ampdblink b)
)
);
commit;

---------------------------------------------------
-- 82. Duplicate Check book details
---------------------------------------------------
insert into amp_validation_tab values('CHECKBOOK','Duplicate check book details','catm_upload_check_details',(
select nvl(count(*),0) from (
select xxx, count(*) yyy from 
(select account_no||'~'||check_no xxx from catm_upload_check_details@ampdblink) ab
group by ab.xxx) cd where  yyy>1)
);
commit;



---------------------------------------------------
-- 83. Invalid HOLD_CODE for Amount Block
---------------------------------------------------
insert into amp_validation_tab values('AMOUNT BLOCK','Invalid HOLD_CODE for Amount Block','catm_upload_amount_blocks',(
select nvl(count(*),0) from catm_upload_amount_blocks@ampdblink where hold_code not in 
(SELECT hold_code FROM sttm_hold_master WHERE once_auth = 'Y' AND record_stat = 'O')
)
);
commit;

---------------------------------------------------
-- 84. Missing Stop payments accounts from Base Accounts 
---------------------------------------------------
insert into amp_validation_tab values('STOP PAYMENT','Missing Stop payment accounts from Base Accounts','catm_upload_stop_payments',(
select nvl(count(*),0) from catm_upload_stop_payments@ampdblink where trim(account_no) not in 
(select trim(alt_ac_no) from sttb_upload_cust_account_casa@ampdblink )
)
);
commit;

---------------------------------------------------
-- 85. Missing Stop payment accounts from Check Detail Accounts 
---------------------------------------------------
insert into amp_validation_tab values('STOP PAYMENT','Missing Stop payment accounts from Check Detail Accounts','catm_upload_stop_payments',(
select nvl(count(*),0) from catm_upload_stop_payments@ampdblink where account_no not in 
(select account_no from catm_upload_check_details@ampdblink)
)
);
commit;

---------------------------------------------------
-- 86. Missing Stop payment accounts from Check Book Accounts 
---------------------------------------------------
insert into amp_validation_tab values('STOP PAYMENT','Missing Stop payment accounts from Check Book Accounts','catm_upload_stop_payments',(
select nvl(count(*),0) from catm_upload_stop_payments@ampdblink where account_no not in 
(select account_no from catm_upload_check_book@ampdblink)
)
);
commit;






END;
/






---------------------
/*
set serveroutput on;
truncate table amp_validation_tab;
exec AMP_VALIDATIONS();

select * from amp_validation_tab where module = 'CIF' order by cnt desc;
select * from amp_validation_tab where module = 'ACCOUNT' order by cnt desc;
select * from amp_validation_tab  order by cnt desc;

*/



