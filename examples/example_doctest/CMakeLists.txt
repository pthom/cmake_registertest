cmake_minimum_required(VERSION 3.0)
project(example_doctest)

set (crt_test_lib_location ${CMAKE_SOURCE_DIR}/../thirdparty_testlibs/doctest)
include("${CMAKE_SOURCE_DIR}/../../src/doctest_registertest.cmake")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
enable_testing()
add_subdirectory(MyLibrary)
