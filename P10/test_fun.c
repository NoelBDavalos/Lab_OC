#include <stdio.h>
extern int suma(int num1, int num2);
extern int strlenn(char *str);


void main()
{
    int res = suma(3, 5);
    printf("Resultado: %d \n", res);

    char cadena[] = "Hola Mundo!"; 
    int len = strlenn(cadena);
    printf("Longitud: %d \n", len);
}