// user/fifo_interactive.c
#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"

#define BUFSIZE 512

int main(int argc, char *argv[]) {
    if(argc != 2) {
        fprintf(2, "Usage: fifo_interactive <fifo_path>\n");
        exit(1);
    }

    int fd = open(argv[1], O_WRONLY);
    if(fd < 0) {
        fprintf(2, "fifo_interactive: cannot open %s\n", argv[1]);
        exit(1);
    }

    printf("Enter messages (one per line):\n");
    
    char buf[BUFSIZE];
    int n;

    while(1) {
        printf("> ");  // Prompt for input
        memset(buf, 0, BUFSIZE);  // Clear buffer
        
        // Read from stdin (console)
        if((n = read(0, buf, BUFSIZE)) <= 0) {
            break;
        }

        // Write to FIFO
        if(write(fd, buf, n) != n) {
            fprintf(2, "fifo_interactive: write error\n");
            close(fd);
            exit(1);
        }
    }

    close(fd);
    exit(0);
}