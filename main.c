#include <stdio.h>

#define N 40
#define M 90

int i,j;


void print(){
    for(i = 0; i < M+1; i++){
        if (i==0)
            printf("%c", 201);
        else if (i==M)
            printf("%c",187);
        else
            printf("%c", 205);
    }
}

int main(){

    print();

    return 0;
}