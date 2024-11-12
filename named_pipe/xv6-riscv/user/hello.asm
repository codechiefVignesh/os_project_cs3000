
user/_hello:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int main() {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    hello();  // Call the new system call
   8:	314000ef          	jal	31c <hello>
    exit(0);
   c:	4501                	li	a0,0
   e:	26e000ef          	jal	27c <exit>

0000000000000012 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  12:	1141                	addi	sp,sp,-16
  14:	e406                	sd	ra,8(sp)
  16:	e022                	sd	s0,0(sp)
  18:	0800                	addi	s0,sp,16
  extern int main();
  main();
  1a:	fe7ff0ef          	jal	0 <main>
  exit(0);
  1e:	4501                	li	a0,0
  20:	25c000ef          	jal	27c <exit>

0000000000000024 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  24:	1141                	addi	sp,sp,-16
  26:	e422                	sd	s0,8(sp)
  28:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  2a:	87aa                	mv	a5,a0
  2c:	0585                	addi	a1,a1,1
  2e:	0785                	addi	a5,a5,1
  30:	fff5c703          	lbu	a4,-1(a1)
  34:	fee78fa3          	sb	a4,-1(a5)
  38:	fb75                	bnez	a4,2c <strcpy+0x8>
    ;
  return os;
}
  3a:	6422                	ld	s0,8(sp)
  3c:	0141                	addi	sp,sp,16
  3e:	8082                	ret

0000000000000040 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  40:	1141                	addi	sp,sp,-16
  42:	e422                	sd	s0,8(sp)
  44:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  46:	00054783          	lbu	a5,0(a0)
  4a:	cb91                	beqz	a5,5e <strcmp+0x1e>
  4c:	0005c703          	lbu	a4,0(a1)
  50:	00f71763          	bne	a4,a5,5e <strcmp+0x1e>
    p++, q++;
  54:	0505                	addi	a0,a0,1
  56:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  58:	00054783          	lbu	a5,0(a0)
  5c:	fbe5                	bnez	a5,4c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  5e:	0005c503          	lbu	a0,0(a1)
}
  62:	40a7853b          	subw	a0,a5,a0
  66:	6422                	ld	s0,8(sp)
  68:	0141                	addi	sp,sp,16
  6a:	8082                	ret

000000000000006c <strlen>:

uint
strlen(const char *s)
{
  6c:	1141                	addi	sp,sp,-16
  6e:	e422                	sd	s0,8(sp)
  70:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  72:	00054783          	lbu	a5,0(a0)
  76:	cf91                	beqz	a5,92 <strlen+0x26>
  78:	0505                	addi	a0,a0,1
  7a:	87aa                	mv	a5,a0
  7c:	86be                	mv	a3,a5
  7e:	0785                	addi	a5,a5,1
  80:	fff7c703          	lbu	a4,-1(a5)
  84:	ff65                	bnez	a4,7c <strlen+0x10>
  86:	40a6853b          	subw	a0,a3,a0
  8a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  8c:	6422                	ld	s0,8(sp)
  8e:	0141                	addi	sp,sp,16
  90:	8082                	ret
  for(n = 0; s[n]; n++)
  92:	4501                	li	a0,0
  94:	bfe5                	j	8c <strlen+0x20>

0000000000000096 <memset>:

void*
memset(void *dst, int c, uint n)
{
  96:	1141                	addi	sp,sp,-16
  98:	e422                	sd	s0,8(sp)
  9a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  9c:	ca19                	beqz	a2,b2 <memset+0x1c>
  9e:	87aa                	mv	a5,a0
  a0:	1602                	slli	a2,a2,0x20
  a2:	9201                	srli	a2,a2,0x20
  a4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  a8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  ac:	0785                	addi	a5,a5,1
  ae:	fee79de3          	bne	a5,a4,a8 <memset+0x12>
  }
  return dst;
}
  b2:	6422                	ld	s0,8(sp)
  b4:	0141                	addi	sp,sp,16
  b6:	8082                	ret

00000000000000b8 <strchr>:

char*
strchr(const char *s, char c)
{
  b8:	1141                	addi	sp,sp,-16
  ba:	e422                	sd	s0,8(sp)
  bc:	0800                	addi	s0,sp,16
  for(; *s; s++)
  be:	00054783          	lbu	a5,0(a0)
  c2:	cb99                	beqz	a5,d8 <strchr+0x20>
    if(*s == c)
  c4:	00f58763          	beq	a1,a5,d2 <strchr+0x1a>
  for(; *s; s++)
  c8:	0505                	addi	a0,a0,1
  ca:	00054783          	lbu	a5,0(a0)
  ce:	fbfd                	bnez	a5,c4 <strchr+0xc>
      return (char*)s;
  return 0;
  d0:	4501                	li	a0,0
}
  d2:	6422                	ld	s0,8(sp)
  d4:	0141                	addi	sp,sp,16
  d6:	8082                	ret
  return 0;
  d8:	4501                	li	a0,0
  da:	bfe5                	j	d2 <strchr+0x1a>

00000000000000dc <gets>:

