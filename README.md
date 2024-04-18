# Climate Wiki

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
	mkdir -p config
	mkdir -p public
	mkdir -p db/migrations

## To run

npm run dev
