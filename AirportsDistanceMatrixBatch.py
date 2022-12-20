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

#For updating  ga_fb_geocoded_cities in PostrgeSQL DB, please insert necessary credentials into the vaiable "engine" and remove the hashtag #.
#engine = create_engine('postgresql+psycopg2://USERNAME:PASSWORD@HOSTNAME:PORTNUMBER/DBNAME')


with engine.connect() as con:
    with open("addAirportsToSample.sql") as file:
        query = text(file.read())
        con.execute(query)

        call_df_in = pd.DataFrame(psql.read_sql("SELECT * from sample_airports_over240", con))
        print(call_df_in.info())
    
    
    df_in = call_df_in


    list_df_out = []


#REPLACE INSERT_API_KEY WITH YOU ORS API KEY
    def dataparser(x):
        from_source = [str(df_in['lon'][x]), str(df_in['lat'][x])]
        to_destination = [str(df_in['destination_coordinates'][x][0]), str(df_in['destination_coordinates'][x][1])]
        body = {"locations":[to_destination, from_source],"destinations":[0],"metrics":["distance","duration"],"resolve_locations":"true","units":"km"}

        headers = {
            'Accept': 'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
            'Authorization': 'INSERT_API_KEY',
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
        time. sleep(0.2)
        dataparser(x)
        




    data_out = pd.concat(list_df_out)


    df_in['lon'] =df_in['lon'].astype(float)
    df_in['lat'] =df_in['lat'].astype(float)

    data_out = df_in.merge(data_out, on = ['lon', 'lat'])


    update_query = "UPDATE ga_fb_geocoded_cities  SET  sample_airport = '" + data_out['destination'] +"', min_to_airport = '" + data_out['duration_min'].apply(str) + "' WHERE  ga_fb_geocoded_cities.ors_id ='" + data_out['ors_id'].apply(str) + "'; " 

    for item in update_query:
        con.execute(text(item))
        

