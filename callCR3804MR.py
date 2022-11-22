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

base_uri_to_set = 'https://data.statistics.sk/api/v2/collection/'
end_of_uri = '?lang=sk'





#ENTER DB CREDENTIALS for LOADING into DB
#engine = create_engine('postgresql+psycopg2://USERNAME:PASSWORD@HOSTNAME:PORTNUMBER/DBNAME')


list_of_nuts = ['SK0422_0425']
list_of_years = '2021'
list_of_months = '1.,2.,3.,4.,5.,6.,7.,8.,9.,10.,11.,12.'
list_of_indicators = 'UKAZ04, UKAZ07, UKAZ10'
list_of_dims = ['DIM01','DIM02','DIM03','DIM04','DIM05','DIM06','DIM07','DIM08','DIM09','DIM10','DIM11','DIM12','DIM13','DIM14','DIM15','DIM16','DIM17','DIM18','DIM19','DIM20','DIM21','DIM22','DIM23','DIM24','DIM25','DIM26','DIM27','DIM28','DIM29','DIM30','DIM31','DIM32','DIM33','DIM34','DIM35','DIM36','DIM37','DIM38','DIM39','DIM40','DIM41','DIM42','DIM43','DIM44','DIM45','DIM46','DIM47','DIM48','DIM49','DIM50','DIM51','DIM52','DIM53','DIM54','DIM55','DIM56','DIM57','DIM58','DIM59','DIM60','DIM61','DIM62','DIM63','DIM64','DIM65','DIM66','DIM67','DIM68','DIM69','DIM70','DIM71','DIM72','DIM73','DIM74','DIM75','DIM76','DIM77','DIM78','DIM79','DIM80','DIM81','DIM82','DIM83','DIM84','DIM85','DIM86','DIM87','DIM88','DIM89','DIM90']



def get_tab(x,y):  
    uri = 'https://data.statistics.sk/api/v2/dataset/cr3804mr/'+list_of_nuts[x]+'/2022/'+list_of_months +'/' + list_of_indicators + '/'+ list_of_dims[y] + '?lang=en'
    print(uri)
    print(x)
    print(y)
    json_stat_dateset = jsonstat.from_url(uri)
    df_idx = json_stat_dateset.to_data_frame(content=['idx'])
    df_label = json_stat_dateset.to_data_frame()
    final_data = pd.merge(df_idx, df_label, left_index=True, right_index=True)
    print(final_data)
    #final_data.to_sql('inputCr3804mr', engine, if_exists='append')

x=0
y=0

get_tab(x,y)

while y < len(list_of_dims) - 1:
    y = y +1
    get_tab(x,y)





