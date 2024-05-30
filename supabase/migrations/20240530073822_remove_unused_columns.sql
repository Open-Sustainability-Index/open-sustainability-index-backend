drop view if exists "public"."companies_by_intensity";

alter table "public"."emission" drop column "comment";

alter table "public"."emission" drop column "source";


