-- Customer Category Script 1
select 
cli cust_code
,nom cust_name
,age branch_code
,(select lib from bkage a where a.age=c.age) branch_name
,catl category_code
,(select lib1 from bknom b where b.ctab='041' and b.cacc=c.catl) category_name

from bkcli c

order by cli;


-- Customer Category script 2
select bc.cpro product_code
,(select trim(lib) from bkprod bp where bp.cpro = bc.cpro) product_name
,age branch_code
,(select trim(lib) from bkage ba where ba.age = bc.age ) branch_name
, decode((select tcli from bkcli bi where bi.cli=bc.cli),1,'Individual',2,'Corporate',3,'Sole Proprietor') customer_type
,(select pro from bkprocli bpc where bpc.cli = bc.cli and bc.cli <> '               ' fetch first 1 row only) profile_code
,(select trim(lib1) from bknom bn, bkprocli bpc where bn.ctab = '050' and bn.cacc =bpc.pro and bpc.cli = bc.cli and bc.cli <> '               ' fetch first 1 row only) Customer_profile
,bc.inti account_type
,decode(cfe,'O','Closed','N','Active') Account_status
,decode(ife,'O','Y','N') Dormant
from bkcom bc
where bc.cli <> '               ';