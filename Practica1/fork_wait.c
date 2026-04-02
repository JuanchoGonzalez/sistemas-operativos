#include <unistd.h> /* UNIX API (syscalls) */
#include <stdio.h>  /* portable i/o functions */
#include <sys/wait.h>
#include <stdlib.h>

int main(void) {
    if (fork() == 0) {
        printf("I'm the child. Pid: %d\n", getpid());
        exit(0);
    } else {
        int child, status;
        printf("I'm the parent. Pid: %d\n", getpid());
        child = wait(&status);
        printf("In parent: child %d finished. Exit code: %d\n", child, status);
    }
}