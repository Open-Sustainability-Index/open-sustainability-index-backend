revoke delete on table "public"."temp_company" from "anon";
revoke insert on table "public"."temp_company" from "anon";
revoke references on table "public"."temp_company" from "anon";
revoke select on table "public"."temp_company" from "anon";
revoke trigger on table "public"."temp_company" from "anon";
revoke truncate on table "public"."temp_company" from "anon";
revoke update on table "public"."temp_company" from "anon";
revoke delete on table "public"."temp_company" from "authenticated";
revoke insert on table "public"."temp_company" from "authenticated";
revoke references on table "public"."temp_company" from "authenticated";
revoke select on table "public"."temp_company" from "authenticated";
revoke trigger on table "public"."temp_company" from "authenticated";
revoke truncate on table "public"."temp_company" from "authenticated";
revoke update on table "public"."temp_company" from "authenticated";
revoke delete on table "public"."temp_company" from "service_role";
revoke insert on table "public"."temp_company" from "service_role";
revoke references on table "public"."temp_company" from "service_role";
revoke select on table "public"."temp_company" from "service_role";
revoke trigger on table "public"."temp_company" from "service_role";
revoke truncate on table "public"."temp_company" from "service_role";
revoke update on table "public"."temp_company" from "service_role";

revoke delete on table "public"."temp_emission" from "anon";
revoke insert on table "public"."temp_emission" from "anon";
revoke references on table "public"."temp_emission" from "anon";
revoke select on table "public"."temp_emission" from "anon";
revoke trigger on table "public"."temp_emission" from "anon";
revoke truncate on table "public"."temp_emission" from "anon";
revoke update on table "public"."temp_emission" from "anon";
revoke delete on table "public"."temp_emission" from "authenticated";
revoke insert on table "public"."temp_emission" from "authenticated";
revoke references on table "public"."temp_emission" from "authenticated";
revoke select on table "public"."temp_emission" from "authenticated";
revoke trigger on table "public"."temp_emission" from "authenticated";
revoke truncate on table "public"."temp_emission" from "authenticated";
revoke update on table "public"."temp_emission" from "authenticated";
revoke delete on table "public"."temp_emission" from "service_role";
revoke insert on table "public"."temp_emission" from "service_role";
revoke references on table "public"."temp_emission" from "service_role";
revoke select on table "public"."temp_emission" from "service_role";
revoke trigger on table "public"."temp_emission" from "service_role";
revoke truncate on table "public"."temp_emission" from "service_role";
revoke update on table "public"."temp_emission" from "service_role";
alter table "public"."temp_emission" drop constraint "temp_emission_company_name_fkey";
alter table "public"."temp_emission" drop constraint "temp_emission_pkey";
drop index if exists "public"."temp_emission_pkey";

drop table "public"."temp_company";
drop table "public"."temp_emission";