char*
gets(char *buf, int max)
{
  dc:	711d                	addi	sp,sp,-96
  de:	ec86                	sd	ra,88(sp)
  e0:	e8a2                	sd	s0,80(sp)
  e2:	e4a6                	sd	s1,72(sp)
  e4:	e0ca                	sd	s2,64(sp)
  e6:	fc4e                	sd	s3,56(sp)
  e8:	f852                	sd	s4,48(sp)
  ea:	f456                	sd	s5,40(sp)
  ec:	f05a                	sd	s6,32(sp)
  ee:	ec5e                	sd	s7,24(sp)
  f0:	1080                	addi	s0,sp,96
  f2:	8baa                	mv	s7,a0
  f4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  f6:	892a                	mv	s2,a0
  f8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
  fa:	4aa9                	li	s5,10
  fc:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
  fe:	89a6                	mv	s3,s1
 100:	2485                	addiw	s1,s1,1
 102:	0344d663          	bge	s1,s4,12e <gets+0x52>
    cc = read(0, &c, 1);
 106:	4605                	li	a2,1
 108:	faf40593          	addi	a1,s0,-81
 10c:	4501                	li	a0,0
 10e:	186000ef          	jal	294 <read>
    if(cc < 1)
 112:	00a05e63          	blez	a0,12e <gets+0x52>
    buf[i++] = c;
 116:	faf44783          	lbu	a5,-81(s0)
 11a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 11e:	01578763          	beq	a5,s5,12c <gets+0x50>
 122:	0905                	addi	s2,s2,1
 124:	fd679de3          	bne	a5,s6,fe <gets+0x22>
    buf[i++] = c;
 128:	89a6                	mv	s3,s1
 12a:	a011                	j	12e <gets+0x52>
 12c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 12e:	99de                	add	s3,s3,s7
 130:	00098023          	sb	zero,0(s3)
  return buf;
}
 134:	855e                	mv	a0,s7
 136:	60e6                	ld	ra,88(sp)
 138:	6446                	ld	s0,80(sp)
 13a:	64a6                	ld	s1,72(sp)
 13c:	6906                	ld	s2,64(sp)
 13e:	79e2                	ld	s3,56(sp)
 140:	7a42                	ld	s4,48(sp)
 142:	7aa2                	ld	s5,40(sp)
 144:	7b02                	ld	s6,32(sp)
 146:	6be2                	ld	s7,24(sp)
 148:	6125                	addi	sp,sp,96
 14a:	8082                	ret

000000000000014c <stat>:

int
stat(const char *n, struct stat *st)
{
 14c:	1101                	addi	sp,sp,-32
 14e:	ec06                	sd	ra,24(sp)
 150:	e822                	sd	s0,16(sp)
 152:	e04a                	sd	s2,0(sp)
 154:	1000                	addi	s0,sp,32
 156:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 158:	4581                	li	a1,0
 15a:	162000ef          	jal	2bc <open>
  if(fd < 0)
 15e:	02054263          	bltz	a0,182 <stat+0x36>
 162:	e426                	sd	s1,8(sp)
 164:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 166:	85ca                	mv	a1,s2
 168:	16c000ef          	jal	2d4 <fstat>
 16c:	892a                	mv	s2,a0
  close(fd);
 16e:	8526                	mv	a0,s1
 170:	134000ef          	jal	2a4 <close>
  return r;
 174:	64a2                	ld	s1,8(sp)
}
 176:	854a                	mv	a0,s2
 178:	60e2                	ld	ra,24(sp)
 17a:	6442                	ld	s0,16(sp)
 17c:	6902                	ld	s2,0(sp)
 17e:	6105                	addi	sp,sp,32
 180:	8082                	ret
    return -1;
 182:	597d                	li	s2,-1
 184:	bfcd                	j	176 <stat+0x2a>

0000000000000186 <atoi>:

int
atoi(const char *s)
{
 186:	1141                	addi	sp,sp,-16
 188:	e422                	sd	s0,8(sp)
 18a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 18c:	00054683          	lbu	a3,0(a0)
 190:	fd06879b          	addiw	a5,a3,-48
 194:	0ff7f793          	zext.b	a5,a5
 198:	4625                	li	a2,9
 19a:	02f66863          	bltu	a2,a5,1ca <atoi+0x44>
 19e:	872a                	mv	a4,a0
  n = 0;
 1a0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1a2:	0705                	addi	a4,a4,1
 1a4:	0025179b          	slliw	a5,a0,0x2
 1a8:	9fa9                	addw	a5,a5,a0
 1aa:	0017979b          	slliw	a5,a5,0x1
 1ae:	9fb5                	addw	a5,a5,a3
 1b0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1b4:	00074683          	lbu	a3,0(a4)
 1b8:	fd06879b          	addiw	a5,a3,-48
 1bc:	0ff7f793          	zext.b	a5,a5
 1c0:	fef671e3          	bgeu	a2,a5,1a2 <atoi+0x1c>
  return n;
}
 1c4:	6422                	ld	s0,8(sp)
 1c6:	0141                	addi	sp,sp,16
 1c8:	8082                	ret
  n = 0;
 1ca:	4501                	li	a0,0
 1cc:	bfe5                	j	1c4 <atoi+0x3e>

