--Create table to dump broken tickers
create table broken_tickers(
	ticker varchar(8)
	)
	
--import broken tickers file
--file to be provided by Stephen

--check results
select * from broken_tickers

--Create broken_tickers_view inner join to get market cap for broken tickers
--from historical_russell_comp table
CREATE VIEW broken_tickers_view AS
SELECT h.ticker, h.market_value, h.weight, h.sector, h.year_imported
FROM historical_russell_comp h
INNER JOIN broken_tickers b ON h.ticker=b.ticker;

--Create views for percentiles by sector for each year
CREATE VIEW tickers_percentile_2018 AS
SELECT ticker, market_value, sector, year_imported,
PERCENT_RANK()
    OVER (
        PARTITION BY sector
        ORDER BY market_value
    ) percentile_rank
FROM historical_russell_comp
WHERE year_imported = 2018;

CREATE VIEW tickers_percentile_2017 AS
SELECT ticker, market_value, sector, year_imported,
PERCENT_RANK()
    OVER (
        PARTITION BY sector
        ORDER BY market_value
    ) percentile_rank
FROM historical_russell_comp
WHERE year_imported = 2017;

CREATE VIEW tickers_percentile_2016 AS
SELECT ticker, market_value, sector, year_imported,
PERCENT_RANK()
    OVER (
        PARTITION BY sector
        ORDER BY market_value
    ) percentile_rank
FROM historical_russell_comp
WHERE year_imported = 2016;

CREATE VIEW tickers_percentile_2015 AS
SELECT ticker, market_value, sector, year_imported,
PERCENT_RANK()
    OVER (
        PARTITION BY sector
        ORDER BY market_value
    ) percentile_rank
FROM historical_russell_comp
WHERE year_imported = 2015;

CREATE VIEW tickers_percentile_2014 AS
SELECT ticker, market_value, sector, year_imported,
PERCENT_RANK()
    OVER (
        PARTITION BY sector
        ORDER BY market_value
    ) percentile_rank
FROM historical_russell_comp
WHERE year_imported = 2014;

CREATE VIEW tickers_percentile_2013 AS
SELECT ticker, market_value, sector, year_imported,
PERCENT_RANK()
    OVER (
        PARTITION BY sector
        ORDER BY market_value
    ) percentile_rank
FROM historical_russell_comp
WHERE year_imported = 2013;

CREATE VIEW tickers_percentile_2012 AS
SELECT ticker, market_value, sector, year_imported,
PERCENT_RANK()
    OVER (
        PARTITION BY sector
        ORDER BY market_value
    ) percentile_rank
FROM historical_russell_comp
WHERE year_imported = 2012;

CREATE VIEW tickers_percentile_2011 AS
SELECT ticker, market_value, sector, year_imported,
PERCENT_RANK()
    OVER (
        PARTITION BY sector
        ORDER BY market_value
    ) percentile_rank
FROM historical_russell_comp
WHERE year_imported = 2011;

CREATE VIEW tickers_percentile_2010 AS
SELECT ticker, market_value, sector, year_imported,
PERCENT_RANK()
    OVER (
        PARTITION BY sector
        ORDER BY market_value
    ) percentile_rank
FROM historical_russell_comp
WHERE year_imported = 2010;

CREATE VIEW tickers_percentile_2009 AS
SELECT ticker, market_value, sector, year_imported,
PERCENT_RANK()
    OVER (
        PARTITION BY sector
        ORDER BY market_value
    ) percentile_rank
FROM historical_russell_comp
WHERE year_imported = 2009;

CREATE VIEW tickers_percentile_2008 AS
SELECT ticker, market_value, sector, year_imported,
PERCENT_RANK()
    OVER (
        PARTITION BY sector
        ORDER BY market_value
    ) percentile_rank
FROM historical_russell_comp
WHERE year_imported = 2008;

CREATE VIEW tickers_percentile_2007 AS
SELECT ticker, market_value, sector, year_imported,
PERCENT_RANK()
    OVER (
        PARTITION BY sector
        ORDER BY market_value
    ) percentile_rank
FROM historical_russell_comp
WHERE year_imported = 2007;

--Create consolidated percentile_comp view

CREATE VIEW percentile_comp AS
SELECT *
FROM tickers_percentile_2007
UNION
SELECT *
FROM tickers_percentile_2008
UNION
SELECT *
FROM tickers_percentile_2009
UNION
SELECT *
FROM tickers_percentile_2010
UNION
SELECT *
FROM tickers_percentile_2011
UNION
SELECT *
FROM tickers_percentile_2012
UNION
SELECT *
FROM tickers_percentile_2013
UNION
SELECT *
FROM tickers_percentile_2014
UNION
SELECT *
FROM tickers_percentile_2015
UNION
SELECT *
FROM tickers_percentile_2016
UNION
SELECT *
FROM tickers_percentile_2017
UNION
SELECT *
FROM tickers_percentile_2018

--Create view last_year_ticker
CREATE VIEW last_year_ticker AS
select ticker, MAX(year_imported) as MAXYEAR
FROM percentile_comp
GROUP BY ticker

--Create list with tickers that were below the 30th percentile (last year)

CREATE VIEW TICKERS_TO_EXCLUDE AS
select l.ticker, l.MAXYEAR, p.percentile_rank
FROM last_year_ticker l
	INNER JOIN percentile_comp p
		ON l.ticker = p.ticker and
		l.MAXYEAR = p.year_imported
	INNER JOIN broken_tickers_view b
	ON l.ticker = b.ticker
WHERE p.percentile_rank < 0.3
GROUP BY l.ticker, l.maxyear, p.percentile_rank
ORDER BY l.ticker


	

