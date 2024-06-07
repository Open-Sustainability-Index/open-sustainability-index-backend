create or replace view "public"."company_slug" as  SELECT company.id,
    regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(lower(TRIM(BOTH FROM company.name)), 'å'::text, 'a'::text, 'g'::text), 'ä'::text, 'a'::text, 'g'::text), 'ö'::text, 'o'::text, 'g'::text), 'ü'::text, 'u'::text, 'g'::text), 'ø'::text, 'o'::text, 'g'::text), ' |_|-'::text, '-'::text, 'g'::text), '[^a-zA-Z0-9-]'::text, ''::text, 'g'::text) AS slug,
    company.name AS company_name,
    company.created_at,
    company.updated_at,
    company.industry,
    company.isic,
    company.lei,
    company.company_url,
    company.hq_country
   FROM company;



