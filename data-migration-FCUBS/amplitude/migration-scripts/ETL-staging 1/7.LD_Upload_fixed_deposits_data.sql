--INSERT INTO Ldtb_Upload_Master  
 DROP SEQUENCE FF_SEQ_LD_FIXED_TD_FLEX;
CREATE SEQUENCE  "FF_SEQ_LD_FIXED_TD_FLEX"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 62000001 CACHE 20 NOORDER  NOCYCLE  NOPARTITION ;
Truncate TABLE Ldtb_Upload_Master;
 Insert into Ldtb_Upload_Master

Select 
acc.eve EXT_CONTRACT_REF_NO    ,--                	reference number in amplitude
'AMPL_FDEP_UPD' SOURCE_CODE    ,--                        	AMP_LD
FF_BRANCH_CODE(acc.age)      BRANCH_CODE  ,--          BRANCH                                 	bank mapping
(case when acc.dev ='936' then 'FCLY' else 'FCFY' end) PRODUCT                       ,--         	mapping product of the bank
'LD' MODULE  ,--                               	default='LD'
'D' PAYMENT_METHOD       ,--                  	Discount,Bearing, True Discount
(case    when acc.renouv in ('A','M') then 'Y' else 'N' end) ROLLOVER_ALLOWED    ,--                   	Renouvellement Y/N
acc.eve   USER_REF_NO              ,--              	EXT_CONTRACT_REF_NO                    
rtrim(ltrim(acc.cli))  COUNTERPARTY              ,--             	client ID in legacy
rtrim(ltrim(FF_DEVISE_ISO3LETTRE(acc.dev)))  CURRENCY         ,--                       	CCY
acc.mon AMOUNT                  ,--                	amount of the TD
acc.dou ORIGINAL_START_DATE        ,--             	original start date of the TD
NULL CLUSTER_ID           ,--                   	default=NULL
NULL CLUSTER_SIZE          ,--                  	default=NULL
acc.agent DEALER            ,--                      	
sysdate BOOKING_DATE             ,--               	migration date
acc.dva VALUE_DATE                 ,--             	
'F' MATURITY_TYPE              ,--             	default=Fixed, Call, Notice
acc.dech MATURITY_DATE               ,--            	
NULL NOTICE_DAYS                    ,--         	default=NULL
acc.typ REMARKS                      ,--           	recuperer le libellé du type
acc.age||acc.ncp||FF_COM_CLC(acc.age,acc.ncp) DFLT_SETTLE_AC                ,--          	
FF_BRANCH_CODE(acc.age) DFLT_SETTLE_AC_BRANCH    ,--              	base on bank mapping document
acc.eve REL_REFERENCE                        ,--   	EXT_CONTRACT_REF_NO                    
NULL CREDIT_LINE                            ,--	default=NULL
NULL BROKER_CODE                            ,--	default=NULL
'NORM' USER_DEFINED_STATUS                   ,-- 	default=NORM
'U' UPLOAD_STATUS                          ,--	default=U
acc.cap CONTRACT_SCHEDULE_TYPE              ,--   	default=C, N
'Y' LIQ_BACK_VALUED_SCHEDULES              	,--default=Y
'A' PRINCIPAL_LIQUIDATION                  	,--default=A
'' REVOLVING_COMMITMENT                 ,--  	default=NULL
rtrim(ltrim(FF_DEVISE_ISO3LETTRE(acc.dev))) HOLIDAY_CCY  ,--                          	default=currency transaction
'N' VERIFY_FUNDS                           ,--	default=N (for loan)
'Y' SCHEDULE_MOVEMENT                      ,--	Y confirm with the bank
'N' IGNORE_HOLIDAYS                        ,--	N confirm with the bank
NULL AMORTISATION_TYPE                     ,-- 	default=NULL
'Y' DEDUCT_TAX_ON_CAPITALISATION           ,--	Y
'' MOVE_ACROSS_MONTH                      	,--
'' CASCADE_SCHEDULES                   ,--   	,--
NULL STATUS_CONTROL                 ,--        ,--	defaut=NULL
(case when acc.renouv='A' then acc.mon else 0 end ) ROLLOVER_AMT                     ,--      	amount of TD if automatique
(case when acc.renouv='A' then 'A' else case when acc.renouv='M' then 'M' else NULL end end) ROLLOVER_TYPE                 ,--         	default=Manuel, A
'' ROLLOVER_AMOUNT_TYPE       ,--            	AMOUNT_TYPE of the rollover
'' ROLLOVER_MATURITY_TYPE  ,--               	Maturity_Type of rollover
'' ROLLOVER_MATURITY_DATE                 ,--	Maturity_date of rollover
'' ROLLOVER_NOTICE_DAYS                  ,-- 	Notice_days of rollover
NULL UPDATE_UTILISATION_ON_ROLLOVER         ,--	default=NULL
'Y' APPLY_TAX_ON_ROLLOVER                ,--  	default=Y
NULL ROLLOVER_ICCF_FROM               ,--      	default=NULL
'Y' LIQUIDATE_OD_SCHEDULES         ,--        	default=Y
NULL SCHEDULE_DEFINITION_BASIS  ,--            	default=NULL
'N' APPLY_CHARGE                          ,-- 	default=N for corporate
'WTH_TX' TAX_SCHEME                             ,--	Tax code product (mapping of the bank)
NULL BROKER_CONFIRM_STATUS          ,--        	default=NULL
NULL CPARTY_CONFIRM_STATUS       ,--           	default=NULL
NULL LOAN_STMT_TYPE           ,--              	default=NULL
NULL LOAN_STMT_CYCLE       ,--                 	default=NULL
NULL STATEMENT_DAY      ,--                    	default=null
rtrim(ltrim(FF_DEVISE_ISO3LETTRE(acc.dev)))  DFLT_SETTLE_CCY ,--                       	default=null modify 06042022
acc.age||acc.ncp||FF_COM_CLC(acc.age,acc.ncp) DR_SETL_AC                   ,--          	default=null modify 06042022
FF_BRANCH_CODE(acc.age) DR_SETL_AC_BR                   ,--       	default=null modify 06042022
rtrim(ltrim(FF_DEVISE_ISO3LETTRE(acc.dev))) DR_SETL_CCY                            	,--default=null
'' PARENT_EXT_CONTRACT_REF_NO             	,--
acc.eve PROCESS_ID                       ,--      	defaut=EXTERNAL_REF_NO
'' ACTION_FLAG                           ,-- 	FASYL Back
NULL ASSIGNED_CONTRACT             ,--         	default=NULL
'I' TREAT_SPL_AMT_AS            ,--           	default=I
NULL NEW_COMPONENTS_ALLOWED  ,--               	default=NULL
'N' TRACK_RECEIVABLE_MLIQ                ,--  	default=N
'N' TRACK_RECEIVABLE_ALIQ             ,--     	default=N
'Y' PARTIAL_PAYMENT_MLIQ           ,--        	default=Y
null MAX_DRAWDOWN_AMOUNT        ,--            	
NULL AUTO_CREATE_CR_ACC      ,--               	default=NULL
NULL AUTO_CREATE_DR_ACC   ,--                  	default=NULL
NULL HOLIDAY_MONTHS_FLAG                    ,--	default=NULL
NULL HOLIDAY_MONTHS                      ,--   	default=NULL
NULL INTERFACE_REF_NO                 ,--      	default=NULL
NULL ANNUITY_LOAN                  ,--         	default=NULL
NULL RISK_FREE_EXP_AMOUNT       ,--            	default=NULL
NULL EXPOSURE_CATEGORY       ,--               	default=NULL
'N' AUTO_PROV_REQD        ,--                 	default=N
'N' VERIFY_FUNDS_FOR_PRINCIPAL,--             	default=N
'N' VERIFY_FUNDS_FOR_INTEREST              ,--	default=N
'N' VERIFY_FUNDS_FOR_PENALTYAMT         ,--   	default=N
'N' SGEN_REQD                        ,--      	default=N
'N' NOTC_REQD                              ,--	default=N
'N' DEMAND_BASIS                        ,--   	default=S (for MM)
'L' PROV_CCY_TYPE                    ,--      	default=L
'F' INT_PERIOD_BASIS              ,--         	default=F
'N' ROUNDING_REQD              ,--            	default=N
'N' CCY_ROUND_RULE          ,--               	default=N
NULL CCY_DECIMALS        ,--                   	default=NULL
NULL CCY_ROUND_UNIT   ,--                      	default=NULL
'N' MOVE_PAYMENT_SCH                       	,--default=N
'N' MOVE_REVISION_SCH                    ,--  	default=N
'N' MOVE_COMM_REDN_SCH                ,--     	default=N
'N' MOVE_DISBURSE_SCH              ,--        	default=N
'N' CONSIDER_BRANCH_HOLIDAY     ,--           	default=N
NULL FUNDING_METHOD          ,--               	default=NULL
NULL WORKFLOW_STATUS      ,--                  	default=NULL
NULL DEAL_DATE         ,--                     	default=NULL
NULL OFFSET_NO      ,--                        	default=NULL
NULL PAY_TO_ACC  ,--                           	default=NULL
NULL DRAWDOWN_NO                            	,--default=NULL
NULL BROKER_CCY                             ,--	default=NULL
NULL BROKER_AMT                          ,--   	default=NULL
NULL PAY_TO                           ,--      	default=NULL
NULL ROLLOVER_METHOD               ,--         	default=NULL
NULL ROLLOVER_MECHANISM      ,--,--               	default=NULL
NULL PAYIND               ,--                  	default=NULL
NULL RECIND            ,--                     	default=NULL
NULL TRANCHE_REF_NO ,--                        	default=NULL
NULL SYNDICATION_REF_NO     ,--                	default=NULL
NULL DEALING_METHOD                         	,--default=NULL
NULL ROLL_RESET_TENOR                      ,-- 	default=NULL
'NEW' ACTION_CODE                       ,--     	NEW
NULL PARENT_CONTRACT_REF_NO          ,--       	default=NULL
acc.eve CONTRACT_REF_NO                   ,--     	default=OLD reference from AMP
NULL SUBSYSTEM_STAT            ,--             	default=NULL
NULL M_SCH_SCHEDULE_MOVEMENT,--                	,--default=NULL
NULL M_SCH_MOVE_ACROSS_MONTH               ,-- 	default=NULL
NULL M_SCH_IGNORE_HOLIDAYS              ,--    	default=NULL
NULL M_SCH_APPLY_FACILITY_HOL_CCY    ,--       	default=NULL
NULL M_SCH_APPLY_CONTRACT_HOL_CCY ,--          	default=NULL
NULL M_SCH_APPLY_LOCAL_HOL_CCY ,--             	default=NULL
1 EVENT_SEQ_NO              ,--             	default=1
1 VERSION_NO             ,--                	default=1
NULL REF_RATE                               	,--default=NULL
'D' ROLL_BY                                	,--default=D to be confirm
'' ROLLOVER_MATURITY_DAYS                 ,	
'Y' ALLOW_PREPAY                           ,--	default=Y
null USER_INPUT_MATURITY_DATE               	,--maturity date
NULL CHK_RATE_CODE_CCY                  ,--    	default=NULL
'N' APPLY_FACILITY_HOL_CCY           ,--      	default=N
'N' APPLY_LOCAL_HOL_CCY           ,--         	default=N
'N' APPLY_CONTRACT_HOL_CCY     ,--            	default=N
'N' USER_DEFINED_SCHED                     ,--	default=N
'N' MULTIPLE_CIF                        ,--   	default=N
'N' SUBSIDY_ALLOWED                  ,--      	default=N
NULL DIFFERENTIAL_AMOUNT          ,--          	default=NULL
acc.eve UPLOAD_ID              ,--                	External_reference_number
FF_SEQ_LD_FIXED_TD_FLEX.nextval SOURCE_SEQ_NO              ,--     	sequence_increment
'CDDTRONL' FUNCTION_ID      --                  	CDDTRONL

