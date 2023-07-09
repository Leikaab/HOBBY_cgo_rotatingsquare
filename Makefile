# Variables
CC = gcc
GO = go
CFLAGS = -I./include/c -L./lib -Wall
GFLAGS = -ldflags "-linkmode external -extldflags -static"
LIB_NAME = libsquare.a
OUT_BIN = bin/rotating_square

# Source and header files
C_SRC = $(wildcard src/c/*.c)
C_HEADERS = $(wildcard include/c/*.h)
GO_SRC = $(wildcard src/go/*.go)

# Default make
all: $(OUT_BIN)

# Link
$(OUT_BIN): $(GO_SRC) $(LIB_NAME)
	$(GO) build $(GFLAGS) -o $@ $(GO_SRC)

# Compile the C code into a static library
$(LIB_NAME): $(C_SRC) $(C_HEADERS)
	$(CC) $(CFLAGS) -c $(C_SRC)
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
