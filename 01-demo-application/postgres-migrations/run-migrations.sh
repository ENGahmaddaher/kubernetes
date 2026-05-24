#!/bin/sh
set -e

echo "Running migrations..."

for file in /migrations/*.up.sql; do
  echo "Applying: $file"
  PGPASSWORD="$DB_PASSWORD" psql \
    -h "$DB_HOST" \
    -U "$DB_USER" \
    -d "$DB_NAME" \
    -f "$file"
done

echo "Migrations completed successfully!"
