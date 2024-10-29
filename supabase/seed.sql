--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Ubuntu 15.1-1.pgdg20.04+1)
-- Dumped by pg_dump version 15.7 (Homebrew)

SET session_replication_role = replica;
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: -
--
INSERT INTO public.company
  (name, slug, industry, isic, lei, company_url, hq_country)
VALUES
  ('A.P. Moller - Maersk A/S', 'ap-moller-maersk', 'Water Transportation - Water Transportation', NULL, '549300D2K6PKKKXVNN73', 'maersk.com', 'Denmark'),
  ('AB SKF', 'skf', 'Electrical Equipment and Machinery', NULL, '549300B6HWYEE57O8J84', 'skf.com', 'Sweden'),
  ('Maersk Contract Logistics Management (Asia) Limited', 'maersk-contract-logistics-management-asia', 'Air Freight Transportation and Logistics', NULL, NULL, 'maersk.com/lf-logistics', 'Hong Kong');

--
-- Data for Name: emission; Type: TABLE DATA; Schema: public; Owner: -
--
INSERT INTO public.emission
  (company_slug, year, fiscal_year, scope_1, scope_2_market_based, scope_2_location_based, scope_2_unknown, total_scope_3, cat_1, cat_2, cat_3, cat_4, cat_5, cat_6, cat_7, cat_8, cat_9, cat_10, cat_11, cat_12, cat_13, cat_14, cat_15, all_cats, revenue_local, ghg_standard, source_emission_report, emission_page, source_emission_link, source_revenue, page_revenue, source_revenue_link, publication_date, status, created_at, updated_at, source_emissions_page_move, currency)
VALUES
  ('ap-moller-maersk', 2023, '2023', 34138000, 346000, 386000, NULL, 44938000, 5728000, 1065000, 5653000, 20465000, 4000, 141000, 25000, 130000, NULL, NULL, 10428000, 391000, 155000, NULL, 753000, 'Yes', 51065, NULL, 'https://www.maersk.com/sustainability', '20,48', 'https://www.maersk.com/sustainability#page=20,48', 'https://www.maersk.com/sustainability', '51', 'https://www.maersk.com/sustainability#page=51', NULL, 'Done', '2024-06-03 11:55:36.559304+00', '2024-06-03 11:55:36.559304+00', 'https://www.maersk.com/sustainability', 'USD'),
  ('ap-moller-maersk', 2022, '2022', 34453000, 423000, 444000, NULL, 47980000, 3249000, 1502000, 5949000, 26575000, 8000, 156000, 20000, 122000, NULL, NULL, 8799000, 313000, 531000, NULL, 756000, 'Yes', 81529, NULL, 'https://www.maersk.com/sustainability', '20,48', 'https://www.maersk.com/sustainability#page=20,48', 'https://www.maersk.com/sustainability', '51', 'https://www.maersk.com/sustainability#page=51', NULL, 'Done', '2024-06-03 11:55:36.561028+00', '2024-06-03 11:55:36.561028+00', 'https://www.maersk.com/sustainability', 'USD'),
  ('ap-moller-maersk', 2021, '2021', 36597000, 335000, 351000, NULL, 39436000, 3158000, 1315000, 6468000, 16275000, 5000, 121000, 18000, 849000, NULL, NULL, 10285000, 347000, 594000, NULL, NULL, 'Yes', 61787, NULL, 'https://www.maersk.com/sustainability', '20,48', 'https://www.maersk.com/sustainability#page=20,48', 'https://www.maersk.com/sustainability', '51', 'https://www.maersk.com/sustainability#page=51', NULL, 'Done', '2024-06-03 11:55:36.562551+00', '2024-06-03 11:55:36.562551+00', 'https://www.maersk.com/sustainability', 'USD'),
  ('ap-moller-maersk', 2020, '2020', 33958000, 348000, 324000, NULL, 36487000, 2604000, 363000, 6778000, 12737000, 4000, 81000, 18000, 641000, NULL, NULL, 12363000, 405000, 493000, NULL, NULL, 'Yes', 39740, NULL, 'https://www.maersk.com/sustainability', '20,48', 'https://www.maersk.com/sustainability#page=20,48', 'https://www.maersk.com/sustainability', '51', 'https://www.maersk.com/sustainability#page=51', NULL, 'Done', '2024-06-03 11:55:36.564395+00', '2024-06-03 11:55:36.564395+00', 'https://www.maersk.com/sustainability', 'USD'),
  ('skf', 2021, '2021', 55941, 312180, 524626, NULL, NULL, NULL, NULL, NULL, 227228, NULL, 3990, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 81732, NULL, 'https://investors.skf.com/sites/skf-ir/files/library/Sustainability%20report%202023.pdf', '16,17', 'https://investors.skf.com/sites/skf-ir/files/library/Sustainability%20report%202023.pdf#page=16,17', 'https://investors.skf.com/sites/skf-ir/files/library/Sustainability%20report%202023.pdf', '17', 'https://investors.skf.com/sites/skf-ir/files/library/Sustainability%20report%202023.pdf#page=17', NULL, 'Done', '2024-06-03 11:55:37.418978+00', '2024-06-03 11:55:37.418978+00', 'https://investors.skf.com/en/sustainability-reports', 'SEK'),
  ('skf', 2022, '2022', 52816, 257516, 470895, NULL, NULL, 1852942, NULL, NULL, 213061, NULL, 6395, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 96933, NULL, 'https://investors.skf.com/sites/skf-ir/files/library/Sustainability%20report%202023.pdf', '16,17', 'https://investors.skf.com/sites/skf-ir/files/library/Sustainability%20report%202023.pdf#page=16,17', 'https://investors.skf.com/sites/skf-ir/files/library/Sustainability%20report%202023.pdf', '17', 'https://investors.skf.com/sites/skf-ir/files/library/Sustainability%20report%202023.pdf#page=17', NULL, 'Done', '2024-06-03 11:55:37.420341+00', '2024-06-03 11:55:37.420341+00', 'https://investors.skf.com/en/sustainability-reports', 'SEK'),
  ('skf', 2023, '2023', 49716, 204024, 447320, NULL, NULL, 1614721, NULL, NULL, 163726, NULL, 10386, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 103881, NULL, 'https://investors.skf.com/sites/skf-ir/files/library/Sustainability%20report%202023.pdf', '16,17', 'https://investors.skf.com/sites/skf-ir/files/library/Sustainability%20report%202023.pdf#page=16,17', 'https://investors.skf.com/sites/skf-ir/files/library/Sustainability%20report%202023.pdf', '17', 'https://investors.skf.com/sites/skf-ir/files/library/Sustainability%20report%202023.pdf#page=17', NULL, 'Done', '2024-06-03 11:55:37.421726+00', '2024-06-03 11:55:37.421726+00', 'https://investors.skf.com/en/sustainability-reports', 'SEK');

