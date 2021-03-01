// LAB_5.1.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
using namespace std;
//Чтение массива из файл
int* read_file(char* address, size_t* len) {
    FILE* f_in;
    int* arr = 0;
    f_in = fopen(address, "r");
    if (f_in != 0) {
        fscanf(f_in, "%d", len);
        size_t i = 0;
        arr = (int*)calloc(*len, sizeof(int));
        while (i < *len) {
            fscanf(f_in, "%d", &arr[i]);
            i++;
        }
        fclose(f_in);
    }
    return arr;
}
//Запись массива в файл
int write_to_file(char* address, int* arr, size_t len) {
    FILE* f_out;
    f_out = fopen(address, "w");
    if (f_out != 0)
    {
        // fprintf(f_out, "%d", len);
        size_t i = 0;
        while (i < len)
        {
            fprintf(f_out, " %d", arr[i]);
            i++;
        }
        fclose(f_out);
        //всё хорошо - вернули 1
        return 1;
    }

    //если мы здесь - записать в файл не удалось
    return 0;
}

void vibor(int Arr[], int n) {
    int min = 0;
    int i = 0;
    int j = 0;// обычный счётчик
    int z = 0;// третья переменная для свап
    for (j = 0; j < n; j++) {
        min = j;
        for (i = j; i < n; i++) {
            if (Arr[i] < Arr[min]) {
                min = i;
            }
        }
        z = Arr[min];
        Arr[min] = Arr[j];
        Arr[j] = z;

    }
}
void sliyanie(int Mass[], int p) {
    int n1 = p / 2;
    int n2 = (p + 1) / 2;
    int mass1[n1];
    int mass2[n2];
    int j;
    for (j = 0; j < n1; j++)
        mass1[j] = Mass[j];
    for (j = 0; j < n2; j++)
        mass2[j] = Mass[j + n1];
    if (n1 > 1)
        sliyanie(mass1, n1);
    if (n2 > 1)
        sliyanie(mass2, n2);
    int i = 0;
    j = 0;
    while (i + j < p)
    {
        if (mass1[i] < mass2[j])
        {
            Mass[i + j] = mass1[i];
            i++;
            if (i == n1)
                while (i + j < p)
                {
                    Mass[i + j] = mass2[j];
                    j++;
                }
        }
        else
        {
            Mass[i + j] = mass2[j];
            j++;
            if (j == n2)
                while (i + j < p)
                {
                    Mass[i + j] = mass1[i];
                    i++;
                }
        }

    }



}
int main() {
    char file_in_path[] = "C:\\Users\\User\\Desktop\\LABA5\\MASS_in.txt";
    char file_out_path[] = "C:\\Users\\User\\Desktop\\LABA5\\MASS_out.txt";
    int n = 0;
    int k = 0;
    int* arr;
    int* brr;
    size_t len;
    size_t i = 0;
    char c;
    //читаем массив из входного файла
    arr = read_file(file_in_path, &len);
    if (arr == 0)
    {
        printf("\nCouldn't read file. Closing...");
        return 0;
    }
    printf("Array from file: \n");
    for (i = 0; i < len; i++)
        printf("%d ", arr[i]);
    printf("\n");
    brr = read_file(file_in_path, &len);
    clock_t begin2 = clock();
    sliyanie(arr, len);
    clock_t end2 = clock() - begin2;
    printf("\nSortirovka sliyniem\n");
    while (k < len)
    {
        printf("%d ", arr[k]);
        k++;
    }
    clock_t begin1 = clock();
    vibor(brr, len);
    clock_t end1 = clock() - begin1;

    printf("\nSortirovka viborom\n");
    while (n < len)
    {
        printf("%d ", brr[n]);
        n++;
    }
    //пишем результат в выходной файл
    printf("\nWrite attempt: %d", write_to_file(file_out_path, arr, len));
    // printf("\nWrite attempt: %d", write_to_file(file_out_path, 0, 0));
    printf("\nWrite attempt: %d", write_to_file(file_out_path, brr, len));
    printf("\n");
    printf("\nVibor %d", end1);
    printf("\nSlyanie %d", end2);
    // не забываем освобождать память
    if (arr != 0)
        free(arr);
    if (brr != 0)
        free(brr);
    return 0;
}





// Запуск программы: CTRL+F5 или меню "Отладка" > "Запуск без отладки"
// Отладка программы: F5 или меню "Отладка" > "Запустить отладку"

// Советы по началу работы 
//   1. В окне обозревателя решений можно добавлять файлы и управлять ими.
//   2. В окне Team Explorer можно подключиться к системе управления версиями.
//   3. В окне "Выходные данные" можно просматривать выходные данные сборки и другие сообщения.
//   4. В окне "Список ошибок" можно просматривать ошибки.
//   5. Последовательно выберите пункты меню "Проект" > "Добавить новый элемент", чтобы создать файлы кода, или "Проект" > "Добавить существующий элемент", чтобы добавить в проект существующие файлы кода.
//   6. Чтобы снова открыть этот проект позже, выберите пункты меню "Файл" > "Открыть" > "Проект" и выберите SLN-файл.
