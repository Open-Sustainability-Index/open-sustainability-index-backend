alter table "public"."commitment" drop constraint "public_commitment_company_name_fkey";

alter table "public"."emission" drop constraint "public_emission_new_company_name_fkey";

alter table "public"."target" drop constraint "public_target_company_name_fkey";

alter table "public"."commitment" add constraint "commitment_company_name_fkey" FOREIGN KEY (company_name) REFERENCES company(name) ON UPDATE CASCADE not valid;

alter table "public"."commitment" validate constraint "commitment_company_name_fkey";

alter table "public"."emission" add constraint "emission_company_name_fkey" FOREIGN KEY (company_name) REFERENCES company(name) ON UPDATE CASCADE not valid;

alter table "public"."emission" validate constraint "emission_company_name_fkey";

alter table "public"."target" add constraint "target_company_name_fkey" FOREIGN KEY (company_name) REFERENCES company(name) ON UPDATE CASCADE not valid;

alter table "public"."target" validate constraint "target_company_name_fkey";


