import requests
import json
import pandas as pd
import numpy as np
from pprint import pprint
from datetime import datetime
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1500)
startTime = datetime.now()
import pandas.io.sql as psql
import psycopg2 as pg
from sqlalchemy import create_engine, MetaData, Table, text
import time

#CREATE A CONNECTION WITH DB, please insert necessary credentials into the vaiable "engine" and remove the hashtag #.
#conn_1 = pg.connect("dbname= DBNAME user=USER host=HOST port=PORT password=PASSWORD")


#CALL UNIQUE CITIES FROM LOCAL DB
call_df_in = psql.read_sql("select *, replace(split_part(coordinates, ',', 1), '[', '') lon, replace(split_part(coordinates, ',', 2), ']', '') lat from ga_fb_geocoded_cities where coordinates is not null and coordinates <> 'n/a' AND distance_km IS NULL LIMIT 5", conn_1)
df_in = pd.DataFrame(call_df_in)
conn_1.close()


#add from lon lat array
list_df_out = []


#DEFAULT SETTING OF DESTINATION: KOSICE, SLOVAKIA
to_destination = [21.25997502964913,48.71733435566788]



def dataparser(x):
    from_source = [str(df_in['lon'][x]), str(df_in['lat'][x])]
    body = {"locations":[to_destination, from_source],"destinations":[0],"metrics":["distance","duration"],"resolve_locations":"true","units":"km"}

    headers = {
        'Accept': 'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
        'Authorization': '5b3ce3597851110001cf62488eb6c3ab311a4c46b02607a24bf3a792',
        'Content-Type': 'application/json; charset=utf-8'
    }
    call = requests.post('https://api.openrouteservice.org/v2/matrix/driving-car', json=body, headers=headers)

    print(call.status_code, call.reason)
    #print(call.text)
    js = call.json()

    df_query = pd.DataFrame(js['metadata']['query']['locations'], columns = ['lon', 'lat'])
    df_query['lon'] =df_query['lon'].astype(float)
    df_query['lat'] =df_query['lat'].astype(float)
    df_distances = pd.DataFrame(js['distances'], columns = ['distance_km'])
    df_durations = pd.DataFrame(js['durations'], columns = ['duration_min'])
    df_durations.loc[:, 'from_lon_matrix'] = js['sources'][1]['location'][0]
    df_durations.loc[:, 'from_lat_matrix'] = js['sources'][1]['location'][1]
    df_durations['duration_min'] = round(df_durations['duration_min']/60, 0)
    frames = [df_query, df_distances, df_durations ]
    df = pd.concat(frames, axis = 1)
    df = list_df_out.append(df)

x = 0
dataparser(x)
while x < len(df_in['adr']) - 1:
    x = x + 1
    time.sleep(0.5)
    dataparser(x)
    
data_out = pd.concat(list_df_out)


df_in['lon'] =df_in['lon'].astype(float)
df_in['lat'] =df_in['lat'].astype(float)

data_out = df_in.merge(data_out, on = ['lon', 'lat'])

data_out = data_out[['ors_id', 'duration_min_y', 'distance_km_y']]


#For updating  ga_fb_geocoded_cities in PostrgeSQL DB, please insert necessary credentials into the vaiable "engine" and remove the hashtag #.
#engine = create_engine('postgresql+psycopg2://USERNAME:PASSWORD@HOSTNAME:PORTNUMBER/DBNAME')

update_query = "UPDATE ga_fb_geocoded_cities SET distance_km =" + data_out['distance_km_y'].apply(str) + ", duration_min = " + data_out['duration_min_y'].apply(str) + " WHERE ga_fb_geocoded_cities.ors_id ='" + data_out['ors_id'].apply(str) + "';" 

for item in update_query:
    with engine.begin() as conn:     
        conn.execute(text(item))



