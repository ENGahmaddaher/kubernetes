FROM migrate/migrate:v4.17.1

COPY ./migrations/ /app/migrations/

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["migrate -path /app/migrations -database $DATABASE_URL up"]
