#include <stdio.h>
#include <stdlib.h>

int lfsr(int n){
    //int* newNum;
    
    //newNum = (int*) malloc(8 * sizeof(int));

    int i;
    unsigned int bit;
    unsigned int lfsr = n;

    for(i = 0; i < 32; i++){
        bit = 0;
        bit = ((lfsr >> 0) ^ (lfsr >> 10)) & 1;
        bit = (bit ^ (lfsr >> 30)) & 1;
        bit = (bit ^ (lfsr >> 31)) & 1;
        lfsr = (lfsr >> 1) | (bit << 31);
        //newNum[i] = bit;
        printf("%d", bit); 
        //printf("next state: %X\n", lfsr);
    }
    
    printf("\n");

    return lfsr;
}

int main() {
    int initialSeed = 0x55AAFF00;
    int newSeed;
    int i;

    printf("\nStarting Seed: %X\n", initialSeed);

    for(i = 1; i < 11; i++){
        printf("Random Number %d: ", i);
        newSeed = lfsr(initialSeed);
        //printf("\nNew Seed: %X\n", newSeed);
        initialSeed = newSeed;
    }

    return 0;
}

