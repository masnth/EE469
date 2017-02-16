#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    printf("PART 1\n");
    int x = 1;
    int y = 2;
    float w = 3.3;
    float v = 4.4;
    char s = 's';
    char t = 't';

    int*xPtr = &x;
    float*wPtr = &w;
    char*sPtr = &s;

    int x1 = *xPtr;
    float w1 = *wPtr;
    char s1 = *sPtr;

    printf("x1 value is: %d\n", x1);
    printf("w1 value is: %.1f\n", w1);
    printf("s1 value is: %c\n", s1);

    int*yPtr = &y;
    float*vPtr = &v;
    char*tPtr = &t;

    int y1 = *yPtr;
    float v1 = *vPtr;
    char t1 = *tPtr;

    printf("y1 value is: %d\n", y1);
    printf("v1 value is: %.1f\n", v1);
    printf("t1 value is: %c\n\n\n\n", t1);

    printf("PART 2\n");

    int A = 22;
    int B = 17;
    int C = 6;
    int D = 4;
    int E = 9;

    int*APtr = &A;
    int*BPtr = &B;
    int*CPtr = &C;
    int*DPtr = &D;
    int*EPtr = &E;

    int A1 = *APtr;
    int B1 = *BPtr;
    int C1 = *CPtr;
    int D1 = *DPtr;
    int E1 = *EPtr;

    int result = ((A1-B1)*(C1+D1))/E1;
    printf("The result of an equation '((A-B)*(C+D))/E' using pointers is: %d\n", result);




    return 0;
}
