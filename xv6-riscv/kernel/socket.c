#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "spinlock.h"
#include "proc.h"
#include "fs.h"
#include "sleeplock.h"
#include "file.h"
#include "socket.h"

struct file*
socketalloc(void)
{
  struct file *f;
  struct socket *s;

  f = filealloc();
  if(f == 0)
    return 0;

  s = kalloc();
  if(s == 0){
    fileclose(f);
    return 0;
  }

  initlock(&s->lock, "socket");
  s->refs = 1;
  s->read_ptr = 0;
  s->write_ptr = 0;
  s->connected = 0;

  f->type = FD_SOCKET;
  f->readable = 1;
  f->writable = 1;
  f->sock = s;
  f->ref = 1;

  return f;
}

int
socketread(struct file *f, uint64 addr, int n)
{
  struct socket *s = f->sock;
  int r;

  if(n < 0)
    return -1;

  acquire(&s->lock);
  
  while(s->read_ptr == s->write_ptr && s->connected){
    if(myproc()->killed){
      release(&s->lock);
      return -1;
    }
    sleep(&s->read_ptr, &s->lock);
  }

  r = 0;
  while(r < n && s->read_ptr != s->write_ptr){
    if(copyout(myproc()->pagetable, addr + r, &s->data[s->read_ptr], 1) == -1)
      break;
    s->read_ptr = (s->read_ptr + 1) % sizeof(s->data);
    r++;
  }

  if(r > 0)
    wakeup(&s->write_ptr);
    
  release(&s->lock);
  return r;
}

int
socketwrite(struct file *f, uint64 addr, int n)
{
  struct socket *s = f->sock;
  int w;

  if(n < 0)
    return -1;

  acquire(&s->lock);

  w = 0;
  while(w < n){
    while(((s->write_ptr + 1) % sizeof(s->data)) == s->read_ptr){
      if(myproc()->killed){
        release(&s->lock);
        return -1;
      }
      wakeup(&s->read_ptr);
      sleep(&s->write_ptr, &s->lock);
    }

    if(copyin(myproc()->pagetable, &s->data[s->write_ptr], addr + w, 1) == -1)
      break;
    
    s->write_ptr = (s->write_ptr + 1) % sizeof(s->data);
    w++;
  }

  if(w > 0)
    wakeup(&s->read_ptr);
    
  release(&s->lock);
  return w;
}

void
socketclose(struct file *f)
{
  struct socket *s = f->sock;

  acquire(&s->lock);
  s->refs--;
  if(s->refs == 0){
    s->connected = 0;
    wakeup(&s->read_ptr);
    wakeup(&s->write_ptr);
    release(&s->lock);
    kfree(s);
  } else {
    release(&s->lock);
  }
}