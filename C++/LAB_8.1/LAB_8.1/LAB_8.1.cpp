#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <fstream>
#include <cstdio>
#include <string>
using namespace std;
#define MAX_LENGTH 256
struct buyer {
    string first_name; //имя
    string second_name; // Фамилия
    string cc;// Город
    string ss;//улица
    int house_number;// номер дома
    int appartament_number;// номер квартиры
    int code_number;// номер счёта

};


void add(buyer first[], int* N, string first_name, string second_name, string city, string street, int house_number, int appartament_number, int code_number)
{
    int n = *N;
    if (n == 0)
    {

        first[0].first_name = first_name;
        first[0].second_name = second_name;
        first[0].cc = city;
        first[0].ss = street;

        first[0].house_number = house_number;
        first[0].appartament_number = appartament_number;
        first[0].code_number = code_number;
    }
    else
    {
        first[n].first_name = first_name;
        first[n].second_name = second_name;
        first[n].cc = city;
        first[n].ss = street;

        first[n].house_number = house_number;
        first[n].appartament_number = appartament_number;
        first[n].code_number = code_number;

        buyer c;
        while (first[(n - 1) / 2].code_number < first[n].code_number)
        {
            c = first[n];
            first[n] = first[(n - 1) / 2];
            first[(n - 1) / 2] = c;
            n = (n - 1) / 2;
            if (n == 0)break;
        }


    }
    (*N)++;

}

void remove(buyer first[], int* N, int i) {
    int n = *N;
    first[i] = first[n - 1];
    int j = i;
    if (j >= 0)
    {

        buyer c;
        while (first[(j - 1) / 2].code_number < first[j].code_number)
        {
            c = first[j];
            first[j] = first[(j - 1) / 2];
            first[(j - 1) / 2] = c;
            j = (j - 1) / 2;
            if (j == 0)break;
        }
        int max = i;

        while (i < n)
        {

            if (i * 2 + 1 < n)
            {

                if (first[i * 2 + 1].code_number > first[i].code_number)
                    max = i * 2 + 1;
                if (i * 2 + 2 < n)
                    if (first[i * 2 + 2].code_number > first[max].code_number)
                        max = i * 2 + 2;
                if (max != i)
                {
                    c = first[i];
                    first[i] = first[max];
                    first[max] = c;
                    i = max;
                }
                else
                    break;




            }
            else
                break;
        }
    }
    (*N)--;
}

int flag = 0;


void GO(buyer first[], int N, int i, int code_number)
{
    if (flag == 0)
    {
        if (N > 0)
            if (first[i].code_number == code_number)
            {
                flag = 1;
                cout << "code_number = " << code_number << " NAIDENO! v Pozicii = " << i;
            }
            else
            {
                if (2 * i + 1 < N)GO(first, N, 2 * i + 1, code_number);
                if (2 * i + 2 < N)GO(first, N, 2 * i + 2, code_number);
            }
    }
}

void find(buyer first[], int N, int code_number)
{
    int i = 0;
    flag = 0;
    if (N > 0)
        if (first[0].code_number == code_number)
        {
            flag = 1;
            cout << "code_number = " << code_number << " NAIDENO! v Pozicii = 0";
        }
        else
        {
            if (2 * i + 1 < N)GO(first, N, 2 * i + 1, code_number);
            if (2 * i + 2 < N)GO(first, N, 2 * i + 2, code_number);
        }

    if (flag == 0)
        cout << "NE NAIDENO!";
    else flag == 0;
    cout << "\n";

}


void write(buyer first[], int n)
{

    int i = 0;
    while (i < n) {
        cout << first[i].first_name << " " << first[i].second_name << " " << first[i].cc << " " << first[i].ss << " " << first[i].house_number << " " << first[i].appartament_number << " " << first[i].code_number << "\n";
        i++;
    }
}

