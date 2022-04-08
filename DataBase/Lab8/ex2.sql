-- cost = 186.38
select film.film_id, title, rating, name
from film join film_category on film.film_id = film_category.film_id
		  join category on film_category.category_id = category.category_id
where film.film_id not in (select distinct film_id from inventory) and rating in ('R', 'PG-13') and name in ('Horror', 'Sci-Fi');

-- cost = 678.95
select city, sum(amount)
from payment join staff on payment.staff_id = staff.staff_id
			 join store on store.store_id = staff.store_id
			 join address on store.address_id = address.address_id
			 join city on address.city_id = city.city_id
where date_part('month', payment_date) = (select max(date_part('month', payment_date)) from payment)
group by city;

/*------------------------------------------------------------------------------------*/
drop index if exists inv;
create index inv on inventory(film_id);

-- cost = 105.54
explain (format json)
select film.film_id, title, rating, name
from film left join inventory on film.film_id = inventory.film_id
		  join film_category on film.film_id = film_category.film_id
		  join category on film_category.category_id = category.category_id
where inventory.film_id is null and rating in ('R', 'PG-13') and name in ('Horror', 'Sci-Fi');


drop index if exists Month;
create index Month on payment(date_part('month', payment_date));

-- cost = 131.17
explain (format json)
select city, sum(amount)
from payment join staff on payment.staff_id = staff.staff_id
			 join store on store.store_id = staff.store_id
			 join address on store.address_id = address.address_id
			 join city on address.city_id = city.city_id
where date_part('month', payment_date) = (select max(date_part('month', payment_date)) from payment)
group by city;

