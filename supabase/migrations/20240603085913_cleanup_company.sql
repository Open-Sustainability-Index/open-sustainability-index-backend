drop view if exists "public"."company_slug";

drop view if exists "public"."industry";

alter table "public"."company" drop column "net_zero_year";

alter table "public"."company" drop column "sbt_near_term_target";

alter table "public"."company" drop column "sbt_near_term_year";

alter table "public"."company" drop column "sbt_status";

alter table "public"."company" drop column "source_reports_page";

alter table "public"."company" add column "slug" text;

CREATE UNIQUE INDEX company_name_key ON public.company USING btree (name);
alter table "public"."company" add constraint "company_name_key" UNIQUE using index "company_name_key";
-- alter table "public"."company" drop constraint "company_company_name_key";
-- drop index if exists "public"."company_company_name_key";

CREATE UNIQUE INDEX company_slug_key ON public.company USING btree (slug);
alter table "public"."company" add constraint "company_slug_key" UNIQUE using index "company_slug_key";

create or replace view "public"."company_slug" as  SELECT company.id,
    regexp_replace(regexp_replace(lower(TRIM(BOTH FROM company.name)), ' |_|-'::text, '-'::text, 'g'::text), '[^a-zA-Z0-9-]'::text, ''::text, 'g'::text) AS slug,
    company.name AS company_name,
    company.created_at,
    company.updated_at,
    company.industry,
    company.isic,
    company.lei,
    company.company_url,
    company.hq_country
   FROM company;


create or replace view "public"."industry" as  SELECT company.industry AS name,
    regexp_replace(regexp_replace(lower(TRIM(BOTH FROM company.industry)), ' |_|-'::text, '-'::text, 'g'::text), '[^a-zA-Z0-9-]'::text, ''::text, 'g'::text) AS slug,
    count(company.name) AS company_count
   FROM company
  GROUP BY company.industry
 HAVING ((company.industry IS NOT NULL) AND (count(company.name) >= 2))
  ORDER BY company.industry;

