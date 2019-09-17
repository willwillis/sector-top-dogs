--Group 2 Portfolio Picking 
--Database Design 

--Create a table with all Russell 3000 compositions
--When importing into this table, filter out all non-equity entries, individually look at nulls
Create table russell_composition(
	id serial primary key, 
	ticker varchar(5),
	name varchar,
	shares int,
	market_value real,
	sector varchar NOT NULL,
	compoistion_year int 
	)

--Create views for each year to easily reference

--Create view for total unique tickers

create table ticker_data(
	--index - year primary
	id serial primary key,
	ticker varchar(5),
	open real,
	high real,
	low real, 
	close real, 
	volume int,
	year int, --INDEX THIS
	trading_day date
	)




create table composition_date(
	year_id int,
	composition_date date
	)

create table  monthly_sector_returns(
	month date,
	sector varchar, 
	returns real
	)


create table aggregate_stock_data(
	ticker
	month 
	year
	return #from first day to last day of month 
	)