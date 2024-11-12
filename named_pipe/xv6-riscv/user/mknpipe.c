#include "user/user.h"   // For system call declarations
#include "fcntl.h"  // For file control operations (optional, but good practice)
#include "kernel/syscall.h" // For syscall definitions (if needed)
#include "kernel/types.h" 

int mknpipe(const char *name)
{
    return syscall(SYS_mknpipe, name);  // Call the system call from the kernel
}
