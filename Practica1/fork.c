#include <unistd.h> /* UNIX syscalls */
#include <stdio.h>  /* portable i/o functions */
#include <sys/wait.h>

int main(void) {
    int pid = fork();
    if (pid == 0) {
        printf("I'm the child. Pid: %d\n", getpid());
    } else {
        printf("I'm the parent. Pid: %d\n", getpid());
        printf("Child pid is: %d\n", pid);
        // wait for child termination
        wait(NULL);
        printf("Child %d terminated.\n", pid);
    }
}