// this file is an example of a file that is not part of the library,
// but which can be added as an additionnal source file for the tests
#include <iostream>
#include "doctest.h"

TEST_CASE("testing in lib3_test.cpp") {
    std::cout << "testing in lib4.cpp" << std::endl;
    CHECK((51+49) == 100);
}
