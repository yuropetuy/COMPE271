#include <stdio.h>
#include <windows.h>
#include <stdlib.h>
#include <conio.h>
#include <time.h>

#define N 20
#define M 60

int i,j;
int Field[N][M];
int x, y, gy, head, tail;
int game;
int var;
int direction;

void initializeSnake(){

    for(i=0; i < N; i++){
        for(j=0; j < M; j++){
            Field[i][j] = 0;
        }
    }

    x = N/2;
    y = M/2;

    head = 5;
    tail = 1;
    gy = y;

    game = 0;

    for(i=0; i < head; i++){
        gy++;
        Field[x][gy- head] = i + 1;
    }
}

void print(){
   
    /*
    printf("ascii 201: %c\n", 201);
    printf("ascii 187: %c\n", 187);
    printf("ascii 205: %c\n", 205);
    printf("ascii 186: %c\n", 186);
    printf("ascii 200: %c\n", 200);
    printf("ascii 188: %c\n", 188);
    */

    //Top Row
    for(i = 0; i < M+1; i++){
        if (i==0)
            printf("%c", 201);
        else if (i==M)
            printf("%c",187);
        else
            printf("%c", 205);
    }

    printf("\n");

    //Middle Rows
    for(i = 0; i < N; i++){
        printf("%c", 186);
        for(j = 0; j < M -1; j++){
            if (Field[i][j]==0) 
                printf(" ");
            if (Field[i][j] > 0 && Field[i][j] != head)
                printf("%c", 176);
            if (Field[i][j] == head)
                printf("%c", 178);

            /*
            if (j == M - 1)
                printf("%c\n", 186);
            */
    }
    printf("%c\n", 186);
    }

    //Bottom Row
    for(i = 0; i < M+1; i++){
        if (i==0)
            printf("%c", 200);
        else if(i == M)
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
    position.Y = 0;

    SetConsoleCursorPosition(hOut, position);
    
  
}

int getchar_noblock(){
    if(_kbhit())
        return _getch();
}

void movement(){
    var = getchar_noblock();
    var = tolower(var);

    /*
    if(var == 'd' || var == 'a' || var == 'w' || var == 's')
        direction = var;
    */ 

    //Movement Controls
    if(var == 'd'){
        y++;
        head++;
        Field[x][y] = head;
    }
    else if(var == 'a'){
        y--;
        head++;
        Field[x][y] = head;
    }
    else if(var == 's'){
        x++;
        head++;
        Field[x][y] = head;
    }
    else if(var == 'w'){
        x--;
        head++;
        Field[x][y] = head;
    }
    
    //Game End Button
    else if(var == 'p'){
        game = 1;
    }
    
}


void TailFollow(){
    for(i=0; i<N;i++){
        for(j=0; j<M;j++){
            if(Field[i][j] == tail)
                Field[i][j] == 0;            
        }
    }
    tail++;
}



int main(){

    //Spawn snake
    initializeSnake();

    while(game == 0){
        //Print function for the game
        print();
        ResetScreenPosition();
        movement();
        //TailFollow();
        //sleep(99);
    }

    printf("Game ended.\n");

    return 0;
}