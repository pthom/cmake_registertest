// this file is an example of a file that is not part of the library,
// but which can be added as an additionnal source file for the tests
#include <iostream>
#include "catch.hpp"

TEST_CASE("testing in lib4_test.cpp") {
    std::cout << "testing in lib4.cpp" << std::endl;
    CHECK((51+49) == 100);
}
