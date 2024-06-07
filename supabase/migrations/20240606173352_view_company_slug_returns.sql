create or replace view "public"."view_company_slug" as  SELECT company.name AS company_name,
    company.name,
    regexp_replace(regexp_replace(lower(TRIM(BOTH FROM company.name)), ' |_|-'::text, '-'::text, 'g'::text), '[^a-zA-Z0-9-]'::text, ''::text, 'g'::text) AS slug_old,
    company.slug,
    company.company_url,
    company.industry,
    company.isic,
    company.lei
   FROM company;



