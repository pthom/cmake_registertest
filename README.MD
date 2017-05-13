# Cmake Register Test for libraries (crt)

This is a set of cmake utilites in order to make it easy to add unit tests to a C++ library, when using googletest, catch or doctest.

It provides a cmake function `crt_registertest()` with the following features :

* Automatic discovery of the tests (even inside the library source files)
* `target_include_directories([catch|googletest|doctest])`
* add an executable target for the tests, and register it with ctest
* link the test target with the test library and provide an approriate main() function

----
## Motto : 
Tests code should be able to reside inside separate source files, *as well as directly inside the library source files*

The [doctest](https://github.com/onqtam/doctest) documentation says rightfully:

> Tests can be considered a form of documentation and should be able to reside near the production code which they test.

Unfortunately, the self-registration of the tests does not work as desired when their code is inside the library source code: your tests might not be launched at all! This is due to the fact that the linker often strips the self-registration code when it is inside a library.

For a more thorough explanation, see:
* [Catch : "issue 421 - Document How to make Catch tests in a library be found"](https://github.com/philsquared/Catch/issues/421) 
* [Doctest: issue 21 - Tests inside a static library](https://github.com/onqtam/doctest/issues/21)
* [Googletest primer : important-note-for-visual-c-users](https://github.com/google/googletest/blob/master/googletest/docs/Primer.md#important-note-for-visual-c-users>)

This project provides a solution that enables to have tests both inside the library sources, as well as inside separate source files.

----


## Platforms
This project was tested under OSX, Windows and Linux

## Requirements
* [googletest](https://github.com/google/googletest), [catch](https://github.com/philsquared/Catch), or [doctest](https://github.com/onqtam/doctest)
* cmake

## Quick usage instructions

`src/crt_registerstaticlibrary.cmake` provides a `crt_registertest`()` functions that make it possible to add tests to a library, using a one-liner instruction in your `CMakeList.txt` file.

For example :
```cmake
add_library(MyLibrary_Object OBJECT lib1.cpp lib2.cpp)
crt_registertest(
  INPUT_OBJECT_LIBRARY MyLibrary_Object
  OUTPUT_LIBRARY_NAME MyLibrary_Static
  OUTPUT_LIBRARY_TYPE STATIC
  OUTPUT_TEST_TARGET MyLibraryTest
  TEST_SOURCES lib3_test.cpp lib4_test.cpp 
)
```

This one-liner will :
1. ensure that *all* tests are actually run 
2. append the test include path to your library
3. create an executable test target (MyLibraryTest) for your library
4. register it as a cmake test (so that `ctest` or `make test`) will launch it.



## Detailed steps :

#### Step 1 : include cmake_registertest in your project as well as your test library

For example (with catch)
* copy [catch.hpp](https://raw.githubusercontent.com/philsquared/Catch/master/single_include/catch.hpp) into your project/catch folder
* copy [cmake_registertest](https://github.com/pthom/cmake_registertest) at the root of your project, such as shown below:
```
YourProject/
├── CMakeLists.txt
├── YourLibrary/
│   ├── CMakeLists.txt
│   ├── lib1.cpp
│   └── lib2.cpp
├── catch
│   ├── catch.hpp
└── cmake_registertest/
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

#### Step 2 : Set your test library path:

Inside your main `CMakeLists.txt`, set the path to the include path of your test library (catch, doctest or googletest)
For example:
```
set (rsl_test_lib_location ${CMAKE_SOURCE_DIR}/catch)
```

#### Step 3 : Include the script in your main CMakeLists.txt file
*After* having set `rsl_test_lib_location` include the correct script.
For catch :
```
include("${CMAKE_SOURCE_DIR}/cmake_registertest/src/crt_registertest_catch.cmake")
````
For googletest :
```
include("${CMAKE_SOURCE_DIR}/cmake_registertest/src/crt_registertest_googletest.cmake")
````
For doctest :
```
include("${CMAKE_SOURCE_DIR}/cmake_registertest/src/crt_registertest_doctest.cmake")
````


#### Step 4 : enable tests for your project
Enable tests in cmake, by adding the following line to your project's main `CMakeLists.txt` file:

```
enable_testing()
```

### Step 5 : Register tests for your library

in the `CMakeLists.txt` of your library, call crt_registertest()


## detailed information about crt_registertest()  

