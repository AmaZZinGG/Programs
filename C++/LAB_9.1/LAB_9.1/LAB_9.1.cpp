#include<stdio.h>
//#include<windows.h>
#include<iostream>
//#include <fstream>
#include <math.h>
#include <stdarg.h>




double OK(double first, ...)//first - количество переменных в функции
{// ap - указатель
    va_list ap; //Указатель на список параметров
    va_start(ap, first);//перемещает указатель
    double x;// считанный параметр
    double i = 0;
    double max = 0;
    while (i < first)
    {
        x = va_arg(ap, double);// к x приравниваем первый элемент
        if (abs(max) < abs(x))
            max = x;
        i++;
    }

    va_end(ap);// закрываем список
    return max;
}




int main()
{
    double a = 100.0;
    double b = 100000.0;
    double c = -300.0;
    printf("%lf", OK(6.0, -100.0, 123.0, c, 50000.0, b, 70000));
}