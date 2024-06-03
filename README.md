## Structure

- /app
	- /components
			- /common
			- /input
			- /[area specific]
	- /routes
		- /api
	- /hooks (incl context)
	- /services (business logic)
	- /utils (smaller utils)
- /loaders
		- articles.ts
- /config
- /public
- /db
	- /migrations

Create folders:

	mkdir -p app/components/scenes
	mkdir -p app/components/page
	mkdir -p app/components/navigation
	mkdir -p app/components/common
	mkdir -p app/components/input
	mkdir -p app/routes/api
	mkdir -p app/hooks
	mkdir -p app/theme
	touch app/theme/global.css
	mkdir -p app/services
	mkdir -p app/utils
	mkdir -p server/loaders
	mkdir -p server/actions
	mkdir -p server/utils
	mkdir -p config
	mkdir -p public
	mkdir -p db/migrations

## To run

	npm run dev

## Set up local Supabase development

	cd ./supabase

	npx supabase start

Take note of `API URL` and `anon key`. You can also use this to get API keys and URLs:

	npx supabase status

### Development environment

Supabase web admin: http://127.0.0.1:54323/

Postgres connection string for TablePlus/Postico: `postgresql://postgres:postgres@localhost:54322/postgres`

### Get schema and data from cloud database

	npx supabase db pull  # Pull down local db schema from cloud db
	npx supabase db push  # Push up your local db schema to cloud db

Get data:

	npx supabase db dump --data-only -f db_data.sql
	psql --single-transaction --file db_data.sql --dbname 'postgresql://postgres:postgres@localhost:54322/postgres'

### Creating migration of database changes from local machine to server

Edit your local database, then run:

	npx supabase db diff -f [migration-name]
	# Then normally run: npx supabase db push

Running a migration locally:

	npx supabase migration up

Reset database and apply current migrations:

	npx supabase db reset

## API

Note: use `&api-key=demo`, or set it as a Bearer token in the header.

- Companies:
	- List: http://localhost:5173/v1/companies?sort=company_name&order=asc&limit=20&offset=0&api-key=demo
	- Company: http://localhost:5173/v1/companies/3m?api-key=demo
	- Company all years: http://localhost:5173/v1/companies/3m/all-years?api-key=demo
- Industries: http://localhost:5173/v1/industries?api-key=demo
- Search: http://localhost:5173/v1/search?query=&sort=name&order=asc&api-key=demo

Live API on https://api.opensustainabilityindex.org/

## SQL functions

	SELECT * FROM companies(
		10,                     -- offset_value
		20,                     -- limit_value
		'name',                 -- sort_by
		'asc'                  -- sort_order
	--  'Technology',           -- industry_filter
	--  true,                   -- near_term_filter
	--  'Type A',               -- commitment_type_filter
	--  'Active',               -- commitment_status_filter
	--  'Target 1'              -- target_target_filter
	);

v2:

	SELECT * FROM companies_v2(
		10,                     -- offset_value
		20,	                     -- limit_value
		'name',                 -- sort_by
		'asc'                  -- sort_order
	--  'Technology',           -- industry_filter
	--  true,                   -- near_term_filter
	--  'Type A',               -- commitment_type_filter
	--  'Active',               -- commitment_status_filter
	--  'Target 1'              -- target_target_filter
	);

Get SQL code:

	SELECT pg_get_functiondef('companies_v2'::regproc);
