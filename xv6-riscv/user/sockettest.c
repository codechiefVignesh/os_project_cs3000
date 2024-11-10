//#include "types.h"
//#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  int fd;

  fd = socketalloc();
  if(fd < 0){
    printf("socketalloc failed\n");
    exit(1);
  }
  
  printf("socket created: fd=%d\n", fd);
  close(fd);
  exit(0);
}