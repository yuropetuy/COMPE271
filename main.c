#include <stdio.h>
#include <windows.h>
#include <stdlib.h>
#include <conio.h>
#include <time.h>

#define N 10
#define M 40

int i,j;
int x,y;
int car;
int field[N][M];

void generateField(){

    //empty field
    for(i = 0; i < N; i++){
        for(j = 0; j < M; j++){
            field[i][j] = 0;
        }
    }

    //where the car is
    x = N/2;
    y = M/2;
    car = 1;

    field[x][y] = car;
}

void print(){

    //top row
    for(i = 0; i < M+1; i++){
        if (i==0)
            printf("%c", 201);
        else if (i==M)
            printf("%c",187);
        else
            printf("%c", 205);
    }

    printf("\n");
    
    //middle rows
    for(i = 0; i < N; i ++){
        printf("%c", 186);
        for(j = 0; j < M-1; j++){
            if(field[i][j] == 0)
                printf("~");
            else if(field[i][j] == car)
                printf("0");
        }
        printf("%c\n", 186);
    }

    //bottom row
    for(i = 0; i < M+1; i ++){
        if (i ==0)
            printf("%c", 200);
        else if (i==M)
            printf("%c", 188);
        else
            printf("%c", 205);
    }
}

int main(){

    generateField();

    print();

    return 0;
}