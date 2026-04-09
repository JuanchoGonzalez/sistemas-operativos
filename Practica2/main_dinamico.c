/* main.c */
#include <stdio.h> /* for printf() */
#include <stdlib.h> // para los exit
#include <dlfcn.h> // dlopen, dlsym, dlcclose

int main(void)
{

    void *handle; // el "manejador" del archivo .so
    char* (*hello_func)(void); // un puntero a la función que vamos a buscar
    char *error; // Para guardar mensajes de error

    handle = dlopen("./libhello.so", RTLD_LAZY);
    if (!handle) {
        fprintf(stderr, "Error al abrir la biblioteca: %s\n", dlerror());
        exit(EXIT_FAILURE);
    }

    // buscar con dlsym la direccion de la funcion hello()
    hello_func = (char* (*)(void)) dlsym(handle, "hello");

    // verificar si hubo un error al buscar la función
    error = dlerror();
    if (error != NULL) {
        fprintf(stderr, "error al buscar el símbolo 'hello': %s\n", error);
        dlclose(handle);
        exit(EXIT_FAILURE);
    }

    // sino hubo error, invocarla e usarla.
    printf("La funcion retorno: %s\n", hello_func()); // en este caso seria el string Hello World que viene de hello.c

    dlclose(handle);

    return 0;
}