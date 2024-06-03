alter table "public"."target" drop column "commitment_deadline";
alter table "public"."target" drop column "commitment_type";
alter table "public"."target" drop column "lei";
alter table "public"."target" drop column "reason_for_commitment_extension_or_removal";
alter table "public"."target" drop column "status";

alter table "public"."target" rename column "sub-type" to "sub_type";

alter table "public"."target" alter column "base_year" set data type integer using "base_year"::integer;
alter table "public"."target" alter column "target_value" set data type numeric using "target_value"::numeric;
alter table "public"."target" alter column "target_year" set data type integer using "target_year"::integer;
alter table "public"."target" alter column "year_type" set data type character varying(2) using "year_type"::character varying(2);
