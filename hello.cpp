#include <iostream>
#include <vector>
#include <string>
#include "date.h"
#include "math.h"

using namespace std;

int main()
{
    Date d1 = Date(2020, 6, 3);
    cout << "The year is " << d1.GetYear() << endl;
    cout << "The month is " << d1.GetMonth() << endl;
    cout << "The day is " << d1.GetDay() << endl;
    cout << endl;

    Math m = Math();
    int x = 6;
    int y = 85;
    int sum = m.Add(x, y);
    int product = m.Multiply(x, y);
    cout << "The sum is " << sum << endl;
    cout << "The product is " << product << endl;
}