--
-- Data for Name: target; Type: TABLE DATA; Schema: public; Owner: -
--
INSERT INTO public.target
  (company_slug, action, full_target_language, company_temperature_alignment, target, target_wording, scope, target_value, type, sub_type, target_classification, base_year, target_year, year_type, date_published, created_at, updated_at)
VALUES
  ('ap-moller-maersk', 'Target', 'A.P. Moller Maersk commits to reach net-zero greenhouse gas emissions across the valuechain by 2040 from a 2022 base year.Near-Term TargetsA.P. Moller-Maersk commits to reduce absolute scope 1 GHG emissions 34.7% by 2030 from a 2022 base year.* A.P. Moller Maersk also commits to reduce absolute scope 3 GHG emissions 21.9% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 34.7% by 2030 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 GHG emissions from all other sources 42% within the same timeframe. A.P. Moller-Maersk further commits to reduce absolute well-to-wake scope 3 GHG emissions from subcontracted container shipping operations 16.7% within the same timeframe. Furthermore, A.P. Moller- Maersk commits to reduce absolute scope 3 GHG emissions from use of sold products covering distributed fossil fuels 42% within the same timeframe. A.P. Moller- Maersk finally commits to reduce remaining absolute scope 3 GHG emissions from fuel and energy related activities and upstream transportation and distribution 25% within the same timeframe. A. P. Moller-Maersk also commits to increase annual sourcing of renewable electricity from 22.7% in 2022 to 100% by 2030.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocksLong-Term TargetsAP. Moller-Maersk commits to reduce absolute scope 1 and 2 GHG emissions 96% by 2040.* A.P. Moller-Maersk also commits to reduce absolute scope 3 GHG emissions 90% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 96.2% by 2040 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 and scope 2 GHG emissions from all other sources 90% within the same timeframe. A.P. Moller- Maersk further commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from subcontracted container shipping operations 97.1% within the same timeframe. Furthermore, A.P. Moller-Maersk commits to reduce remaining absolute scope 3 GHG emissions 90% within the same timeframe.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocks', '1.5°C', 'Net-zero', 'A.P. Moller Maersk commits to reach net-zero greenhouse gas emissions across the value chain by 2040 from a 2022 base year.', '1+2+3', NULL, 'Net-zero', 'Other', '1.5°C', 2022, 2040, 'CY', '2024-02-08', '2024-06-03 11:55:36.578475+00', '2024-06-03 11:55:36.578475+00'),
  ('ap-moller-maersk', 'Target', 'A.P. Moller Maersk commits to reach net-zero greenhouse gas emissions across the valuechain by 2040 from a 2022 base year.Near-Term TargetsA.P. Moller-Maersk commits to reduce absolute scope 1 GHG emissions 34.7% by 2030 from a 2022 base year.* A.P. Moller Maersk also commits to reduce absolute scope 3 GHG emissions 21.9% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 34.7% by 2030 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 GHG emissions from all other sources 42% within the same timeframe. A.P. Moller-Maersk further commits to reduce absolute well-to-wake scope 3 GHG emissions from subcontracted container shipping operations 16.7% within the same timeframe. Furthermore, A.P. Moller- Maersk commits to reduce absolute scope 3 GHG emissions from use of sold products covering distributed fossil fuels 42% within the same timeframe. A.P. Moller- Maersk finally commits to reduce remaining absolute scope 3 GHG emissions from fuel and energy related activities and upstream transportation and distribution 25% within the same timeframe. A. P. Moller-Maersk also commits to increase annual sourcing of renewable electricity from 22.7% in 2022 to 100% by 2030.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocksLong-Term TargetsAP. Moller-Maersk commits to reduce absolute scope 1 and 2 GHG emissions 96% by 2040.* A.P. Moller-Maersk also commits to reduce absolute scope 3 GHG emissions 90% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 96.2% by 2040 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 and scope 2 GHG emissions from all other sources 90% within the same timeframe. A.P. Moller- Maersk further commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from subcontracted container shipping operations 97.1% within the same timeframe. Furthermore, A.P. Moller-Maersk commits to reduce remaining absolute scope 3 GHG emissions 90% within the same timeframe.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocks', '1.5°C', 'Near-term', 'A.P. Moller-Maersk commits to reduce absolute scope 1 GHG emissions 34.7% by 2030 from a 2022 base year.**The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocks', '1', NULL, 'Absolute', 'Reduction', '1.5°C', 2022, 2030, 'CY', '2024-02-08', '2024-06-03 11:55:36.580313+00', '2024-06-03 11:55:36.580313+00'),
  ('ap-moller-maersk', 'Target', 'A.P. Moller Maersk commits to reach net-zero greenhouse gas emissions across the valuechain by 2040 from a 2022 base year.Near-Term TargetsA.P. Moller-Maersk commits to reduce absolute scope 1 GHG emissions 34.7% by 2030 from a 2022 base year.* A.P. Moller Maersk also commits to reduce absolute scope 3 GHG emissions 21.9% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 34.7% by 2030 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 GHG emissions from all other sources 42% within the same timeframe. A.P. Moller-Maersk further commits to reduce absolute well-to-wake scope 3 GHG emissions from subcontracted container shipping operations 16.7% within the same timeframe. Furthermore, A.P. Moller- Maersk commits to reduce absolute scope 3 GHG emissions from use of sold products covering distributed fossil fuels 42% within the same timeframe. A.P. Moller- Maersk finally commits to reduce remaining absolute scope 3 GHG emissions from fuel and energy related activities and upstream transportation and distribution 25% within the same timeframe. A. P. Moller-Maersk also commits to increase annual sourcing of renewable electricity from 22.7% in 2022 to 100% by 2030.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocksLong-Term TargetsAP. Moller-Maersk commits to reduce absolute scope 1 and 2 GHG emissions 96% by 2040.* A.P. Moller-Maersk also commits to reduce absolute scope 3 GHG emissions 90% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 96.2% by 2040 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 and scope 2 GHG emissions from all other sources 90% within the same timeframe. A.P. Moller- Maersk further commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from subcontracted container shipping operations 97.1% within the same timeframe. Furthermore, A.P. Moller-Maersk commits to reduce remaining absolute scope 3 GHG emissions 90% within the same timeframe.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocks', '1.5°C', 'Near-term', 'A.P. Moller-Maersk also commits to reduce absolute scope 3 GHGemissions 21.9% within the same timeframe.', '3', NULL, 'Absolute', 'Reduction', NULL, 2022, 2030, 'CY', '2024-02-08', '2024-06-03 11:55:36.582026+00', '2024-06-03 11:55:36.582026+00'),
  ('ap-moller-maersk', 'Target', 'A.P. Moller Maersk commits to reach net-zero greenhouse gas emissions across the valuechain by 2040 from a 2022 base year.Near-Term TargetsA.P. Moller-Maersk commits to reduce absolute scope 1 GHG emissions 34.7% by 2030 from a 2022 base year.* A.P. Moller Maersk also commits to reduce absolute scope 3 GHG emissions 21.9% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 34.7% by 2030 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 GHG emissions from all other sources 42% within the same timeframe. A.P. Moller-Maersk further commits to reduce absolute well-to-wake scope 3 GHG emissions from subcontracted container shipping operations 16.7% within the same timeframe. Furthermore, A.P. Moller- Maersk commits to reduce absolute scope 3 GHG emissions from use of sold products covering distributed fossil fuels 42% within the same timeframe. A.P. Moller- Maersk finally commits to reduce remaining absolute scope 3 GHG emissions from fuel and energy related activities and upstream transportation and distribution 25% within the same timeframe. A. P. Moller-Maersk also commits to increase annual sourcing of renewable electricity from 22.7% in 2022 to 100% by 2030.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocksLong-Term TargetsAP. Moller-Maersk commits to reduce absolute scope 1 and 2 GHG emissions 96% by 2040.* A.P. Moller-Maersk also commits to reduce absolute scope 3 GHG emissions 90% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 96.2% by 2040 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 and scope 2 GHG emissions from all other sources 90% within the same timeframe. A.P. Moller- Maersk further commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from subcontracted container shipping operations 97.1% within the same timeframe. Furthermore, A.P. Moller-Maersk commits to reduce remaining absolute scope 3 GHG emissions 90% within the same timeframe.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocks', '1.5°C', 'Near-term', 'Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 34.7% by 2030 from a 2022 base year.', '1+3', NULL, 'Absolute', 'Reduction', '1.5°C', 2022, 2030, 'CY', '2024-02-08', '2024-06-03 11:55:36.583649+00', '2024-06-03 11:55:36.583649+00'),
  ('ap-moller-maersk', 'Target', 'A.P. Moller Maersk commits to reach net-zero greenhouse gas emissions across the valuechain by 2040 from a 2022 base year.Near-Term TargetsA.P. Moller-Maersk commits to reduce absolute scope 1 GHG emissions 34.7% by 2030 from a 2022 base year.* A.P. Moller Maersk also commits to reduce absolute scope 3 GHG emissions 21.9% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 34.7% by 2030 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 GHG emissions from all other sources 42% within the same timeframe. A.P. Moller-Maersk further commits to reduce absolute well-to-wake scope 3 GHG emissions from subcontracted container shipping operations 16.7% within the same timeframe. Furthermore, A.P. Moller- Maersk commits to reduce absolute scope 3 GHG emissions from use of sold products covering distributed fossil fuels 42% within the same timeframe. A.P. Moller- Maersk finally commits to reduce remaining absolute scope 3 GHG emissions from fuel and energy related activities and upstream transportation and distribution 25% within the same timeframe. A. P. Moller-Maersk also commits to increase annual sourcing of renewable electricity from 22.7% in 2022 to 100% by 2030.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocksLong-Term TargetsAP. Moller-Maersk commits to reduce absolute scope 1 and 2 GHG emissions 96% by 2040.* A.P. Moller-Maersk also commits to reduce absolute scope 3 GHG emissions 90% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 96.2% by 2040 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 and scope 2 GHG emissions from all other sources 90% within the same timeframe. A.P. Moller- Maersk further commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from subcontracted container shipping operations 97.1% within the same timeframe. Furthermore, A.P. Moller-Maersk commits to reduce remaining absolute scope 3 GHG emissions 90% within the same timeframe.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocks', '1.5°C', 'Near-term', 'A. P. Moller-Maersk also commits to increase annual sourcing of renewable electricity from 22.7% in 2022 to 100% by 2030.', '2', NULL, 'Renewable electricity', 'Other', '1.5°C', 2022, 2030, 'CY', '2024-02-08', '2024-06-03 11:55:36.591909+00', '2024-06-03 11:55:36.591909+00'),
  ('ap-moller-maersk', 'Target', 'A.P. Moller Maersk commits to reach net-zero greenhouse gas emissions across the valuechain by 2040 from a 2022 base year.Near-Term TargetsA.P. Moller-Maersk commits to reduce absolute scope 1 GHG emissions 34.7% by 2030 from a 2022 base year.* A.P. Moller Maersk also commits to reduce absolute scope 3 GHG emissions 21.9% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 34.7% by 2030 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 GHG emissions from all other sources 42% within the same timeframe. A.P. Moller-Maersk further commits to reduce absolute well-to-wake scope 3 GHG emissions from subcontracted container shipping operations 16.7% within the same timeframe. Furthermore, A.P. Moller- Maersk commits to reduce absolute scope 3 GHG emissions from use of sold products covering distributed fossil fuels 42% within the same timeframe. A.P. Moller- Maersk finally commits to reduce remaining absolute scope 3 GHG emissions from fuel and energy related activities and upstream transportation and distribution 25% within the same timeframe. A. P. Moller-Maersk also commits to increase annual sourcing of renewable electricity from 22.7% in 2022 to 100% by 2030.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocksLong-Term TargetsAP. Moller-Maersk commits to reduce absolute scope 1 and 2 GHG emissions 96% by 2040.* A.P. Moller-Maersk also commits to reduce absolute scope 3 GHG emissions 90% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 96.2% by 2040 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 and scope 2 GHG emissions from all other sources 90% within the same timeframe. A.P. Moller- Maersk further commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from subcontracted container shipping operations 97.1% within the same timeframe. Furthermore, A.P. Moller-Maersk commits to reduce remaining absolute scope 3 GHG emissions 90% within the same timeframe.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocks', '1.5°C', 'Long-term', 'AP. Moller-Maersk commits to reduce absolute scope 1 and 2 GHG emissions 96% by 2040.** The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocks', '1+2', NULL, 'Absolute', 'Reduction', '1.5°C', 2022, 2040, 'CY', '2024-02-08', '2024-06-03 11:55:36.593466+00', '2024-06-03 11:55:36.593466+00'),
  ('ap-moller-maersk', 'Target', 'A.P. Moller Maersk commits to reach net-zero greenhouse gas emissions across the valuechain by 2040 from a 2022 base year.Near-Term TargetsA.P. Moller-Maersk commits to reduce absolute scope 1 GHG emissions 34.7% by 2030 from a 2022 base year.* A.P. Moller Maersk also commits to reduce absolute scope 3 GHG emissions 21.9% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 34.7% by 2030 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 GHG emissions from all other sources 42% within the same timeframe. A.P. Moller-Maersk further commits to reduce absolute well-to-wake scope 3 GHG emissions from subcontracted container shipping operations 16.7% within the same timeframe. Furthermore, A.P. Moller- Maersk commits to reduce absolute scope 3 GHG emissions from use of sold products covering distributed fossil fuels 42% within the same timeframe. A.P. Moller- Maersk finally commits to reduce remaining absolute scope 3 GHG emissions from fuel and energy related activities and upstream transportation and distribution 25% within the same timeframe. A. P. Moller-Maersk also commits to increase annual sourcing of renewable electricity from 22.7% in 2022 to 100% by 2030.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocksLong-Term TargetsAP. Moller-Maersk commits to reduce absolute scope 1 and 2 GHG emissions 96% by 2040.* A.P. Moller-Maersk also commits to reduce absolute scope 3 GHG emissions 90% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 96.2% by 2040 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 and scope 2 GHG emissions from all other sources 90% within the same timeframe. A.P. Moller- Maersk further commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from subcontracted container shipping operations 97.1% within the same timeframe. Furthermore, A.P. Moller-Maersk commits to reduce remaining absolute scope 3 GHG emissions 90% within the same timeframe.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocks', '1.5°C', 'Long-term', 'A.P. Moller-Maersk also commits to reduce absolute scope 3 GHG emissions 90% within the same timeframe.', '3', NULL, 'Absolute', 'Reduction', NULL, 2022, 2040, 'CY', '2024-02-08', '2024-06-03 11:55:36.595023+00', '2024-06-03 11:55:36.595023+00'),
  ('ap-moller-maersk', 'Target', 'A.P. Moller Maersk commits to reach net-zero greenhouse gas emissions across the valuechain by 2040 from a 2022 base year.Near-Term TargetsA.P. Moller-Maersk commits to reduce absolute scope 1 GHG emissions 34.7% by 2030 from a 2022 base year.* A.P. Moller Maersk also commits to reduce absolute scope 3 GHG emissions 21.9% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 34.7% by 2030 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 GHG emissions from all other sources 42% within the same timeframe. A.P. Moller-Maersk further commits to reduce absolute well-to-wake scope 3 GHG emissions from subcontracted container shipping operations 16.7% within the same timeframe. Furthermore, A.P. Moller- Maersk commits to reduce absolute scope 3 GHG emissions from use of sold products covering distributed fossil fuels 42% within the same timeframe. A.P. Moller- Maersk finally commits to reduce remaining absolute scope 3 GHG emissions from fuel and energy related activities and upstream transportation and distribution 25% within the same timeframe. A. P. Moller-Maersk also commits to increase annual sourcing of renewable electricity from 22.7% in 2022 to 100% by 2030.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocksLong-Term TargetsAP. Moller-Maersk commits to reduce absolute scope 1 and 2 GHG emissions 96% by 2040.* A.P. Moller-Maersk also commits to reduce absolute scope 3 GHG emissions 90% within the same timeframe. Within these targets, A.P. Moller- Maersk commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from container shipping operations 96.2% by 2040 from a 2022 base year. A.P. Moller- Maersk also commits to reduce absolute scope 1 and scope 2 GHG emissions from all other sources 90% within the same timeframe. A.P. Moller- Maersk further commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from subcontracted container shipping operations 97.1% within the same timeframe. Furthermore, A.P. Moller-Maersk commits to reduce remaining absolute scope 3 GHG emissions 90% within the same timeframe.* The target boundary includes biogenic land-related emissions and removals from bioenergy feedstocks', '1.5°C', 'Long-term', 'A.P. Moller- Maersk further commits to reduce absolute well-to-wake scope 1 and 3 GHG emissions from subcontracted container shipping operations 97.1% within the same timeframe.', '1+3', NULL, 'Absolute', 'Reduction', '1.5°C', 2022, 2040, 'CY', '2024-02-08', '2024-06-03 11:55:36.599764+00', '2024-06-03 11:55:36.599764+00'),
  ('skf', 'Target', 'AB SKF commits to reach net-zero greenhouse gas emissions across the value chain by 2050 from a 2019 base year.Near-Term TargetsAB SKF commits to reduce absolute scope 1 and scope 2 GHG emissions 95% by 2030 from a 2019 base year.* AB SKF also commits to reduce absolute scope 3 emissions from purchased goods and services, upstream transportation and distribution, and use of sold products 31% within the same timeframe.Long-Term TargetsAB SKF commits to maintain at least 95% absolute reduction of scope 1 and 2 GHG emissions from 2030 through 2050, relative to a 2019 base year.* AB SKF also commits to reduce absolute scope 3 GHG emissions from purchased goods and services, fuel- and energy-related activities, upstream transportation and distribution, and use of sold products 90% by 2050 from a 2019 base year. *The target boundary includes land-related emissions and removals from bioenergy feedstocks.', '1.5°C', 'Net-zero', 'AB SKF commits to reach net-zero greenhouse gas emissions across the value chain by 2050 from a 2019 base year.', '1+2+3', NULL, 'Net-zero', 'Other', '1.5°C', 2019, 2050, 'CY', '2023-03-09', '2024-06-03 11:55:36.653077+00', '2024-06-03 11:55:36.653077+00'),
  ('skf', 'Target', 'AB SKF commits to reach net-zero greenhouse gas emissions across the value chain by 2050 from a 2019 base year.Near-Term TargetsAB SKF commits to reduce absolute scope 1 and scope 2 GHG emissions 95% by 2030 from a 2019 base year.* AB SKF also commits to reduce absolute scope 3 emissions from purchased goods and services, upstream transportation and distribution, and use of sold products 31% within the same timeframe.Long-Term TargetsAB SKF commits to maintain at least 95% absolute reduction of scope 1 and 2 GHG emissions from 2030 through 2050, relative to a 2019 base year.* AB SKF also commits to reduce absolute scope 3 GHG emissions from purchased goods and services, fuel- and energy-related activities, upstream transportation and distribution, and use of sold products 90% by 2050 from a 2019 base year. *The target boundary includes land-related emissions and removals from bioenergy feedstocks.', '1.5°C', 'Near-term', 'AB SKF commits to reduce absolute scope 1 and scope 2 GHG emissions 95% by 2030 from a 2019 base year*. *The target boundary includes land-related emissions and removals from bioenergy feedstocks.', '1+2', NULL, 'Absolute', 'Reduction', '1.5°C', 2019, 2030, 'CY', '2023-03-09', '2024-06-03 11:55:36.65572+00', '2024-06-03 11:55:36.65572+00'),
  ('skf', 'Target', 'AB SKF commits to reach net-zero greenhouse gas emissions across the value chain by 2050 from a 2019 base year.Near-Term TargetsAB SKF commits to reduce absolute scope 1 and scope 2 GHG emissions 95% by 2030 from a 2019 base year.* AB SKF also commits to reduce absolute scope 3 emissions from purchased goods and services, upstream transportation and distribution, and use of sold products 31% within the same timeframe.Long-Term TargetsAB SKF commits to maintain at least 95% absolute reduction of scope 1 and 2 GHG emissions from 2030 through 2050, relative to a 2019 base year.* AB SKF also commits to reduce absolute scope 3 GHG emissions from purchased goods and services, fuel- and energy-related activities, upstream transportation and distribution, and use of sold products 90% by 2050 from a 2019 base year. *The target boundary includes land-related emissions and removals from bioenergy feedstocks.', '1.5°C', 'Near-term', 'AB SKF also commits to reduce absolute scope 3 emissions from purchased goods and services, upstream transportation and distribution, and use of sold products 31% within the same timeframe.', '3', NULL, 'Absolute', 'Reduction', NULL, 2019, 2030, 'CY', '2023-03-09', '2024-06-03 11:55:36.657275+00', '2024-06-03 11:55:36.657275+00'),
  ('skf', 'Target', 'AB SKF commits to reach net-zero greenhouse gas emissions across the value chain by 2050 from a 2019 base year.Near-Term TargetsAB SKF commits to reduce absolute scope 1 and scope 2 GHG emissions 95% by 2030 from a 2019 base year.* AB SKF also commits to reduce absolute scope 3 emissions from purchased goods and services, upstream transportation and distribution, and use of sold products 31% within the same timeframe.Long-Term TargetsAB SKF commits to maintain at least 95% absolute reduction of scope 1 and 2 GHG emissions from 2030 through 2050, relative to a 2019 base year.* AB SKF also commits to reduce absolute scope 3 GHG emissions from purchased goods and services, fuel- and energy-related activities, upstream transportation and distribution, and use of sold products 90% by 2050 from a 2019 base year. *The target boundary includes land-related emissions and removals from bioenergy feedstocks.', '1.5°C', 'Long-term', 'AB SKF commits to maintain at least 95% absolute reduction of scope 1 and 2 GHG emissions from 2030 through 2050, relative to a 2019 base year*. *The target boundary includes land-related emissions and removals from bioenergy feedstocks.', '1+2', NULL, 'Absolute', 'Maintenance', '1.5°C', 2019, 2050, 'CY', '2023-03-09', '2024-06-03 11:55:36.65892+00', '2024-06-03 11:55:36.65892+00'),
  ('skf', 'Target', 'AB SKF commits to reach net-zero greenhouse gas emissions across the value chain by 2050 from a 2019 base year.Near-Term TargetsAB SKF commits to reduce absolute scope 1 and scope 2 GHG emissions 95% by 2030 from a 2019 base year.* AB SKF also commits to reduce absolute scope 3 emissions from purchased goods and services, upstream transportation and distribution, and use of sold products 31% within the same timeframe.Long-Term TargetsAB SKF commits to maintain at least 95% absolute reduction of scope 1 and 2 GHG emissions from 2030 through 2050, relative to a 2019 base year.* AB SKF also commits to reduce absolute scope 3 GHG emissions from purchased goods and services, fuel- and energy-related activities, upstream transportation and distribution, and use of sold products 90% by 2050 from a 2019 base year. *The target boundary includes land-related emissions and removals from bioenergy feedstocks.', '1.5°C', 'Long-term', 'AB SKF also commits to reduce absolute scope 3 GHG emissions from purchased goods and services, fuel- and energy-related activities, upstream transportation and distribution, and use of sold products 90% by 2050 from a 2019 base year.', '3', NULL, 'Absolute', 'Reduction', NULL, 2019, 2050, 'CY', '2023-03-09', '2024-06-03 11:55:36.660389+00', '2024-06-03 11:55:36.660389+00'),
  ('maersk-contract-logistics-management-asia', 'Target', 'Maersk Contract Logistics Management (Asia) Limited commits to reduce absolute scope 1 and 2 GHG emissions 42% by 2030 from a 2021 base year.* Maersk Contract Logistics Management (Asia) Limited also commits to reduce absolute scope 3 GHG emissions from upstream transportation and distribution 42% within the same timeframe. *The target boundary includes land-related emissions and removals from bioenergy feedstocks.', '1.5°C', 'Near-term', 'Maersk Contract Logistics Management (Asia) Limited commits to reduce absolute scope 1 and 2 GHG emissions 42% by 2030 from a 2021 base year.**The target boundary includes land-related emissions and removals from bioenergy feedstocks.', '1+2', NULL, 'Absolute', 'Reduction', '1.5°C', 2021, 2030, 'CY', '2024-03-21', '2024-06-03 11:55:44.363443+00', '2024-06-03 11:55:44.363443+00'),
  ('maersk-contract-logistics-management-asia', 'Target', 'Maersk Contract Logistics Management (Asia) Limited commits to reduce absolute scope 1 and 2 GHG emissions 42% by 2030 from a 2021 base year.* Maersk Contract Logistics Management (Asia) Limited also commits to reduce absolute scope 3 GHG emissions from upstream transportation and distribution 42% within the same timeframe. *The target boundary includes land-related emissions and removals from bioenergy feedstocks.', '1.5°C', 'Near-term', 'Maersk Contract Logistics Management (Asia) Limited also commits to reduce absolute scope 3 GHG emissions from upstream transportation and distribution 42% within the same timeframe.', '3', NULL, 'Absolute', 'Reduction', NULL, 2021, 2030, 'CY', '2024-03-21', '2024-06-03 11:55:44.364619+00', '2024-06-03 11:55:44.364619+00');