00000000000001ce <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1ce:	1141                	addi	sp,sp,-16
 1d0:	e422                	sd	s0,8(sp)
 1d2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1d4:	02b57463          	bgeu	a0,a1,1fc <memmove+0x2e>
    while(n-- > 0)
 1d8:	00c05f63          	blez	a2,1f6 <memmove+0x28>
 1dc:	1602                	slli	a2,a2,0x20
 1de:	9201                	srli	a2,a2,0x20
 1e0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 1e4:	872a                	mv	a4,a0
      *dst++ = *src++;
 1e6:	0585                	addi	a1,a1,1
 1e8:	0705                	addi	a4,a4,1
 1ea:	fff5c683          	lbu	a3,-1(a1)
 1ee:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 1f2:	fef71ae3          	bne	a4,a5,1e6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 1f6:	6422                	ld	s0,8(sp)
 1f8:	0141                	addi	sp,sp,16
 1fa:	8082                	ret
    dst += n;
 1fc:	00c50733          	add	a4,a0,a2
    src += n;
 200:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 202:	fec05ae3          	blez	a2,1f6 <memmove+0x28>
 206:	fff6079b          	addiw	a5,a2,-1
 20a:	1782                	slli	a5,a5,0x20
 20c:	9381                	srli	a5,a5,0x20
 20e:	fff7c793          	not	a5,a5
 212:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 214:	15fd                	addi	a1,a1,-1
 216:	177d                	addi	a4,a4,-1
 218:	0005c683          	lbu	a3,0(a1)
 21c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 220:	fee79ae3          	bne	a5,a4,214 <memmove+0x46>
 224:	bfc9                	j	1f6 <memmove+0x28>

0000000000000226 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 226:	1141                	addi	sp,sp,-16
 228:	e422                	sd	s0,8(sp)
 22a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 22c:	ca05                	beqz	a2,25c <memcmp+0x36>
 22e:	fff6069b          	addiw	a3,a2,-1
 232:	1682                	slli	a3,a3,0x20
 234:	9281                	srli	a3,a3,0x20
 236:	0685                	addi	a3,a3,1
 238:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 23a:	00054783          	lbu	a5,0(a0)
 23e:	0005c703          	lbu	a4,0(a1)
 242:	00e79863          	bne	a5,a4,252 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 246:	0505                	addi	a0,a0,1
    p2++;
 248:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 24a:	fed518e3          	bne	a0,a3,23a <memcmp+0x14>
  }
  return 0;
 24e:	4501                	li	a0,0
 250:	a019                	j	256 <memcmp+0x30>
      return *p1 - *p2;
 252:	40e7853b          	subw	a0,a5,a4
}
 256:	6422                	ld	s0,8(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret
  return 0;
 25c:	4501                	li	a0,0
 25e:	bfe5                	j	256 <memcmp+0x30>

0000000000000260 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 260:	1141                	addi	sp,sp,-16
 262:	e406                	sd	ra,8(sp)
 264:	e022                	sd	s0,0(sp)
 266:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 268:	f67ff0ef          	jal	1ce <memmove>
}
 26c:	60a2                	ld	ra,8(sp)
 26e:	6402                	ld	s0,0(sp)
 270:	0141                	addi	sp,sp,16
 272:	8082                	ret

0000000000000274 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 274:	4885                	li	a7,1
 ecall
 276:	00000073          	ecall
 ret
 27a:	8082                	ret

000000000000027c <exit>:
.global exit
exit:
 li a7, SYS_exit
 27c:	4889                	li	a7,2
 ecall
 27e:	00000073          	ecall
 ret
 282:	8082                	ret

0000000000000284 <wait>:
.global wait
wait:
 li a7, SYS_wait
 284:	488d                	li	a7,3
 ecall
 286:	00000073          	ecall
 ret
 28a:	8082                	ret

000000000000028c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 28c:	4891                	li	a7,4
 ecall
 28e:	00000073          	ecall
 ret
 292:	8082                	ret

0000000000000294 <read>:
.global read
read:
 li a7, SYS_read
 294:	4895                	li	a7,5
 ecall
 296:	00000073          	ecall
 ret
 29a:	8082                	ret

000000000000029c <write>:
.global write
write:
 li a7, SYS_write
 29c:	48c1                	li	a7,16
 ecall
 29e:	00000073          	ecall
 ret
 2a2:	8082                	ret

00000000000002a4 <close>:
.global close
close:
 li a7, SYS_close
 2a4:	48d5                	li	a7,21
 ecall
 2a6:	00000073          	ecall
 ret
 2aa:	8082                	ret

00000000000002ac <kill>:
.global kill
kill:
 li a7, SYS_kill
 2ac:	4899                	li	a7,6
 ecall
 2ae:	00000073          	ecall
 ret
 2b2:	8082                	ret

00000000000002b4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 2b4:	489d                	li	a7,7
 ecall
 2b6:	00000073          	ecall
 ret
 2ba:	8082                	ret

00000000000002bc <open>:
.global open
open:
 li a7, SYS_open
 2bc:	48bd                	li	a7,15
 ecall
 2be:	00000073          	ecall
 ret
 2c2:	8082                	ret

00000000000002c4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 2c4:	48c5                	li	a7,17
 ecall
 2c6:	00000073          	ecall
 ret
 2ca:	8082                	ret

