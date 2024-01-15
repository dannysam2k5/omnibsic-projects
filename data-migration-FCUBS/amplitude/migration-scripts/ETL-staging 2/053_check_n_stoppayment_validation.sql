select * from catm_check_book;
select * from catm_check_details;
select * from fbtb_check_details;
select * from catm_stop_payments;



select * from catm_check_details where account||'~'||check_book_no not in (select account||'~'||first_check_no from catm_check_book);
select * from catm_stop_payments where account not in (select account from catm_check_details);
select * from catm_stop_payments where start_check_no = end_check_no and account||'~'||start_check_no not in (select account||'~'||CHECK_NO from catm_check_details);
select * from catm_stop_payments_split where account||'~'||check_no not in (select account||'~'||CHECK_NO from catm_check_details) order by account,start_check_no,check_no;
-----------------------------------
delete from catm_check_details where account||'~'||check_book_no not in (select account||'~'||first_check_no from catm_check_book);
delete from catm_stop_payments where account not in (select account from catm_check_details);
delete from catm_stop_payments where start_check_no = end_check_no and account||'~'||start_check_no not in (select account||'~'||CHECK_NO from catm_check_details);
delete from catm_stop_payments a where (a.account||'~'||a.start_check_no) in
(select account||'~'||check_no from catm_stop_payments_split where account||'~'||check_no not in (select account||'~'||CHECK_NO from catm_check_details));

---------------------------------------------------------------------------------------------------------------------------
drop table catm_stop_payments_split
create table catm_stop_payments_split as 
select branch, account, stop_payment_no, start_check_no,end_check_no check_no from catm_stop_payments where 1=2;
----------------------------------------------------------------------------------------------------------------------------
declare 
a number;
begin
for i in (select branch, account, stop_payment_no, to_number(START_CHECK_NO) START_CHECK_NO, to_number(END_CHECK_NO) END_CHECK_NO from catm_stop_payments where START_CHECK_NO <> END_CHECK_NO and to_number(START_CHECK_NO) < to_number(END_CHECK_NO))loop
a:=i.START_CHECK_NO;
while (a<=i.END_CHECK_NO) 
loop
insert into catm_stop_payments_split values(i.branch, i.account, i.stop_payment_no,lpad(i.start_check_no,6,'0') ,lpad(a,6,'0')); commit;
a:=a+1;
end loop;

end loop;
end;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
