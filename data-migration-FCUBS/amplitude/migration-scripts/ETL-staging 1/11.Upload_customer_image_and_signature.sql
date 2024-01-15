Truncate table STVM_CIF_SIG_MASTER_UPLOAD;
Insert Into STVM_CIF_SIG_MASTER_UPLOAD 
Select distinct 
cl.cli CIF_ID		,
cl.cli CIF_SIG_ID	,
FF_BRANCH_CODE(cl.age) BRANCH	,
cl.nom CIF_SIG_NAME,
cl.sig CIF_SIG_TITLE,
'O' RECORD_STAT,
'A' AUTH_STAT	,
1 MOD_NO	,
'MIG_USER1' MAKER_ID	,			
to_char(sysdate, 'DD-MON-YYYY') MAKER_DT_STAMP,			
'MIG_USER2' CHECKER_ID	,		
to_char(sysdate, 'DD-MON-YYYY') CHECKER_DT_STAMP,
'Y' ONCE_AUTH	,
'Y' REPL_TO_ACC		



--Select sicli.cli,sim.ident_sig,blo.image
From 
BKSIG_IMAGE sim ,--ident_sig,chemin
BKSIG_CLIENT  sicli,-- ident_sig, ident_cli, cli
BKSIG_SIG sigsig, --ident_sig, ident_carton
--BKSIG_BLOB blo,-- chemin, image(BLOB)
BKCLI Cl
where sim.ident_sig=sicli.ident_sig
and sigsig.ident_sig=sicli.ident_sig
--and sim.chemin=blo.chemin
and cl.cli=sicli.cli 
/*
and cl.cli not in ('999999998', '999999999','141000000','141000001','141000002','141000003','141000004','141000006','141004280','141005210','141007180','141007264','141009727','141009526','141009528','141012040','141010973') 
*/
order by 1;

commit;

------------------------------------------

   DROP SEQUENCE BKSIG_BLOB_SEQ_UPLOAD ;
   
   CREATE SEQUENCE  BKSIG_BLOB_SEQ_UPLOAD  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;

Truncate table STVM_CIF_SIG_DET_UPLOAD;

    Insert Into STVM_CIF_SIG_DET_UPLOAD
    Select-- distinct 
    sicli.cli CIF_ID		,
    sicli.cli CIF_SIG_ID	,
    sim.no_format SPECIMEN_NO	,
    BKSIG_BLOB_SEQ_UPLOAD.nextval SPECIMEN_SEQ_NO,
    '' SIGNATURE,
    'N' RECORD_STAT,
    '' SIG_TEXT,
    siblo.IMAGE SIGN_IMG,
    'cust_id_cust_sig_id_'||sicli.cli||'_'||sim.no_format||'_seq.png' FILE_TYPE,
    'N' STATUS
	
    from BKSIG_CLIENT sicli , BKSIG_IMAGE sim , BKSIG_BLOB siblo
    where  sim.chemin=siblo.chemin    and sim.IDENT_SIG=sicli.IDENT_SIG 
	/*
   and sicli.cli not in ('999999998', '999999999','141000000','141000001','141000002','141000003','141000004','141000006','141004280','141005210','141007180','141007264','141009727','141009526','141009528','141012040','141010973') 
   */
	; --order by sicli.cli,sisig.no_carton
    
    
commit;    
   ------------------------------------------------
   
   
   -- customer image uppload

Truncate table sttm_cust_img_master;

Insert Into sttm_cust_img_master 
Select distinct 
cl.cli CUSTOMER_NO		,
'O' RECORD_STAT,
'A' AUTH_STAT	,
'MIG_USER1' MAKER_ID	,			
to_char(sysdate, 'DD-MON-YYYY') MAKER_DT_STAMP,			
'MIG_USER2' CHECKER_ID	,		
to_char(sysdate, 'DD-MON-YYYY') CHECKER_DT_STAMP,
1 MOD_NO	,
'Y' ONCE_AUTH	,
cl.cli CIF_SIG_ID	

--Select sicli.cli,sim.ident_sig,blo.image
From 
BKSIG_IMAGE sim ,--ident_sig,chemin
BKSIG_CLIENT  sicli,-- ident_sig, ident_cli, cli
BKSIG_SIG sigsig, --ident_sig, ident_carton
--BKSIG_BLOB blo,-- chemin, image(BLOB)
BKCLI Cl
where sim.ident_sig=sicli.ident_sig
and sigsig.ident_sig=sicli.ident_sig
--and sim.chemin=blo.chemin
/*
and cl.cli=sicli.cli and cl.cli not in ('999999998', '999999999','141000000','141000001','141000002','141000003','141000004','141000006','141004280','141005210','141007180','141007264','141009727','141009526','141009528','141012040','141010973') 
*/
order by 1;

commit;
--Cloud2021#

 /*
    DROP SEQUENCE BKSIG_BLOB_SEQ_IMG_UPLOAD ;
   
   CREATE SEQUENCE  BKSIG_BLOB_SEQ_IMG_UPLOAD  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;
    TRUNCATE TABLE sttm_cust_upload_image_det;
    Insert Into sttm_cust_upload_image_det
     Select-- distinct 
    sicli.cli CUSTOMER_NO		,
    sim.no_format SEQ_NO	,
	'' IMAGE,
    siblo.IMAGE IMAGE_TEXT	,
    'cust_id_cust_sig_id_'||rtrim(ltrim(sicli.cli))||'_'||sim.no_format||'_seq.png' FILE_TYPE,
	sicli.cli CIF_SIG_ID,
    BKSIG_BLOB_SEQ_IMG_UPLOAD.nextval SPECIMEN_SEQ_NO,
    'N' STATUS
	
    from BKSIG_CLIENT sicli , BKSIG_IMAGE sim , BKSIG_BLOB siblo
    where  sim.chemin=siblo.chemin    and sim.IDENT_SIG=sicli.IDENT_SIG  ; --order by sicli.cli,sisig.no_carton
   commit;
   

*/



 DROP SEQUENCE BKSIG_BLOB_SEQ_IMG_UPLOAD ;
   
   CREATE SEQUENCE  BKSIG_BLOB_SEQ_IMG_UPLOAD  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;

   Truncate table sttm_cust_upload_image_det;

    Insert Into sttm_cust_upload_image_det
    Select-- distinct 
    sicli.cli CUSTOMER_NO		,
    sim.no_format  SEQ_NO	,
    '' IMAGE	,
	siblo.IMAGE SIGN_IMG 	,
	'cust_id_cust_img_id_'||rtrim(ltrim(sicli.cli))||'_'||sim.no_format||'_seq.png' FILE_TYPE,
	sicli.cli CIF_SIG_ID,
    BKSIG_BLOB_SEQ_IMG_UPLOAD.nextval SPECIMEN_SEQ_NO,
    'N' STATUS
	
    from BKSIG_CLIENT sicli , BKSIG_IMAGE sim , BKSIG_BLOB siblo
    where  sim.chemin=siblo.chemin    and sim.IDENT_SIG=sicli.IDENT_SIG;   --order by sicli.cli,sisig.no_carton
	/*
    and sicli.cli not in ('999999998', '999999999','141000000','141000001','141000002','141000003','141000004','141000006','141004280','141005210','141007180','141007264','141009727','141009526','141009528','141012040','141010973') ;
	*/
	commit;