DROP table IF EXISTS customer, order_, item_, order_item, temp_;

CREATE table customer(
	customerId INT PRIMARY KEY,
	city VARCHAR(20),
	customerName VARCHAR(20)
);

CREATE table order_(
	orderId INT PRIMARY KEY,
	customerId_ INT REFERENCES customer(customerId),
	orderDate date
);

CREATE table item_(
	itemId INT PRIMARY KEY,
	itemName VARCHAR(20),
	price NUMERIC(2)
);

CREATE table order_item(
	orderId_ INT REFERENCES order_(orderId),
	itemId_ INT REFERENCES item_ (itemId),
	quant INT NOT NULL
);

INSERT INTO customer(customerId, city, customerName)
VALUES (101, 'Prague', 'Martin'), (107, 'Madrid', 'Herman'), (110, 'Moscow', 'Pedro');

INSERT INTO order_(orderId, customerId_, orderDate)
VALUES 
(2301, 101, TO_DATE('23/02/2011', 'DD/MM/YYYY')),
(2302, 107, TO_DATE('25/02/2011', 'DD/MM/YYYY')),
(2303, 110, TO_DATE('27/02/2011', 'DD/MM/YYYY'));

INSERT INTO item_(itemId, itemName, price)
VALUES 
(3786, 'Net', 35.00),
(4011, 'Racket', 65.00),
(9132, 'Pack-3', 4.75),
(5794, 'Pack-6', 5.00),
(3141, 'Cover', 10.00);

INSERT INTO order_item(orderId_, itemId_, quant)
VALUES
(2301, 3786, 3), (2301, 4011, 6), (2301, 9132, 8),
(2302, 5794, 4), (2303, 4011, 2), (2303, 3141, 2);

/* Uncomment necessary query */

/* select orderId, sum(quant) as TotalNumber, sum(quant * price) as AmountToPay
from order_ join order_item on orderId = orderId_
			join item_ on itemId = itemId_
group by orderId; */

/*-----------------------------------------------------------------*/

/*create table temp_ as
	select orderId, sum(quant * price) as AmountToPay, customerId_
	from order_ join order_item on orderId = orderId_
				join item_ on itemId = itemId_
	group by orderId;
	
select customerName, AmountToPay
from temp_ join Customer on customerId = customerId_
where AmountToPay = (select max(AmountToPay) from temp_)*/