create or replace procedure AMP_VALIDATIONS as
/*
create table amp_validation_tab (module varchar2(100),comments varchar2(1000),tname varchar2(100), cnt number);

*/
date_param date;

BEGIN
date_param := '31-JUL-22';

----==========================================
--	 FINANACIAL DATA VALIDATIONS ------
----==========================================

---------------------------------------------------
-- 87. Missing cust account balance from base accounts
---------------------------------------------------
insert into amp_validation_tab values('FINANCE','Missing cust account balance from base accounts','detb_upload_detail',(
select nvl(count(*),0) from detb_upload_detail@ampdblink 
where nvl(trim(account),'xxx') not in (select nvl(trim(alt_ac_no),'yyy') from sttb_upload_cust_account_casa@ampdblink)
)
);
commit;

---------------------------------------------------
-- 88. First_Exec_Date|Next_Exec_Date|First_Value_Date|Next_Value_Date is Mandatory
---------------------------------------------------
insert into amp_validation_tab values('SI','First_Exec_Date | Next_Exec_Date | First_Value_Date | Next_Value_Date is Mandatory','sitb_upload_instruction',(
select nvl(count(*),0) from sitb_upload_instruction@ampdblink where First_Exec_Date is null or Next_Exec_Date is null or First_Value_Date is null or Next_Value_Date is null
)
);
commit;

---------------------------------------------------
-- 89. Counterparty is Mandatory
---------------------------------------------------
insert into amp_validation_tab values('SI','Counterparty is Mandatory','sitb_upload_master',(
select nvl(count(*),0) from sitb_upload_master@ampdblink where counterparty is null
)
);
commit;

---------------------------------------------------
-- 90. Counterparty is Mandatory
---------------------------------------------------
insert into amp_validation_tab values('SI','Counterparty is Mandatory','sitb_upload_instruction',(
select nvl(count(*),0) from sitb_upload_instruction@ampdblink where counterparty is null
)
);
commit;

---------------------------------------------------
-- 91. CR_ACC_BR | CR_Account is Mandatory
---------------------------------------------------
insert into amp_validation_tab values('SI','CR_ACC_BR | CR_Account is Mandatory','sitb_upload_master',(
select nvl(count(*),0) from sitb_upload_master@ampdblink where cr_account = '                  '
)
);
commit;

/* --Validation script in development stage

---------------------------------------------------
-- 92.  Account branch and account are not in sync.
---------------------------------------------------
select dr_acc_br,dr_account from sitb_upload_master@ampdblink where dr_acc_br||'~'||dr_account  not in (select branch_code||'~'||alt_ac_no from sttb_upload_cust_account_casa@ampdblink);
select cr_acc_br,cr_account  from sitb_upload_master@ampdblink where cr_acc_br||'~'||cr_account  not in (select branch_code||'~'||alt_ac_no from sttb_upload_cust_account_casa@ampdblink);
*/

---------------------------------------------------
-- 93.  The tax scheme should have the value (WTH_TX) for FCFY & FCLY product
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','The tax_scheme should have the value (WTH_TX) for FCFY and FCLY product','ldtb_upload_master',(
select nvl(count(*),0) from ldtb_upload_master@ampdblink where tax_scheme <> 'WTH_TX' and product in ('FCLY','FCFY')
)
);

commit;

---------------------------------------------------
-- 94.  The tax_scheme should be NULL for product FIFY and FILY
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','The tax_scheme should be NULL for product FIFY and FILY','ldtb_upload_master',(
select nvl(count(*),0) from ldtb_upload_master@ampdblink where tax_scheme is not NULL and product in ('FIFY','FILY')
)
);

commit;

---------------------------------------------------
-- 95. The dflt_settle_ccy, dr_setl_ccy and dr_setl_ac should not be  null
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','The dflt_settle_ccy, dr_setl_ccy and dr_setl_ac should not be null','ldtb_upload_master',(
select nvl(count(*),0) from ldtb_upload_master@ampdblink where dflt_settle_ccy is null or  dr_setl_ccy is null or dr_setl_ac is null
)
);
commit;

---------------------------------------------------
-- 96. RATE_CODE is not NULL
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','RATE_CODE is not NULL','cftb_upload_interest',(
select nvl(count(*),0) from cftb_upload_interest@ampdblink where rate_code is not null
)
);
commit;

