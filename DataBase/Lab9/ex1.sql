create or replace function getAddresses()
returns table(adress_id integer, address varchar) as $$
	begin
	return query
	
		select address.address_id, address.address from address
		where address_id between 400 and 600 and address.address like '%11%';
		
	end; $$
	
language plpgsql;