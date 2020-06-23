#include "date.h"

Date::Date(int year, int month, int day)
{
    _year = year;
    _month = month;
    _day = day;
}

int Date::GetYear()
{
    return _year;
}

int Date::GetMonth()
{
    return _month;
}

int Date::GetDay()
{
    return _day;
}