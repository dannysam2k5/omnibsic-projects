-- Customer Risk Report
SELECT
cli customer_code
,trim(nomrest) customer_name
,(case when resd='001' then 'YES' 
    when resd = '002' then 'NO' else 'Not Specified' end) RESIDENT_STATUS
,decode(rrc,'1','LOW','2','MEDIUM-LOW','3','MEDIUM','4','MEDIUM-HIGH','5','HIGH','Not Specified') Risk
,decode((select trim(vala) from bkicli bi where iden='0000000014' and bi.cli=bc.cli),'N','NO','O','YES','Not Specified') Pep
,decode(tcli,1,'Individual',2,'Company',3,'Sole Proprietor') Customer_type
,(select trim(lib1) from bknom bn, bkprocli bpc where bn.ctab = '050' and bn.cacc =bpc.pro and bpc.cli = bc.cli and bc.cli <> '               ' fetch first 1 row only) Customer_category
,dou Opening_date
,decode(age,'00100','CLEARING SYSTEM'    
,'00101','BSIC ADABRAKA BRANCH'    
,'00102','BSIC ACCRA CENTRAL'    
,'00103','BSIC SPINTEX'    
,'00104','BSIC NIMA'    
,'00105','BSIC NORTH INDUSTRIAL AREA'    
,'00106','BSIC MADINA'    
,'00107','BSIC TEMA'    
,'00108','BSIC DARKUMAN'    
,'00109','BSIC ACHIMOTA'    
,'00110','BSIC KASOA'    
,'00111','BSIC OSU'    
,'00112','BSIC TEMA COMM 11'    
,'00113','OMNIWCEB'    
,'00114','OMNIACCRA'    
,'00115','REGIONAL BRANCH TAADI'    
,'00401','BSIC TAKORADI'    
,'00601','BSIC ADUM'    
,'00602','BSIC ALABAR'    
,'00603','REGIONAL BRANCH ADUM'    
,'00701','BSIC SUNYANI'    
,'00801','BSIC TAMALE' ) branch
FROM bkcli bc;