drop view if exists "public"."industry";

create or replace view "public"."industry" as  SELECT company.industry AS name,
    regexp_replace(regexp_replace(lower(TRIM(BOTH FROM company.industry)), ' |_|-'::text, '-'::text, 'g'::text), '[^a-zA-Z0-9-]'::text, ''::text, 'g'::text) AS slug,
    count(company.name) AS company_count
   FROM company
  GROUP BY company.industry
 HAVING ((company.industry IS NOT NULL) AND (count(company.name) >= 2))
  ORDER BY company.industry;



