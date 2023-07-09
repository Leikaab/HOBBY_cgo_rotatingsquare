# Variables
CC = gcc
GO = go
CFLAGS = -I./include/c -I./src/c -L./lib -Wall
CFLAGS += -ObjC -framework Metal -framework MetalKit
GFLAGS = -ldflags "-linkmode external"
LIB_NAME = libsquare_renderer.a
OUT_BIN = bin/rotating_square

# Source and header files
OBJC_SRC = $(wildcard src/objc/*.m)
OBJC_HEADERS = $(wildcard src/objc/*.h)
C_SRC = $(wildcard src/c/*.c)
C_HEADERS = $(wildcard include/c/*.h)
GO_SRC = $(wildcard src/go/*.go)

# Default make
all: $(OUT_BIN)

# Link
$(OUT_BIN): $(GO_SRC) $(LIB_NAME) $(OBJC_SRC) $(OBJC_HEADERS)
	$(GO) build $(GFLAGS) -o $@ $(GO_SRC)

# Compile the C code into a static library
$(LIB_NAME): $(C_SRC) $(C_HEADERS) $(OBJC_SRC) $(OBJC_HEADERS)
	$(CC) $(CFLAGS) -c $(C_SRC) $(OBJC_SRC)
	ar rcs lib/$(LIB_NAME) *.o
	rm *.o

# Clean
clean:
	rm -f *.o
	rm -f lib/$(LIB_NAME)
	rm -f $(OUT_BIN)

# Run
run: $(OUT_BIN)
	./$(OUT_BIN)
