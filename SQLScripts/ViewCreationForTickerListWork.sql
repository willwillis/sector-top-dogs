--Select statements to check for duplicates in ticker list 

--7551 entries in ticker list (distinct on asset - ticker - name)

--Statement checking for duplicates in company names in the data base 
select count(*), company_name
from ticker_list 
group by company_name
order by count(*) desc
-- 1 with a 3 peat, 149 additional with duplicates
--7400 rows 

--Statement checking for duplicates in tickers in the data base
select count(*), ticker
from ticker_list
group by ticker
order by count(*) desc
--5689 rows 
-- More than 1000 pairs, several with 3+
-- 1766 problem rows

select count(*), ticker||LEFT(company_name, 4)
from ticker_list
group by ticker||LEFT(company_name, 4)
order by count(*) desc

create view counter1 as
select count(*), ticker
from ticker_list
group by ticker
order by count(*) desc

create view counter2 as 
select count(*), ticker||LEFT(company_name, 5)
from ticker_list 
group by ticker||LEFT(company_name, 5)
order by count(*) desc

select * from counter2
where count > 1