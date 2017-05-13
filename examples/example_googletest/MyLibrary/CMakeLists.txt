add_library(MyLibrary_Object OBJECT lib1.cpp lib2.cpp)
cmake_registertest(MyLibrary_Object MyLibrary SHARED MyLibraryTest)
