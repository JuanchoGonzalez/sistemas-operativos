#include <stdio.h>
#include <sys/wait.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <signal.h>

#define N 10 // cantidad de numeros en el arreglo
#define P 5 // procesos

void minimo_local_pipe() {
    int arr[N] = {10, -2, -3, 14, -20, 5, -30, -5, 23, 10};
    
    // int pipes[N][2]
    int p[2]; // con un solo pipe que los hijos manden la informacion esta, se pone 2 xq uno para leer y otro para escribir
    pipe(p);

    // inicializar pipe ver
    // hacer con for
    // pipe(pipes[i])
    // ver si es lo mismo que tengo, o que.


    // dentro de este while hacer un read por ahi, para mas eficiencia ver
    int i = 0;
    while (i < P) {
        pid_t id_proceso = fork();

        if (id_proceso == 0) { // hijo, entro por cada ciclo del while
            close(p[0]);


            int inicio = i * (N/P);
            int fin = inicio + (N/P);

            int minimo = arr[inicio];
            for (int j = inicio + 1; j < fin ; j++) {
                if (arr[j] < minimo) {
                    minimo = arr[j];
                }
            }
            write(p[1], &minimo, sizeof(int)); // escribir mi minimo local
            
            close(p[1]);
            exit(0);
        }
        i++;
    }

    // si llego aca es xq es el padre xq los hijos murieron con exit
    close(p[1]);

    int minimo_local;
    read(p[0], &minimo_local , sizeof(int));
    int minimo_global = minimo_local;

    // encontrar minimo local 
    for (int i = 0; i < P - 1; i++) {
        read(p[0], &minimo_local , sizeof(int));
        if (minimo_local < minimo_global) {
            minimo_global = minimo_local;
        }
    }

    for (int i = 0; i < P; i++) {
        wait(NULL);
    }
    close(p[0]);
    printf("El minimo global del arreglo es: %d\n", minimo_global);
}

int main() {
    minimo_local_pipe();
    return 0;
}