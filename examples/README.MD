
*Note:* in order to build the googletest examples, you need to retrieve its source code.

Use this command:
```
git submodule update --init
```

##### Example 1 : test code in separate source files

[example_doctest_outertests](example_doctest_outertests)

##### Example 2 : test code inside the library source files as well as separate source files

* [example_catch](example_catch)
* [example_doctest](example_doctest)
* [example_googletest](example_googletest)


##### Bare examples

The examples below do not use the `*crt_registertest`() function. 

They demonstrate the techniques that this project use, directly inside the library `CMakeList.txt` file.

* [example_catch_raw](example_catch_raw)
* [example_doctest_raw](example_doctest_raw)
* [example_googletest_raw](example_googletest_raw)
