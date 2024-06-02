alter table "public"."temp_emission" drop constraint "t_emission_company_name_fkey";

alter table "public"."temp_emission" drop constraint "t_emission_pkey";

drop index if exists "public"."t_emission_pkey";

alter table "public"."temp_emission" drop column "comment";

alter table "public"."temp_emission" drop column "source";

CREATE UNIQUE INDEX temp_emission_pkey ON public.temp_emission USING btree (year, company_name);

alter table "public"."temp_emission" add constraint "temp_emission_pkey" PRIMARY KEY using index "temp_emission_pkey";

alter table "public"."temp_emission" add constraint "temp_emission_company_name_fkey" FOREIGN KEY (company_name) REFERENCES company(name) ON UPDATE CASCADE not valid;

alter table "public"."temp_emission" validate constraint "temp_emission_company_name_fkey";