00000000000002cc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 2cc:	48c9                	li	a7,18
 ecall
 2ce:	00000073          	ecall
 ret
 2d2:	8082                	ret

00000000000002d4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 2d4:	48a1                	li	a7,8
 ecall
 2d6:	00000073          	ecall
 ret
 2da:	8082                	ret

00000000000002dc <link>:
.global link
link:
 li a7, SYS_link
 2dc:	48cd                	li	a7,19
 ecall
 2de:	00000073          	ecall
 ret
 2e2:	8082                	ret

00000000000002e4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 2e4:	48d1                	li	a7,20
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 2ec:	48a5                	li	a7,9
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 2f4:	48a9                	li	a7,10
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 2fc:	48ad                	li	a7,11
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 304:	48b1                	li	a7,12
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 30c:	48b5                	li	a7,13
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 314:	48b9                	li	a7,14
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <hello>:
.global hello
hello:
 li a7, SYS_hello
 31c:	48d9                	li	a7,22
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <shutdown>:
.global shutdown
shutdown:
 li a7, SYS_shutdown
 324:	48dd                	li	a7,23
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <mkfifo>:
.global mkfifo
mkfifo:
 li a7, SYS_mkfifo
 32c:	48e1                	li	a7,24
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 334:	1101                	addi	sp,sp,-32
 336:	ec06                	sd	ra,24(sp)
 338:	e822                	sd	s0,16(sp)
 33a:	1000                	addi	s0,sp,32
 33c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 340:	4605                	li	a2,1
 342:	fef40593          	addi	a1,s0,-17
 346:	f57ff0ef          	jal	29c <write>
}
 34a:	60e2                	ld	ra,24(sp)
 34c:	6442                	ld	s0,16(sp)
 34e:	6105                	addi	sp,sp,32
 350:	8082                	ret

0000000000000352 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 352:	7139                	addi	sp,sp,-64
 354:	fc06                	sd	ra,56(sp)
 356:	f822                	sd	s0,48(sp)
 358:	f426                	sd	s1,40(sp)
 35a:	0080                	addi	s0,sp,64
 35c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 35e:	c299                	beqz	a3,364 <printint+0x12>
 360:	0805c963          	bltz	a1,3f2 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 364:	2581                	sext.w	a1,a1
  neg = 0;
 366:	4881                	li	a7,0
 368:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 36c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 36e:	2601                	sext.w	a2,a2
 370:	00000517          	auipc	a0,0x0
 374:	4f850513          	addi	a0,a0,1272 # 868 <digits>
 378:	883a                	mv	a6,a4
 37a:	2705                	addiw	a4,a4,1
 37c:	02c5f7bb          	remuw	a5,a1,a2
 380:	1782                	slli	a5,a5,0x20
 382:	9381                	srli	a5,a5,0x20
 384:	97aa                	add	a5,a5,a0
 386:	0007c783          	lbu	a5,0(a5)
 38a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 38e:	0005879b          	sext.w	a5,a1
 392:	02c5d5bb          	divuw	a1,a1,a2
 396:	0685                	addi	a3,a3,1
 398:	fec7f0e3          	bgeu	a5,a2,378 <printint+0x26>
  if(neg)
 39c:	00088c63          	beqz	a7,3b4 <printint+0x62>
    buf[i++] = '-';
 3a0:	fd070793          	addi	a5,a4,-48
 3a4:	00878733          	add	a4,a5,s0
 3a8:	02d00793          	li	a5,45
 3ac:	fef70823          	sb	a5,-16(a4)
 3b0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 3b4:	02e05a63          	blez	a4,3e8 <printint+0x96>
 3b8:	f04a                	sd	s2,32(sp)
 3ba:	ec4e                	sd	s3,24(sp)
 3bc:	fc040793          	addi	a5,s0,-64
 3c0:	00e78933          	add	s2,a5,a4
 3c4:	fff78993          	addi	s3,a5,-1
 3c8:	99ba                	add	s3,s3,a4
 3ca:	377d                	addiw	a4,a4,-1
 3cc:	1702                	slli	a4,a4,0x20
 3ce:	9301                	srli	a4,a4,0x20
 3d0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 3d4:	fff94583          	lbu	a1,-1(s2)
 3d8:	8526                	mv	a0,s1
 3da:	f5bff0ef          	jal	334 <putc>
  while(--i >= 0)
 3de:	197d                	addi	s2,s2,-1
 3e0:	ff391ae3          	bne	s2,s3,3d4 <printint+0x82>
 3e4:	7902                	ld	s2,32(sp)
 3e6:	69e2                	ld	s3,24(sp)
}
 3e8:	70e2                	ld	ra,56(sp)
 3ea:	7442                	ld	s0,48(sp)
 3ec:	74a2                	ld	s1,40(sp)
 3ee:	6121                	addi	sp,sp,64
 3f0:	8082                	ret
    x = -xx;
 3f2:	40b005bb          	negw	a1,a1
    neg = 1;
 3f6:	4885                	li	a7,1
    x = -xx;
 3f8:	bf85                	j	368 <printint+0x16>

