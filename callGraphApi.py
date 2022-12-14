import requests
import json
import pandas as pd
from pprint import pprint
from datetime import datetime
from datetime import date, timedelta 
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1500)
startTime = datetime.now()


#ADD PAGE NAME
page_name = 'PAGE NAME'
#ADD PAGE ID
url_page_id = 'PAGE ID'
#ADD YOUR GRAPH API ACCESS TOKEN
url_access_token = "ACCESS TOKEN"

#RANGE MAX 180 DAYS: SET start date and date bby uartals
d1 = date(2021, 12, 31)
d2 = date(2022, 4, 1)






group2 = ["page_fans_country","page_impressions_by_country_unique","page_content_activity_by_country_unique", "page_fans_city", "page_impressions_by_city_unique", "page_content_activity_by_city_unique"]







for item in group2:
    metric = item
    #print(metric)
    exec(open('graphBase2.py').read())


print(" DONE IN " + str(datetime.now() - startTime)) 
