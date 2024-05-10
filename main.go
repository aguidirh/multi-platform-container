package main

import (
	"fmt"
	"runtime"
)

func main() {
	fmt.Printf("Hello, World!\n")
	fmt.Printf("I'm running on %s architecture.\n", runtime.GOARCH)
}
