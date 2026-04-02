#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main() {

    int abrir_lector = open("comunicacion_independiente", O_RDONLY);
    char str[50];

    read(abrir_lector, str, sizeof(str));
    printf("soy el proceso receptor, recibi este msg: %s\n", str);
    close(abrir_lector); // cerramos lectura ya leyo

    return 0; // retorno correcto
}