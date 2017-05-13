cmake_minimum_required(VERSION 3.0)
project(example_catch_raw)

if (CMAKE_COMPILER_IS_GNUCC)
    add_compile_options( -fPIC)
endif()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
enable_testing()
add_subdirectory(MyLibrary)
