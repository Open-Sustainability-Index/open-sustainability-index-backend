-- Fields we keep: total_scope_3

-- Fields we can remove later:
  -- total_emission_market_based = scope_1 + scope_2_market_based + total_scope_3_calculated
  -- total_emission_location_based = scope_1 + scope_2_location_based + total_scope_3_calculated
  -- total_reported_emission_scope_1_2 + scope_1 + (scope_2_market_based OR scope_2_location_based OR scope_2_unknown)
  -- total_reported_emission_scope_1_2_3 = total_reported_emission_scope_1_2 + total_scope_3_calculated

  -- upstream_scope_3 = SUM of cat1-cat8
  -- share_upstream_of_scope_3 = NULL (remove)
  -- scope_1_share_of_total_upstream_emissions = NULL (remove)
  -- total_upstream_emissions = total_reported_emission_scope_1_2 + upstream_scope_3

  -- currency_local
  -- revenue = revenue_local * currency_rate
  -- emission_intensity = total_reported_emission_scope_1_2_3 / revenue
  -- cradle_to_gate = total_upstream_emissions / revenue

COMMENT ON COLUMN "public"."emission"."revenue_local" IS 'In millions, in local currency';
COMMENT ON COLUMN "public"."emission"."revenue" IS 'In millions, in USD';

-- Create table currency_rate

create table "public"."currency_rate" (
    "currency_code" character(3) not null,
    "year" integer not null,
    "rate_in_usd" numeric(10,6) not null
);

COMMENT ON COLUMN "public"."currency_rate"."rate_in_usd" IS '*Average* yearly rate, becase emissions can have happened at any point during the year';

CREATE UNIQUE INDEX currency_rate_pkey ON public.currency_rate USING btree (year, currency_code);
alter table "public"."currency_rate" add constraint "currency_rate_pkey" PRIMARY KEY using index "currency_rate_pkey";
alter table "public"."currency_rate" add constraint "currency_rate_rate_in_usd_check" CHECK ((rate_in_usd > (0)::numeric)) not valid;
alter table "public"."currency_rate" validate constraint "currency_rate_rate_in_usd_check";

grant delete on table "public"."currency_rate" to "anon";
grant insert on table "public"."currency_rate" to "anon";
grant references on table "public"."currency_rate" to "anon";
grant select on table "public"."currency_rate" to "anon";
grant trigger on table "public"."currency_rate" to "anon";
grant truncate on table "public"."currency_rate" to "anon";
grant update on table "public"."currency_rate" to "anon";
grant delete on table "public"."currency_rate" to "authenticated";
grant insert on table "public"."currency_rate" to "authenticated";
grant references on table "public"."currency_rate" to "authenticated";
grant select on table "public"."currency_rate" to "authenticated";
grant trigger on table "public"."currency_rate" to "authenticated";
grant truncate on table "public"."currency_rate" to "authenticated";
grant update on table "public"."currency_rate" to "authenticated";
grant delete on table "public"."currency_rate" to "service_role";
grant insert on table "public"."currency_rate" to "service_role";
grant references on table "public"."currency_rate" to "service_role";
grant select on table "public"."currency_rate" to "service_role";
grant trigger on table "public"."currency_rate" to "service_role";
grant truncate on table "public"."currency_rate" to "service_role";
grant update on table "public"."currency_rate" to "service_role";


-- Create view emission

