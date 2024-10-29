-- Helpful views

CREATE OR REPLACE VIEW view_companies_no_emission_data AS
  SELECT c.name
  FROM company c
  LEFT JOIN emission e ON c.slug = e.company_slug
  WHERE e.company_slug IS NULL
  ORDER BY c.name;

CREATE OR REPLACE VIEW view_countries AS
  SELECT DISTINCT hq_country
  FROM company
  WHERE hq_country IS NOT NULL
  ORDER BY hq_country;

CREATE OR REPLACE VIEW view_currencies AS
  SELECT DISTINCT UPPER(currency)
  FROM emission
  WHERE currency IS NOT NULL
  ORDER BY UPPER(currency);
