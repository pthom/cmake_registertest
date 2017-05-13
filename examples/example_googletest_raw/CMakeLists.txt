cmake_minimum_required(VERSION 3.0)
project(example_googletest_raw)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
enable_testing()

add_subdirectory(../thirdparty_testlibs/googletest/googletest googletest_build)
add_subdirectory(MyLibrary)
