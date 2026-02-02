//
//
#include <stdio.h>

int garray[] = {1,2,3,4,5,6,7,8,9,10};

int arraysum(int arr[], int length) {

   int i;
   int sum = 0;
   if (length >= 0) {
      for (i = 0; i < length; i++)
         sum = sum + arr[i];
   }
   return sum;
}

int main() {
   int sum = arraysum(garray,10);
   printf("sum = %d\n", sum);
   return 0;
}