CREATE OR REPLACE VIEW view_emission AS
    SELECT

    -- Basic fields and total_scope_3_summary
    e.company_slug,
    e.year,
    e.fiscal_year,

    -- Scope 1 and 2
    e.scope_1,
    e.scope_2_market_based,
    e.scope_2_location_based,
    e.scope_2_unknown,

    -- Scope 3 total from categories, and from summary
    COALESCE((e.cat_1 + e.cat_2 + e.cat_3 + e.cat_4 + e.cat_5 + e.cat_6 + e.cat_7 + e.cat_8 + e.cat_9 + e.cat_10 + e.cat_11 + e.cat_12 + e.cat_13 + e.cat_14 + e.cat_15), e.total_scope_3) AS total_scope_3,
    e.total_scope_3 AS total_scope_3_summary,

    -- Total emission calculations
    e.scope_1 + e.scope_2_market_based + COALESCE( (e.cat_1 + e.cat_2 + e.cat_3 + e.cat_4 + e.cat_5 + e.cat_6 + e.cat_7 + e.cat_8 + e.cat_9 + e.cat_10 + e.cat_11 + e.cat_12 + e.cat_13 + e.cat_14 + e.cat_15), e.total_scope_3 ) AS total_emission_market_based,
    e.scope_1 + e.scope_2_location_based + COALESCE( (e.cat_1 + e.cat_2 + e.cat_3 + e.cat_4 + e.cat_5 + e.cat_6 + e.cat_7 + e.cat_8 + e.cat_9 + e.cat_10 + e.cat_11 + e.cat_12 + e.cat_13 + e.cat_14 + e.cat_15), e.total_scope_3 ) AS total_emission_location_based,
    -- Totals for 1-2, and 1-2-3
    e.scope_1 + COALESCE(e.scope_2_market_based, e.scope_2_location_based, e.scope_2_unknown) AS total_reported_emission_scope_1_2,
    (e.scope_1 + COALESCE(e.scope_2_market_based, e.scope_2_location_based, e.scope_2_unknown) + COALESCE( (e.cat_1 + e.cat_2 + e.cat_3 + e.cat_4 + e.cat_5 + e.cat_6 + e.cat_7 + e.cat_8 + e.cat_9 + e.cat_10 + e.cat_11 + e.cat_12 + e.cat_13 + e.cat_14 + e.cat_15), e.total_scope_3 )) AS total_reported_emission_scope_1_2_3,

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
    e.revenue_local * cr.rate_in_usd AS revenue,

    -- Intensity calculations
    (COALESCE( (e.cat_1 + e.cat_2 + e.cat_3 + e.cat_4 + e.cat_5 + e.cat_6 + e.cat_7 + e.cat_8 + e.cat_9 + e.cat_10 + e.cat_11 + e.cat_12 + e.cat_13 + e.cat_14 + e.cat_15), e.total_scope_3 ) + e.scope_1 + COALESCE(e.scope_2_market_based, e.scope_2_location_based, e.scope_2_unknown)) / NULLIF(e.revenue_local * cr.rate_in_usd, 0) AS emission_intensity,
    (e.scope_1 + COALESCE(e.scope_2_market_based, e.scope_2_location_based, e.scope_2_unknown) + (e.cat_1 + e.cat_2 + e.cat_3 + e.cat_4 + e.cat_5 + e.cat_6 + e.cat_7 + e.cat_8)) / NULLIF(e.revenue_local * cr.rate_in_usd, 0) AS cradle_to_gate,

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
LEFT JOIN
    currency_rate cr
      ON e.currency = cr.currency_code
      AND e.year = cr.year;

-- Functions that use the view

CREATE OR REPLACE FUNCTION public.companies(offset_value integer, limit_value integer, sort_by text, sort_order text, industry_filter text DEFAULT NULL::text, near_term_filter boolean DEFAULT false, commitment_type_filter text DEFAULT NULL::text, commitment_status_filter text DEFAULT NULL::text, target_target_filter text DEFAULT NULL::text, tags_filter text DEFAULT NULL::text)
 RETURNS TABLE(company_name character varying, slug text, company_url text, industry text, organization_type text, tags text, commitment_type text, status text, commitment_deadline date, total_reported_emission_scope_1_2_3 numeric, revenue numeric, hq_country text, year integer, currency character varying, emission_intensity numeric, targets target_info[])
 LANGUAGE plpgsql
AS $function$DECLARE
    query TEXT;
