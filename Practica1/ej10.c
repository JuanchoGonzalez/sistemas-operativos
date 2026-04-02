#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>

// capturador de señal SIGINT

void capturador_SIGINT() {

    printf("\nrecibi un SIGINT, Estas seguro de que quieres salir? (s/n): \n");
    char caracter = getchar();
    if (caracter != 's' && caracter != 'S') {
        exit(-1); // error, destruir proceso
    }
    exit(0); // bien, se destruye el proceso lo mismo
}

int main() {
    // la idea aca es ya que se manda la senial de SIGINT
    // que no se muera, primero ejecuta esta funcion
    signal(SIGINT, capturador_SIGINT);

    printf("programa corriendo, apreta Ctrl+C para interrumpir\n");
    
    // ciclo infinito asi se puede probar esto
    while (1) {
        sleep(1); // que se duerma 1 segundo, luego se despierta asi, xq sino es un ciclo infinito que te consume toda la memoria
    }
    return 0;
}