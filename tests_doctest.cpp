#include "date.h"
#include "math.h"

#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "doctest.h"

TEST_SUITE("Math tests")
{
    TEST_CASE("Can add two numbers")
    {
        Math m = Math();
        int result = m.Add(4, 7);
        int expectedResult = 11;
        CHECK_EQ(result, expectedResult);
    }

    TEST_CASE("Can multiply two numbers")
    {
        Math m = Math();
        int result = m.Multiply(11, 2);
        int expectedResult = 22;
        CHECK_EQ(result, expectedResult);
    }
}

TEST_SUITE("Date tests")
{
    TEST_CASE("Can get the year properly")
    {
        Date d = Date(2020, 1, 2);
        int result = d.GetYear();
        int expectedResult = 2020;
        CHECK_EQ(result, expectedResult);
    }
}
