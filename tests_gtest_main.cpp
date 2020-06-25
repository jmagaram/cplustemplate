#include "gtest/gtest.h"
#include "date.h"
#include "math.h"

// Very often your tests do NOT need their own main() function. The GTest framework
// will supply a main() if you link to the GTest "main" library. This .cpp is an
// example of how to add GTest to a program you've written that already has a main().
int main(int argc, char **argv){

    // Include these lines as explained in
    // https://github.com/google/googletest/blob/master/googletest/docs/primer.md
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

namespace
{
    TEST(Math, SixPlusNineIsFifteen)
    {
        Math m = Math();
        int result = m.Add(6, 9);
        int expectedResult = 15;
        EXPECT_EQ(result, expectedResult);
    }

    TEST(Math, TenTimesZeroIsZero)
    {
        Math m = Math();
        int result = m.Multiply(10, 0);
        int expectedResult = 0;
        EXPECT_EQ(result, expectedResult);
    }

    TEST(Date, CanGetTheMonthProperly)
    {
        Date d = Date(2020, 1, 2);
        int result = d.GetMonth();
        int expectedResult = 1;
        EXPECT_EQ(result, expectedResult);
    }

} // namespace