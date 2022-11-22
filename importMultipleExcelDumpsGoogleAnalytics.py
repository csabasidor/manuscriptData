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



list_of_files=['C:\\Users\\csb\\Documents\\csb_files\\00notes\\cc_ors\\slr_ga_month_21\\Analytics Všetky údaje webových stránok Location 20210101-20210131.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\00notes\\cc_ors\\slr_ga_month_21\\Analytics Všetky údaje webových stránok Location 20210201-20210228.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\00notes\\cc_ors\\slr_ga_month_21\\Analytics Všetky údaje webových stránok Location 20210301-20210331.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\00notes\\cc_ors\\slr_ga_month_21\\Analytics Všetky údaje webových stránok Location 20210401-20210430.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\00notes\\cc_ors\\slr_ga_month_21\\Analytics Všetky údaje webových stránok Location 20210501-20210531.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\00notes\\cc_ors\\slr_ga_month_21\\Analytics Všetky údaje webových stránok Location 20210601-20210630.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\00notes\\cc_ors\\slr_ga_month_21\\Analytics Všetky údaje webových stránok Location 20210701-20210731.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\00notes\\cc_ors\\slr_ga_month_21\\Analytics Všetky údaje webových stránok Location 20210801-20210831.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\00notes\\cc_ors\\slr_ga_month_21\\Analytics Všetky údaje webových stránok Location 20210901-20210930.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\00notes\\cc_ors\\slr_ga_month_21\\Analytics Všetky údaje webových stránok Location 20211001-20211031.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\00notes\\cc_ors\\slr_ga_month_21\\Analytics Všetky údaje webových stránok Location 20211101-20211130.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\00notes\\cc_ors\\slr_ga_month_21\\Analytics Všetky údaje webových stránok Location 20211201-20211231.xlsx']
               #, 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20180201-20180228.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20180301-20180331.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20180401-20180430.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20180501-20180531.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20180601-20180630.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20180701-20180731.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20180801-20180831.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20180901-20180930.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20181001-20181031.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20181101-20181130.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20181201-20181231.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20190101-20190131.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20190201-20190228.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20190301-20190331.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20190401-20190430.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20190501-20190531.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20190601-20190630.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20190701-20190731.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20190801-20190831.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20190901-20190930.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20191001-20191031.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20191101-20191130.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20191201-20191231.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20200101-20200131.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20200201-20200229.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20200301-20200331.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20200401-20200430.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20200501-20200531.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20200601-20200630.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20200701-20200731.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20200801-20200831.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20200901-20200930.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20201001-20201031.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20201101-20201130.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20201201-20201231.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20210101-20210131.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20210201-20210228.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20210301-20210331.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20210401-20210430.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20210501-20210531.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20210601-20210630.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20210701-20210731.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20210801-20210831.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20210901-20210930.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20211001-20211031.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20211101-20211130.xlsx', 'C:\\Users\\csb\\Documents\\csb_files\\viske2021\\Analytics All Web Site Data Location 20211201-20211231.xlsx']

global list_df
list_df = []

x = 0

def foo():
    
    df = pd.read_excel(list_of_files[x], sheet_name='Dataset1')
    d_range = list_of_files[x].split("Analytics Všetky údaje webových stránok Location ")[1].split('.xlsx')[0]
    d_year = d_range[0:4]
    d_month = d_range[4:6]
    df.loc[:, 'd_year'] = d_year
    df.loc[:, 'd_month'] = d_month
    df.loc[:, 'page_name'] = 'Visit Kosice'
    df_out = df[['page_name','d_year', 'd_month','City', 'Country', 'Users', 'New Users', 'Sessions', 'Bounce Rate', 'Pages / Session', 'Avg. Session Duration']]
    list_df.append(df_out)
    #print(df_out.head)

foo()

while x < len(list_of_files) - 1:
    x =x +1
    foo()

data = pd.concat(list_df)

data.reset_index(level=0, inplace=False)


#ENTER DB CREDENTIALS for LOADING into DB
engine = create_engine('postgresql+psycopg2://USERNAME:PASSWORD@HOSTNAME:PORTNUMBER/DBNAME')
print("contected")
data.to_sql("ga_city_month", engine, if_exists='append')
