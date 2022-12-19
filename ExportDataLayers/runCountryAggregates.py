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
from sqlalchemy import create_engine, MetaData, Table, text
import time
from selenium import webdriver


#For creating temp tables, and TABLES for further processing in PostrgeSQL DB, please insert necessary credentials into the vaiable "engine" and remove the hashtag #.
#engine = create_engine('postgresql+psycopg2://USERNAME:PASSWORD@HOSTNAME:PORTNUMBER/DBNAME')


with engine.connect() as con:
    with open("createTempTables.sql") as file:
        query = text(file.read())
        con.execute(query)
        susr_country_month = pd.DataFrame(psql.read_sql("SELECT * from susr_country_month", con))
        susr_country_month.to_excel('graphData//susr_country_month.xlsx')
        print(susr_country_month.info())

        fb_country_month = pd.DataFrame(psql.read_sql("SELECT * from fb_country_month", con))
        fb_country_month.to_excel('graphData//fb_country_month.xlsx')
        print(fb_country_month.info())
        
        ga_country_month = pd.DataFrame(psql.read_sql("SELECT * from ga_country_month", con))
        ga_country_month.to_excel('graphData//ga_country_month.xlsx')
        print(ga_country_month.info())

        figure_1a = pd.DataFrame(psql.read_sql("SELECT * from figure_1a", con))
        figure_1a.to_excel('graphData//figure_1a.xlsx')
        print(figure_1a.info())

        figure_1b = pd.DataFrame(psql.read_sql("SELECT * from figure_1b", con))
        figure_1b.to_excel('graphData//figure_1b.xlsx')
        print(figure_1b.info())

        figure_1c = pd.DataFrame(psql.read_sql("SELECT * from figure_1c", con))
        figure_1c.to_excel('graphData//figure_1c.xlsx')
        print(figure_1c.info())

        figure_2a = pd.DataFrame(psql.read_sql("SELECT * from figure_2a", con))
        figure_2a.to_excel('graphData//figure_2a.xlsx')
        print(figure_2a.info())

        figure_2b = pd.DataFrame(psql.read_sql("SELECT * from figure_2b", con))
        figure_2b.to_excel('graphData//figure_2b.xlsx')
        print(figure_2b.info())

        figure_2c = pd.DataFrame(psql.read_sql("SELECT * from figure_2c", con))
        figure_2c.to_excel('graphData//figure_2c.xlsx')
        print(figure_2c.info())

        figure_3a = pd.DataFrame(psql.read_sql("SELECT * from figure_3a", con))
        figure_3a.to_excel('graphData//figure_3a.xlsx')
        print(figure_3a.info())

        figure_3b = pd.DataFrame(psql.read_sql("SELECT * from figure_3b", con))
        figure_3b.to_excel('graphData//figure_3b.xlsx')
        print(figure_3b.info())

        figure_3c = pd.DataFrame(psql.read_sql("SELECT * from figure_3c", con))
        figure_3c.to_excel('graphData//figure_3c.xlsx')
        print(figure_3c.info())

        
        figure_4 = pd.DataFrame(psql.read_sql("SELECT * FROM figure_4to10 WHERE name_var_native = 'Number of visitors total' ORDER BY name_dim_unified, month_unified", con))
        figure_4.to_excel('graphData//figure_4.xlsx')
        print(figure_4.info())

        figure_5 = pd.DataFrame(psql.read_sql("SELECT * FROM figure_4to10 WHERE name_var_native = 'Number of nights spent by visitors' ORDER BY name_dim_unified, month_unified", con))
        figure_5.to_excel('graphData//figure_5.xlsx')
        print(figure_5.info())

        figure_6 = pd.DataFrame(psql.read_sql("SELECT * FROM figure_4to10 WHERE name_var_native = 'Average number of nights spent by visitors' ORDER BY name_dim_unified, month_unified", con))
        figure_6.to_excel('graphData//figure_6.xlsx')
        print(figure_6.info())

        figure_7 = pd.DataFrame(psql.read_sql("SELECT * FROM figure_4to10 WHERE name_var_native = 'Users' ORDER BY name_dim_unified, month_unified", con))
        figure_7.to_excel('graphData//figure_7.xlsx')
        print(figure_7.info())

        figure_8 = pd.DataFrame(psql.read_sql("SELECT * FROM figure_4to10 WHERE name_var_native = 'Sessions' ORDER BY name_dim_unified, month_unified", con))
        figure_8.to_excel('graphData//figure_8.xlsx')
        print(figure_8.info())

        figure_9 = pd.DataFrame(psql.read_sql("SELECT * FROM figure_4to10 WHERE name_var_native = 'Page impressions by country' ORDER BY name_dim_unified, month_unified", con))
        figure_9.to_excel('graphData//figure_9.xlsx')
        print(figure_9.info())

        figure_10 = pd.DataFrame(psql.read_sql("SELECT * FROM figure_4to10 WHERE name_var_native = 'Page content activity by country' ORDER BY name_dim_unified, month_unified", con))
        figure_10.to_excel('graphData//figure_10.xlsx')
        print(figure_10.info())






