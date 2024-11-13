#include "kernel/types.h"
#include "kernel/stat.h"
#include "user.h"

#define BUFFER_SIZE 64

int
main(int argc, char *argv[])
{
  int sockfd;
  char buf[BUFFER_SIZE];
  int n;

  // Create a socket
  sockfd = socketalloc();
  if(sockfd < 0){
    printf("socketalloc failed\n");
    exit(1);
  }
  printf("Socket created: fd=%d\n", sockfd);

  // Write some data to the socket
  const char* msg = "Hello from sockettest!";
  if(socketwrite(sockfd, msg, strlen(msg)) < 0){
    printf("socketwrite failed\n");
    socketclose(sockfd);
    exit(1);
  }
  printf("Wrote data to socket\n");

  // Read data from the socket
  n = socketread(sockfd, buf, BUFFER_SIZE-1);
  if(n < 0){
    printf("socketread failed\n");
    socketclose(sockfd);
    exit(1);
  }
  buf[n] = '\0';
  printf("Read from socket: %s\n", buf);

  // Close the socket
  if(socketclose(sockfd) < 0){
    printf("socketclose failed\n");
    exit(1);
  }
  printf("Socket closed\n");

  exit(0);
}