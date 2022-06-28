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
int game;
int var;
int field[N][M];


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
    y = M/2;
    car = 1;

    field[x][y] = car;

    //game loop status
    game = 0;
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
            else if(field[i][j] != 0)
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

void ResetScreenPosition(){
    
    HANDLE hOut;
    COORD position;

    hOut = GetStdHandle(STD_OUTPUT_HANDLE);

    position.X = 0;
    position.Y = 2;

    SetConsoleCursorPosition(hOut, position);
     
}

int getchar_noblock(){
    if(_kbhit())
        return _getch();
}

void movement(){
    var = getchar_noblock();
    var = tolower(var);

    //Movement Controls (W, A, S, D) (P ends the game)
    if(var == 'd'){
        y++;
        field[x][y-1] = 0;
        car++;
        field[x][y] = car;
    }
    else if(var == 'a'){
        y--;
        field[x][y+1] = 0;
        car++;
        field[x][y] = car;
    }
    else if(var == 's'){
        x++;
        field[x-1][y] = 0;
        car++;
        field[x][y] = car;
    }
    else if(var == 'w'){
        x--;
        field[x+1][y] = 0;
        car++;
        field[x][y] = car;
    }
    
    //Game End Button
    else if(var == 'p'){
        game = 1;
    }
    
}

//Random generation for the objects to spawn and avoid
/*
void random(){

}
*/

//Function to spawn obstacles from the top of the play area and scroll downward over time
/*
void spawnObjects(){

}
*/

int main(){

    //generate field and car sprite
    generateField();

    //game loop
    while(game == 0){
        //display items
        print();
        ResetScreenPosition();
        movement();
    }

    printf("Game Ended.\n");

    return 0;
}