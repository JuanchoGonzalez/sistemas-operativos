#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int my_system(const char* command) {

    pid_t id_proceso = fork(); // clonacion del proceso corriente

    // aca hay 2 procesos en la mismo nivel, el del padre e hijo

    if (id_proceso == 0) { 
        // al hijo no le da un numero por eso es 0, xq el 0 no es nada, solo dice que esta bien.
        // no lo necesita con saber getpid() lo sabe, y tambien sabe el de su creador getppid()
        execl("/bin/sh", "sh", "-c", command, NULL); // ejecuta: pasa el sh para interpretar, pasa -c para leer el texto y el comando que escribio el usuario
        exit(1); // dio algo error, no termino bien el exec, por eso el 1 de que algo salio mal, se murio el hijo pero con problemas
    } else { 
        // a el padre le da el PID (process_id) del hijo, que es el id_proceso en este caso, es un numero grande tipo 3871
        int exit_code;
        wait(&exit_code);
        return exit_code; // padre despierta, retorna 0 si esta todo ok
    }

    return -1;
}

int main() {
    my_system("echo anda bien!!"); // aca se prueba cualq comando que se quiera como si fuera la terminal
    return 0; // retorno correcto
}