00000000000003fa <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 3fa:	711d                	addi	sp,sp,-96
 3fc:	ec86                	sd	ra,88(sp)
 3fe:	e8a2                	sd	s0,80(sp)
 400:	e0ca                	sd	s2,64(sp)
 402:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 404:	0005c903          	lbu	s2,0(a1)
 408:	26090863          	beqz	s2,678 <vprintf+0x27e>
 40c:	e4a6                	sd	s1,72(sp)
 40e:	fc4e                	sd	s3,56(sp)
 410:	f852                	sd	s4,48(sp)
 412:	f456                	sd	s5,40(sp)
 414:	f05a                	sd	s6,32(sp)
 416:	ec5e                	sd	s7,24(sp)
 418:	e862                	sd	s8,16(sp)
 41a:	e466                	sd	s9,8(sp)
 41c:	8b2a                	mv	s6,a0
 41e:	8a2e                	mv	s4,a1
 420:	8bb2                	mv	s7,a2
  state = 0;
 422:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 424:	4481                	li	s1,0
 426:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 428:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 42c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 430:	06c00c93          	li	s9,108
 434:	a005                	j	454 <vprintf+0x5a>
        putc(fd, c0);
 436:	85ca                	mv	a1,s2
 438:	855a                	mv	a0,s6
 43a:	efbff0ef          	jal	334 <putc>
 43e:	a019                	j	444 <vprintf+0x4a>
    } else if(state == '%'){
 440:	03598263          	beq	s3,s5,464 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 444:	2485                	addiw	s1,s1,1
 446:	8726                	mv	a4,s1
 448:	009a07b3          	add	a5,s4,s1
 44c:	0007c903          	lbu	s2,0(a5)
 450:	20090c63          	beqz	s2,668 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 454:	0009079b          	sext.w	a5,s2
    if(state == 0){
 458:	fe0994e3          	bnez	s3,440 <vprintf+0x46>
      if(c0 == '%'){
 45c:	fd579de3          	bne	a5,s5,436 <vprintf+0x3c>
        state = '%';
 460:	89be                	mv	s3,a5
 462:	b7cd                	j	444 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 464:	00ea06b3          	add	a3,s4,a4
 468:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 46c:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 46e:	c681                	beqz	a3,476 <vprintf+0x7c>
 470:	9752                	add	a4,a4,s4
 472:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 476:	03878f63          	beq	a5,s8,4b4 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 47a:	05978963          	beq	a5,s9,4cc <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 47e:	07500713          	li	a4,117
 482:	0ee78363          	beq	a5,a4,568 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 486:	07800713          	li	a4,120
 48a:	12e78563          	beq	a5,a4,5b4 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 48e:	07000713          	li	a4,112
 492:	14e78a63          	beq	a5,a4,5e6 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 496:	07300713          	li	a4,115
 49a:	18e78a63          	beq	a5,a4,62e <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 49e:	02500713          	li	a4,37
 4a2:	04e79563          	bne	a5,a4,4ec <vprintf+0xf2>
        putc(fd, '%');
 4a6:	02500593          	li	a1,37
 4aa:	855a                	mv	a0,s6
 4ac:	e89ff0ef          	jal	334 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 4b0:	4981                	li	s3,0
 4b2:	bf49                	j	444 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 4b4:	008b8913          	addi	s2,s7,8
 4b8:	4685                	li	a3,1
 4ba:	4629                	li	a2,10
 4bc:	000ba583          	lw	a1,0(s7)
 4c0:	855a                	mv	a0,s6
 4c2:	e91ff0ef          	jal	352 <printint>
 4c6:	8bca                	mv	s7,s2
      state = 0;
 4c8:	4981                	li	s3,0
 4ca:	bfad                	j	444 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 4cc:	06400793          	li	a5,100
 4d0:	02f68963          	beq	a3,a5,502 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 4d4:	06c00793          	li	a5,108
 4d8:	04f68263          	beq	a3,a5,51c <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 4dc:	07500793          	li	a5,117
 4e0:	0af68063          	beq	a3,a5,580 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 4e4:	07800793          	li	a5,120
 4e8:	0ef68263          	beq	a3,a5,5cc <vprintf+0x1d2>
        putc(fd, '%');
 4ec:	02500593          	li	a1,37
 4f0:	855a                	mv	a0,s6
 4f2:	e43ff0ef          	jal	334 <putc>
        putc(fd, c0);
 4f6:	85ca                	mv	a1,s2
 4f8:	855a                	mv	a0,s6
 4fa:	e3bff0ef          	jal	334 <putc>
      state = 0;
 4fe:	4981                	li	s3,0
 500:	b791                	j	444 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 502:	008b8913          	addi	s2,s7,8
 506:	4685                	li	a3,1
 508:	4629                	li	a2,10
 50a:	000ba583          	lw	a1,0(s7)
 50e:	855a                	mv	a0,s6
 510:	e43ff0ef          	jal	352 <printint>
        i += 1;
 514:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 516:	8bca                	mv	s7,s2
      state = 0;
 518:	4981                	li	s3,0
        i += 1;
 51a:	b72d                	j	444 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 51c:	06400793          	li	a5,100
 520:	02f60763          	beq	a2,a5,54e <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 524:	07500793          	li	a5,117
 528:	06f60963          	beq	a2,a5,59a <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 52c:	07800793          	li	a5,120
 530:	faf61ee3          	bne	a2,a5,4ec <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 534:	008b8913          	addi	s2,s7,8
 538:	4681                	li	a3,0
 53a:	4641                	li	a2,16
 53c:	000ba583          	lw	a1,0(s7)
 540:	855a                	mv	a0,s6
 542:	e11ff0ef          	jal	352 <printint>
        i += 2;
 546:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 548:	8bca                	mv	s7,s2
      state = 0;
 54a:	4981                	li	s3,0
        i += 2;
 54c:	bde5                	j	444 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 54e:	008b8913          	addi	s2,s7,8
 552:	4685                	li	a3,1
 554:	4629                	li	a2,10
 556:	000ba583          	lw	a1,0(s7)
 55a:	855a                	mv	a0,s6
 55c:	df7ff0ef          	jal	352 <printint>
        i += 2;
 560:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 562:	8bca                	mv	s7,s2
      state = 0;
 564:	4981                	li	s3,0
        i += 2;
 566:	bdf9                	j	444 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 568:	008b8913          	addi	s2,s7,8
 56c:	4681                	li	a3,0
 56e:	4629                	li	a2,10
 570:	000ba583          	lw	a1,0(s7)
 574:	855a                	mv	a0,s6
 576:	dddff0ef          	jal	352 <printint>
 57a:	8bca                	mv	s7,s2
      state = 0;
 57c:	4981                	li	s3,0
 57e:	b5d9                	j	444 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 580:	008b8913          	addi	s2,s7,8
 584:	4681                	li	a3,0
 586:	4629                	li	a2,10
 588:	000ba583          	lw	a1,0(s7)
 58c:	855a                	mv	a0,s6
 58e:	dc5ff0ef          	jal	352 <printint>
        i += 1;
 592:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 594:	8bca                	mv	s7,s2
      state = 0;
 596:	4981                	li	s3,0
        i += 1;
 598:	b575                	j	444 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 59a:	008b8913          	addi	s2,s7,8
 59e:	4681                	li	a3,0
 5a0:	4629                	li	a2,10
 5a2:	000ba583          	lw	a1,0(s7)
 5a6:	855a                	mv	a0,s6
 5a8:	dabff0ef          	jal	352 <printint>
        i += 2;
 5ac:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 5ae:	8bca                	mv	s7,s2
      state = 0;
 5b0:	4981                	li	s3,0
        i += 2;
 5b2:	bd49                	j	444 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 5b4:	008b8913          	addi	s2,s7,8
 5b8:	4681                	li	a3,0
 5ba:	4641                	li	a2,16
 5bc:	000ba583          	lw	a1,0(s7)
 5c0:	855a                	mv	a0,s6
 5c2:	d91ff0ef          	jal	352 <printint>
 5c6:	8bca                	mv	s7,s2
      state = 0;
 5c8:	4981                	li	s3,0
 5ca:	bdad                	j	444 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5cc:	008b8913          	addi	s2,s7,8
 5d0:	4681                	li	a3,0
 5d2:	4641                	li	a2,16
 5d4:	000ba583          	lw	a1,0(s7)
 5d8:	855a                	mv	a0,s6
 5da:	d79ff0ef          	jal	352 <printint>
        i += 1;
 5de:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 5e0:	8bca                	mv	s7,s2
      state = 0;
 5e2:	4981                	li	s3,0
        i += 1;
 5e4:	b585                	j	444 <vprintf+0x4a>
 5e6:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 5e8:	008b8d13          	addi	s10,s7,8
 5ec:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5f0:	03000593          	li	a1,48
 5f4:	855a                	mv	a0,s6
 5f6:	d3fff0ef          	jal	334 <putc>
  putc(fd, 'x');
 5fa:	07800593          	li	a1,120
 5fe:	855a                	mv	a0,s6
 600:	d35ff0ef          	jal	334 <putc>
 604:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 606:	00000b97          	auipc	s7,0x0
 60a:	262b8b93          	addi	s7,s7,610 # 868 <digits>
 60e:	03c9d793          	srli	a5,s3,0x3c
 612:	97de                	add	a5,a5,s7
 614:	0007c583          	lbu	a1,0(a5)
 618:	855a                	mv	a0,s6
 61a:	d1bff0ef          	jal	334 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 61e:	0992                	slli	s3,s3,0x4
 620:	397d                	addiw	s2,s2,-1
 622:	fe0916e3          	bnez	s2,60e <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 626:	8bea                	mv	s7,s10
      state = 0;
 628:	4981                	li	s3,0
 62a:	6d02                	ld	s10,0(sp)
 62c:	bd21                	j	444 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 62e:	008b8993          	addi	s3,s7,8
 632:	000bb903          	ld	s2,0(s7)
 636:	00090f63          	beqz	s2,654 <vprintf+0x25a>
        for(; *s; s++)
 63a:	00094583          	lbu	a1,0(s2)
 63e:	c195                	beqz	a1,662 <vprintf+0x268>
          putc(fd, *s);
 640:	855a                	mv	a0,s6
 642:	cf3ff0ef          	jal	334 <putc>
        for(; *s; s++)
 646:	0905                	addi	s2,s2,1
 648:	00094583          	lbu	a1,0(s2)
 64c:	f9f5                	bnez	a1,640 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 64e:	8bce                	mv	s7,s3
      state = 0;
 650:	4981                	li	s3,0
 652:	bbcd                	j	444 <vprintf+0x4a>
          s = "(null)";
 654:	00000917          	auipc	s2,0x0
 658:	20c90913          	addi	s2,s2,524 # 860 <malloc+0x100>
        for(; *s; s++)
 65c:	02800593          	li	a1,40
 660:	b7c5                	j	640 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 662:	8bce                	mv	s7,s3
      state = 0;
 664:	4981                	li	s3,0
 666:	bbf9                	j	444 <vprintf+0x4a>
 668:	64a6                	ld	s1,72(sp)
 66a:	79e2                	ld	s3,56(sp)
 66c:	7a42                	ld	s4,48(sp)
 66e:	7aa2                	ld	s5,40(sp)
 670:	7b02                	ld	s6,32(sp)
 672:	6be2                	ld	s7,24(sp)
 674:	6c42                	ld	s8,16(sp)
 676:	6ca2                	ld	s9,8(sp)
    }
  }
}
 678:	60e6                	ld	ra,88(sp)
 67a:	6446                	ld	s0,80(sp)
 67c:	6906                	ld	s2,64(sp)
 67e:	6125                	addi	sp,sp,96
 680:	8082                	ret

