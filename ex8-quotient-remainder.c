//
//
#include <stdio.h>

char *msg1 = "Type in the positive integer values of dividend and divisor: \n";
char *msg2 = "quotient = ";
char *msg3 = "remainder = ";
char *msg4 = "bye bye";

void printmsg(char *s) {
   printf("%s", s);
}

int readint() {
   int num;
   scanf("%d", &num);
   return num;
}

void printresult(char *s, int val) {
   printf("%s %d\n", s, val);
}

int main() {
   int quotient;
   int remainder;
   int dividend;
   int divisor;

   printmsg(msg1);
   dividend = readint();
   divisor = readint();
   while (dividend > 0 && divisor > 0) {
      quotient = dividend / divisor;
      remainder = dividend % divisor;
      printresult(msg2, quotient);
      printresult(msg3, remainder);
      printmsg(msg1);
      dividend = readint();
      divisor = readint();
   }
   printmsg(msg4);
   return 0;
}
