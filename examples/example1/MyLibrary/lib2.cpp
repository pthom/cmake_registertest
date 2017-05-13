#define DEBUG
#include <iostream>
#include "catch.hpp"

TEST_CASE("testing in lib2.cpp") {
    std::cout << "testing in lib2.cpp" << std::endl;
    CHECK((1+1) == 2);
}
