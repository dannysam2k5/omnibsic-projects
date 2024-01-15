truncate table  cvtb_upload_master;
truncate table  sttb_upload_master;
truncate table  cstb_upload_exception;





---customer-----------------------------------
truncate table  sttm_upload_customer;
truncate table  sttm_upload_cust_personal;
truncate table  sttm_upload_cust_professional;
truncate table  sttm_upload_corp_directors;
truncate table  sttm_upload_cust_corporate;
truncate table  sttm_upload_cust_domestic;
truncate table  sttm_upload_personal_joint;
--truncate table  sttm_auto_liab_upload;
----------------------------------------------
truncate table cif_upload_log;
--execute insert_customer();
--execute insert_customer_dtn;




--Account--------------------------------------
truncate table sttb_upload_cust_account;
truncate table sttb_upload_linked_entities;
truncate table acct_upload_log;
-----------------------------------------------

--Amount Block---------------------------------
truncate table CATM_UPLOAD_AMOUNT_BLOCKS;
-----------------------------------------------

--CD-------------------------------------------
truncate table ldtb_upload_master;
truncate table ldtb_upload_schedules;
truncate table cftb_upload_interest;
truncate table cd_upload_log;
---------------------------------------------