struct socket {
  struct spinlock lock;
  int refs;           // reference count
  char data[512];     // socket buffer
  uint read_ptr;      // read pointer
  uint write_ptr;     // write pointer
  int connected;      // connection status
};