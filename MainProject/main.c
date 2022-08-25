#include <stdio.h>
#include <windows.h>
#include <stdlib.h>
#include <time.h>

#define N 10
#define M 40

int i,j;
int x,y;
int car;
int game;
int var;
int field[N][M];
int obstacle;

char input;

struct Car{
    int front;
    int back;
} Car;

struct Car car1;

//Change the size of the car to be at least 2 or 4 spaces
void generateField(){

    //empty field
    for(i = 0; i < N; i++){
        for(j = 0; j < M; j++){
            field[i][j] = 0;
        }
    }

    //where the car is
    x = N/2;
    y = 4;
    car1.front = 1;
    car1.back = 1;

    field[x][y] = car1.front;
    field[x-1][y] = car1.back;

    int obstacle = randomize();

    field[0][obstacle] = 2;

    //game loop status
    game = 0;
}

void print(){

    printf("\n");

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
            else if(field[i][j] == 1)
                printf("0");
            else if(field[i][j] == 2)
                printf("x");
        }
        printf("%c\n", 186);
    }

    //bottom row
    for(i = 0; i < M+1; i ++){
        if (i ==0)
            printf("%c", 200);
        else if (i==M)
            printf("%c\n", 188);
        else
            printf("%c", 205);
    }

    printf("Input Direction (W, A, S, D): ");
}

void movement(char input){

    switch(input){
        case 'd' :
        y++;
        field[x][y] = 1;
        field[x-1][y] = 1;
        field[x][y-1] = 0;
        field[x-1][y-1] = 0;
        break;

        case 'a' :
        y--;
        field[x][y] = 1;
        field[x-1][y] = 1;
        field[x][y+1] = 0;
        field[x-1][y+1] = 0;
        break;

        case 's' :
        x++;
        field[x][y] = 1;
        field[x-1][y] = 1;
        field[x-2][y] = 0;
        break;

        case 'w' :
        x--;
        field[x][y] = 1;
        field[x-1][y] = 1;
        field[x+1][y] = 0;
        break;

        case 'p' :
        game = 1;
        break;

    
    }

    system("clear");
}


int randomize(){
    time_t t;

    srand((unsigned) time(&t));

    return rand() % N;
}

int main(){

    //generate field and car sprite
    generateField();
    
    //game loop
    while(game == 0){
        //display items
        print();

        scanf("%c", &input);

        movement(input);   
    }
    

    printf("Game Ended.\n");

    return 0;
}