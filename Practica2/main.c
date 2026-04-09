/* main.c */
#include <stdio.h> /* for printf() */
#include "hello.h"
#include "hello2.h"

extern char* hello(void);

int main(void)
{
    int var_local = 3;
    // %p es puntero y el casting a void es necesario xq &var_local es puntero a entero, y necesito que sea algo de tipo puntero generico,
    // xq aca lo que me importa es la direccion de memoria no el valor en concreto de la variable por mas que sea de cualq tipo.
    printf("La direccion de var_local es: %p\n", (void*)&var_local);

    printf("%s\n", hello());

    int a = 3;
    int b = 7;
    int result = sum(a, b);
    printf("El resultado de la suma es: %d\n", result);
    return 0;
}