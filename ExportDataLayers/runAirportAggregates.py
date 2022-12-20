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
    with open("airportAggregates.sql") as file:
        query = text(file.read())
        con.execute(query)
        

        figure_16ab = pd.DataFrame(psql.read_sql("SELECT * from ga_airports_agg_share ", con))
        figure_16ab.to_excel('graphData//figure_16ab.xlsx')
        print(figure_16ab.info())

        figure_16cd = pd.DataFrame(psql.read_sql("SELECT * from fb_airports_agg_share ", con))
        #figure_16cd.to_excel('graphData//figure_16cd.xlsx')
        print(figure_16cd.info())


        

        


        

        





