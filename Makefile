network:
	docker network create zarin-network

postgres:
	docker run --name postgres --network zarin-network --restart always -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres createdb --username=root --owner=root zarin_link

dropdb:
	docker exec -it postgres dropdb zarin_link

new_migration:
	migrate create -ext sql -dir db/migration -seq $(name)

migrateup:
	migrate -path ./db/migration -database "postgresql://root:secret@localhost:5432/zarin_link?sslmode=disable" -verbose up
 
migratedown:
	migrate -path ./db/migration -database "postgresql://root:secret@localhost:5432/zarin_link?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test :
	go test -v -cover ./...

format:
	go fmt ./...

server:
	go run main.go

	