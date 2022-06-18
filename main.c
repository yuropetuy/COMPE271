#include <stdio.h>

int main(void){

    int num1, num2, sum;

    printf("Please enter two numbers:\n");
    scanf("%d %d\n", &num1, &num2);

    sum = num1 + num2;

    printf("The sum of these two number is %d\n", sum);
    printf("If this works then I understand Git to a certain degree.\n");

    return 0;
}