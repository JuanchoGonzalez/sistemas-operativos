#include <unistd.h>     // UNIX syscalls
#include <stdio.h>      // standard input/output
#include <fcntl.h>      // file operations and flags
#include <sys/wait.h>   // wait() syscall

int main(void) {
    if (fork() == 0) {
      // in child: open/create file with rw permissions
      int fd = open("output.txt", O_WRONLY | O_CREAT, 0600);
      char* args[] = {"ls", "-l", 0};
      printf("File fd: %d\n", fd);    // fd should have the value
      close(1);                       // close stdout
      dup(fd);                       // duplicate fd: ofiles[1] == fd
      // output of "ls -l" goes to output.txt
      execv("/bin/ls", args);
    } else {
      /* in parent */
      wait(NULL);
    }
}