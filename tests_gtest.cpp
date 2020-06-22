#include "gtest/gtest.h"
#include "date.h"
#include "math.h"

namespace
{
    TEST(Math, CanAddTwoNumbers)
    {
        Math m = Math();
        int result = m.Add(4, 7);
        int expectedResult = 11;
        EXPECT_EQ(result, expectedResult);
    }

    TEST(Math, CanMultiplyTwoNumbers)
    {
        Math m = Math();
        int result = m.Multiply(11, 2);
        int expectedResult = 22;
        EXPECT_EQ(result, expectedResult);
    }

    TEST(Date, CanGetTheYearProperly)
    {
        Date d = Date(2020, 1, 2);
        int result = d.GetYear();
        int expectedResult = 2020;
        EXPECT_EQ(result, expectedResult);
    }

} // namespace