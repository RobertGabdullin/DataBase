drop table if exists ex2;

create table ex2(
	username varchar(15) primary key,
	fullname varchar(30),
	balance integer,
	group_id integer
);

insert into ex2(username, fullname, balance, group_id)
values
('jones', 'Alice Jones', 82, 1),
('bitdiddl', 'Ben Bitdiddle', 65, 1),
('mike', 'Michael Dole', 73, 2),
('alyssa', 'Alyssa P. Hacker', 79, 3),
('bbrown', 'Bob Brown', 100, 3);

