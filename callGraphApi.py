import requests
import json
import pandas as pd
from pprint import pprint
from datetime import datetime
from datetime import date, timedelta 
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1500)
startTime = datetime.now()
from sqlalchemy import create_engine, MetaData, Table


#For loading the response data into a PostrgeSQL DB, please insert necessary credentials into the vaiable "engine" and remove the hashtag #.
#engine = create_engine('postgresql+psycopg2://USERNAME:PASSWORD@HOSTNAME:PORTNUMBER/DBNAME')

#DUE TO EXTENT OF DATA .csv and xlsx EXPORTS ARE NOT RECOMMENDED 

#ADD PAGE NAME
page_name = 'PAGE NAME'
#ADD PAGE ID
url_page_id = 'PAGE ID'
#ADD YOUR GRAPH API ACCESS TOKEN
url_access_token = "ACCESS TOKEN"


url_base = 'https://graph.facebook.com/v3.2/'
url_insights_access_token = "/insights?access_token=" 
"&"
url_dk = "pretty=1"
url_metric= "metric="
url_since= "since="
url_until = "until=" 

#Be careful with long date ranges, it is recommended to load 1 month intervals (risk of Memory overload)
day_from = date(2020, 12, 31)
day_to = date(2021, 2, 1)

delta = day_to - day_from

base_dates = []

for i in range(delta.days + 1):
    base_dates.append(str(day_from + timedelta(i)))


#List of variables for extraction
group2 = ["page_fans_city", "page_fans_country","page_impressions_by_country_unique", "page_content_activity_by_country_unique", "page_impressions_by_city_unique", "page_content_activity_by_city_unique"]



for item in group2:
    metric = item

global list_of_urls
list_of_urls = []

def urls_list(dates, url_list_n):

    x = 0
    y = 2
    url = url_base + url_page_id + url_insights_access_token + url_access_token + "&" + url_dk + "&" + url_metric + metric + "&" + url_since + dates[x] + "&" + url_until + dates[y]
    url_list_n.append(url)
    print("working on urls " + str(datetime.now() - startTime))
    while x < len(base_dates) - 3:
        x = x + 1
        y = y +1
        url = url_base + url_page_id + url_insights_access_token + url_access_token + "&" + url_dk + "&" + url_metric + metric + "&" + url_since + dates[x] + "&" + url_until + dates[y]
        url_list_n.append(url)

for item in group2:
    metric = item
    urls_list(base_dates, list_of_urls)
    

global dataframes_list
dataframes_list = []


for item in list_of_urls:
    #print(item)
    try:
        req = requests.get(item)
        js = req.json()
        countries = js['data'][0]['values'][0]['value']
        date = js['data'][0]['values'][0]['end_time']
        var_id = js['data'][0]['name']
        #print('Working on var_id: ' + var_id + ' for date: ' + date)
        df = pd.DataFrame.from_dict(countries, orient='index')
        df.reset_index(level=0, inplace=True)
        df1 = pd.DataFrame()
        df1['country_id'] = df['index']
        df1['value'] = df[0]
        df1.loc[:,'var_id'] = var_id
        df1.loc[:,'date'] = date
        df1.loc[:,'page_id'] = url_page_id
        
        df1.loc[:,'page_name'] = page_name
        dataframes_list.append(df1)
    except(IndexError, KeyError):
        print('Error var_id: ' + var_id + ' at date: ' + date)
        time.sleep(1)
        pass
    try:
        data = pd.concat(dataframes_list)
        #print(data)
        data.reset_index(level=0, inplace=True)
        print("working on " + str(var_id) + " day " + str(date) + "  " + str(datetime.now() - startTime))
    except(ValueError):
        pass        

#EXPORT TO DB
data.to_sql('fb_data_in', engine, if_exists='append')

print(" DONE IN " + str(datetime.now() - startTime)) 






