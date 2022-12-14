import requests
import json
import pandas as pd
from pprint import pprint
from datetime import datetime
from datetime import date, timedelta 
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1500)
startTime = datetime.now()
import pandas.io.sql as psql
import psycopg2 as pg
from sqlalchemy import create_engine, MetaData, Table
import jsonstat
from collections import OrderedDict
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1500)

#All the data sets with the API may be found at: https://data.statistics.sk/api/v2/collection/
base_uri_to_set = 'https://data.statistics.sk/api/v2/dataset/'
data_set_id = 'cr3804mr'
response_lang = '?lang=en'

#ENTER DB CREDENTIALS for LOADING into a SQL based DB to the "engine" variable.
#If one does not itend to load the response data into a SQL based DB, the called data may be exported into a table (command ).

#engine = create_engine('postgresql+psycopg2://USERNAME:PASSWORD@HOSTNAME:PORTNUMBER/DBNAME')

#For the selection of a different or adding additional administrative units please use comma as separators within the list_of_nuts variable.
#Additional administrative units for the given data topic may be found: https://data.statistics.sk/api/v2/dimension/cr3804mr/nuts14?lang=en
list_of_nuts = ['SK0422_0425']

#For the selection of a different year please change the value for value_id variable
year_id = '2021'
#For excluding any month, please delete their value and separator within list of list_of_months variable.
list_of_months = '1.,2.,3.,4.,5.,6.,7.,8.,9.,10.,11.,12.'
#For excluding any indicator, please delete their value and separator within list of list_of_indicators variable.
#List of indicators for the given data topic may be found: https://data.statistics.sk/api/v2/dimension/cr3804mr/cr3804mr_ukaz?lang=en
list_of_indicators = 'UKAZ04, UKAZ07, UKAZ10'
#For excluding any dimension (incoming market), please delete their value and separator within list of "list_of_dims" variable.
#List of dimension for the given data topic may be found: https://data.statistics.sk/api/v2/dimension/cr3804mr/cr3804mr_dim3?lang=en
list_of_dims = ['DIM01','DIM02','DIM03','DIM04','DIM05','DIM06','DIM07','DIM08','DIM09','DIM10','DIM11','DIM12','DIM13','DIM14','DIM15','DIM16','DIM17','DIM18','DIM19','DIM20','DIM21','DIM22','DIM23','DIM24','DIM25','DIM26','DIM27','DIM28','DIM29','DIM30','DIM31','DIM32','DIM33','DIM34','DIM35','DIM36','DIM37','DIM38','DIM39','DIM40','DIM41','DIM42','DIM43','DIM44','DIM45','DIM46','DIM47','DIM48','DIM49','DIM50','DIM51','DIM52','DIM53','DIM54','DIM55','DIM56','DIM57','DIM58','DIM59','DIM60','DIM61','DIM62','DIM63','DIM64','DIM65','DIM66','DIM67','DIM68','DIM69','DIM70','DIM71','DIM72','DIM73','DIM74','DIM75','DIM76','DIM77','DIM78','DIM79','DIM80','DIM81','DIM82','DIM83','DIM84','DIM85','DIM86','DIM87','DIM88','DIM89','DIM90']



def get_tab(x,y):  
    uri = base_uri_to_set + data_set_id +'/'+list_of_nuts[x]+'/'+ year_id +'/'+list_of_months +'/' + list_of_indicators + '/'+ list_of_dims[y] + response_lang
    print(uri)
    print(x)
    print(y)
    json_stat_dateset = jsonstat.from_url(uri)
    df_idx = json_stat_dateset.to_data_frame(content=['idx'])
    df_label = json_stat_dateset.to_data_frame()
    final_data = pd.merge(df_idx, df_label, left_index=True, right_index=True)
    print(final_data)
    #For exporting data into SQL or PostgreSql DB, please use the command below by deleting the hashtag #.
    #final_data.to_sql('inputCr3804mr', engine, if_exists='append')
    #For exporting data into a .CSV, please use the command below by deleting the hashtag #.
    #final_data.to_excel('inputCr3804mr.xlsx')
    
x=0
y=0


get_tab(x,y)

while y < len(list_of_dims) - 1:
    y = y +1
    get_tab(x,y)





