# Demo Application

![](./readme-assets/screenshot.png)

## Minimal 3 tier web application

- **React frontend:** Uses React to load data from the API and display the result.
- **Node.js API:** Has `/api/hello`, `/api/users`, `/health`, and `/metrics` endpoints. `/api/users` queries the database for users, and `/health` returns the database connection status.
- **Postgres Database:** PostgreSQL database with a `users` table. The API application executes `SELECT * FROM users` to return the user list.
- **Prometheus Metrics:** The API exposes metrics on `/metrics` endpoint for Prometheus scraping.

![](./readme-assets/request-diagram.png)

The demo application builds upon the one used in the [DevOps Directive Docker Course](https://github.com/sidpalas/devops-directive-docker-course/tree/main/05-example-web-application).

It adds a PostgreSQL database with a `users` table and Prometheus metrics collection.

## Running the Application

While the whole point of this course is that you probably won't want/need to run the application locally, we can do so as a starting point.

The Taskfile contains the commands to start each application:

### Postgres

It's way more convenient to run postgres in a container, so we will do that.

`task up` will start postgres in a container and publish port 5432 from the container to your localhost.

**🚨 NOTE:** After starting the database, you need to run the migration file in `./postgres-migrations/migrations` to create the `users` table that the API uses. This can be done with `task migrate`.

### api-node

To run the node api you will need to `task build` to install the dependencies and build the image.

After building the image, `docker-compose up -d` will run the api in production mode on port 3001.

### client-react

To run the react app, `docker-compose up -d` will run the react app on port 4321.

### Database Migrations

To run database migrations, use `task migrate`. This will run the `golang-migrate` container to apply the `001_create_users_table.up.sql` script.

## Tasks

The top level `Taskfile` provides all necessary commands to run the application:
```
❯ task --list-all
task: Available tasks for this project:

up: Start all services locally with docker-compose

down: Stop all services

logs: View logs of all services

build: Build all Docker images

migrate: Run database migrations locally

test-api: Test API endpoint

test-react: Open React in browser

clean: Remove all containers, volumes, and images
```
