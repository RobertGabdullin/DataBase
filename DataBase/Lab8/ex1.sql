drop index if exists customer_name, customer_adress, customer_review;
--ex1

--query 1 
-- cost=0.00..4285.20
explain 
select name
from customer
where name like 'A%';

--query 2
-- cost=0.00..4285.00
explain
select name, address
from customer
where address = '178 Joseph Hollow Suite 485 Baxterberg, SD 13248';

--query 3
-- cost=0.00..4285.20
explain 
select review
from customer
where review = 'Nice';

create index customer_name on customer(name);
create index customer_adress on customer(address);
create index customer_review on customer(review);

-- query 1 (with index)
-- cost=0.42..3194.41
explain 
select name
from customer
where name like 'A%';

-- query 2 (with index)
-- cost=0.42..8.44
explain
select name, address
from customer 
where address = '178 Joseph Hollow Suite 485 Baxterberg, SD 13248';

-- query 3 (with index)
-- cost=0.54..8.56
explain 
select review
from customer
where review = 'Nice';