BEGIN
    query := 'SELECT 
               c.name AS company_name,
               c.slug,
               c.company_url,
               c.industry,  
               c.organization_type,
               c.tags,
               MIN(cm.commitment_type) AS commitment_type,
               MIN(cm.status) AS status, 
               MIN (cm.commitment_deadline) AS commitment_deadline,
               e.total_reported_emission_scope_1_2_3, 
               e.revenue,
               c.hq_country,
               e.year, 
               e.currency,
               ROUND(e.emission_intensity::NUMERIC, 2)::NUMERIC AS emission_intensity,
               ARRAY_AGG(
                   ROW(t.type, t.scope, t.target_year, t.target)::target_info
               ) AS targets 
            FROM company c
            LEFT JOIN commitment cm ON c.slug = cm.company_slug
            LEFT JOIN (
                SELECT company_slug, MAX(year) AS latest_year
                FROM view_emission
                GROUP BY company_slug
            ) le ON c.slug = le.company_slug
            LEFT JOIN view_emission e ON c.slug = e.company_slug AND le.latest_year = e.year
            LEFT JOIN target t ON c.slug = t.company_slug
            WHERE e.total_reported_emission_scope_1_2_3 IS NOT NULL ';

    -- Apply filter based on industry if provided
    IF industry_filter IS NOT NULL THEN
        query := query || ' AND c.industry = ' || quote_literal(industry_filter);
    END IF;

    -- Apply filter for companies with non-null commitment_type and status not equal to 'Removed' if requested
    IF near_term_filter THEN
        query := query || ' AND cm.commitment_type IS NOT NULL AND cm.status != ''Removed''';
    END IF;

    -- Apply filter based on commitment type if provided
    IF commitment_type_filter IS NOT NULL THEN
        query := query || ' AND cm.commitment_type = ' || quote_literal(commitment_type_filter);
    END IF;

    -- Apply filter based on commitment status if provided
    IF commitment_status_filter IS NOT NULL THEN
        query := query || ' AND cm.status = ' || quote_literal(commitment_status_filter);
    END IF;

    -- Apply filter based on target target if provided
    IF target_target_filter IS NOT NULL THEN
        query := query || ' AND EXISTS (
                                SELECT 1 
                                FROM target t2 
                                WHERE t2.company_slug = c.slug 
                                AND t2.target = ' || quote_literal(target_target_filter) || 
                            ')';
    END IF;

    -- Apply filter based on company tags if provided
	IF tags_filter IS NOT NULL THEN
	    query := query || ' AND c.tags ILIKE ' || quote_literal('%' || tags_filter || '%');
	END IF;

    query := query || ' GROUP BY c.name, c.industry, e.total_reported_emission_scope_1_2_3, e.revenue, e.year, e.currency, e.emission_intensity';

    -- Sorting
    query := query || ' ORDER BY ' || sort_by || ' ';
    IF LOWER(sort_order) = 'desc' THEN
        query := query || ' DESC ';
    END IF;
    query := query || ' NULLS LAST ';

    -- Limit
    query := query || ' OFFSET ' || offset_value || ' LIMIT ' || limit_value || ';';

    -- Execute the dynamically constructed query
    RETURN QUERY EXECUTE query;
END;$function$
;

CREATE OR REPLACE FUNCTION public.companies_v2(offset_value integer, limit_value integer, sort_by text, sort_order text, industry_filter text DEFAULT NULL::text, near_term_filter boolean DEFAULT false, commitment_type_filter text DEFAULT NULL::text, commitment_status_filter text DEFAULT NULL::text, target_target_filter text DEFAULT NULL::text, emissions_required text DEFAULT NULL::text, tags_filter text DEFAULT NULL::text)
 RETURNS TABLE(company_name text, slug text, company_url text, industry text, organization_type text, tags text, lei text, updated_at timestamp with time zone, id uuid, commitments jsonb[], emissions jsonb[], targets target_info[])
 LANGUAGE plpgsql
AS $function$
DECLARE
    query TEXT;
