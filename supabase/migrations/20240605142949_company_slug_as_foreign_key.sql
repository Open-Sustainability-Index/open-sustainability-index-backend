alter table "public"."commitment" drop constraint "commitment_company_name_fkey";

alter table "public"."emission" drop constraint "emission_company_name_fkey";

alter table "public"."target" drop constraint "target_company_name_fkey";

alter table "public"."commitment" drop constraint "commitment_pkey";

alter table "public"."emission" drop constraint "emission_pkey";

alter table "public"."target" drop constraint "target_pkey";

drop index if exists "public"."commitment_pkey";

drop index if exists "public"."emission_pkey";

drop index if exists "public"."target_pkey";

alter table "public"."commitment" drop column "company_name";

alter table "public"."commitment" add column "company_slug" text not null;

alter table "public"."emission" drop column "company_name";

alter table "public"."emission" add column "company_slug" text not null;

alter table "public"."target" drop column "company_name";

alter table "public"."target" add column "company_slug" text not null;

CREATE UNIQUE INDEX commitment_pkey ON public.commitment USING btree (company_slug, commitment_type);

CREATE UNIQUE INDEX emission_pkey ON public.emission USING btree (year, company_slug);

CREATE UNIQUE INDEX target_pkey ON public.target USING btree (scope, type, target_year, company_slug, target_wording);

alter table "public"."commitment" add constraint "commitment_pkey" PRIMARY KEY using index "commitment_pkey";

alter table "public"."emission" add constraint "emission_pkey" PRIMARY KEY using index "emission_pkey";

alter table "public"."target" add constraint "target_pkey" PRIMARY KEY using index "target_pkey";

alter table "public"."commitment" add constraint "public_commitment_company_slug_fkey" FOREIGN KEY (company_slug) REFERENCES company(slug) not valid;

alter table "public"."commitment" validate constraint "public_commitment_company_slug_fkey";

alter table "public"."emission" add constraint "public_emission_slug_fkey" FOREIGN KEY (company_slug) REFERENCES company(slug) ON UPDATE CASCADE not valid;

alter table "public"."emission" validate constraint "public_emission_slug_fkey";

alter table "public"."target" add constraint "public_target_company_slug_fkey" FOREIGN KEY (company_slug) REFERENCES company(slug) not valid;

alter table "public"."target" validate constraint "public_target_company_slug_fkey";
