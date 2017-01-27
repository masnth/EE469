#include <stdio.h>
#include <stdlib.h>

float getInput(void);
float computeVelocity(float x, float data1);
float estimatedDuration(float y, float data2);
void showResult(float data3);

int main()
{
    float data1 = 0.0;
    float data2 = 0.0;
    float data3 = 0.0;
    float distance = 4781.0;

    data1 = getInput();
    data2 = computeVelocity(distance, data1);
    data3 = estimatedDuration(distance, data2);
    showResult(data3);


    return 0;
}

float getInput(void)
{
    float temp;

    getp: printf("Please enter the duration of a nonstop flight to London from Seattle (in hours): ");
    float x = scanf("%f", &temp);

     if (x != 1)
                {
                    printf("Must be a number!\n");
                    while(getchar() != '\n');
                    goto getp;
                }

    else
        getchar();
    return temp;
}

float computeVelocity(float x, float data1)
{
    float temp = 0.0;
    temp = x / data1;

    return temp;
}

float estimatedDuration(float y, float data2)
{
    float temp = 0.0;
    float wind = 89.6;

        temp = y / (data2 - wind);


    return temp;
}

void showResult(float data3)
{
    if ( data3 <= 0)
        printf ("Please check your duration again.");
    else
        printf("The estimated flight duration: %0.2f", data3);

    return;

}
