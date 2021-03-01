#include "iostream"
#include "stdio.h"
#include "math.h"
#include "stdlib.h"
int chet_nechet(int Arr[], int m, int* fncht, int* pr) {
    int j = 0;
    int chetn = 0;
    for (j = 0; j < m; j++) {
        if (Arr[j] % (*pr) == 0) {
            if (Arr[j] % 2 == 0) {
                chetn++;
            }
            else {
                (*fncht)++;

            }
        }
    }
    return chetn;
}

int main() {
    int i = 0;//Обычный счётчик
    int k = 0;// Количество элементов в массиве
    int par = 0; // Параметр
    int nechet = 0;
    int chet = 0;
    printf("Vvedite kolichestvo elementov v massive\n");
    scanf("%d", &k);
    int* arr = NULL;
    printf("Vvedite elementi massiva\n");
    arr = (int*)malloc(k * sizeof(int));
    while (i < k) {
        scanf("%d", &arr[i]);
        i++;
    }
    printf("Vvedite parametr\n");
    scanf("%d", &par);
    int (*operation)(int a[], int b, int* c, int* d);
    operation = chet_nechet;
    chet = operation(arr, k, &nechet, &par);
    printf("Kolichestvo chetnix chisel delyachixsya na parametr\n");
    printf("%d", chet);
    printf("\nKolichestvo nechetnix chisel delyachixsya na parametr \n");
    printf("%d", nechet);
    free(arr);
    return 0;
}




































#include <stdio.h>
#include <stdlib.h>
#include <math.h>
double** massiv2x2(int rows, int cols) {
    int i;
    double** matrix = (double**)calloc(rows, sizeof(double));
    for (i = 0; i < rows; i++) {
        matrix[i] = (double*)calloc(cols, sizeof(double));
    }
    return matrix;
}

void free_massiv(double** matrix, int cols, int rows) {
    int i;
    for (i = 0; i < rows; i++) {
        free(matrix[i]);
    }
    free(matrix);

}

double* Vektor(double** A, int n)
{
    double* resultArray = (double*)malloc(n * sizeof(double));
    for (int i = 0; i < n; i++)
    {
        resultArray[i] = 1;
        for (int j = 0; j < n; j++) {
            resultArray[i] *= A[i][j];
        }
    }
    return resultArray;
}
int main() {
    int i;
    int j;
    int rows;
    int cols;
    printf("Vvedite kolichestvo strok\n");
    scanf("%d", &rows);
    printf("Vvedite kolichestvo stolbcov\n");
    scanf("%d", &cols);
    double** arr;
    arr = massiv2x2(rows, cols);
    printf("Vvedite elementi massiva\n");
    for (i = 0; i < rows; i++) {
        for (j = 0; j < cols; j++) {
            scanf("%lf", &arr[i][j]);
        }
    }
    for (i = 0; i < rows; i++) {
        for (j = 0; j < cols; j++) {
            printf("%f ", arr[i][j]);
        }
        printf("\n");
    }
    double* vector = NULL;
    vector = (double*)malloc(rows * sizeof(double));
    vector = Vektor(arr, rows);
    printf("\nVEKTOR STROKA\n");
    for (i = 0; i < rows; i++) {
        printf("%f ", vector[i]);
    }



    free_massiv(arr, cols, rows);
    free(vector);
    return 0;
}























#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double* initArray(double** A, int n, int m)
{
    double* resultArray = (double*)malloc(n * sizeof(double));
    for (int i = 0; i < n; i++)
    {
        resultArray[i] = 1;
        for (int j = 0; j < m; j++)
            resultArray[i] *= A[i][j];
    }
    return resultArray;
}

int main()
{
    int N = 3;
    int M = 4;
    double** matrix;
    matrix = (double**)malloc(N * sizeof(double*));
    for (int i = 0; i < N; i++)
    {
        matrix[i] = (double*)malloc(M * sizeof(double));
        for (int j = 0; j < M; j++)
            matrix[i][j] = rand() % 10;

    }
    double* res = initArray(matrix, N, M);

    printf("Hello World\n");
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < M; j++)
            printf("%lf ", matrix[i][j]);
        printf("\n");

    }
    printf("\n");

    for (int i = 0; i < N; i++)
    {
        printf("%lf ", res[i]);
    }

    return 0;
}