#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
    int n = atoi(argv[1]);
    return n;
}

/*  
    ej5 a: gcc ej5.c -o ej5
           ./ej5 9
           $?  // esto devuelve 9, esta correcto

    ej5 b: ./ej5 0 && echo "finalizo con exito"
            ejecuto otro comando, devuelve "finalizo con exito", esta correcto
    
    ej5 c: ./ej5 3 || echo "finalizo con error"
            ejecuto otro comando, devuelve "finalizo con error", esta correcto
*/
