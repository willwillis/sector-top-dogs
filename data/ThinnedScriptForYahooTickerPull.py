#Cleaned Python File for Stock Import
import numpy as np
import pandas as pd
import datetime
from iexfinance.stocks import get_historical_data
from iexfinance.refdata import get_symbols
import matplotlib.pyplot as plt
%matplotlib inline
import pickle
import os.path
import csv
from pathlib import Path

from pandas_datareader import data

def fetch_prices_as_df(ticker,start,end):
    """ Fetch ticker adjusted closing prices for start-end date range"""
    # Caveat: only ever use the same time series, or your pickes won't be consistent.
    # TODO: implement flush=[True,False] to write new files
    serialized_ticker_file = f"./pickle_stock_data2/{ticker}.pickle"
    df = None
    if os.path.exists(serialized_ticker_file):
        df = pickle.load( open( serialized_ticker_file, "rb" ) )
    else:
        df = data.DataReader(ticker,'yahoo',start,end).filter(['Open', 'High', 'Low', 'Adj Close', 'Volume'])
        pickle.dump( df, open( serialized_ticker_file, "wb" ) )
    return df

# Flashback!
# https://rice.bootcampcontent.com/Rice-Coding-Bootcamp/RU-HOU-FIN-PT-07-2019-U-C/blob/master/class/02-Python/3/Activities/09-Ins_CSV_Reader/Solved/Untitled.ipynb

russell = Path('ticker.csv')
all_tickers = []
with open(russell, 'r') as holdings:
    csvreader = csv.reader(holdings, delimiter=',')
    #print(f"{header} <---- HEADER")
    # Read each row of data after the header
    for row in csvreader:
        ticker = row[0]
        all_tickers.append(ticker)


for ticker in all_tickers[:100]:
    print(ticker,end=",")
    try:
        fetch_prices_as_df(ticker,'2005-01-01', '2018-12-31')
    except:
        print("broke on ", ticker)
        # TODO need to show what tickers it's breaking on