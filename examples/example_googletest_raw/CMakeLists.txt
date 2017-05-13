cmake_minimum_required(VERSION 3.0)
project(example_googletest_raw)

if (MSVC)
  # These lines are here to solve a link error under msvc
  # (gtest uses a static runtime and require the libs to also use it)
  include("../thirdparty_testlibs/onqtam_ucm/cmake/ucm.cmake")
  ucm_set_runtime(STATIC)
endif()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
enable_testing()

add_subdirectory(../thirdparty_testlibs/googletest/googletest googletest_build)
add_subdirectory(MyLibrary)
