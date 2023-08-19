postgres:
	docker run --name postgres14 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14-alpine

createdb:
	docker exec -it postgres14 createdb --username=root --owner=root go_bank

dropdb:
	docker exec -it postgres14 --owner=root go_bank

migrateup:
	migrate -path db/migration -database "postgres://root:secret@localhost:5432/go_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgres://root:secret@localhost:5432/go_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.truePHONY: postgres createdb dropdb migrateup migratedown