0000000000000682 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 682:	715d                	addi	sp,sp,-80
 684:	ec06                	sd	ra,24(sp)
 686:	e822                	sd	s0,16(sp)
 688:	1000                	addi	s0,sp,32
 68a:	e010                	sd	a2,0(s0)
 68c:	e414                	sd	a3,8(s0)
 68e:	e818                	sd	a4,16(s0)
 690:	ec1c                	sd	a5,24(s0)
 692:	03043023          	sd	a6,32(s0)
 696:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 69a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 69e:	8622                	mv	a2,s0
 6a0:	d5bff0ef          	jal	3fa <vprintf>
}
 6a4:	60e2                	ld	ra,24(sp)
 6a6:	6442                	ld	s0,16(sp)
 6a8:	6161                	addi	sp,sp,80
 6aa:	8082                	ret

00000000000006ac <printf>:

void
printf(const char *fmt, ...)
{
 6ac:	711d                	addi	sp,sp,-96
 6ae:	ec06                	sd	ra,24(sp)
 6b0:	e822                	sd	s0,16(sp)
 6b2:	1000                	addi	s0,sp,32
 6b4:	e40c                	sd	a1,8(s0)
 6b6:	e810                	sd	a2,16(s0)
 6b8:	ec14                	sd	a3,24(s0)
 6ba:	f018                	sd	a4,32(s0)
 6bc:	f41c                	sd	a5,40(s0)
 6be:	03043823          	sd	a6,48(s0)
 6c2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6c6:	00840613          	addi	a2,s0,8
 6ca:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6ce:	85aa                	mv	a1,a0
 6d0:	4505                	li	a0,1
 6d2:	d29ff0ef          	jal	3fa <vprintf>
}
 6d6:	60e2                	ld	ra,24(sp)
 6d8:	6442                	ld	s0,16(sp)
 6da:	6125                	addi	sp,sp,96
 6dc:	8082                	ret

