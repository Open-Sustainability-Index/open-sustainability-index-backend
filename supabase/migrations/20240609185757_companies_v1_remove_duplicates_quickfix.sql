-- Quickfix to remove duplicates from companies_v1 function

set check_function_bodies = off;

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
                FROM emission
                GROUP BY company_slug
            ) le ON c.slug = le.company_slug
            LEFT JOIN emission e ON c.slug = e.company_slug AND le.latest_year = e.year
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
