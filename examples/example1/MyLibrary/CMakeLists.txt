set(sources lib1.cpp lib2.cpp)
add_library(MyLibrary STATIC lib1.cpp lib2.cpp)
set_property(TARGET MyLibrary PROPERTY CXX_STANDARD 11)
cmake_registertest(MyLibrary MyLibraryTest)
