 -- STTM_UPLOAD_CUST_PERSONAL
 select 
 (select trim(lib1) from bknom bn where bn.ctab = '036' and bn.cacc=bc.lib ) CUSTOMER_PREFIX -- t036
 ,pre FIRST_NAME 
 ,midname MIDDLE_NAME
 ,nom LAST_NAME
 ,dna DATE_OF_BIRTH
-- ,(select bj.pre||' '||bj.nom from bkcoj bj where bj.clip=bc.cli and bc.lib=31) LEGAL_GUARDIAN 
 ,(case when bc.lib=31 then 'more than 1 record' end) LEGAL_GUARDIAN
 ,(case when bc.lib=31 then 'Y' end) MINOR 
 ,sext SEX 
 ,(select trim(lib1) from bknom bn where bn.ctab = '033' and bn.cacc=bc.nat) P_NATIONAL_ID
 ,(case when trim(bc.tid) = '00002' then bc.nid  end) PASSPORT_NO -- national identity number
 ,(case when trim(bc.tid) = '00002' then bc.did end ) PPT_ISS_DATE 
 ,(case when trim(bc.tid) = '00002' then bc.vid end ) PPT_EXP_DATE 
 ,(select ba.adr1 from bkadcli ba where ba.cli = bc.cli fetch first 1 row only ) D_ADDRESS1  -- bkadcli.adr1
 ,(select ba.adr2 from bkadcli ba where ba.cli = bc.cli fetch first 1 row only ) D_ADDRESS2 -- bkadcli.adr2
 ,(select ba.adr3 from bkadcli ba where ba.cli = bc.cli fetch first 1 row only ) D_ADDRESS3 -- bkadcli.adr3
 ,'more than one' TELEPHONE
 ,'' FAX 
 ,(select trim(email) from bkemacli be where be.cli = bc.cli and be.typ='001') E_MAIL
 ,(select ba.adr1 from bkadcli ba where ba.cli = bc.cli fetch first 1 row only ) P_ADDRESS1  -- bkadcli.adr1
 ,(select ba.adr2 from bkadcli ba where ba.cli = bc.cli fetch first 1 row only ) P_ADDRESS2 -- bkadcli.adr2
 ,(select ba.adr3 from bkadcli ba where ba.cli = bc.cli fetch first 1 row only ) P_ADDRESS3
 ,cli CUSTOMER_NO
 ,(select trim(lib1) from bknom bn where bn.ctab = '040' and bn.cacc=bc.res) D_COUNTRY
 ,(select trim(lib1) from bknom bn where bn.ctab = '040' and bn.cacc=bc.res) P_COUNTRY
 ,(case when resd='001' then 'Y' 
    when resd = '002' then 'N' end) RESIDENT_STATUS
 ,'' CONVERSION_STATUS_FLAG
 ,'' ERR_MSG 
 ,'' MAINTENANCE_SEQ_NO
 ,(select trim(lib1) from bknom bn where bn.ctab = '036' and bn.cacc=bc.lib ) CUSTOMER_PREFIX1
 ,(select trim(lib1) from bknom bn where bn.ctab = '036' and bn.cacc=bc.lib ) CUSTOMER_PREFIX2
 ,'' SOURCE_SEQ_NO
 ,age BRANCH_CODE
 ,'' SOURCE_CODE
 ,'' AGE_PROOF_SUBMITTED
 ,(select ba.adr1 from bkadcli ba where ba.cli = bc.cli fetch first 1 row only ) P_ADDRESS4
 ,(select ba.adr2 from bkadcli ba where ba.cli = bc.cli fetch first 1 row only ) D_ADDRESS4 
 ,viln PLACE_OF_BIRTH
 ,(select trim(lib1) from bknom bn where bn.ctab = '033' and bn.cacc=bc.payn ) BIRTH_COUNTRY
 ,'' TEL_ISD_NO 
 ,'' MOB_ISD_NO
 ,'' FAX_ISD_NO 
 ,(select trim(lib1) from bknom bn where bn.ctab='186' and bn.cacc = bc.fatca_status) US_RES_STATUS
 ,'' PA_ISSUED
 ,'' PA_HOLDER_NAME 
 ,(select trim(lib1) from bknom bn where bn.ctab = '033' and bn.cacc=bc.nat ) PA_HOLDER_NATIONALTY 
 ,'' PA_HOLDER_ADDR
 ,'' PA_HOLDER_ADDR_COUNTRY
 ,'' PA_HOLDER_TEL_ISD
 ,'' PA_HOLDER_TEL_NO 
 ,'' VST_US_PREV 
 ,'more than one' MOBILE_NUMBER 
 ,'' CUST_COMM_MODE
 ,dmo modified_date
 from bkcli bc where dmo <= '12-Sep-21';