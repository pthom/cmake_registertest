#include <iostream>
#include "gtest/gtest.h"

TEST(TestLib2, Test1) {
    std::cout << "testing in lib2.cpp" << std::endl;
    ASSERT_TRUE((1+1) == 2);
}
