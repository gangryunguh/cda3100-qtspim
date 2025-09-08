//
// Created by Gang-Ryung Uh on 9/5/25.
//
#include <stdio.h>

int array[10] = { 0 };

int bar(int a, int b, int c) {
   int x;
   x = a+b+c;
   x += 6;
   return x;
}

int main(void) {
   int x = 1, y = 2, z = 3;
   x = bar(x, y, z);
   array[5] = x;
   printf("x = %d\n", x);
   return 0;
}
