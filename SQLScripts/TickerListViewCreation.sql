-- View: public.ordered_russell_comp

-- DROP VIEW public.ordered_russell_comp;

CREATE OR REPLACE VIEW public.ordered_russell_comp AS
 SELECT historical_russell_comp.ticker,
    historical_russell_comp.company_name,
    historical_russell_comp.asset_class,
    historical_russell_comp.year_imported
   FROM historical_russell_comp
  ORDER BY historical_russell_comp.year_imported, historical_russell_comp.ticker, historical_russell_comp.company_name;

ALTER TABLE public.ordered_russell_comp
    OWNER TO postgres;



-- View: public.ticker_list

-- DROP VIEW public.ticker_list;

CREATE OR REPLACE VIEW public.ticker_list AS
 SELECT DISTINCT ON (((ordered_russell_comp.ticker::text || ordered_russell_comp.company_name::text) || ordered_russell_comp.asset_class::text)) ordered_russell_comp.ticker,
    ordered_russell_comp.company_name,
    ordered_russell_comp.year_imported
   FROM ordered_russell_comp
  WHERE ordered_russell_comp.asset_class::text = 'Equity'::text;

ALTER TABLE public.ticker_list
    OWNER TO postgres;

