#ifndef DATE_H
#define DATE_H

class Date
{
private:
    int _year;
    int _month;
    int _day;

public:
    Date(int year, int month, int day);
    int GetYear();
    int GetMonth();
    int GetDay();
};

#endif