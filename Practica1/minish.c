#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <string.h>
#include <fcntl.h>

int ejecutar_comando(char *comando, int esperar, char *archivo_lectura, char *archivo_escritura, int al_final) {
    
    // arreglo que guarda el comando en pedazos
    char *argumentos[100];

    // strtok lo que hace es corta palabra por palabra, tomando como espacio otra palabra 
    // (si es un solo caracter va ese solo caracter en un espacio de argumentos)
    // pj ls -l se divide en 2, ls y luego -l
    char *palabra = strtok(comando, " \t\n");
    
    int i = 0;
    while (palabra != NULL) {
        argumentos[i] = palabra;
        i++;
        palabra = strtok(NULL, " \t\n"); // asi se busca la siguiente palabra
    }
    argumentos[i] = NULL; // ponerle null en la ultima posicion de argumentos, para que execvp funcione

    // Si el usuario puso puros espacios y no hay comando, salimos
    if (argumentos[0] == NULL) {
        return 0; 
    }

    pid_t pid = fork();

    if (pid == 0) {
        // ver si es comando o archivo
        if (archivo_lectura != NULL) {
            int archivo_l = open(archivo_lectura, O_RDONLY);
            if (archivo_l < 0) {
                perror("Error al abrir el archivo");
                exit(1);
            }
            dup2(archivo_l, 0);
            close(archivo_l);
        } else if (archivo_escritura != NULL) {
            int flag = O_WRONLY | O_CREAT;
            if (al_final == 1) {
                flag = flag | O_APPEND;
            } else {
                flag = flag | O_TRUNC;
            }
            int archivo_e = open(archivo_escritura, flag, 0666);
            if (archivo_e < 0) {
                perror("Error al abrir el archivo");
                exit(1);
            }
            dup2(archivo_e, 1);
            close(archivo_e);
        }
        execvp(argumentos[0], argumentos);
        perror("Error al ejecutar");
        exit(1);
    } else if (pid > 0) {

        if (esperar == 0) {
            int exit_code;
            wait(&exit_code);
            if (WIFEXITED(exit_code)) {
                return WEXITSTATUS(exit_code); // devuelve algo, 0 si es exito
            }
        } else {
            printf("proceso %d corriendo de fondo: \n", pid);
            return 0;
        }
        
    } else {
        printf("Error fatal al clonar.\n");
        return -1;
    }
}

void ejecutar_comando_pipe(char *comando1, char *comando2) {
    
    char *args1[100];
    char *palabra1 = strtok(comando1, " \t\n");
    int i = 0;
    while (palabra1 != NULL) {
        args1[i] = palabra1;
        i++;
        palabra1 = strtok(NULL, " \t\n");
    }
    args1[i] = NULL;

    char *args2[100];
    char *palabra2 = strtok(comando2, " \t\n");
    int j = 0;
    while (palabra2 != NULL) {
        args2[j] = palabra2;
        j++;
        palabra2 = strtok(NULL, " \t\n");
    }
    args2[j] = NULL;

    if (args1[0] == NULL || args2[0] == NULL) {
        return;
    }

    int p[2];
    if (pipe(p) < 0) {
        perror("Error al crear el pipe");
        return;
    }

    pid_t pid1 = fork();
    if (pid1 == 0) { // hijo 1
        close(p[0]); // cierro lectura no me interesa
        dup2(p[1], 1); // cambio la salida por pantalla a stdout por pipe
        close(p[1]); // cierro la boca original xq ya la copie
        execvp(args1[0], args1); // ejecuta los argumentos
        perror("Error al ejecutar comando 1");
        exit(1);
    }

    pid_t pid2 = fork();
    if (pid2 == 0) {
        close(p[1]); // cierro escritura no me interesa
        dup2(p[0], 0); // cierro para escribir por teclado (stdin) a escribir en el pipe
        close(p[0]); // cierro la oreja xq ya la copie
        execvp(args2[0], args2); 
        perror("Error al ejecutar comando 2");
        exit(1);
    }

    close(p[0]);
    close(p[1]);
    
    // aca no es wait() solo xq necesita que ambos terminen
    // pregunta primero por pid1 si no termino no paso con el otro por mas que haya terminado
    waitpid(pid1, NULL, 0);
    waitpid(pid2, NULL, 0);
}

