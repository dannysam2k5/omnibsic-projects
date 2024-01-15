-- STTM_UPLOAD_CORP_DIRECTORS
select 
cli CUSTOMER_NO     
,trim(pre)||' '||trim(nom) DIRECTOR_NAME  
,'' CONVERSION_STATUS_FLAG 
,'' ERR_MSG  
,'' MAINTENANCE_SEQ_NO     
,'' SOURCE_SEQ_NO   
,(select age from bkcli bc where bc.cli=bdc.cli) BRANCH_CODE     
,'' SOURCE_CODE     
-- Mailing Address
--,(case when (select ba.typ,ba.fmt from bkadcli ba where ba.cli = bdc.cli and ba.typ='C' and ba.fmt='BP') = ('C','BP') then (select 'P.O. Box '||trim(bpos)||' '||ville from bkadcli ba where ba.cli=bdc.cli and ba.typ='C' and ba.fmt='BP' ) end )   ADDRESS_LINE1
,'' ADDRESS_LINE1 -- mailing address
,'' ADDRESS_LINE2
,'' ADDRESS_LINE3 
,'' ADDRESS_LINE4

-- Permanent Address

,(select adr1 from bkadcli bd where bd.typ='D' and bd.cli=bdc.cli ) P_ADDRESS1 -- permanent address
,(select adr2 from bkadcli bd where bd.typ='D' and bd.cli=bdc.cli ) P_ADDRESS2
,(select adr3 from bkadcli bd where bd.typ='D' and bd.cli=bdc.cli ) P_ADDRESS3
,(select trim(ville) from bkadcli bd where bd.typ='D' and bd.cli=bdc.cli) P_ADDRESS4 
,(select trim(lib1) from bknom bn where bn.ctab = '033' and bn.cacc=bdc.nat) P_COUNTRY
,(select trim(num) from bktelcli bt where bt.cli=bdc.cli and bt.typ='001') TELEPHONE
,(case when bdc.typ='C' then
 (select vala from bkicli bi where iden = '007' and att='G' and bi.cli=bdc.cli) end ) TAX_ID
,(select trim(num) from bktelcli bt where bt.cli=bdc.cli and bt.typ='005') MOBILE_NUMBER
,(select trim(email) from bkemacli be where be.cli=bdc.cli and be.typ='001') E_MAIL
,ord SLNO
,'' TEL_ISD_NO 
,'' MOB_ISD_NO
,'' ADDR_COUNTRY
,(select trim(lib1) from bknom bn where bn.ctab = '033' and bn.cacc=bdc.nat) NATIONALITY
,'' US_RES_STATUS
,'' PCT_HOLDING
,'' TAX_CNTRY
,(select dna from bkcli bc where bc.cli=bdc.cli) DATE_OF_BIRTH
,(select trim(viln) from bkcli bc where bc.cli=bdc.cli) PLACE_OF_BIRTH
,(select trim(lib1) from bkcli bc, bknom bn where bn.ctab = '040' and bn.cacc=bc.payn and bc.cli=bdc.cli ) BIRTH_COUNTRY
,'' OWNERSHIP_TYPE
from bkdircli bdc order by cli;