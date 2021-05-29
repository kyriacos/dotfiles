package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
)

func main() {
	portPtr := flag.String("port", "8080", "Port to run the server on")
	dirPtr := flag.String("dir", ".", "Directory to serve")

	flag.Parse()

	fmt.Println("---------------------------------------------------------------------")
	fmt.Println("|\tRunning HTTP server on PORT:\t", *portPtr)
	fmt.Println("|\t--> serving DIRECTORY:\t\t", *dirPtr)
	fmt.Println("---------------------------------------------------------------------")

	fileServer := http.FileServer(http.Dir(*dirPtr))
	if err := http.ListenAndServe(":"+*portPtr, fileServer); err != nil {
		log.Fatal(err)
	}
}
