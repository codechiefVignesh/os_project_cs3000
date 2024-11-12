#include "user/user.h"
#include "kernel/types.h"  // Access types like uint, ushort, etc.

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(2, "Usage: mkfifo <path>\n");
        exit(1);
    }

    const char *path = argv[1];

    if (mkfifo(path) < 0) {
        fprintf(2, "mkfifo: failed to create named pipe at %s\n", path);
        exit(1);
    }

    exit(0);  // Exit successfully if mkfifo call succeeds
}
