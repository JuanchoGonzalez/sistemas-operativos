#include <stdio.h>
#include <unistd.h>

#define N 20 

int main(){
    char linea[500];
    alarm(N);
    printf("Por favor escribe algo, tenes %d segundos: \n", N);

    if (fgets(linea, sizeof(linea), stdin) != NULL) {
        alarm(0); // apago la alarma
        printf("todo bien, escribiste antes \n");
        printf("tu texto fue %s \n",linea);
    }

    return 0;
}