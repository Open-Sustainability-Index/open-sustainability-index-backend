alter table "public"."commitment" drop constraint "commitment_pkey";

drop index if exists "public"."commitment_pkey";

alter table "public"."commitment" alter column "commitment_type" set not null;

CREATE UNIQUE INDEX commitment_pkey ON public.commitment USING btree (company_name, commitment_type);

alter table "public"."commitment" add constraint "commitment_pkey" PRIMARY KEY using index "commitment_pkey";


