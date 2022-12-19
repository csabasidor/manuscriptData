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
    with open("durationBins.sql") as file:
        query = text(file.read())
        con.execute(query)
        

        figure_11ab = pd.DataFrame(psql.read_sql("SELECT * from ga_duration_bins_share ", con))
        #figure_11ab.to_excel('graphData//figure_11ab.xlsx')
        print(figure_11ab.info())

        figure_11cd = pd.DataFrame(psql.read_sql("SELECT * from fb_duration_bins_share ", con))
        #figure_11cd.to_excel('graphData//figure_11cd.xlsx')
        print(figure_11cd.info())


        figure_12ae_13ae = pd.DataFrame(psql.read_sql("SELECT * from ga_monthly_duration_bins_share  ", con))
        #figure_12ae_13ae.to_excel('graphData//figure_12ae_13ae.xlsx')
        print(figure_12ae_13ae.info())

        figure_14ae_15ae = pd.DataFrame(psql.read_sql("SELECT * from fb_monthly_duration_bins_share  ", con))
        #figure_14ae_15ae.to_excel('graphData//figure_14ae_15ae.xlsx')
        print(figure_14ae_15ae.info())

        


        

        





