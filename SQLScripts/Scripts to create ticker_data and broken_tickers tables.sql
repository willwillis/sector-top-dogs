-- Table: public.ticker_data

-- DROP TABLE public.ticker_data;

CREATE TABLE public.ticker_data
(
    "Date" timestamp without time zone,
    "Open" double precision,
    "High" double precision,
    "Low" double precision,
    "Adj Close" double precision,
    "Volume" double precision,
    "Ticker" text COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.ticker_data
    OWNER to postgres;

-- Index: ix_ticker_data_Date

-- DROP INDEX public."ix_ticker_data_Date";

CREATE INDEX "ix_ticker_data_Date"
    ON public.ticker_data USING btree
    ("Date")
    TABLESPACE pg_default;


-- Table: public.broken_tickers

-- DROP TABLE public.broken_tickers;

CREATE TABLE public.broken_tickers
(
    index bigint,
    "0" text COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.broken_tickers
    OWNER to postgres;

-- Index: ix_broken_tickers_index

-- DROP INDEX public.ix_broken_tickers_index;

CREATE INDEX ix_broken_tickers_index
    ON public.broken_tickers USING btree
    (index)
    TABLESPACE pg_default;