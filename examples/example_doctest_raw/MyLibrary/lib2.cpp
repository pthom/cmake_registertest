#define DEBUG
#include <iostream>
#include "doctest.h"

TEST_CASE("testing in lib2.cpp") {
    std::cout << "testing in lib2.cpp" << std::endl;
    CHECK((1+1) == 2);
}
