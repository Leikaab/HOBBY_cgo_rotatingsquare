# RotatingSquare: A Small Example to Demonstrate C and Go Interoperability

## Description

`RotatingSquare` is a simple project created to demonstrate how C and Go can interact in a single project. The project displays a rotating square on a MacOS system. The project utilizes C for low-level functions that are wrapped in a Go application.

The project is structured such that the core functionalities are implemented in C and then these functions are imported into a Go application which controls the program flow.

## Project Structure

The project is structured as follows:

RotatingSquare/
│ ├── src/
│ │ ├── go/
│ │ │ ├── main.go
│ │ └── c/
│ │ ├── lib.c
│ │ └── lib.h
│ ├── include/
│ │ └── c/
│ │ └── lib.h
│ ├── bin/
│ ├── lib/
│ ├── Makefile
│ └── README.md

### Description of Directories and Files

1. `src/` - Contains all the source files for the project.
    - `go/` - Contains the Go source files.
    - `c/` - Contains the C source files.
2. `include/` - Contains the C header files which are to be included in other parts of the project.
    - `c/` - Contains the C header files.
3. `bin/` - The directory where the final executable file will be placed after compiling the project. It is excluded from version control to avoid cluttering the repository with generated binaries.
4. `lib/` - The directory where the compiled C libraries will be placed. Since these libraries are typically platform-specific and can be large in size, they are excluded from version control to keep the repository size manageable.
5. `Makefile` - Contains instructions for `make` command to build the project.
6. `README.md` - This file, which provides information about the project.

Please note that when cloning or pulling this repository, the `bin/` and `lib/` folders will not be included by default. However, they will be created and populated during the build process or by running appropriate scripts.

If you need to work with the project's executable or compiled libraries, please refer to the build instructions or consult the project documentation for guidance on generating these files.

## Building and Running the Project

This project includes a `Makefile` that can be used to build and run the project. Use the following commands:

- To build the project: `make`
- To clean the project: `make clean`
- To run the project: `make run`

Note: Make sure you have the necessary C and Go compilers installed in your system.

## Author(s)

Leik Andre Asbjørnsen Butenschøn

## License

This project is licensed under the terms of the MIT license.
