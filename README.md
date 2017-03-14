[![Build Status](https://travis-ci.org/KurioApp/fibgo.svg?branch=master)](https://travis-ci.org/KurioApp/fibgo)

# Fibonacci

Provide functionality for fibonacci related operation

## Installation
```shell
$ go get github.com/uudashr/fibgo
```

## Usage
Get fibonacci number of N
```go
import (
  "fmt"
  fib "github.com/uudashr/fibgo"
)

func ExampleN() {
	fmt.Println(fib.N(0))
	fmt.Println(fib.N(6))
	fmt.Println(fib.N(9))
	// Output:
	// 0
	// 8
	// 34
}
```

Or get sequence with length 10
```go
import (
  "fmt"
  fib "github.com/uudashr/fibgo"
)

func ExampleSeq() {
	fmt.Println(fib.Seq(10))
	// Output: [0 1 1 2 3 5 8 13 21 34]
}
```

Or create HTTP Service
```go
package main

import (
	"log"
	"net/http"

	fib "github.com/uudashr/fibgo"
)

func main() {
	handler := fib.NewHTTPHandler()
	log.Println("Listening on port", 8080, "...")
	err := http.ListenAndServe(":8080", handler)
	log.Println("Stopped err:", err)
}
```


## Running the fibgo service
Fibgo provide the http service for fibonacci numbers.

To run the service

```shell
$ fibgo-server --port 8080
```


## Cloud Deployment
Set GCLOUD_SERVICE_KEY on travis environment variable
```shell
$ base64 gcloud-service-key.json
```

Make sure we create the cluster
```shell
$ make init-cloud-all
```

or the cluster might be already created, then do
```shell
$ make init-cloud
```
This will do the initialization without creating the cluster

Then every successful Travis build, it will be automatically deploy the service.
