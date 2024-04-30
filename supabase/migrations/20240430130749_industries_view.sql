create or replace view "public"."industries" as  SELECT company.industry AS name,
    count(company.name) AS company_count
   FROM company
  GROUP BY company.industry
 HAVING ((company.industry IS NOT NULL) AND (count(company.name) >= 2))
  ORDER BY company.industry;



