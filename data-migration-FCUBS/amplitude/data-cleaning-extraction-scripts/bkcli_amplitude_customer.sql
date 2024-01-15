select
CLI
,NOM          
,TCLI         
,(select trim(lib1) from bknom bn where bn.ctab = '036' and bn.cacc=bc.lib ) lib          
,PRE          
,SEXT         
,NJF          
,DNA          
,VILN         
,DEPN         
,(select trim(lib1) from bknom bn where bn.ctab = '040' and bn.cacc=bc.payn ) payn   
,LOCN         
,(select trim(lib1) from bknom bn where bn.ctab = '078' and bn.cacc=bc.tid)  TID          
,NID          
,DID          
,LID          
,OID          
,VID          
,(select trim(lib1) from bknom bn where bn.ctab = '047' and bn.cacc=bc.sit) SIT          
, (select trim(lib1) from bknom bn where bn.ctab = '048' and bn.cacc=bc.reg) REG          
,(select trim(lib1) from bknom bn where bn.ctab = '172' and bn.cacc=bc.capj) CAPJ         
,DCAPJ        
,(select trim(lib1) from bknom bn where bn.ctab = '185' and bn.cacc=bc.sitj) SITJ         
,DSITJ        
,TCONJ        
,CONJ         
,NBENF        
,CLIFAM       
,RSO          
,SIG          
,DATC         
,(select trim(lib1) from bknom bn where bn.ctab = '049' and bn.cacc=bc.fju) FJU          
,NRC          
,VRC          
,(select trim(lib1) from bknom bn where bn.ctab = '077' and bn.cacc=bc.nchc) NCHC         
,NPA          
,VPA          
,NIDN         
,NIS          
,NIDF         
,GRP          
,SGRP         
,MET          
,SMET         
,CMC1         
,CMC2         
,AGE          
,GES          
,QUA          
,TAX          
, (select trim(lib1) from bknom bn where bn.ctab = '041' and bn.cacc=bc.catl) CATL         
,(select trim(lib1) from bknom bn where bn.ctab = '188' and bn.cacc=bc.seg) SEG          
,NST          
,CLIPAR       
,CHL1         
,CHL2         
,CHL3         
,(select trim(lib1) from bknom bn where bn.ctab = '079' and bn.cacc=bc.lter) LTER         
,LTERC        
,(select trim(lib1) from bknom bn where bn.ctab = '186' and bn.cacc=bc.resd) RESD         
,(select trim(lib1) from bknom bn where bn.ctab = '042' and bn.cacc=bc.catn) CATN         
,(select trim(lib1) from bknom bn where bn.ctab = '071' and bn.cacc=bc.sec) SEC          
,(select trim(lib1) from bknom bn where bn.ctab = '187' and bn.cacc=bc.LIENBQ) LIENBQ       
,ACLAS        
,MACLAS       
,EMTIT        
,NICR         
,CED          
,CLCR         
,NMER         
,(select trim(lib1) from bknom bn where bn.ctab = '190' and bn.cacc=bc.lang) LANG         
,(select trim(lib1) from bknom bn where bn.ctab = '033' and bn.cacc=bc.nat) NAT          
,(select trim(lib1) from bknom bn where bn.ctab = '040' and bn.cacc=bc.res) RES          
,ICHQ         
,DICHQ        
,ICB          
,DICB         
,EPU          
,UTIC         
,UTI          
,DOU          
,DMO          
,ORD          
,CATR         
,MIDNAME      
,NOMREST      
,DRC          
,LRC          
,RSO2         
,REGN         
,RRC          
,DVRRC        
,UTI_VRRC     
,IDEXT        
,(select trim(lib1) from bknom bn where bn.ctab = '264' and bn.cacc=bc.SITIMMO) SITIMMO      
,OPETR        
,FATCA_STATUS 
,FATCA_DATE   
,FATCA_UTI    
,CRS_STATUS   
,CRS_DATE     
,CRS_UTI      
from bkcli bc;