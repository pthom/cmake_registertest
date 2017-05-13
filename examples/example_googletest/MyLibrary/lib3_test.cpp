// this file is an example of a file that is not part of the library,
// but which can be added as an additionnal source file for the tests
#include <iostream>
#include "gtest/gtest.h"

TEST(TestLib3, Test1) {
    std::cout << "testing in lib3.cpp" << std::endl;
    ASSERT_TRUE((3+6) == 9);
}
