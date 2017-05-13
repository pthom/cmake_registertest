add_library(MyLibrary STATIC lib1.cpp)
set_target_properties(MyLibrary PROPERTIES FOLDER MyLibraries)

crt_registertest(
  # Name of the library to be tested
  LIBRARY MyLibrary
  # Name of the output executable test target
  OUTPUT_TEST_TARGET MyLibraryTest
  # List of the sources files containing tests 
  TEST_SOURCES lib1_test.cpp
)
