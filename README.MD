# Cmake Register Test for libraries (crt)

This is a set of cmake utilites in order to make it easy to add unit tests to a C++ library, when using googletest, catch or doctest.

It provides a cmake function `crt_registertest()` with the following features :

* Automatic discovery of the tests (*outside* of even *inside* the library source files)
* Automatic creation of an executable target for the tests, and registration with `ctest` (i.e `make test`)
* Automatic link the test target with the test library (providing an approriate main() function)
* Automatic inclusion of the test library include path

----
## Motto : 
Tests code should be able to reside inside separate source files, *as well as directly inside the library source files*

The [doctest](https://github.com/onqtam/doctest) documentation says rightfully:

> Tests can be considered a form of documentation and should be able to reside near the production code which they test.

However, storing the test code is inside a library is often cumbersome : your tests might not be launched at all! The linker often strips the self-registration code when it is inside a library. 

This project provides a solution that enables to have tests both inside the library sources, as well as inside separate source files.

For more information about the possible issues that this project attempts to solve, see:
* [Catch : "issue 421 - Document How to make Catch tests in a library be found"](https://github.com/philsquared/Catch/issues/421) 
* [Doctest: issue 21 - Tests inside a static library](https://github.com/onqtam/doctest/issues/21)
* [Googletest primer : important-note-for-visual-c-users](https://github.com/google/googletest/blob/master/googletest/docs/Primer.md#important-note-for-visual-c-users>)



----


## Platforms
This project was tested under OSX, Windows and Linux

## Requirements
* [googletest](https://github.com/google/googletest), [catch](https://github.com/philsquared/Catch), or [doctest](https://github.com/onqtam/doctest)
* cmake

## Quick usage instructions

`src/crt_registerstaticlibrary.cmake` provides a `crt_registertest()` functions that make it possible to add tests to a library, using a simple instruction in the `CMakeList.txt` of your library.

Two cases are possible:

### Case 1 : your test code resides in separate files

```cmake
add_library(MyLibrary STATIC lib1.cpp)
crt_registertest(
  LIBRARY MyLibrary
  OUTPUT_TEST_TARGET MyLibraryTest
  TEST_SOURCES lib1_test.cpp
)
```

This will :
1. Create an executable test target (MyLibraryTest) for your library.
2. Register it as a cmake test (so that `ctest` or `make test`) will launch it.
3. Link this test target with your library
4. Append the test library include path to your `TEST_SOURCES`

For an example, see [example_doctest_outertests](examples/example_doctest_outertests):
* [Main CMakeLists.txt](examples/example_doctest_outertests/CMakeLists.txt)
* [Library CMakeLists.txt](examples/example_doctest_outertests/MyLibrary/CMakeLists.txt)


### Case 2 : your test code resides in the library source code (as well as separate files)

```cmake
add_library(MyLibrary OBJECT lib1.cpp lib2.cpp)
crt_registertest(
  TEST_INPLACE  
  INPUT_OBJECT_LIBRARY MyLibrary
  OUTPUT_LIBRARY_NAME MyLibrary_Static
  OUTPUT_LIBRARY_TYPE STATIC
  OUTPUT_TEST_TARGET MyLibraryTest
  TEST_SOURCES lib3_test.cpp lib4_test.cpp 
)
```

This will :
1. First compile your library source files (lib1.cpp and lib2.cpp) as an "object" library. 
2. Create a static or dynamic library from these files (see `OUTPUT_LIBRARY_NAME` and `OUTPUT_LIBRARY_TYPE`). Your source files will be compiled only once.
3. Create an executable test target (MyLibraryTest) for your library.
4. Register it as a cmake test (so that `ctest` or `make test`) will launch it.
5. Append the test library include path to your `TEST_SOURCES`, as well as to the library sources
6. Make sure that all tests are run (whether they are inside the library source files or inside `TEST_SOURCES`)

For an example, see [example_doctest](examples/example_doctest):
* [Main CMakeLists.txt](examples/example_doctest/CMakeLists.txt)
* [Library CMakeLists.txt](examples/example_doctest/MyLibrary/CMakeLists.txt)


## Detailed steps :

### Step 1 : project structure

The structure of your project should resemble the tree shown below:

```
YourProject/
├── CMakeLists.txt
├── YourLibrary/
│   ├── CMakeLists.txt
│   ├── lib1.cpp
│   └── lib2.cpp
├── catch                         
│   ├── catch.hpp                 # Only one of 
├── doctest                       #  catch
│   ├── doctest.h                 #  doctest
├── gtest                         #  or googletest is required
│   ├── include/gtest/gtest.h     
|
└── cmake_registertest/           #  copy or reference cmake_registertest as a submodule at the root of your project
   └──   src
          ├── cpp_runners
          │   ├── catch_dynamic.cpp
          │   ├── catch_main.cpp
          │   ├── doctest_dynamic.cpp
          │   └── doctest_main.cpp
          ├── crt_registertest.cmake
          ├── crt_registertest_catch.cmake
          ├── crt_registertest_doctest.cmake
          └── crt_registertest_googletest.cmake
```


### Step 2 : Modify your main CMakeList.txt file

#### Typical main CMakeList.txt file content (example using doctest)
```cmake
cmake_minimum_required(VERSION 3.0)
project(my_project)
set (crt_test_lib_location ${CMAKE_SOURCE_DIR}/doctest)
include("${CMAKE_SOURCE_DIR}/cmake_registertest/src/crt_registertest_doctest.cmake")
enable_testing()
add_subdirectory(MyLibrary)
```

1. Inside your main `CMakeLists.txt`, set the path to the include path of your test library (catch, doctest or googletest)
Depending upon your test library, include one of the 3 lines below:
```cmake
set (rsl_test_lib_location ${CMAKE_SOURCE_DIR}/catch)
set (rsl_test_lib_location ${CMAKE_SOURCE_DIR}/doctest)
set (rsl_test_lib_location ${CMAKE_SOURCE_DIR}/gtest/include)
```
2. Include the script in your main CMakeLists.txt file
*After* having set `rsl_test_lib_location` include the correct script.Depending upon your test library, include one of the 3 lines below:
```cmake
include("${CMAKE_SOURCE_DIR}/cmake_registertest/src/crt_registertest_catch.cmake")
include("${CMAKE_SOURCE_DIR}/cmake_registertest/src/crt_registertest_googletest.cmake")
include("${CMAKE_SOURCE_DIR}/cmake_registertest/src/crt_registertest_doctest.cmake")
```
3. enable tests for your project
```cmake
enable_testing()
```

### Step 3 : Register tests for your library

in the `CMakeLists.txt` of your library, call `crt_registertest()`


## More info

See the [examples](examples)