--
-- Data for Name: commitment; Type: TABLE DATA; Schema: public; Owner: -
--
INSERT INTO public.commitment
  (company_slug, action, commitment_type, commitment_deadline, status, reason_for_commitment_extension_or_removal, year_type, date_published, created_at, updated_at)
VALUES
  ('ap-moller-maersk', 'Target', 'Standard', NULL, NULL, NULL, 'CY', '2024-02-08', '2024-06-03 11:55:36.578984+00', '2024-06-03 11:55:36.578984+00'),
  ('skf', 'Target', 'Standard', NULL, NULL, NULL, 'CY', '2023-03-09', '2024-06-03 11:55:36.653458+00', '2024-06-03 11:55:36.653458+00'),
  ('maersk-contract-logistics-management-asia', 'Target', 'Standard', NULL, NULL, NULL, 'CY', '2024-03-21', '2024-06-03 11:55:44.36375+00', '2024-06-03 11:55:44.36375+00');

-- currency_rate (Google: “1 SEK in USD”)
INSERT INTO "public"."currency_rate"
  ("currency_code", "year", "rate_in_usd")
VALUES
  ('USD', 2022, 1.00),
  ('EUR', 2022, 1.08),
  ('GBP', 2022, 1.30),
  ('CHF', 2022, 1.15),
  ('DKK', 2022, 0.14),
  ('NOK', 2022, 0.091),
  ('SEK', 2022, 0.094);
