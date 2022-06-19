#include <stdio.h>

int main(void){

    printf("This is for the first commit.\n");
    printf("This is for the second commit.\n");

    
    int num1, num2, sum;

    printf("Please enter two numbers:\n");
    scanf("%d %d\n", &num1, &num2);

    sum = num1 + num2;

    printf("The sum of these two number is %d\n", sum);
    printf("If this works then I understand Git to a certain degree.\n");
    printf("This is a test to see if pushing to GitHub worked or not.\n");

    return 0;
}