void filter(buyer first[], buyer second[], int n, int* N, string city)
{
    int i = 0;
    (*N) = n;
    while (i < (*N))
    {
        second[i] = first[i];
        i++;
    }
    i = 0;
    while (i < (*N))
    {
        if (second[i].cc != city)
        {
            //write(second,(*N));
            remove(second, N, i);
            // cout<<"_&&&&&&&&&&&&&&&&&&&\n";
             //write(second,(*N));
             //cout<<"!!!\n";
            i = 0;

        }
        else i++;
    }
}


void write_to_file(char* address, buyer first[], int N) {
    FILE* f_out;
    f_out = fopen(address, "w");
    if (f_out != 0) {
        int i = 0;
        while (i < N) {
            fprintf(f_out, "%s\n", (first[i].first_name).c_str());
            fprintf(f_out, "%s\n", (first[i].second_name).c_str());
            fprintf(f_out, "%s\n", (first[i].cc).c_str());
            fprintf(f_out, "%s\n", (first[i].ss).c_str());
            fprintf(f_out, "%d\n", first[i].house_number);
            fprintf(f_out, "%d\n", first[i].appartament_number);
            fprintf(f_out, "%d\n", first[i].code_number);
            i++;

        }
        fclose(f_out);
        //âñ¸ õîðîøî - âåðíóëè 1

    }
}

void read_file(char* address, buyer first[], int* N) {
    FILE* f_in;
    char A[222];
    string first_name;
    string second_name;
    string cc;
    string ss;
    int house_number;
    int appartament_number;
    int code_number;
    f_in = fopen(address, "r");
    if (f_in != 0) {
        while (!(feof(f_in))) {
            fgets(A, MAX_LENGTH, f_in);
            first_name = string(A);
            first_name = first_name.substr(0, first_name.length() - 1);
            fgets(A, MAX_LENGTH, f_in);

            second_name = string(A);
            second_name = second_name.substr(0, second_name.length() - 1);

            fgets(A, MAX_LENGTH, f_in);
            cc = string(A);
            cc = cc.substr(0, cc.length() - 1);
            fgets(A, MAX_LENGTH, f_in);
            ss = string(A);
            ss = ss.substr(0, ss.length() - 1);

            fgets(A, MAX_LENGTH, f_in);
            house_number = stoi(string(A));
            fgets(A, MAX_LENGTH, f_in);
            appartament_number = stoi(string(A));
            fgets(A, MAX_LENGTH, f_in);
            code_number = stoi(string(A));

            add(first, N, first_name, second_name, cc, ss, house_number, appartament_number, code_number);


        }
        fclose(f_in);
    }

}






int main() {

    char file_in_path[] = "C:\\Users\\User\\Desktop\\LABA8\\tree_in.txt";
    char file_out_path[] = "C:\\Users\\User\\Desktop\\LABA8\\tree_out.txt";

    buyer A[1000];
    buyer B[1000];
    int n = 0;


    read_file(file_in_path, A, &n);

    // write(A,n);


    add(A, &n, "PETR", "PERVII", "mosc", "CYMCKAIA1", 1, 222222, 7);
    add(A, &n, "ALEKSANR", "PERVII", "mosc", "CYMCKAIA1", 1, 222222, 3);
    add(A, &n, "IVAN", "GROZNII", "piter", "CYMCKAIA1", 1, 222222, 6);
    add(A, &n, "NIKOLAI", "VTOROI", "mosc", "CYMCKAIA1", 1, 222222, 1);
    add(A, &n, "ELIZAVETA", "PETROVNA", "mosc", "CYMCKAIA1", 1, 222222, 2);
    add(A, &n, "EKATERINA", "VTORAYA", "mosc", "CYMCKAIA1", 1, 222222, 4);

    write(A, n);
    //remove(A,&n,3);
        //cout<<"\n";
    printf("________\n");
    find(A, n, 7);
    printf("________\n");

    int N;

    filter(A, B, n, &N, "mosc");
    // remove(A,&n,0);
    printf("\nPROSTO SPISOK________\n");
    write(A, n);
    printf("\nfilter_________\n");
    write(B, N);


    write_to_file(file_out_path, A, n);
    delete[]A;
    delete[]B;
    return 0;
}