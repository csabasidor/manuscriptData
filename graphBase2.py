import requests
import json
import pandas as pd
from pprint import pprint
from datetime import datetime
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1500)
startTime = datetime.now() 


url_base = 'https://graph.facebook.com/v3.2/'
url_insights_access_token = "/insights?access_token=" 
url_and = "&"
url_dk = "pretty=1"
url_metric= "metric="
url_since= "since="
url_until = "until=" 

from datetime import date, timedelta 


delta = d2 - d1

# timedelta 
base_dates = []
for i in range(delta.days + 1):
    base_dates.append(str(d1 + timedelta(i)))


def urls_list():
    global list_of_urls
    list_of_urls = []
    x = 0
    y = 2
    url = url_base + url_page_id + url_insights_access_token + url_access_token + url_and + url_dk + url_and + url_metric + metric + url_and + url_since + base_dates[x] + url_and + url_until + base_dates[y]
    list_of_urls.append(url)
    print("working on urls " + str(datetime.now() - startTime))
    while x < len(base_dates) - 3:
        x = x + 1
        y = y +1
        url = url_base + url_page_id + url_insights_access_token + url_access_token + url_and + url_dk + url_and + url_metric + metric + url_and + url_since + base_dates[x] + url_and + url_until + base_dates[y]
        list_of_urls.append(url)

urls_list()
pprint(list_of_urls[0])





global dataframes_list
dataframes_list = []

for item in list_of_urls:
    try:
        req = requests.get(item)
        js = req.json()
        countries = js['data'][0]['values'][0]['value']
        date = js['data'][0]['values'][0]['end_time']
        df = pd.DataFrame.from_dict(countries, orient='index')
        df.reset_index(level=0, inplace=True)
        df1 = pd.DataFrame()
        df1['country_id'] = df['index']
        df1['fans'] = df[0]
        df1.loc[:,'date'] = date
        df1.loc[:,'page_id'] = url_page_id
        df1.loc[:,'page_name'] = page_name
        dataframes_list.append(df1)
    except(IndexError, KeyError):
        pass
    try:
        data = pd.concat(dataframes_list)
        #print(data)
        data.reset_index(level=0, inplace=True)
        print("working on " + str(metric) + " day " + str(date) + "  " + str(datetime.now() - startTime))
    except(ValueError):
        pass        
    
    


#EXPORT TO SPREADSHEET
#data.to_excel("root:/fb_data.xlsx")

#EXPORT TO PG DATABASE
from sqlalchemy import create_engine, MetaData, Table

#ENTER DB CREDENTIALS for LOADING into DB
engine = create_engine('postgresql+psycopg2://USERNAME:PASSWORD@HOSTNAME:PORTNUMBER/DBNAME')
data.to_sql(str(metric), engine, if_exists='append')
print(str(metric) + "' in database " + str(datetime.now() - startTime)) 

