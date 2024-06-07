drop function if exists "public"."companies"(offset_value integer, limit_value integer, sort_by text, sort_order text, industry_filter text, near_term_filter boolean, commitment_type_filter text, commitment_status_filter text, target_target_filter text);

alter table "public"."emission" drop column "hq_country_move";

alter table "public"."emission" drop column "industry";

alter table "public"."emission" drop column "isic_rev_4";

alter table "public"."emission" drop column "source_emisions_page_move";

alter table "public"."emission" add column "source_emissions_page_move" text;

alter table "public"."emission" alter column "cat_1" set data type numeric using "cat_1"::numeric;

alter table "public"."emission" alter column "cat_10" set data type numeric using "cat_10"::numeric;

alter table "public"."emission" alter column "cat_11" set data type numeric using "cat_11"::numeric;

alter table "public"."emission" alter column "cat_12" set data type numeric using "cat_12"::numeric;

alter table "public"."emission" alter column "cat_13" set data type numeric using "cat_13"::numeric;

alter table "public"."emission" alter column "cat_14" set data type numeric using "cat_14"::numeric;

alter table "public"."emission" alter column "cat_15" set data type numeric using "cat_15"::numeric;

alter table "public"."emission" alter column "cat_2" set data type numeric using "cat_2"::numeric;

alter table "public"."emission" alter column "cat_3" set data type numeric using "cat_3"::numeric;

alter table "public"."emission" alter column "cat_4" set data type numeric using "cat_4"::numeric;

alter table "public"."emission" alter column "cat_5" set data type numeric using "cat_5"::numeric;

alter table "public"."emission" alter column "cat_6" set data type numeric using "cat_6"::numeric;

alter table "public"."emission" alter column "cat_7" set data type numeric using "cat_7"::numeric;

alter table "public"."emission" alter column "cat_8" set data type numeric using "cat_8"::numeric;

alter table "public"."emission" alter column "cat_9" set data type numeric using "cat_9"::numeric;

alter table "public"."emission" alter column "cradle_to_gate" set data type numeric using "cradle_to_gate"::numeric;

alter table "public"."emission" alter column "currency" set data type character varying(4) using "currency"::character varying(4);

alter table "public"."emission" alter column "emission_intensity" set data type numeric using "emission_intensity"::numeric;

alter table "public"."emission" alter column "publication_date" set data type date using "publication_date"::date;

alter table "public"."emission" alter column "revenue" set data type numeric using "revenue"::numeric;

alter table "public"."emission" alter column "revenue_million" set data type numeric using "revenue_million"::numeric;

alter table "public"."emission" alter column "scope_1" set data type numeric using "scope_1"::numeric;

alter table "public"."emission" alter column "scope_1_share_of_total_upstream_emissions" set data type numeric using "scope_1_share_of_total_upstream_emissions"::numeric;

alter table "public"."emission" alter column "scope_2_location_based" set data type numeric using "scope_2_location_based"::numeric;

alter table "public"."emission" alter column "scope_2_market_based" set data type numeric using "scope_2_market_based"::numeric;

alter table "public"."emission" alter column "scope_2_unknown" set data type numeric using "scope_2_unknown"::numeric;

alter table "public"."emission" alter column "share_upstream_of_scope_3" set data type numeric using "share_upstream_of_scope_3"::numeric;

alter table "public"."emission" alter column "total_emission_location_based" set data type numeric using "total_emission_location_based"::numeric;

alter table "public"."emission" alter column "total_emission_market_based" set data type numeric using "total_emission_market_based"::numeric;

alter table "public"."emission" alter column "total_reported_emission_scope_1_2" set data type numeric using "total_reported_emission_scope_1_2"::numeric;

alter table "public"."emission" alter column "total_reported_emission_scope_1_2_3" set data type numeric using "total_reported_emission_scope_1_2_3"::numeric;

alter table "public"."emission" alter column "total_scope_3" set data type numeric using "total_scope_3"::numeric;

alter table "public"."emission" alter column "total_upstream_emissions" set data type numeric using "total_upstream_emissions"::numeric;

alter table "public"."emission" alter column "upstream_scope_3" set data type numeric using "upstream_scope_3"::numeric;

alter table "public"."emission" alter column "year" set data type integer using "year"::integer;

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.companies(offset_value integer, limit_value integer, sort_by text, sort_order text, industry_filter text DEFAULT NULL::text, near_term_filter boolean DEFAULT false, commitment_type_filter text DEFAULT NULL::text, commitment_status_filter text DEFAULT NULL::text, target_target_filter text DEFAULT NULL::text)
 RETURNS TABLE(company_name character varying, industry text, commitment_type text, status text, commitment_deadline text, total_reported_emission_scope_1_2_3 numeric, revenue numeric, hq_country text, year integer, currency character varying, emission_intensity numeric, targets target_info[])
 LANGUAGE plpgsql
AS $function$DECLARE
    query TEXT;
BEGIN
    query := 'SELECT 
               c.name AS company_name, 
               c.industry,  
               cm.commitment_type, 
               cm.status, 
               cm.commitment_deadline,
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
            LEFT JOIN commitment cm ON c.name = cm.company_name
            LEFT JOIN (
                SELECT company_name, MAX(year) AS latest_year
                FROM emission
                GROUP BY company_name
            ) latest_emission ON c.name = latest_emission.company_name
            LEFT JOIN emission e ON c.name = e.company_name AND latest_emission.latest_year = e.year
            LEFT JOIN target t ON c.name = t.company_name
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
                                WHERE t2.company_name = c.name 
                                AND t2.target = ' || quote_literal(target_target_filter) || 
                            ')';
    END IF;

    query := query || ' GROUP BY c.name, c.industry, cm.commitment_type, cm.status, cm.commitment_deadline, e.total_reported_emission_scope_1_2_3, e.revenue, e.year, e.currency, e.emission_intensity';

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


