alter table "public"."company" add column "created_at" timestamp with time zone not null default now();

alter table "public"."company" add column "id" uuid not null default gen_random_uuid();

alter table "public"."company" add column "updated_at" timestamp with time zone not null default now();

CREATE UNIQUE INDEX company_id_key ON public.company USING btree (id);

alter table "public"."company" add constraint "company_id_key" UNIQUE using index "company_id_key";
