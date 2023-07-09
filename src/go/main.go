package main

/*
#cgo CFLAGS: -I${SRCDIR}/../c
#cgo LDFLAGS: -L${SRCDIR}/../../lib -lsquare_renderer
#include "square_renderer.h"
*/
import "C"

import (
	"fmt"
	"time"
)

func main() {
	fmt.Println("Creating square...")
	C.draw_square()

	// Delay to visualize the square creation
	time.Sleep(2 * time.Second)

	fmt.Println("Rotating square...")
	C.rotate_square()

	fmt.Println("Process completed.")
}