00000000000006de <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6de:	1141                	addi	sp,sp,-16
 6e0:	e422                	sd	s0,8(sp)
 6e2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6e4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e8:	00001797          	auipc	a5,0x1
 6ec:	9187b783          	ld	a5,-1768(a5) # 1000 <freep>
 6f0:	a02d                	j	71a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6f2:	4618                	lw	a4,8(a2)
 6f4:	9f2d                	addw	a4,a4,a1
 6f6:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6fa:	6398                	ld	a4,0(a5)
 6fc:	6310                	ld	a2,0(a4)
 6fe:	a83d                	j	73c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 700:	ff852703          	lw	a4,-8(a0)
 704:	9f31                	addw	a4,a4,a2
 706:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 708:	ff053683          	ld	a3,-16(a0)
 70c:	a091                	j	750 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70e:	6398                	ld	a4,0(a5)
 710:	00e7e463          	bltu	a5,a4,718 <free+0x3a>
 714:	00e6ea63          	bltu	a3,a4,728 <free+0x4a>
{
 718:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 71a:	fed7fae3          	bgeu	a5,a3,70e <free+0x30>
 71e:	6398                	ld	a4,0(a5)
 720:	00e6e463          	bltu	a3,a4,728 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 724:	fee7eae3          	bltu	a5,a4,718 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 728:	ff852583          	lw	a1,-8(a0)
 72c:	6390                	ld	a2,0(a5)
 72e:	02059813          	slli	a6,a1,0x20
 732:	01c85713          	srli	a4,a6,0x1c
 736:	9736                	add	a4,a4,a3
 738:	fae60de3          	beq	a2,a4,6f2 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 73c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 740:	4790                	lw	a2,8(a5)
 742:	02061593          	slli	a1,a2,0x20
 746:	01c5d713          	srli	a4,a1,0x1c
 74a:	973e                	add	a4,a4,a5
 74c:	fae68ae3          	beq	a3,a4,700 <free+0x22>
    p->s.ptr = bp->s.ptr;
 750:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 752:	00001717          	auipc	a4,0x1
 756:	8af73723          	sd	a5,-1874(a4) # 1000 <freep>
}
 75a:	6422                	ld	s0,8(sp)
 75c:	0141                	addi	sp,sp,16
 75e:	8082                	ret

