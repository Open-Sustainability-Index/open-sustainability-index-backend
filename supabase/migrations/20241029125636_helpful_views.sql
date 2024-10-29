-- Helpful views

CREATE OR REPLACE VIEW view_companies_no_emission_data AS
  SELECT
    c.name,
    'https://www.opensustainabilityindex.org/company/' || slug AS osi_url,
    c.company_url,
    c.hq_country,
    c.organization_type,
    c.industry,
    c.lei,
    c.isic,
    c.tags,
    c.slug
  FROM company c
  LEFT JOIN emission e ON c.slug = e.company_slug
  WHERE e.company_slug IS NULL
  ORDER BY c.company_url NULLS LAST, c.name;

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
