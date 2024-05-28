CREATE OR REPLACE FUNCTION public.companies_v2(
    offset_value integer, 
    limit_value integer, 
    sort_by text, 
    sort_order text, 
    industry_filter text DEFAULT NULL::text, 
    near_term_filter boolean DEFAULT false, 
    commitment_type_filter text DEFAULT NULL::text, 
    commitment_status_filter text DEFAULT NULL::text, 
    target_target_filter text DEFAULT NULL::text,
    emissions_required text DEFAULT NULL::text
)
RETURNS TABLE(
    company_name text,
    industry text,
    lei text,
    company_url text,
    updated_at timestamptz,
    id uuid,
    commitments JSONB[],
    emissions JSONB[],
    targets target_info[]
)
LANGUAGE plpgsql
AS $function$
DECLARE
    query TEXT;
BEGIN
    query := 'WITH commitments_agg AS (
                SELECT 
                    cm.company_name,
                    ARRAY_AGG(to_jsonb(cm)) AS commitments
                FROM commitment cm
                GROUP BY cm.company_name
              ), 
              emissions_agg AS (
                SELECT 
                    e.company_name,
                    ARRAY_AGG(to_jsonb(e) - ''company_name'' - ''year'') AS emissions
                FROM emission e
                GROUP BY e.company_name
              ),
              targets_agg AS (
                SELECT 
                    t.company_name,
                    ARRAY_AGG(ROW(t.type, t.scope, t.target_year, t.target)::target_info) AS targets
                FROM target t
                GROUP BY t.company_name
              )
            SELECT 
               c.name::text AS company_name, 
               c.industry::text, 
               c.lei::text,
               c.company_url::text,
               c.updated_at::timestamptz,
               c.id::uuid,
               COALESCE(ca.commitments, ARRAY[]::JSONB[]) AS commitments,
               COALESCE(ea.emissions, ARRAY[]::JSONB[]) AS emissions,
               COALESCE(ta.targets, ARRAY[]::target_info[]) AS targets
            FROM company c
            LEFT JOIN commitments_agg ca ON c.name = ca.company_name
            LEFT JOIN emissions_agg ea ON c.name = ea.company_name
            LEFT JOIN targets_agg ta ON c.name = ta.company_name';

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
        query := query || ' AND EXISTS (
                                SELECT 1 
                                FROM commitment cm 
                                WHERE cm.company_name = c.name 
                                  AND cm.commitment_type IS NOT NULL 
                                  AND cm.status != ''Removed''
                            )';
    END IF;

    -- Apply filter based on commitment type if provided
    IF commitment_type_filter IS NOT NULL THEN
        query := query || ' AND EXISTS (
                                SELECT 1 
                                FROM commitment cm 
                                WHERE cm.company_name = c.name 
                                  AND cm.commitment_type = ' || quote_literal(commitment_type_filter) || 
                            ')';
    END IF;

    -- Apply filter based on commitment status if provided
    IF commitment_status_filter IS NOT NULL THEN
        query := query || ' AND EXISTS (
                                SELECT 1 
                                FROM commitment cm 
                                WHERE cm.company_name = c.name 
                                  AND cm.status = ' || quote_literal(commitment_status_filter) || 
                            ')';
    END IF;

    -- Apply filter based on target target if provided
    IF target_target_filter IS NOT NULL THEN
        query := query || ' AND EXISTS (
                                SELECT 1 
                                FROM target t 
                                WHERE t.company_name = c.name 
                                  AND t.target = ' || quote_literal(target_target_filter) || 
                            ')';
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
$function$;