0000000000000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	7139                	addi	sp,sp,-64
 762:	fc06                	sd	ra,56(sp)
 764:	f822                	sd	s0,48(sp)
 766:	f426                	sd	s1,40(sp)
 768:	ec4e                	sd	s3,24(sp)
 76a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 76c:	02051493          	slli	s1,a0,0x20
 770:	9081                	srli	s1,s1,0x20
 772:	04bd                	addi	s1,s1,15
 774:	8091                	srli	s1,s1,0x4
 776:	0014899b          	addiw	s3,s1,1
 77a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 77c:	00001517          	auipc	a0,0x1
 780:	88453503          	ld	a0,-1916(a0) # 1000 <freep>
 784:	c915                	beqz	a0,7b8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 786:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 788:	4798                	lw	a4,8(a5)
 78a:	08977a63          	bgeu	a4,s1,81e <malloc+0xbe>
 78e:	f04a                	sd	s2,32(sp)
 790:	e852                	sd	s4,16(sp)
 792:	e456                	sd	s5,8(sp)
 794:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 796:	8a4e                	mv	s4,s3
 798:	0009871b          	sext.w	a4,s3
 79c:	6685                	lui	a3,0x1
 79e:	00d77363          	bgeu	a4,a3,7a4 <malloc+0x44>
 7a2:	6a05                	lui	s4,0x1
 7a4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7a8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7ac:	00001917          	auipc	s2,0x1
 7b0:	85490913          	addi	s2,s2,-1964 # 1000 <freep>
  if(p == (char*)-1)
 7b4:	5afd                	li	s5,-1
 7b6:	a081                	j	7f6 <malloc+0x96>
 7b8:	f04a                	sd	s2,32(sp)
 7ba:	e852                	sd	s4,16(sp)
 7bc:	e456                	sd	s5,8(sp)
 7be:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 7c0:	00001797          	auipc	a5,0x1
 7c4:	85078793          	addi	a5,a5,-1968 # 1010 <base>
 7c8:	00001717          	auipc	a4,0x1
 7cc:	82f73c23          	sd	a5,-1992(a4) # 1000 <freep>
 7d0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7d2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7d6:	b7c1                	j	796 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 7d8:	6398                	ld	a4,0(a5)
 7da:	e118                	sd	a4,0(a0)
 7dc:	a8a9                	j	836 <malloc+0xd6>
  hp->s.size = nu;
 7de:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7e2:	0541                	addi	a0,a0,16
 7e4:	efbff0ef          	jal	6de <free>
  return freep;
 7e8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 7ec:	c12d                	beqz	a0,84e <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ee:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7f0:	4798                	lw	a4,8(a5)
 7f2:	02977263          	bgeu	a4,s1,816 <malloc+0xb6>
    if(p == freep)
 7f6:	00093703          	ld	a4,0(s2)
 7fa:	853e                	mv	a0,a5
 7fc:	fef719e3          	bne	a4,a5,7ee <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 800:	8552                	mv	a0,s4
 802:	b03ff0ef          	jal	304 <sbrk>
  if(p == (char*)-1)
 806:	fd551ce3          	bne	a0,s5,7de <malloc+0x7e>
        return 0;
 80a:	4501                	li	a0,0
 80c:	7902                	ld	s2,32(sp)
 80e:	6a42                	ld	s4,16(sp)
 810:	6aa2                	ld	s5,8(sp)
 812:	6b02                	ld	s6,0(sp)
 814:	a03d                	j	842 <malloc+0xe2>
 816:	7902                	ld	s2,32(sp)
 818:	6a42                	ld	s4,16(sp)
 81a:	6aa2                	ld	s5,8(sp)
 81c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 81e:	fae48de3          	beq	s1,a4,7d8 <malloc+0x78>
        p->s.size -= nunits;
 822:	4137073b          	subw	a4,a4,s3
 826:	c798                	sw	a4,8(a5)
        p += p->s.size;
 828:	02071693          	slli	a3,a4,0x20
 82c:	01c6d713          	srli	a4,a3,0x1c
 830:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 832:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 836:	00000717          	auipc	a4,0x0
 83a:	7ca73523          	sd	a0,1994(a4) # 1000 <freep>
      return (void*)(p + 1);
 83e:	01078513          	addi	a0,a5,16
  }
}
 842:	70e2                	ld	ra,56(sp)
 844:	7442                	ld	s0,48(sp)
 846:	74a2                	ld	s1,40(sp)
 848:	69e2                	ld	s3,24(sp)
 84a:	6121                	addi	sp,sp,64
 84c:	8082                	ret
 84e:	7902                	ld	s2,32(sp)
 850:	6a42                	ld	s4,16(sp)
 852:	6aa2                	ld	s5,8(sp)
 854:	6b02                	ld	s6,0(sp)
 856:	b7f5                	j	842 <malloc+0xe2>
