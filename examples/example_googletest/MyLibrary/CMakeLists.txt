# Create a library with the "OBJECT" type 
# It will be turned into a static or shared library later (see below)
add_library(MyLibrary_Object OBJECT lib1.cpp lib2.cpp)

# set_target_properties is just here to showcase that tests target 
# will be automatically placed in the same solution folder under Visual Studio
set_target_properties(MyLibrary_Object PROPERTIES FOLDER MyLibraries)

# cmake_registertest can then create a static (or shared) library from the object library 
# and a test executable
cmake_registertest(MyLibrary_Object MyLibrary STATIC MyLibraryTest)
