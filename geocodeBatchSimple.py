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
from sqlalchemy import create_engine, MetaData, Table
import time


#CREATE A CONNECTION WITH DB, please insert necessary credentials into the vaiable "engine" and remove the hashtag #.
#conn_1 = pg.connect("dbname= DBNAME user=USER host=HOST port=PORT password=PASSWORD")

#call all records without coordinates
#DEFAULT LIMIT 50 for API LIMITATIONS
call_df_in = psql.read_sql("SELECT *, origin_city || ', ' || origin_country adr_in FROM ga_fb_geocoded_cities WHERE adr IS NULL LIMIT 50", conn_1)
df_in = pd.DataFrame(call_df_in)

conn_1.close()

global list_df_out
list_df_out = []



#Define calls a data manupilation for ORS API
def dataparser(x):
#INSERT YOUR API KEY
    print('https://api.openrouteservice.org/geocode/search?api_key=_INSERT_API_KEY_HERE_&text=' + str(df_in['adr_in'][x]))
    headers = {
        'Accept': 'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
    }
    #INSERT YOUR API KEY
    call = requests.get('https://api.openrouteservice.org/geocode/search?api_key=_INSERT_API_KEY_HERE_&text=' + str(df_in['adr_in'][x]), headers=headers)

    
    print(call.status_code, call.reason)

    js = call.json()

    

    

    def countryValidation():
        def dfBuilder(foo):
            print(js['features'][foo]['properties']['country'])
            df = pd.DataFrame.from_dict(js['features'][foo]['geometry'], orient = 'index')
            df = df.T
            
            df.loc [:, 'adr'] = str(df_in['adr_in'][x])
            df.loc[:, 'geometry_confidence'] = js['features'][foo]['properties']['confidence']
            df.loc[:, 'ors_id'] = js['features'][foo]['properties']['id']
            df.loc[:, 'osm_id'] = js['features'][foo]['properties']['source_id']
            df.loc[:, 'osm_layer'] =  js['features'][foo]['properties']['layer']
            df.loc[:, 'city_name']= js['features'][foo]['properties']['name']
            try:
                df.loc[:, 'region_name'] = js['features'][foo]['properties']['region']
            except(KeyError):
                df.loc[:, 'region_name'] = 'n/a'
            df.loc[:, 'country_name'] = js['features'][foo]['properties']['country']
            df = df[['type','coordinates', 'adr', 'geometry_confidence','ors_id', 'osm_id', 'osm_layer', 'city_name', 'region_name', 'country_name']]
            #print(df)
            list_df_out.append(df)
           

      
        featureposition = 0

        if js['features'][featureposition]['properties']['country'] == str(df_in['adr_in'][x]).split(", ")[1]:
            dfBuilder(featureposition)
        else:
            while js['features'][featureposition]['properties']['country'] != str(df_in['adr_in'][x]).split(", ")[1] and featureposition < len(js['features']) - 1:
                featureposition = featureposition + 1
            if js['features'][featureposition]['properties']['country'] == str(df_in['adr_in'][x]).split(", ")[1]:
                newfeatureposition = featureposition
                dfBuilder(newfeatureposition)
            elif featureposition == len(js['features']) - 1 and  js['features'][featureposition]['properties']['country'] != str(df_in['adr_in'][x]).split(", ")[1]:
                dict_flagged = { "type": "n/a", "adr": str(df_in['adr_in'][x]), "coordinates": ["n/a"], "ors_id": "n/a", "osm_id": "n/a", "type": "n/a", "city_name": "n/a", "region_name": "n/a", "country_name": "n/a"}
                df = pd.DataFrame.from_dict(dict_flagged)
                list_df_out.append(df)
             

    
    if not js['features']:
        dict_flagged = { "type": "n/a", "adr": str(df_in['adr_in'][x]), "coordinates": ["n/a"], "ors_id": "n/a", "osm_id": "n/a", "type": "n/a", "city_name": "n/a", "region_name": "n/a", "country_name": "n/a"}
        df = pd.DataFrame.from_dict(dict_flagged)
        list_df_out.append(df)
    else:
        countryValidation()
        #print('Country OK')
        




x = 0
dataparser(x)
while x < len(df_in['adr_in']) - 1:
    x = x + 1
    dataparser(x)


data_out = pd.concat(list_df_out)
data_out = data_out.reset_index()


#For loading the response data into a PostrgeSQL DB, please insert necessary credentials into the vaiable "engine" and remove the hashtag #.
#engine = create_engine('postgresql+psycopg2://USERNAME:PASSWORD@HOSTNAME:PORTNUMBER/DBNAME')

#EXPORT TEMP TABLE WITH COORDINATES
data_out.to_sql('fbgacit', engine, if_exists='replace')


#UPDATE COORDINATES IN DB
with engine.connect() as con:
    query = "UPDATE ga_fb_geocoded_cities set \"type\" = nv.\"type\", coordinates = nv.coordinates, adr = nv.adr, geometry_confidence = nv.geometry_confidence, ors_id = nv. ors_id, osm_id = nv.osm_id, osm_layer = nv.osm_layer, city_name = nv.city_name, region_name = nv.region_name, country_name = nv.country_name FROM (SELECT * FROM fbgacit) nv WHERE origin_city || ', ' || origin_country = nv.adr"
    con.execute(query)

con.close()








