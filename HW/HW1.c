/*********************************************************************
*               SEGGER MICROCONTROLLER GmbH & Co. KG                 *
*       Solutions for real time microcontroller applications         *
**********************************************************************
*                                                                    *
*       (c) 2014 - 2016  SEGGER Microcontroller GmbH & Co. KG        *
*                                                                    *
*       www.segger.com     Support: support@segger.com               *
*                                                                    *
**********************************************************************

-------------------------- END-OF-HEADER -----------------------------

File    : main.c
Purpose : Generic application start
*/

#include <stdio.h>
#include <stdlib.h>

/*********************************************************************
*
*       main()
*
*  Function description
*   Application entry point.
*/

extern float computeArea(int *v1, int *v2, int shape) ; 
extern int numTimesAppears(char *, char) ;

void main(void) {
  int i;
  char mystring[100]="Yusuf Ozturk";
  char ch; 
  float area;
  int  length, height, diameter, base;
 
  int count; 
 
 base = 25;
 length  = 25;
 height  = 10;
 diameter = 5; 
 
  area = computeArea(&base, &height, 1);
  printf("\nThe area of the triangle is %f", area);

  /*area = computeArea(&diameter, &diameter,3)  
  printf("\nThe area of a circle is %f", area);

  
  ch = 'u';
  count = numTimesAppears(mystring, ch);
  printf("\n Number of times %c appears in string is %d", ch, count);
*/ 



}

/*************************** End of file ****************************/
