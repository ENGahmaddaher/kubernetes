#!/bin/bash

echo "🚀 Starting services..."
docker-compose up -d

echo "⏳ Waiting for PostgreSQL to be ready..."
sleep 10

echo "📦 Running migrations..."
docker run --rm \
  --network src_microservices-network \
  -e DATABASE_URL="postgres://admin:secret123@postgres:5432/mydb?sslmode=disable" \
  entransistor/postgres-migrations:v1.0.0 \
  sh -c "migrate -path /app/migrations -database \"$DATABASE_URL\" up"

echo "✅ Migration completed!"

echo "📊 Checking users..."
docker exec microservices-postgres psql -U admin -d mydb -c "SELECT * FROM users;"

echo ""
echo "🎉 All services are running!"
echo "🌐 React UI: http://localhost:8080"
echo "🔌 API: http://localhost:3001"
echo "💾 PostgreSQL: localhost:5432"
echo ""
echo "📋 Logs: docker-compose logs -f"
