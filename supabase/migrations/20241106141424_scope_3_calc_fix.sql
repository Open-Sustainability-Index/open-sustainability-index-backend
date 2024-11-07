-- CHANGE: total_scope_3_summary = total_scope_3 OR SUM of cat1-cat15

-- total_emission_market_based = scope_1 + scope_2_market_based + total_scope_3_summary
-- total_emission_location_based = scope_1 + scope_2_location_based + total_scope_3_summary
-- total_reported_emission_scope_1_2 + scope_1 + (scope_2_market_based OR scope_2_location_based OR scope_2_unknown)
-- total_reported_emission_scope_1_2_3 = total_reported_emission_scope_1_2 + total_scope_3_summary
-- upstream_scope_3 = SUM of cat1-cat8
-- total_upstream_emissions = total_reported_emission_scope_1_2 + upstream_scope_3

-- revenue = revenue_local * currency_rate
-- emission_intensity = total_reported_emission_scope_1_2_3 / revenue
-- cradle_to_gate = total_upstream_emissions / revenue

CREATE OR REPLACE VIEW view_emission AS
SELECT
  -- Slug and year
  e.company_slug,
  e.year,
  e.fiscal_year,

  -- Scope 1 and 2
  e.scope_1,
  e.scope_2_market_based,
  e.scope_2_location_based,
  e.scope_2_unknown,

  -- Scope 3: first from defined total value, then total from categories
  COALESCE(e.total_scope_3, (e.cat_1 + e.cat_2 + e.cat_3 + e.cat_4 + e.cat_5 + e.cat_6 + e.cat_7 + e.cat_8 + e.cat_9 + e.cat_10 + e.cat_11 + e.cat_12 + e.cat_13 + e.cat_14 + e.cat_15)) AS total_scope_3,
  e.total_scope_3 AS total_scope_3_summary,

  -- Total emission calculations
  e.scope_1 + e.scope_2_market_based + COALESCE(e.total_scope_3, (e.cat_1 + e.cat_2 + e.cat_3 + e.cat_4 + e.cat_5 + e.cat_6 + e.cat_7 + e.cat_8 + e.cat_9 + e.cat_10 + e.cat_11 + e.cat_12 + e.cat_13 + e.cat_14 + e.cat_15)) AS total_emission_market_based,
  e.scope_1 + e.scope_2_location_based + COALESCE(e.total_scope_3, (e.cat_1 + e.cat_2 + e.cat_3 + e.cat_4 + e.cat_5 + e.cat_6 + e.cat_7 + e.cat_8 + e.cat_9 + e.cat_10 + e.cat_11 + e.cat_12 + e.cat_13 + e.cat_14 + e.cat_15)) AS total_emission_location_based,

  -- Totals for 1-2, and 1-2-3
  e.scope_1 + COALESCE(e.scope_2_market_based, e.scope_2_location_based, e.scope_2_unknown) AS total_reported_emission_scope_1_2,
  (e.scope_1 + COALESCE(e.scope_2_market_based, e.scope_2_location_based, e.scope_2_unknown) + COALESCE(e.total_scope_3, (e.cat_1 + e.cat_2 + e.cat_3 + e.cat_4 + e.cat_5 + e.cat_6 + e.cat_7 + e.cat_8 + e.cat_9 + e.cat_10 + e.cat_11 + e.cat_12 + e.cat_13 + e.cat_14 + e.cat_15))) AS total_reported_emission_scope_1_2_3,

  -- Category 1-15
  e.cat_1,
  e.cat_2,
  e.cat_3,
  e.cat_4,
  e.cat_5,
  e.cat_6,
  e.cat_7,
  e.cat_8,
  e.cat_9,
  e.cat_10,
  e.cat_11,
  e.cat_12,
  e.cat_13,
  e.cat_14,
  e.cat_15,
  e.all_cats, -- Text field

  -- Upstream emissions
  (e.cat_1 + e.cat_2 + e.cat_3 + e.cat_4 + e.cat_5 + e.cat_6 + e.cat_7 + e.cat_8) AS upstream_scope_3,
  NULL AS share_upstream_of_scope_3,
  NULL AS scope_1_share_of_total_upstream_emissions,
  (e.scope_1 + COALESCE(e.scope_2_market_based, e.scope_2_location_based, e.scope_2_unknown) + (e.cat_1 + e.cat_2 + e.cat_3 + e.cat_4 + e.cat_5 + e.cat_6 + e.cat_7 + e.cat_8)) AS total_upstream_emissions,

  -- Revenue and currency rate
  e.revenue_local,
  e.currency,
  cr.rate_in_usd AS currency_rate,
  ROUND(e.revenue_local * cr.rate_in_usd) AS revenue,

  -- Intensity calculations
  ROUND((COALESCE(e.total_scope_3, (e.cat_1 + e.cat_2 + e.cat_3 + e.cat_4 + e.cat_5 + e.cat_6 + e.cat_7 + e.cat_8 + e.cat_9 + e.cat_10 + e.cat_11 + e.cat_12 + e.cat_13 + e.cat_14 + e.cat_15)) + e.scope_1 + COALESCE(e.scope_2_market_based, e.scope_2_location_based, e.scope_2_unknown)) / NULLIF(e.revenue_local * cr.rate_in_usd, 0)) AS emission_intensity,
  ROUND((e.scope_1 + COALESCE(e.scope_2_market_based, e.scope_2_location_based, e.scope_2_unknown) + (e.cat_1 + e.cat_2 + e.cat_3 + e.cat_4 + e.cat_5 + e.cat_6 + e.cat_7 + e.cat_8)) / NULLIF(e.revenue_local * cr.rate_in_usd, 0)) AS cradle_to_gate,

  -- Other fields
  e.ghg_standard,
  e.source_emission_report,
  e.emission_page,
  e.source_emission_link,
  e.source_revenue,
  e.page_revenue,
  e.source_revenue_link,
  e.publication_date,
  e.status,
  e.created_at,
  e.updated_at,
  e.source_emissions_page_move
FROM emission e
LEFT JOIN currency_rate cr ON e.currency = cr.currency_code
AND e.year = cr.year;
