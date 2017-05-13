# Step 1 : add include directory
include_directories("../../thirdparty_testlibs/googletest/googletest/include")

# Step 2 : make an "OBJECT" library (do not make a static or shared library, it will be done later)
# This pseudo librairy will only group the object files
add_library(MyLibrary_Object OBJECT lib1.cpp lib2.cpp)

# 
# Step 3 : turn the object library into a static or shared library. 
# (Only Step 2i/ or step 2ii/ is required depending on your need)
#
# Step 3 i/ (case of a static library) : create a static library from the object library
add_library(MyLibrary_Static STATIC $<TARGET_OBJECTS:MyLibrary_Object>)
# Step 3 ii/ (case of a dynamic or module library) : create a dynamic library from the object library
# You will need to also link it to gtest for a successful link 
add_library(MyLibrary_Shared SHARED $<TARGET_OBJECTS:MyLibrary_Object> )
target_link_libraries(MyLibrary_Shared gtest)

# Step 4 : Add an exe for the tests and reference it for ctest, link it with gtest_main
add_executable(MyLibraryTest $<TARGET_OBJECTS:MyLibrary_Object>)
target_link_libraries(MyLibraryTest gtest_main)
add_test(NAME MyLibraryTest COMMAND MyLibraryTest)
