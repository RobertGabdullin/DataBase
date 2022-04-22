begin; -- start

drop table if exists accounts, ledger;

create table accounts(
	id integer primary key generated always as identity,
	name varchar(20),
	credit integer,
	currency varchar(20)
);

create table ledger(
	id integer primary key generated always as identity,
	from_ integer,
	to_ integer,
	fee integer,
	amount integer
);

insert into accounts(name, credit, currency)
values
('Herman', 1000, 'RUB'),
('Artem', 1000, 'RUB'),
('Roman', 1000, 'RUB');

commit;

begin transaction; -- T1

update accounts set credit = credit - 500 where id = 1;
update accounts set credit = credit + 500 where id = 3;

select * from accounts;

rollback;

begin; -- T2

update accounts set credit = credit - 700 where id = 2;
update accounts set credit = credit + 700 where id = 1;

select * from accounts;

rollback;

begin; -- T3

update accounts set credit = credit - 100 where id = 2;
update accounts set credit = credit + 100 where id = 3;

select * from accounts;

rollback;


/*-------------------------------------------------------------*/

alter table accounts add BankName varchar(15);
update accounts set BankName = 'SberBank' where id = 1 or id = 3;
update accounts set BankName = 'Tinkoff' where id = 2;

insert into accounts(name, credit, currency)
values
('Fees', 0, 'RUB');

begin; -- T1

update accounts set credit = credit - 500 where id = 1;
update accounts set credit = credit + 500 where id = 3;

select * from accounts;

rollback;


begin; -- T2

update accounts set credit = credit - 730 where id = 2;
update accounts set credit = credit + 700 where id = 1;
update accounts set credit = credit + 30 where id = 4;

select * from accounts;

rollback;

begin; -- T3

update accounts set credit = credit - 130 where id = 2;
update accounts set credit = credit + 100 where id = 3;
update accounts set credit = credit + 30 where id = 4;

select * from accounts;

rollback;

/*---------------------------------------------------------*/

begin;

update accounts set credit = credit - 500 where id = 1;
update accounts set credit = credit + 500 where id = 3;

insert into ledger(from_, to_, fee, amount)
values(1, 3, 0, 500);

commit;

begin;

update accounts set credit = credit - 730 where id = 2;
update accounts set credit = credit + 700 where id = 1;
update accounts set credit = credit + 30 where id = 4;

insert into ledger(from_, to_, fee, amount)
values(2, 1, 30, 700);

commit;

select * from accounts;

begin;

update accounts set credit = credit - 130 where id = 2;
update accounts set credit = credit + 100 where id = 3;
update accounts set credit = credit + 30 where id = 4;

insert into ledger(from_, to_, fee, amount)
values (2, 3, 30, 100);

commit;

select * from accounts;

select * from ledger;





