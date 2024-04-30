drop function if exists "public"."companies"(offset_value integer, limit_value integer, sort_by text, sort_order text, industry_filter text, near_term_filter boolean, commitment_type_filter text);

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.companies(offset_value integer, limit_value integer, sort_by text, sort_order text, industry_filter text DEFAULT NULL::text, near_term_filter boolean DEFAULT false, commitment_type_filter text DEFAULT NULL::text, commitment_status_filter text DEFAULT NULL::text, target_target_filter text DEFAULT NULL::text)
 RETURNS TABLE(company_name character varying, industry text, commitment_type text, status text, commitment_deadline text, total_reported_emission_scope_1_2_3 double precision, revenue bigint, hq_country_move text, year bigint, currency text, emission_intensity double precision, targets target_info[])
 LANGUAGE plpgsql
AS $function$
DECLARE
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
               e.hq_country_move, 
               e.year, 
               e.currency,
               e.emission_intensity,
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

    query := query || ' GROUP BY c.name, c.industry, cm.commitment_type, cm.status, cm.commitment_deadline, e.total_reported_emission_scope_1_2_3, e.revenue, e.hq_country_move, e.year, e.currency, e.emission_intensity';

    IF sort_by = 'emission_intensity' THEN
        query := query || ' ORDER BY e.emission_intensity ';
    ELSE
        query := query || ' ORDER BY c.name ';
    END IF;

    IF sort_order = 'desc' THEN
        query := query || ' DESC ';
    END IF;

    query := query || ' OFFSET ' || offset_value || ' LIMIT ' || limit_value || ';';

    -- Execute the dynamically constructed query
    RETURN QUERY EXECUTE query;
END;
$function$
;


