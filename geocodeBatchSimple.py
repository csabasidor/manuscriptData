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

#ENTER DB CREDENTIALS for LOADING into DB
conn_1 = pg.connect("dbname=DBNAME user=USERNAME host=HOSTNAME port=PORTNUMBER password=PASSWORD")

#ENTER DB CREDENTIALS for LOADING into DB
engine = create_engine('postgresql+psycopg2://USERNAME:PASSWORD@HOSTNAME:PORTNUMBER/DBNAME')



#CALL FOR Facebook Graph API export
call_df_in = psql.read_sql("SELECT DISTINCT(origin_city), origin_country, origin_city || ', ' || origin_country adr \
                            from fb_city_month \
                            where page_name IN ('Visit Kosice') \
                            and geom is null \
                            order by origin_country, origin_city \
                            limit 50", conn_1)


#CALL FOR Google Analytics API export
call_df_in = psql.read_sql("SELECT DISTINCT(\"City\"), \"Country\", \"City\" || ', ' || \"Country\" adr \
                            from ga_city_month \
                            where page_name IN ('Visit Kosice') \
                            and geom is null \
                            order by \"Country\", \"City\" \
                            limit 50", conn_1)


df_in = pd.DataFrame(call_df_in)

conn_1.close()





global list_df_out
list_df_out = []

def dataparser(x):
    #ENTER YOUR API KEY
    print('https://api.openrouteservice.org/geocode/search?api_key=ENTERYOURAPIKEY&text=' + str(df_in['adr'][x]))
    headers = {
        'Accept': 'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
    }
    #ENTER YOUR API KEY
    call = requests.get('https://api.openrouteservice.org/geocode/search?api_key=ENTERYOURAPIKEY&text=' + str(df_in['adr'][x]), headers=headers)

    
    print(call.status_code, call.reason)

    js = call.json()

    
    

    

    def countryValidation():
        def dfBuilder(foo):
            print(js['features'][foo]['properties']['country'])
            df = pd.DataFrame.from_dict(js['features'][foo]['geometry'], orient = 'index')
            df = df.T
            
            df.loc [:, 'adr'] = str(df_in['adr'][x])
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

        if js['features'][featureposition]['properties']['country'] == str(df_in['adr'][x]).split(", ")[1]:
            dfBuilder(featureposition)
        else:
            while js['features'][featureposition]['properties']['country'] != str(df_in['adr'][x]).split(", ")[1] and featureposition < len(js['features']) - 1:
                featureposition = featureposition + 1
            if js['features'][featureposition]['properties']['country'] == str(df_in['adr'][x]).split(", ")[1]:
                newfeatureposition = featureposition
                dfBuilder(newfeatureposition)
            elif featureposition == len(js['features']) - 1 and  js['features'][featureposition]['properties']['country'] != str(df_in['adr'][x]).split(", ")[1]:
                dict_flagged = { "type": "n/a", "adr": str(df_in['adr'][x]), "coordinates": ["n/a"], "ors_id": "n/a", "osm_id": "n/a", "type": "n/a", "city_name": "n/a", "region_name": "n/a", "country_name": "n/a"}
                df = pd.DataFrame.from_dict(dict_flagged)
                list_df_out.append(df)
             

    
    if not js['features']:
        dict_flagged = { "type": "n/a", "adr": str(df_in['adr'][x]), "coordinates": ["n/a"], "ors_id": "n/a", "osm_id": "n/a", "type": "n/a", "city_name": "n/a", "region_name": "n/a", "country_name": "n/a"}
        df = pd.DataFrame.from_dict(dict_flagged)
        list_df_out.append(df)
    else:
        countryValidation()
        #print('Country OK')
        
    

x = 0
dataparser(x)
while x < len(df_in['adr']) - 1:
    x = x + 1
    dataparser(x)


data_out = pd.concat(list_df_out)

#EXPORT TO PG DATABASE

#CHANGE THE OUTPUT NAME
data_out.to_sql('CHANGE THE OUTPUT NAME', engine, if_exists='append')

