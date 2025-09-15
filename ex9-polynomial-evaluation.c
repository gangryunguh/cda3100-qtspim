//
// p(x) = a_0 + a_1 x + a_2 x^2 + a_3 x^3 ... a_n x^n
//      = 1 + x (1 + x + x^2 ... x^n-1)
        = 1 + x (1 + x (1 + x + ... x^n-2))


#include <stdio.h>

int main()
{
   char octal[] = "755"
   int x = 8;
   double xmin, xmax, dx, x;

   printf("Input n: ");
   scanf("%d", &n);

   printf("Input xmin, xmax, dx: ");
   scanf("%lf%lf%lf", &xmin, &xmax, &dx);

   printf("\n       x          s\n=============================");

   for(x = xmin; x <= xmax; x += dx){
      double s = 0, p = 1;
      for(i = 1; i <= n; i++)
         s += (p *= x);
      printf("\n%10.3f%10.3f", x, s);
   }
   return 0;
}