---------------------------------------------------
-- 97. COMPONENT Field should be CD_MAINCOM
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','COMPONENT Field should be CD_MAINCOM','cftb_upload_interest',(
select nvl(count(*),0) from cftb_upload_interest@ampdblink where nvl(component,0) <> 'CD_MAINCOM'
)
);
commit;


---------------------------------------------------
-- 98. Incorrect account number in DFLT_SETTLE_AC field
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','Incorrect account number in DFLT_SETTLE_AC field','ldtb_upload_master',(
select nvl(count(*),0) from 
(
select dflt_settle_ac_branch,dflt_settle_ac  from ldtb_upload_master@ampdblink 
where dflt_settle_ac_branch||'~'||dflt_settle_ac  not in (select branch_code||'~'||alt_ac_no from sttb_upload_cust_account_casa@ampdblink)) 
)
);
commit;


---------------------------------------------------
-- 99. Invalid account number in DR_SETL_AC field
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','Invalid account number in DR_SETL_AC field','ldtb_upload_master',(
select nvl(count(*),0) from 
(
select dr_setl_ac_br,dr_setl_ac from ldtb_upload_master@ampdblink 
where dr_setl_ac_br||'~'||dr_setl_ac  not in (select branch_code||'~'||alt_ac_no from sttb_upload_cust_account_casa@ampdblink)
) 
)
);
commit;

---------------------------------------------------
-- 100. Payment_method should be defaulted to B
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','Payment_method should be defaulted to B','ldtb_upload_master',(
select nvl(count(*),0) from ldtb_upload_master@ampdblink where Payment_method <> 'B'
)
);
commit;

---------------------------------------------------
-- 101. Rollover_allowed should be defaulted to N
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','Rollover_allowed should be defaulted to N','ldtb_upload_master',(
select nvl(count(*),0) from ldtb_upload_master@ampdblink where rollover_allowed <> 'N'
)
);
commit;

---------------------------------------------------
-- 102. Partial_payment_mliq should be defaulted to N
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','Partial_payment_mliq should be defaulted to N','ldtb_upload_master',(
select nvl(count(*),0) from ldtb_upload_master@ampdblink where Partial_payment_mliq <> 'N'
)
);
commit;


---------------------------------------------------
-- 103. Schedule_movement should be defaulted to N
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','Schedule_movement should be defaulted to N','ldtb_upload_master',(
select nvl(count(*),0) from ldtb_upload_master@ampdblink where schedule_movement <> 'N'
)
);
commit;

---------------------------------------------------
-- 104. Demand_basis should be defaulted to S
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','Demand_basis should be defaulted to S','ldtb_upload_master',(
select nvl(count(*),0) from ldtb_upload_master@ampdblink where Demand_basis <> 'S'
)
);
commit;
---------------------------------------------------
-- 105. sgen_reqd should be defaulted to Y
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','sgen_reqd should be defaulted to Y','ldtb_upload_master',(
select nvl(count(*),0) from ldtb_upload_master@ampdblink where sgen_reqd <> 'Y'
)
);
commit;

---------------------------------------------------
-- 106. contract_ref_no should be defaulted to NULL
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','contract_ref_no should be defaulted to NULL','ldtb_upload_master',(
select nvl(count(*),0) from ldtb_upload_master@ampdblink where contract_ref_no is not null
)
);
commit;

---------------------------------------------------
-- 107. rollover_type should be defaulted to NULL
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','rollover_type should be defaulted to NULL','ldtb_upload_master',(
select nvl(count(*),0) from ldtb_upload_master@ampdblink where rollover_type is not null
)
);
commit;

---------------------------------------------------
-- 108. apply_tax_on_rollover should be defaulted to NULL
---------------------------------------------------
insert into amp_validation_tab values('CORPORATE DEPOSIT','apply_tax_on_rollover should be defaulted to NULL','ldtb_upload_master',(
select nvl(count(*),0) from ldtb_upload_master@ampdblink where apply_tax_on_rollover is not null
)
);
commit;




END;
/



---------------------
/*
set serveroutput on;
create table amp_validation_tab_bak as select * from amp_validation_tab;
truncate table amp_validation_tab;
exec AMP_VALIDATIONS();

select * from amp_validation_tab where module = 'CIF' order by cnt desc;
select * from amp_validation_tab where module = 'ACCOUNT' order by cnt desc;
select * from amp_validation_tab  order by cnt desc;

*/