From BKDAT acc, BKCLI cli, BKCOM Com where acc.cli = cli.cli and CUSTOMER_TYPE(cli.cli) in ('C','B','I') and com.ncp=acc.ncpd and acc.age=com.age
and ctr not in ('6','7','9','8');
commit;



---- Upload of Cftb_Upload_Interest


-- NOT FINISH for upload the ICTM
Truncate table Cftb_Upload_Interest;
Insert into Cftb_Upload_Interest 
Select 
acc.SOURCE_CODE SOURCE_CODE,
acc.BRANCH BRANCH_CODE,
acc.USER_REF_NO SOURCE_REF,
'CD_MAINCOM' COMPONENT, -- correct 11042022
'N' WAIVER,
'' INTEREST_BASIS,
ss.tau RATE,
NULL RATE_CODE,
'' SPREAD,
NULL FLAT_AMOUNT,
NULL ACQUIRED_AMOUNT,
'U' CONV_STATUS,
NULL ERR_MSG,
NULL MIN_RATE,
NULL MAX_RATE,
NULL RATE_TYPE,
NULL RATE_CODE_USAGE,
'U' RATE_CALC_TYPE,
NULL BORROW_LEND_IND,
0 RESET_TENOR,
'D' UNIT,
0 NO_OF_UNITS,
'D' DENOMINATOR_BASIS,
'' BASIS_366,
NULL NO_OF_INT_PERIOD,
'N' DISC_ACCR_APPLICABLE,
NULL MARGIN,
acc.SOURCE_SEQ_NO SOURCE_SEQ_NO,
NULL CUST_MARGIN 
FROM Ldtb_Upload_Master ACC, BKDAT SS where ss.eve=ACC.CONTRACT_REF_NO;

commit;