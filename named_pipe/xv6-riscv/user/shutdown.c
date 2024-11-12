#include "user/user.h"
// In user/user.h
#include "kernel/types.h"  // Add this to access types like uint, uint64, etc.

int main() {
    shutdown();  // This will invoke the sys_shutdown system call
    exit(0);     // Exit the program
}
