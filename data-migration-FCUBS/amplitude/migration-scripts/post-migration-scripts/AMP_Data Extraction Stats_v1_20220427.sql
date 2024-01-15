create or replace procedure AMP_EXTRACTION_STATS as
/*
create table amp_extraction_stats_tab (module varchar2(100),tname varchar2(100), extracted_data_ampl number);

*/

begin
---==================================
-- AMPLITUDE EXTRACTION STATS
---==================================

------ CUSTOMER STATIC DATA

------------------------------
-- 1. STTM_UPLOAD_CUSTOMER
------------------------------

insert into amp_extraction_stats_tab values('CIF','STTM_UPLOAD_CUSTOMER',
(
select nvl(count(*),0) from sttm_upload_customer@ampdblink)
); 
commit; 

------------------------------
-- 2. STTM_UPLOAD_CUST_PERSONAL
------------------------------
insert into amp_extraction_stats_tab values('CIF','STTM_UPLOAD_CUST_PERSONAL',
(
select nvl(count(*),0) from sttm_upload_cust_personal@ampdblink)
); 
commit; 

------------------------------
-- 3. STTM_UPLOAD_CUST_CORPORATE
------------------------------
insert into amp_extraction_stats_tab values('CIF','STTM_UPLOAD_CUST_CORPORATE',
(
select nvl(count(*),0) from sttm_upload_cust_corporate@ampdblink)
); 
commit; 

------------------------------
-- 4. STTM_UPLOAD_PERSONAL_JOINT
------------------------------
insert into amp_extraction_stats_tab values('CIF','STTM_UPLOAD_PERSONAL_JOINT',
(
select nvl(count(*),0) from sttm_upload_personal_joint@ampdblink)
); 
commit; 

------------------------------
-- 5. STTM_UPLOAD_CUST_DOMESTIC
------------------------------

insert into amp_extraction_stats_tab values('CIF','STTM_UPLOAD_CUST_DOMESTIC',
(
select nvl(count(*),0) from sttm_upload_cust_domestic@ampdblink)
); 
commit; 

------------------------------
-- 6. CATM_UPLOAD_STOP_PAYMENTS
------------------------------
insert into amp_extraction_stats_tab values('CIF','CATM_UPLOAD_STOP_PAYMENTS',
(
select nvl(count(*),0) from catm_upload_stop_payments@ampdblink)
); 
commit; 

------------------------------
-- 7. CATM_UPLOAD_CHECK_BOOK
------------------------------
insert into amp_extraction_stats_tab values('CIF','CATM_UPLOAD_CHECK_BOOK',
(
select nvl(count(*),0) from catm_upload_check_book@ampdblink)
); 
commit; 

------------------------------
-- 8. CATM_UPLOAD_CHECK_DETAILS
------------------------------

insert into amp_extraction_stats_tab values('CIF','CATM_UPLOAD_CHECK_DETAILS',
(
select nvl(count(*),0) from catm_upload_check_details@ampdblink)
); 
commit; 

------------------------------
-- 9. CATM_UPLOAD_AMOUNT_BLOCKS
------------------------------

insert into amp_extraction_stats_tab values('CIF','CATM_UPLOAD_AMOUNT_BLOCKS',
(
select nvl(count(*),0) from catm_upload_amount_blocks@ampdblink)
); 
commit; 

------------------------------
-- 10. Z_UDF
------------------------------
insert into amp_extraction_stats_tab values ('CIF','Z_UDF',
(
select nvl(count(*),0) from z_udf@ampdblink)
);
commit;


------------------------------
-- 11. STTB_UPLOAD_CUST_ACCOUNT_TD
------------------------------

insert into amp_extraction_stats_tab values('ACCOUNT','STTB_UPLOAD_CUST_ACCOUNT_TD',
(
select nvl(count(*),0) from sttb_upload_cust_account_td@ampdblink)
); 
commit; 

------------------------------
-- 12. STTB_UPLOAD_CUST_ACCOUNT_CASA
------------------------------

insert into amp_extraction_stats_tab values('ACCOUNT','STTB_UPLOAD_CUST_ACCOUNT_CASA',
(
select nvl(count(*),0) from STTB_UPLOAD_CUST_ACCOUNT_CASA@ampdblink)
); 
commit; 

------------------------------
-- 13. STTB_UPLOAD_LINKED_ENTITIES
------------------------------

insert into amp_extraction_stats_tab values('ACCOUNT','STTB_UPLOAD_LINKED_ENTITIES',
(
select nvl(count(*),0) from STTB_UPLOAD_LINKED_ENTITIES@ampdblink)
); 
commit; 

------------------------------
-- 14. MSTM_CUST_ACC_ADDRESS
------------------------------

insert into amp_extraction_stats_tab values('ACCOUNT','MSTM_CUST_ACC_ADDRESS',
(
select nvl(count(*),0) from mstm_cust_acc_address@ampdblink)
); 
commit; 

------------------------------
-- 15. CATM_UPLOAD_AMOUNT_BLOCKS
------------------------------

insert into amp_extraction_stats_tab values('ACCOUNT','CATM_UPLOAD_AMOUNT_BLOCKS',
(
select nvl(count(*),0) from catm_upload_amount_blocks@ampdblink)
); 
commit; 

---- END OF CUSTOMER STATIC EXTRACTION STATISTICS DATA

--- CUSTOMER FINANCIAL DATA

