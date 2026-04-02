#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int main() {
    mkfifo("comunicacion_independiente", 0666); // el 0666 es para que se pueda leer y escribir

    int abrir_escritor = open("comunicacion_independiente", O_WRONLY);
    char str[] = "comunicacion de escritor a lector a traves de FIFO";
    
    write(abrir_escritor, str, sizeof(str));
    close(abrir_escritor); // cerramos escritura, ya escribio

    return 0;
}