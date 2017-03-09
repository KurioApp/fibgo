[![Build Status](https://travis-ci.org/uudashr/fibgo.svg?branch=master)](https://travis-ci.org/uudashr/fibgo)
[![Coverage Status](https://coveralls.io/repos/github/uudashr/fibgo/badge.svg?branch=master)](https://coveralls.io/github/uudashr/fibgo?branch=master)

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
