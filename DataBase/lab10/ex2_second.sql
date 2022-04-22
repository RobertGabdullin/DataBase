begin;

update ex2 set username = 'ajones' where fullname = 'Alice Jones';

select * from ex2;

commit;

select * from ex2; 

begin;

update ex2 set balance = balance + 20 where fullname = 'Alice Jones';


rollback;

select * from ex2;

