//
//
#include <stdio.h>

int partialsum(int a) {
   int sum;
   if (a < 2)
      return 1;
   sum = partialsum(a-1);
   return (a+sum);
}


int main() {
   int sum; // Initialize the accumulator
   //int i;

   // Loop from 1 to 10
   //for (i = 1; i <= 10; i++) {
   //   sum += i; // Add the current number to the sum
   //}
   sum = partialsum(20);
   printf("The sum of the first 10 natural numbers is: %d\n", sum);
   return 0;
}