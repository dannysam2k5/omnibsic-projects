-- Sequence of Migration Data Refresh

-- CIF
truncate table STTM_UPLOAD_CUSTOMER;    ---
truncate table STTM_UPLOAD_CUST_PERSONAL; ---
truncate table STTM_UPLOAD_CUST_CORPORATE; ---
truncate table STTM_UPLOAD_PERSONAL_JOINT; --
truncate table STTM_UPLOAD_CUST_DOMESTIC; --
truncate table Z_UDF; --
/* -- Not to be Migrated
truncate table STTM_UPLOAD_CORP_DIRECTORS;
truncate table STTM_UPLOAD_CUST_PROFESSIONAL;
truncate table STTM_UPLOAD_CUST_SHAREHOLDER;
*/


-- Signature : TEST_SIGNATURE DB
truncate table STVM_CIF_SIG_MASTER_UPLOAD;
truncate table STVM_CIF_SIG_DET_UPLOAD;
truncate table STTM_CUST_UPLOAD_IMAGE_DET;
truncate table STTM_CUST_IMG_MASTER;

-- MOCK Signature DB
truncate table STVM_CIF_SIG_MASTER_UPLOAD_upload;
truncate table STVM_CIF_SIG_DET_UPLOAD_upload;
truncate table STTM_CUST_UPLOAD_IMAGE_DET_upload;
truncate table STTM_CUST_IMG_MASTER_UPLOAD;

-- STOP PAY
truncate table CATM_UPLOAD_STOP_PAYMENTS;

-- CHECK BOOK
truncate table CATM_UPLOAD_CHECK_BOOK;
truncate table CATM_UPLOAD_CHECK_DETAILS;

-- Amount Block
truncate table CATM_UPLOAD_AMOUNT_BLOCKS;


-- Account
truncate table STTB_UPLOAD_CUST_ACCOUNT_CASA;
truncate table STTB_UPLOAD_CUST_ACCOUNT_TD;
truncate table STTB_UPLOAD_LINKED_ENTITIES;
truncate table MSTM_CUST_ACC_ADDRESS;
truncate table DETB_UPLOAD_MASTER; -- Financial
truncate table DETB_UPLOAD_DETAIL; -- Financial
truncate table ICTM_UPLOAD_ACC; -- Financial
truncate table STTM_STATUS_CHANGE_A_BAL_UPD;

-- LD (Fixed Deposits)
truncate table LDTB_UPLOAD_MASTER;
truncate table CFTB_UPLOAD_INTEREST;
truncate table LDTB_UPLOAD_SCHEDULES;

-- Standing Instructions
truncate table SITB_UPLOAD_MASTER;
truncate table SITB_UPLOAD_INSTRUCTION;

-- OBDX WEB Banking
truncate table STTM_OBDX_UPLOAD_MASTER;
truncate table STTM_OBDX_BENEF_INTERNAL_PAYEE;
truncate table STTM_OBDX_BENEF_DOMESTIC_PAYEE;
