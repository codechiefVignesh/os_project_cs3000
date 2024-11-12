#include "kernel/types.h"
#include "user/user.h"

int main() {
    hello();  // Call the new system call
    exit(0);
}
