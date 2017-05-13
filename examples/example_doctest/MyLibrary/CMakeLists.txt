# Create a library with the "OBJECT" type 
# It will be turned into a static or shared library later (see below)
# The tests that are stored in library source files will be auto-discovered
add_library(MyLibrary_Object OBJECT lib1.cpp lib2.cpp)

# set_target_properties is just here to showcase that tests target 
# will be automatically placed in the same solution folder under Visual Studio
set_target_properties(MyLibrary_Object PROPERTIES FOLDER MyLibraries)

# crt_registertest will then create a static (or shared) library from the object library 
# and a test executable
crt_registertest(
   # Name of the input object library 
  INPUT_OBJECT_LIBRARY MyLibrary_Object
  # Name of the output shared or static library that will be created from the object library 
  OUTPUT_LIBRARY_NAME MyLibrary_Static
  # type of the output library (SHARED, STATIC or MODULE) 
  OUTPUT_LIBRARY_TYPE STATIC
  # Name of the output executable test target
  OUTPUT_TEST_TARGET MyLibraryTest

  # List of the other sources files containing tests (which are outside of the library sources):
  #  - tests in lib1.cpp and lib2.cpp will be auto-discovered since they are part of the library source files
  #  - below we also add tests from lib3_test.cpp and lib4_test.cpp (which are not part of the library)
  TEST_SOURCES lib3_test.cpp lib4_test.cpp 
)
