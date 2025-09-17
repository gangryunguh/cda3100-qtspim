#include <stdio.h>
#include <stdlib.h>
/*
 * Using the Horner's method to covert hex value to decimal value
 *
 *    https://en.wikipedia.org/wiki/Horner%27s_method
 *
 *  Written by Gang-Ryung
 */

char hexstring[12] = {0};
int invalid = 0;

int hextodec(char *s) {
   char t;
   int total = 0;
   int length = 0;
  for (t = *s; t; s++,t = *s) {
      int digit;
      if (t > 'f') {
         invalid = 1;
         break;
      }
      if (t == '\n')
         return total;
      if (length >= 8) {
         invalid = 1;
         break;
      }
      if (t >= 'a')
         digit = t - 'a' + 10;
      else
         digit = t - '0';
      total = total*16 + digit;
      length++;
   }
   return total;
}

int main(void) {
   int value;
   /* prompt the user to enter the hexadecimal value */
   printf("Enter a hexadecimal value.\n");
   fgets(hexstring,12,stdin);
   value = hextodec(hexstring);
   if (invalid)
      printf("The hexadecimal number entered is invalid: 0x%s\n", hexstring);
   else
      printf("The hexadecimal number entered is the decimal value: %d\n", value);
   return 0;
}
