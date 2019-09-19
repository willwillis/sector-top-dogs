create table historical_russell_comp(
	ticker varchar(8),
	company_name varchar,
	asset_class varchar,
	weight real, 
	price real,
	shares real, 
	market_value real,
	notional_value varchar, 
	sector varchar,
	sedol varchar,
	isin varchar,
	exchange varchar,
	year_imported int
	)
	
select count(ticker), year_imported
from historical_russell_comp
group by year_imported
order by year_imported