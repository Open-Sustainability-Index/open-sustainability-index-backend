set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.companies_v2(offset_value integer, limit_value integer, sort_by text, sort_order text, industry_filter text DEFAULT NULL::text, near_term_filter boolean DEFAULT false, commitment_type_filter text DEFAULT NULL::text, commitment_status_filter text DEFAULT NULL::text, target_target_filter text DEFAULT NULL::text, emissions_required text DEFAULT NULL::text)
 RETURNS TABLE(company_name text, industry text, lei text, company_url text, updated_at timestamp with time zone, id uuid, commitments jsonb[], emissions jsonb[], targets target_info[])
 LANGUAGE plpgsql
AS $function$
DECLARE
    query TEXT;
BEGIN
    query := 'SELECT 
               c.name::text AS company_name, 
               c.industry::text, 
               c.lei::text,
               c.company_url::text,
               c.updated_at::timestamptz,
               c.id::uuid,
               ARRAY_AGG(
                   to_jsonb(cm)
               ) AS commitments,
               ARRAY_AGG(
                   to_jsonb(e) - ''company_name'' - ''year''
               ) AS emissions,
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
            LEFT JOIN target t ON c.name = t.company_name';

    -- Apply condition based on emissions_required argument
    IF emissions_required = 'required' THEN
        query := query || ' WHERE EXISTS (SELECT 1 FROM emission e WHERE e.company_name = c.name) ';
    ELSE
        query := query || ' WHERE 1=1 ';
    END IF;

    -- Apply filter based on industry if provided
    IF industry_filter IS NOT NULL THEN
        query := query || ' AND c.industry = ' || quote_literal(industry_filter);
    END IF;

    -- Apply filter for companies with non-null commitment_type and status not equal to ''Removed'' if requested
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

    query := query || ' GROUP BY c.name, c.industry, c.lei, c.company_url, c.updated_at, c.id';

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


