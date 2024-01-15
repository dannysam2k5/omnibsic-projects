-- SITB_INSTRUCTION
select
eve INSTRUCTION_NO
,eve INST_VERSION_NO
,'' LATEST_VERSION_NO
,ope PRODUCT_CODE
,(select trim(lib) from bkope bo where bo.ope=bv.ope ) PRODUCT_TYPE
,tvir SI_TYPE
,'' CAL_HOL_EXCP
,typcou RATE_TYPE
,jex EXEC_DAYS
,'' EXEC_MTHS
,'' EXEC_YRS
,'' FIRST_EXEC_DATE
,'' NEXT_EXEC_DATE
,'' FIRST_VALUE_DATE
,'' NEXT_VALUE_DATE
,'' MONTH_END_FLAG
,'' PROCESSING_TIME
,'' USER_INST_NO
,'' INST_STATUS
,'' AUTH_STATUS
,'' LATEST_VERSION_DATE
,age BRANCH
,dou BOOK_DATE
,'' SERIAL_NO
,'' COUNTERPARTY
,'' LATEST_CYCLE_NO
,'' LATEST_CYCLE_DATE
,'' SOURCE_CODE
,'' SOURCE_INST_NO
,(select trim(lib) from bkope bo where bo.ope=bv.ope ) OPERATION
,'' SUSPEND_EXECUTION
,'' GOAL_REF_NO
from bkvrt bv;