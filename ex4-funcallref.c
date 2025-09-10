//
//
#include <stdio.h>

int array[10] = { 0 };

void bar(int *a, int b, int c) {
   int x;
   x = *a+b+c;
   x += 6;
   *a = x;
   return;
}

int main(void) {
   int x = 1, y = 2, z = 3;
   bar(&x, y, z);
   array[5] = x;
   printf("x = %d\n", x);
   return 0;
}