//
//
#include <stdio.h>

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
   // compiler needs to insert code that initialize
   // the larray[] with
   // int i,k;
   // for (i=0,k=1; i < 10; i++,k++)
   //      larray[i] = k;
   int larray[] = {1,2,3,4,5,6,7,8,9,10};
   int sum = arraysum(larray,10);
   printf("sum = %d\n", sum);
}