TRUNCATE TABLE STTM_OBDX_UPLOAD_MASTER;
Insert into STTM_OBDX_UPLOAD_MASTER
Select 
ABO.LOGIN USERNAME	,--user id of the logged in user
--ABO.MDP PASSWORD	,-- Password should be provided in decrypted format so that the migration tool will encrypt it and store in OBDX DB
''  PASSWORD	,-- 
(case  when CUSTOMER_TYPE(ABO.CLI_PAL) in  ('C','B') then 'CORPORATE' else 'RETAIL' end)  USER_TYPE	,-- values can be RETAIL or CORPORATE
(case  when CUSTOMER_TYPE(ABO.CLI_PAL) in  ('C','B') then 'MAKER' else NULL end) CORP_USER_TYPE	,--If user is a corporate user, pls mention CHECKER or MAKER and nothing for retail user
COM.CLI  PARTYID	,--party id of the user
CPT.age||CPT.ncp||COM.clc ACCOUNT_NUMBER,--	if party id is not available, pls share account numbers
(select lib1 from bknom where ctab='036' and cacc=ACC.lib) TITLE	,--salutation of the user
ACC.nom FIRSTNAME	,--first name of the user
ACC.midname MIDDLENAME	,--middlename of the user
ACC.pre LASTNAME	,--lastname of the user
(select max(email)  from bkemacli where substr(cli,1,9) =substr(ABO.CLI_PAL,1,9)) EMAIL	,--email address of the user
NVL(FF_DNA_COJ(ABO.CLI_PAL,'C') ,to_date('01/01/1991','dd/mm/yyyy')) DOB	,--date of birth of the user (DD-MM-YY)
NVL(FF_BP_HOMEPOSTALADDRESS(ABO.CLI_PAL),'HOMPOST') HOMEPOSTALADDRESS	,--postal address of the user, address lines must be separated by ^ character. For instance - 123 BRONX NEWYORK^3 STREET^GHANA
FF_PLACE_OF_BIRTH_CLI_TIERS(ABO.CLI_PAL,'C') CITY	,--city where the user belongs
'GH' COUNTRY	,--country code GH should be passed
FF_LOCATION_CODE(acc.regn) STATE	,--state where the user belongs
NVL(FF_BP_POSTALCODE(ABO.CLI_PAL),'POST') POSTALCODE	,--postal code of the user address
FF_E_TELEPHONE_CLI_TIERS (ABO.CLI_PAL,'C') HOMEPHONE	,--home phone of the user
NVL(FF_E_MOBILE_CLI_TIERS(ABO.CLI_PAL,'C'),FF_E_TELEPHONE_CLI_TIERS (ABO.CLI_PAL,'C')) MOBILENO	--mobile number of the user
From BKW_ABO ABO, BKW_ABO_CPT CPT, BKCLI ACC, BKCOM COM
Where ABO.LOGIN = CPT.LOGIN AND ACC.CLI=ABO.CLI_PAL AND ABO.CPRO='WEB' and ABO.CPRO=CPT.CPRO
AND COM.CLI=ACC.CLI AND COM.NCP=CPT.NCP
order by Account_number ;
commit;
------- 
TRUNCATE TABLE STTM_OBDX_BENEF_INTERNAL_PAYEE;

Insert into STTM_OBDX_BENEF_INTERNAL_PAYEE

Select BEN.LOGIN USERNAME,trim(BEN.ETAB)||trim(BEN.GUIB)||trim(BEN.COMB) ACCOUNT_NUMBER,BEN.NOMB	ACC_NAME,BEN.NOMB	NICKNAME,
NVL((select max(email)  from bkemacli where substr(cli,1,9) =substr(ABO.CLI_PAL,1,9)),'unknowemail@yahoo.fr') PAYEE_EMAIL_ID
From BKW_ABO ABO, bkw_benef BEN 
where ABO.LOGIN =BEN.LOGIN
AND ABO.CPRO='WEB'  and BEN.ETAB='00027' and ABO.CPRO=BEN.CPRO;

commit;

TRUNCATE TABLE STTM_OBDX_BENEF_DOMESTIC_PAYEE;
Insert into STTM_OBDX_BENEF_DOMESTIC_PAYEE

Select BEN.LOGIN,BEN.COMB ACCOUNT_NUMBER,BEN.NOMB	ACC_NAME,
'HEADOFFICE' NETWORK_CLEARING_CODE,
'' NETWORK,
BEN.NOMB	NICKNAME,
NVL((select max(email)  from bkemacli where substr(cli,1,9) =substr(ABO.CLI_PAL,1,9)),'Unknoweamil@yahoo.fr') PAYEE_EMAIL_ID
From BKW_ABO ABO, bkw_benef BEN 
where ABO.LOGIN =BEN.LOGIN and ABO.CPRO=BEN.CPRO
AND ABO.CPRO='WEB'  and BEN.ETAB!='00027';

commit;