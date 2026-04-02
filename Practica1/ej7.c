#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    // creacion de un pipe, comunicacion entre padre e hijo
    int p[2]; // arreglo de 2 enteros, el primero es lectura cmd2 y el segundo es escritura cmd1
    pipe(p); // se hace antes del fork(), asi padre e hijo tienen ese arreglo, tienen lo mismo

    pid_t id_proceso = fork(); // clonacion del proceso corriente

    // aca hay 2 procesos en el mismo nivel, el del padre e hijo

    if (id_proceso == 0) { 
        close(p[1]); // cierro la tuberia del lado de la escritura, no me interesa son de un solo sentido.
        char str[50];
        // el p[0] necesita tener un valor para leer, por eso primero se hace el padre en este caso
        read(p[0], str, sizeof(str));
        printf("soy hijo, recibi este msg: %s\n", str);

        close(p[0]); // cerramos lectura ya leyo
        exit(0); // matar hijo
    } else if (id_proceso > 0) { 
        close(p[0]); // cierro la tuberia del lado de la lectura, no me interesa son de un solo sentido.
        
        char str[] = "comunicacion de padre a hijo";
        write(p[1], str, sizeof(str));

        close(p[1]); // cerramos escritura, ya escribio

        wait(NULL); // no me interesa como termino el hijo xq es un string nomas, va a dar 0 va a terminar bien
        return 0;
    } else {
        printf("error al clonar");
        return -1;
    }

    return 0; // retorno correcto
}

