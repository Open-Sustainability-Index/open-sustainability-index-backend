alter table "public"."company" drop constraint "company_company_name_key";
drop index if exists "public"."company_company_name_key";

alter table "public"."company" drop constraint "company_name_key";
drop index if exists "public"."company_name_key";
