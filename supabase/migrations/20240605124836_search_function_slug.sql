set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.search(query text, sort_by text DEFAULT 'name'::text, sort_order text DEFAULT 'asc'::text)
 RETURNS TABLE(name text, slug text, type text)
 LANGUAGE plpgsql
AS $function$
DECLARE
  sql_query TEXT;
BEGIN
  -- Construct the SQL query dynamically
  sql_query := format(
    'WITH company_results AS (
       SELECT
         name::TEXT,
         slug,
         ''company'' AS type
       FROM company
       WHERE name ILIKE %L
     ),
     industry_results AS (
       SELECT
         name,
         regexp_replace(regexp_replace(lower(TRIM(BOTH FROM name)), '' |_|-''::text, ''-''::text, ''g''::text), ''[^a-zA-Z0-9-]''::text, ''''::text, ''g''::text) AS slug,
         ''industry'' AS type
       FROM industry
       WHERE name ILIKE %L
     )
     SELECT * FROM company_results
     UNION ALL
     SELECT * FROM industry_results
     ORDER BY %I %s
     LIMIT 20',
    '%' || query || '%', -- Search term for company
    '%' || query || '%', -- Search term for industry
    sort_by,             -- Sort column
    sort_order           -- Sort direction
  );

  -- Execute the dynamically constructed SQL query
  RETURN QUERY EXECUTE sql_query;
END;
$function$
;