void iniciar_shell() {
    char linea[1024];

    printf("terminal: ");

    // espera que el usuario escriba algo, agarra la linea y se fija si es ctrl + d, sino es asi sigue
    while (fgets(linea, sizeof(linea), stdin) != NULL) {
        // se limpia el 'Enter' invisible
        linea[strcspn(linea, "\n")] = '\0';

        // si apretó enter sin escribir nada, volvemos a preguntar
        if (strlen(linea) == 0) {
            printf("terminal: ");
            continue;
        }
        
        char *posicion;

        // empiezo a preguntar que simbolo es
        if ((posicion = strstr(linea, ">>")) != NULL) { // primero con simbolos dobles
            
            *posicion = '\0'; // la posicion del medio y mas 1 va nulo asi sabe donde cortar
            *(posicion + 1) = '\0';
            char *cmd1 = linea;
            char *archivo = posicion + 2; // archivo

            while (*archivo == ' ') {
                archivo++;
            }
            ejecutar_comando(cmd1, 0, NULL, archivo, 1);

        } else if ((posicion = strstr(linea, "&&")) != NULL){

            *posicion = '\0';
            *(posicion + 1) = '\0';
            char *cmd1 = linea;
            char *cmd2 = posicion + 2;
            int resultado =  ejecutar_comando(cmd1, 0, NULL, NULL, 0);
            if (resultado == 0) {
                ejecutar_comando(cmd2, 0, NULL, NULL, 0);
            }

        } else if ((posicion = strstr(linea, "||")) != NULL){
            
            *posicion = '\0';
            *(posicion + 1) = '\0';
            char *cmd1 = linea;
            char *cmd2 = posicion + 2;
            int resultado = ejecutar_comando(cmd1, 0, NULL, NULL, 0);
            if (resultado != 0) {
                ejecutar_comando(cmd2, 0, NULL, NULL, 0);
            }

        } else if ((posicion = strchr(linea, ';')) != NULL) { // aca posicion ya es un puntero que apunta al indice que esta el simbolo corriente (en este caso ;)
        
            *posicion = '\0'; // entonces aca le pongo un "termino" el string vi algo nulo en el indice donde estaba el ;
            char *cmd1 = linea; // entonces ahora linea es la mitad izquierda hasta este nulo(\0)
            char *cmd2 = posicion + 1; // y esto es mitad derecha  
            ejecutar_comando(cmd1, 0, NULL, NULL, 0);
            ejecutar_comando(cmd2, 0, NULL, NULL, 0);

        } else if ((posicion = strchr(linea, '&')) != NULL) {
            
            *posicion = '\0';
            char *cmd1 = linea;
            char *cmd2 = posicion + 1;
            ejecutar_comando(cmd1, 0, NULL, NULL, 0);
            ejecutar_comando(cmd2, 1, NULL, NULL, 0);

        } else if ((posicion = strchr(linea, '<')) != NULL) {

            *posicion = '\0';
            char *cmd1 = linea;
            char *archivo = posicion + 1; // archivo

            while (*archivo == ' ') {
                archivo++;
            }
            ejecutar_comando(cmd1, 0, archivo, NULL, 0);

        } else if ((posicion = strchr(linea, '>')) != NULL) {

            *posicion = '\0';
            char *cmd1 = linea;
            char *archivo = posicion + 1; // archivo

            while (*archivo == ' ') {
                archivo++;
            }
            ejecutar_comando(cmd1, 0, NULL, archivo, 0);

        } else if ((posicion = strchr(linea, '|')) != NULL){
            
            *posicion = '\0';
            char *cmd1 = linea;
            char *cmd2 = posicion + 1;
            ejecutar_comando_pipe(cmd1, cmd2);

        } else {
            // si no tiene ningún símbolo, es un comando normal (ej: "ls" o "cat")
            ejecutar_comando(linea, 0, NULL, NULL, 0);
        }
        
        printf("terminal: ");
    }
    
    printf("saliendo de la terminal...\n");
}

int main() {
    iniciar_shell();
    return 0;
}