------------------------------
-- 16. DETB_UPLOAD_MASTER
------------------------------

insert into amp_extraction_stats_tab values('ACCOUNT','DETB_UPLOAD_MASTER',
(
select nvl(count(*),0) from detb_upload_master@ampdblink)
); 
commit; 

------------------------------
-- 17. DETB_UPLOAD_DETAIL
------------------------------

insert into amp_extraction_stats_tab values('ACCOUNT','DETB_UPLOAD_DETAIL',
(
select nvl(count(*),0) from detb_upload_detail@ampdblink)
); 
commit; 

------------------------------
-- 18. ICTM_UPLOAD_ACC
------------------------------

insert into amp_extraction_stats_tab values('ACCOUNT','ICTM_UPLOAD_ACC',
(
select nvl(count(*),0) from ictm_upload_acc@ampdblink)
); 
commit; 

------------------------------
-- 19. LDTB_UPLOAD_MASTER
------------------------------

insert into amp_extraction_stats_tab values('CORPORATE DEPOSIT','LDTB_UPLOAD_MASTER',
(
select nvl(count(*),0) from ldtb_upload_master@ampdblink)
); 
commit; 


------------------------------
-- 20. LDTB_UPLOAD_SCHEDULES
------------------------------
insert into amp_extraction_stats_tab values('CORPORATE DEPOSIT','LDTB_UPLOAD_SCHEDULES',
(
select nvl(count(*),0) from ldtb_upload_schedules@ampdblink)
); 
commit; 



------------------------------
-- 21. CFTBS_UPLOAD_INTEREST
------------------------------

insert into amp_extraction_stats_tab values('CORPORATE DEPOSIT','CFTB_UPLOAD_INTEREST',
(
select nvl(count(*),0) from cftb_upload_interest@ampdblink)
); 
commit; 


------------------------------
-- 22. SITB_UPLOAD_MASTER
------------------------------

insert into amp_extraction_stats_tab values('SI','SITB_UPLOAD_MASTER',
(
select nvl(count(*),0) from sitb_upload_master@ampdblink)
); 
commit; 

------------------------------
-- 23. SITB_UPLOAD_INSTRUCTION
------------------------------

insert into amp_extraction_stats_tab values('SI','SITB_UPLOAD_INSTRUCTION',
(
select nvl(count(*),0) from sitb_upload_instruction@ampdblink)
); 
commit; 


------------------------------
-- 24. STTM_OBDX_UPLOAD_MASTER
------------------------------

insert into amp_extraction_stats_tab values('OBDX','STTM_OBDX_UPLOAD_MASTER',
(
select nvl(count(*),0) from sttm_obdx_upload_master@ampdblink)
); 
commit; 

------------------------------
-- 25. STTM_OBDX_BENEF_INTERNAL_PAYEE
------------------------------

insert into amp_extraction_stats_tab values('OBDX','STTM_OBDX_BENEF_INTERNAL_PAYEE',
(
select nvl(count(*),0) from STTM_OBDX_BENEF_INTERNAL_PAYEE@ampdblink)
); 
commit; 

------------------------------
-- 26. STTM_OBDX_BENEF_DOMESTIC_PAYEE
------------------------------

insert into amp_extraction_stats_tab values('OBDX','STTM_OBDX_BENEF_DOMESTIC_PAYEE',
(
select nvl(count(*),0) from STTM_OBDX_BENEF_DOMESTIC_PAYEE@ampdblink)
); 
commit; 

------------------------------
-- 27. STVM_CIF_SIG_MASTER_UPLOAD
------------------------------
insert into amp_extraction_stats_tab values('SIG','STVM_CIF_SIG_MASTER_UPLOAD',
(
select nvl(count(*),0) from STVM_CIF_SIG_MASTER_UPLOAD_upload)
); 
commit; 

------------------------------
-- 28. STVM_CIF_SIG_DET_UPLOAD
------------------------------
insert into amp_extraction_stats_tab values('SIG','STVM_CIF_SIG_DET_UPLOAD',
(
select nvl(count(*),0) from STVM_CIF_SIG_DET_UPLOAD_upload)
); 
commit; 


------------------------------
-- 29. STTM_CUST_UPLOAD_IMAGE_DET
------------------------------
insert into amp_extraction_stats_tab values('SIG','STTM_CUST_UPLOAD_IMAGE_DET',
(
select nvl(count(*),0) from STTM_CUST_UPLOAD_IMAGE_DET_upload)
); 
commit; 


------------------------------
-- 30. STTM_CUST_IMG_MASTER
------------------------------
insert into amp_extraction_stats_tab values('SIG','STTM_CUST_IMG_MASTER',
(
select nvl(count(*),0) from STTM_CUST_IMG_MASTER_upload)
); 
commit; 

------------------------------
-- 31. STTM_STATUS_CHANGE_AFTER_BALANCE_UPLOAD
------------------------------
insert into amp_extraction_stats_tab values('ACCOUNT','STTM_STATUS_CHANGE_A_BAL_UPD',
(
select nvl(count(*),0) from  sttm_status_change_a_bal_upd@ampdblink)
);
commit;


-- EXECUTION OF SCRIPT

---------------------
/*
set serveroutput on;
truncate table amp_extraction_stats_tab;
exec AMP_EXTRACTION_STATS();

select * from amp_extraction_stats_tab order by module;



*/

end;
/



