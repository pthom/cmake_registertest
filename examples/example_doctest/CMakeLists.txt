cmake_minimum_required(VERSION 3.0)
project(example_doctest)

if (CMAKE_COMPILER_IS_GNUCC)
    add_compile_options( -fPIC)
endif()

set (crt_test_lib_location ${CMAKE_SOURCE_DIR}/../thirdparty_testlibs/doctest)
include("${CMAKE_SOURCE_DIR}/../../src/crt_registertest_doctest.cmake")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
enable_testing()
add_subdirectory(MyLibrary)
