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
    base.company_slug,
    base.year,
    base.fiscal_year,

    -- Scope 1 and 2
    base.scope_1,
    base.scope_2_market_based,
    base.scope_2_location_based,
    base.scope_2_unknown,

    -- Scope 3: Total and summary
    base.total_scope_3,
    base.total_scope_3_summary,

    -- Total emissions (market-based and location-based)
    base.scope_1 + base.scope_2_market_based + base.total_scope_3 AS total_emission_market_based,
    base.scope_1 + base.scope_2_location_based + base.total_scope_3 AS total_emission_location_based,
      
    -- Totals for 1-2, and 1-2-3
    base.scope_1 + base.scope_2 AS total_reported_emission_scope_1_2,
    base.scope_1 + base.scope_2 + base.total_scope_3 AS total_reported_emission_scope_1_2_3,

    -- Category 1-15
    base.cat_1, base.cat_2, base.cat_3, base.cat_4, base.cat_5, base.cat_6,
    base.cat_7, base.cat_8, base.cat_9, base.cat_10, base.cat_11,
    base.cat_12, base.cat_13, base.cat_14, base.cat_15,
    base.all_cats,

    -- Upstream and downstream emissions
    base.upstream_scope_3,
    COALESCE(
      ROUND(
        NULLIF(upstream_scope_3, 0) / NULLIF(total_scope_3, 0) * 100,
        0
      ) || '%',
      '0%'
    ) AS share_upstream_of_scope_3,
    COALESCE(
      ROUND(
        NULLIF(scope_1, 0) / NULLIF(upstream_scope_3, 0) * 100,
        0
      ) || '%',
      '0%'
    ) AS scope_1_share_of_total_upstream_emissions,
    -- Total upstream emissions
    base.scope_1 + base.scope_2 + base.upstream_scope_3 AS total_upstream_emissions,

    -- Revenue and currency rate
    base.revenue_local,
    base.currency,
    base.currency_rate,
    base.revenue,

    -- Intensity calculations
    ROUND((base.scope_1 + base.scope_2 + base.total_scope_3) / NULLIF(base.revenue, 0)) AS emission_intensity,
    ROUND((base.scope_1 + base.scope_2 + base.upstream_scope_3) / NULLIF(base.revenue, 0)) AS cradle_to_gate,

    -- Other fields
    base.ghg_standard,
    base.source_emission_report,
    base.emission_page,
    base.source_emission_link,
    base.source_revenue,
    base.page_revenue,
    base.source_revenue_link,
    base.publication_date,
    base.status,
    base.created_at,
    base.updated_at,
    base.source_emissions_page_move,

	-- New fields
    base.scope_2,
    base.downstream_scope_3
  FROM (
    SELECT
      e.company_slug,
      e.year,
      e.fiscal_year,

      e.scope_1,
      e.scope_2_market_based,
      e.scope_2_location_based,
      e.scope_2_unknown,

      -- Category 1-15
      e.cat_1, e.cat_2, e.cat_3, e.cat_4, e.cat_5, e.cat_6, e.cat_7, e.cat_8, e.cat_9, e.cat_10, e.cat_11, e.cat_12, e.cat_13, e.cat_14, e.cat_15,
      e.all_cats,
    
      e.revenue_local,
      e.currency,
      cr.rate_in_usd AS currency_rate,

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
      e.source_emissions_page_move,

      -- Consolidated Scope 2
      COALESCE(e.scope_2_market_based, e.scope_2_location_based, e.scope_2_unknown) AS scope_2,

      -- Upstream and downstream Scope 3
      COALESCE(e.cat_1, 0) + COALESCE(e.cat_2, 0) + COALESCE(e.cat_3, 0) + 
      COALESCE(e.cat_4, 0) + COALESCE(e.cat_5, 0) + COALESCE(e.cat_6, 0) + 
      COALESCE(e.cat_7, 0) + COALESCE(e.cat_8, 0) AS upstream_scope_3,

      COALESCE(e.cat_9, 0) + COALESCE(e.cat_10, 0) + COALESCE(e.cat_11, 0) + 
      COALESCE(e.cat_12, 0) + COALESCE(e.cat_13, 0) + COALESCE(e.cat_14, 0) + 
      COALESCE(e.cat_15, 0) AS downstream_scope_3,

      -- Total Scope 3
      COALESCE(
        e.total_scope_3,
        COALESCE(e.cat_1, 0) + COALESCE(e.cat_2, 0) + COALESCE(e.cat_3, 0) + 
        COALESCE(e.cat_4, 0) + COALESCE(e.cat_5, 0) + COALESCE(e.cat_6, 0) + 
        COALESCE(e.cat_7, 0) + COALESCE(e.cat_8, 0) + COALESCE(e.cat_9, 0) + 
        COALESCE(e.cat_10, 0) + COALESCE(e.cat_11, 0) + COALESCE(e.cat_12, 0) + 
        COALESCE(e.cat_13, 0) + COALESCE(e.cat_14, 0) + COALESCE(e.cat_15, 0)
      ) AS total_scope_3,

      e.total_scope_3 AS total_scope_3_summary,

      -- Revenue
      ROUND(e.revenue_local * cr.rate_in_usd) AS revenue

    FROM emission e
    LEFT JOIN currency_rate cr ON e.currency = cr.currency_code
    AND e.year = cr.year
  ) base;
