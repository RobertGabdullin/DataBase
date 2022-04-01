drop table if exists Suppliers, Parts, Catalog;

create table Suppliers
(
    sid     int not null primary key,
    sname   text,
    address text
);

create table Parts
(
    pid   int not null primary key,
    pname text,
    color text
);

create table Catalog
(
    pid  int references Parts (pid),
    sid  int references Suppliers (sid),
    cost real,
    primary key (pid, sid)
);

insert into suppliers (sid, sname, address)
values (1, 'Yosemite Sham',     E'Devil\'s canyon, AZ'),
       (2, 'Wiley E.Coyote',    'RR Asylum, NV'),
       (3, 'Elmer Fudd',        'Carrot Patch, MN');

insert into parts (pid, pname, color)
values (1, 'Red1',      'Red'),
       (2, 'Red2',      'Red'),
       (3, 'Green1',    'Green'),
       (4, 'Blue1',     'Blue'),
       (5, 'Red3',      'Red');

insert into catalog (sid, pid, cost)
values (1, 1, 10), (1, 2, 20), (1, 3, 30), (1, 4, 40), (1, 5, 50), (2, 1, 9), (2, 3, 34), (2, 5, 48);

/* ex1 */

select distinct s.sname
from Suppliers as s, Parts as p, Catalog as c 
where s.sid = c.sid and p.pid = c.pid and p.color = 'Red';

select distinct s.sid
from Suppliers as s, Parts as p, Catalog as c 
where s.sid = c.sid and p.pid = c.pid and (p.color = 'Red' or p.color = 'Green');

select distinct s.sid
from Suppliers as s, Parts as p, Catalog as c 
where s.sid = c.sid and p.pid = c.pid and (p.color = 'Red' or s.adress = '221 Packer Street');

select c.sid from Catalog as c
where not exists (select p.pid from Parts as p where (p.color = 'Red' or p.color = 'Green')
and (not exists (select c_.sid from Catalog as c_ where c_.sid = c.sid and c_.pid = p.pid)));

select distinct c.sid from Catalog as c
where (not exists (select p.pid from Parts as p where (p.color = 'Red')
	and (not exists (select c_.sid from Catalog as c_ where c_.sid = c.sid and c_.pid = p.pid))))
or (not exists (select p.pid from Parts as p where (p.color = 'Green')
	and (not exists (select c_.sid from Catalog as c_ where c_.sid = c.sid and c_.pid = p.pid))));

select c.sid, c_.sid
from Catalog as c cross join Catalog as c_
where c.pid = c_.pid and c.sid <> c_.sid and c.cost > c_.cost;

select pid from Catalog
group by pid having count(*) > 1;

select sid, avg(cost) as AvgCost
from Catalog inner join Parts on Catalog.pid = Parts.pid
where color = 'Green' or color = 'Red'
group by sid;

select sid from Catalog
group by sid having max(cost) >= 50;

/*------------------------------------------------*/

/* ex2 */

select * from Author join Book on author_id = editor; -- 1

create table temp_ as
select author_id 
from Author, Book
where author_id not in (select editor from Book)
group by author_id
	  
select * from temp_ -- 3

select first_name, last_name
from temp_ join Author on temp_.author_id = Author.author_id -- 2
	  