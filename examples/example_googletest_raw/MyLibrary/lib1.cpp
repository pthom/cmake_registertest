#include <iostream>
#include "gtest/gtest.h"

int factorial(int number) { return number <= 1 ? number : factorial(number - 1) * number; }

TEST(TestLib1, Test1) {
  std::cout << "testing in lib1.cpp" << std::endl;
  ASSERT_TRUE(factorial(1) == 1);
  ASSERT_TRUE(factorial(2) == 2);
  ASSERT_TRUE(factorial(10) == 3628800);
}