BEGIN
    query := 'WITH commitments_agg AS (
                SELECT 
                    cm.company_slug,
                    ARRAY_AGG(to_jsonb(cm)) AS commitments
                FROM commitment cm
                GROUP BY cm.company_slug
              ), 
              emissions_agg AS (
                SELECT 
                    e.company_slug,
                    ARRAY_AGG(to_jsonb(e) - ''company_slug'' - ''year'') AS emissions
                FROM view_emission e
                GROUP BY e.company_slug
              ),
              targets_agg AS (
                SELECT 
                    t.company_slug,
                    ARRAY_AGG(ROW(t.type, t.scope, t.target_year, t.target)::target_info) AS targets
                FROM target t
                GROUP BY t.company_slug
              )
            SELECT 
               c.name::text AS company_name,
               c.slug,
               c.company_url,
               c.industry::text, 
               c.organization_type,
               c.tags,
               c.lei::text,
               c.updated_at::timestamptz,
               c.id::uuid,
               COALESCE(ca.commitments, ARRAY[]::JSONB[]) AS commitments,
               COALESCE(ea.emissions, ARRAY[]::JSONB[]) AS emissions,
               COALESCE(ta.targets, ARRAY[]::target_info[]) AS targets
            FROM company c
            LEFT JOIN commitments_agg ca ON c.slug = ca.company_slug
            LEFT JOIN emissions_agg ea ON c.slug = ea.company_slug
            LEFT JOIN targets_agg ta ON c.slug = ta.company_slug';

    -- Apply condition based on emissions_required argument
    IF emissions_required = 'required' THEN
        query := query || ' WHERE EXISTS (SELECT 1 FROM emission e WHERE e.company_slug = c.slug) ';
    ELSE
        query := query || ' WHERE 1=1 ';
    END IF;

    -- Apply filter based on industry if provided
    IF industry_filter IS NOT NULL THEN
        query := query || ' AND c.industry = ' || quote_literal(industry_filter);
    END IF;

    -- Apply filter for companies with non-null commitment_type and status not equal to ''Removed'' if requested
    IF near_term_filter THEN
        query := query || ' AND EXISTS (
                                SELECT 1 
                                FROM commitment cm 
                                WHERE cm.company_slug = c.slug 
                                  AND cm.commitment_type IS NOT NULL 
                                  AND cm.status != ''Removed''
                            )';
    END IF;

    -- Apply filter based on commitment type if provided
    IF commitment_type_filter IS NOT NULL THEN
        query := query || ' AND EXISTS (
                                SELECT 1 
                                FROM commitment cm 
                                WHERE cm.company_slug = c.slug 
                                  AND cm.commitment_type = ' || quote_literal(commitment_type_filter) || 
                            ')';
    END IF;

    -- Apply filter based on commitment status if provided
    IF commitment_status_filter IS NOT NULL THEN
        query := query || ' AND EXISTS (
                                SELECT 1 
                                FROM commitment cm 
                                WHERE cm.company_slug = c.slug 
                                  AND cm.status = ' || quote_literal(commitment_status_filter) || 
                            ')';
    END IF;

    -- Apply filter based on target target if provided
    IF target_target_filter IS NOT NULL THEN
        query := query || ' AND EXISTS (
                                SELECT 1 
                                FROM target t 
                                WHERE t.company_slug = c.slug 
                                  AND t.target = ' || quote_literal(target_target_filter) || 
                            ')';
    END IF;

    -- Apply filter based on company tags if provided
	IF tags_filter IS NOT NULL THEN
	    query := query || ' AND c.tags ILIKE ' || quote_literal('%' || tags_filter || '%');
	END IF;

    -- Sorting
    query := query || ' ORDER BY ' || sort_by || ' ';
    IF LOWER(sort_order) = 'desc' THEN
        query := query || ' DESC ';
    END IF;
    query := query || ' NULLS LAST ';

    -- Limit
    query := query || ' OFFSET ' || offset_value || ' LIMIT ' || limit_value || ';';

    -- Execute the dynamically constructed query
    RETURN QUERY EXECUTE query;
END;
$function$
;
