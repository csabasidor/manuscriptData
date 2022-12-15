import requests
import json
import pandas as pd
from urllib.request import urlopen
from bs4 import BeautifulSoup
from tabulate import tabulate
import itertools
import itertools
from urllib import parse
import functools
from itertools import groupby
from operator import itemgetter
from pprint import pprint
from datetime import datetime
from datetime import date, timedelta 
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1500)
startTime = datetime.now()
import pandas.io.sql as psql
import psycopg2 as pg
from sqlalchemy import create_engine, MetaData, Table
import pandas as pd
import pandasql as ps
import os


global listOfFilePathsCityData
listOfFilePathsCityData = []


global listOfFilePathsCountryData
listOfFilePathsCountryData = []


def list_files(dir):
    
    for root, dirs, files in os.walk(dir):
        
        print(root)
        #print(dirs)
        #print(files)
        for name in files:
            if 'GAcountry' in str(root):
                listOfFilePathsCountryData.append(os.path.join(root, name))
            elif 'GAcity' in str(root):
                listOfFilePathsCityData.append(os.path.join(root, name))
            else:
                pass

#INSERT PATH TO DIR GAcountry containing monthly country metrics
# e.g. C:\\Users\\Admin\\datadumps\\GAcountry
list_files('\\GAcountry')
#INSERT PATH TO DIR GAccity containing monthly country metrics
# e.g. C:\\Users\\Admin\\datadumps\\GAcity
list_files('\\GAcity')



global list_df_city
list_df_city = []

def cityData():
    
    df = pd.read_excel(listOfFilePathsCityData[x], sheet_name='Dataset1')
    #The name of the files in d_range may vary depending on Your language
    d_range = list_of_files[x].split("Analytics Všetky údaje webových stránok Location ")[1].split('.xlsx')[0]
    d_year = d_range[0:4]
    d_month = d_range[4:6]
    df.loc[:, 'd_year'] = d_year
    df.loc[:, 'd_month'] = d_month
    #INSERT PAGE NAME
    df.loc[:, 'page_name'] = 'PAGE NAME'
    df_out = df[['page_name','d_year', 'd_month','City', 'Country', 'Users', 'New Users', 'Sessions', 'Avg. Session Duration']]
    list_df_city.append(df_out)
    
x = 0
cityData()

while x < len(listOfFilePathsCityData) - 1:
    x =x +1
    cityData()

dataCity = pd.concat(list_df_city)
dataCity.reset_index(level=0, inplace=False)


global list_df_country
list_df_country = []

def countryData():
    
    df = pd.read_excel(listOfFilePathsCountryData[x], sheet_name='Dataset1')
    #The name of the files in d_range may vary depending on Your language
    d_range = list_of_files[x].split("Analytics Všetky údaje webových stránok Location ")[1].split('.xlsx')[0]
    d_year = d_range[0:4]
    d_month = d_range[4:6]
    df.loc[:, 'd_year'] = d_year
    df.loc[:, 'd_month'] = d_month
    #INSERT PAGE NAME
    df.loc[:, 'page_name'] = 'PAGE NAME'
    df_out = df[['page_name','d_year', 'd_month', 'Country', 'Users', 'New Users', 'Sessions', 'Avg. Session Duration']]
    list_df_country.append(df_out)
    
x = 0
countryData()

while x < len(listOfFilePathsCountryData) - 1:
    x =x +1
    countryData()

dataCountry = pd.concat(list_df_country)
dataCountry.reset_index(level=0, inplace=False)


#For loading the response data into a PostrgeSQL DB, please insert necessary credentials into the vaiable "engine" and remove the hashtag #.
#engine = create_engine('postgresql+psycopg2://USERNAME:PASSWORD@HOSTNAME:PORTNUMBER/DBNAME')
print("contected")
dataCity.to_sql("ga_city_month", engine, if_exists='append')
dataCountry.to_sql("ga_country_month", engine, if_exists='append')

