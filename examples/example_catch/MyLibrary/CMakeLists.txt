# Step 1 : make an "OBJECT" library (do not make a static or shared library, it will be done later)
# This pseudo librairy will only group the object files
add_library(MyLibrary_Object OBJECT lib1.cpp lib2.cpp)

# 
# Step 2 : cmake_registertest will 
# - add the include necessary include path for the tests
# - turn the object library into a static or shared library
# - add an executable target for the tests, and register it with ctest
# - link the test target with an apprpriate main() test function, and with the test library.
# - (in the case of a dynamic library) : also link the dynamic library 
#   with the required test function. 
#
# cmake_registertest arguments : 
# arg 1 = objectLibraryName : this is the name of your object library 
# arg 2: library type (can be either STATIC, SHARED or MODULE)
# arg 3 : name of the library to create 
# arg 4 : name of test executable
cmake_registertest(MyLibrary_Object MyLibrary STATIC MyLibraryTest)

