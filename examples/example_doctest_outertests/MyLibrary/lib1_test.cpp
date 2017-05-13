#include <iostream>
#include "doctest.h"
#include "lib1.h"

TEST_CASE("testing the factorial function") {
  std::cout << "testing in lib1.cpp" << std::endl;
  CHECK(factorial(1) == 1);
  CHECK(factorial(2) == 2);
  CHECK(factorial(10) == 3628800);
}
