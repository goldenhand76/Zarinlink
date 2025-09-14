package main

import (
	"database/sql"
	"log"

	api "github.com/goldenhand76/zarinlink/api"
	db "github.com/goldenhand76/zarinlink/db/sqlc"
)

const (
	version       = "1.0.0"
	dbDriver      = "postgres"
	dbSource      = "postgresql://root:secret@localhost:5432/zarinlink?sslmode=disable"
	serverAddress = "0.0.0.0:8888"
)

func main() {
	conn, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("Cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(serverAddress)
	if err != nil {
		log.Fatal("Cannot start server:", err)
	}
}
