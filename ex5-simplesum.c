//
// sum = 1+2+..+10
//
#include <stdio.h>

int main() {
   int sum = 0; // Initialize the accumulator
   int i;

   // Loop from 1 to 10
   for (i = 1; i <= 10; i++) {
      sum += i; // Add the current number to the sum
   }

   printf("The sum of the first 10 natural numbers is: %d\n", sum);

   return 0;
}