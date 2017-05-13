# `example_register`

This is an example that uses catch_registerstaticlibrary.
The usage is extremely simple: refer to MyLibrary/CMakeLists.txt.


This CMakeList.txt is reproduced below:
```
include("${CMAKE_SOURCE_DIR}/catch_registerstaticlibrary/src/catch_registerstaticlibrary.cmake")

set(sources lib1.cpp lib2.cpp)
add_library(MyLibrary STATIC lib1.cpp lib2.cpp)
set_property(TARGET MyLibrary PROPERTY CXX_STANDARD 11)
catch_registerstaticlibrary(MyLibrary MyLibraryTest)
```

If you build this example (using `build.sh` or `build.bat`), you will see the following output (example under windows)

```
          ...   (lots of lines) ...
Build succeeded.
    0 Warning(s)
    0 Error(s)

F:\dvp\catch_registerstaticlibrary\examples\example_register_processed\build>.\bin\Debug\MyLibraryTest.exe
testing in lib1.cpp
testing in lib2.cpp
===============================================================================
All tests passed (4 assertions in 2 test cases)
```
