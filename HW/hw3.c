#include <stdio.h>

int arrayAddress( int row, int col, int ncolumns, int array[][ncolumns]){
    int *baseAddress;
    int *arrAddress;
    int *calcAddress;
    int num;
    int i;
    int j;

    baseAddress = &array[0][0];
    arrAddress = &array[row][col];
    num = array[row][col];
    
    printf("base address: %p\n", baseAddress);
    printf("array address: %p\n", arrAddress);
    printf("array value: %d\n", num);
}

int main(){

    int row;
    int column;
    int ncolumns = 5;
    int address;

    int arr[3][5] = {
        {1, 2, 3, 4, 5},
        {6, 7, 8, 9, 10},
        {11, 12, 13, 14, 15}
    };

    printf("Please enter rown and column: ");
    scanf("%d %d", &row, &column);
 
    printf("row: %d, column: %d\n", row, column);

    address = arrayAddress(row, column, ncolumns, arr);

    return 0;
}