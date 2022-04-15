import psycopg2
from geopy.geocoders import Nominatim

con = psycopg2.connect(database="dvdrental", user="postgres",
                       password="f8%BASgG", host="127.0.0.1", port="5432")

print("Database opened successfully")
cur = con.cursor()

cur.execute('''alter table address add longitude real;''')
cur.execute('''alter table address add latitude real;''')

cur.callproc('getaddresses', ())

geolocator = Nominatim(user_agent="my_request")
que1 = """update address set longitude = %s where address.address_id = %s"""
que2 = """update address set latitude = %s where address.address_id = %s"""

Ad = cur.fetchall()

for item in Ad:
    location = geolocator.geocode(item[1])
    ng = 0.0
    ti = 0.0
    if(location is not None):
        ng = location.longitude
        ti = location.latitude
        continue
    
    cur.execute(que1, (ng, item[0]))
    cur.execute(que2, (ti, item[0]))
    
con.commit()

 
