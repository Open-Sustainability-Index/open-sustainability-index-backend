create table "public"."temp_company" (
    "name" character varying not null,
    "industry" text,
    "isic" text,
    "lei" text,
    "company_url" text,
    "hq_country" text,
    "created_at" timestamp with time zone not null default now(),
    "id" uuid not null default gen_random_uuid(),
    "updated_at" timestamp with time zone not null default now(),
    "slug" text,
    "tags" text,
    "organization_type" text
);


alter table "public"."temp_company" enable row level security;

alter table "public"."company" add column "organization_type" text;

alter table "public"."company" add column "tags" text;

CREATE UNIQUE INDEX temp_company_id_key ON public.temp_company USING btree (id);

CREATE UNIQUE INDEX temp_company_pkey ON public.temp_company USING btree (name);

CREATE UNIQUE INDEX temp_company_slug_key ON public.temp_company USING btree (slug);

alter table "public"."temp_company" add constraint "temp_company_pkey" PRIMARY KEY using index "temp_company_pkey";

alter table "public"."temp_company" add constraint "temp_company_id_key" UNIQUE using index "temp_company_id_key";

alter table "public"."temp_company" add constraint "temp_company_slug_key" UNIQUE using index "temp_company_slug_key";

grant delete on table "public"."temp_company" to "anon";

grant insert on table "public"."temp_company" to "anon";

grant references on table "public"."temp_company" to "anon";

grant select on table "public"."temp_company" to "anon";

grant trigger on table "public"."temp_company" to "anon";

grant truncate on table "public"."temp_company" to "anon";

grant update on table "public"."temp_company" to "anon";

grant delete on table "public"."temp_company" to "authenticated";

grant insert on table "public"."temp_company" to "authenticated";

grant references on table "public"."temp_company" to "authenticated";

grant select on table "public"."temp_company" to "authenticated";

grant trigger on table "public"."temp_company" to "authenticated";

grant truncate on table "public"."temp_company" to "authenticated";

grant update on table "public"."temp_company" to "authenticated";

grant delete on table "public"."temp_company" to "service_role";

grant insert on table "public"."temp_company" to "service_role";

grant references on table "public"."temp_company" to "service_role";

grant select on table "public"."temp_company" to "service_role";

grant trigger on table "public"."temp_company" to "service_role";

grant truncate on table "public"."temp_company" to "service_role";

grant update on table "public"."temp_company" to "service_role";


