alter table "public"."temp_company" alter column "name" set not null;

create table "public"."temp_emission" (
    "source" text,
    "year" bigint not null,
    "fiscal_year" text,
    "company_name" text not null,
    "industry" text,
    "isic_rev_4" text,
    "hq_country_move" text,
    "scope_1" double precision,
    "scope_2_market_based" text,
    "scope_2_location_based" text,
    "scope_2_unknown" text,
    "total_scope_3" text,
    "total_emission_market_based" text,
    "total_emission_location_based" text,
    "total_reported_emission_scope_1_2" double precision,
    "total_reported_emission_scope_1_2_3" double precision,
    "cat_1" text,
    "cat_2" text,
    "cat_3" text,
    "cat_4" text,
    "cat_5" text,
    "cat_6" text,
    "cat_7" text,
    "cat_8" text,
    "cat_9" text,
    "cat_10" text,
    "cat_11" text,
    "cat_12" text,
    "cat_13" text,
    "cat_14" text,
    "cat_15" text,
    "all_cats" text,
    "upstream_scope_3" text,
    "share_upstream_of_scope_3" text,
    "scope_1_share_of_total_upstream_emissions" text,
    "total_upstream_emissions" bigint,
    "revenue" bigint,
    "currency" text,
    "revenue_million" bigint,
    "cradle_to_gate" double precision,
    "ghg_standard" text,
    "source_emisions_page_move" text,
    "emission_intensity" double precision,
    "source_emission_report" text,
    "emission_page" text,
    "source_emission_link" text,
    "source_revenue" text,
    "page_revenue" text,
    "source_revenue_link" text,
    "publication_date" text,
    "comment" text,
    "status" text,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now()
);


alter table "public"."temp_emission" enable row level security;

CREATE UNIQUE INDEX t_emission_pkey ON public.temp_emission USING btree (year, company_name);

alter table "public"."temp_emission" add constraint "t_emission_pkey" PRIMARY KEY using index "t_emission_pkey";

alter table "public"."temp_emission" add constraint "t_emission_company_name_fkey" FOREIGN KEY (company_name) REFERENCES company(name) ON UPDATE CASCADE not valid;

alter table "public"."temp_emission" validate constraint "t_emission_company_name_fkey";

grant delete on table "public"."temp_emission" to "anon";

grant insert on table "public"."temp_emission" to "anon";

grant references on table "public"."temp_emission" to "anon";

grant select on table "public"."temp_emission" to "anon";

grant trigger on table "public"."temp_emission" to "anon";

grant truncate on table "public"."temp_emission" to "anon";

grant update on table "public"."temp_emission" to "anon";

grant delete on table "public"."temp_emission" to "authenticated";

grant insert on table "public"."temp_emission" to "authenticated";

grant references on table "public"."temp_emission" to "authenticated";

grant select on table "public"."temp_emission" to "authenticated";

grant trigger on table "public"."temp_emission" to "authenticated";

grant truncate on table "public"."temp_emission" to "authenticated";

grant update on table "public"."temp_emission" to "authenticated";

grant delete on table "public"."temp_emission" to "service_role";

grant insert on table "public"."temp_emission" to "service_role";

grant references on table "public"."temp_emission" to "service_role";

grant select on table "public"."temp_emission" to "service_role";

grant trigger on table "public"."temp_emission" to "service_role";

grant truncate on table "public"."temp_emission" to "service_role";

grant update on table "public"."temp_emission" to "service_role";

