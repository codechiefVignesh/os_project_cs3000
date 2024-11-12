
user/_fifo_int:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fcntl.h"
#include "user/user.h"

#define BUFSIZE 512

int main(int argc, char *argv[]) {
   0:	dd010113          	addi	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	1c00                	addi	s0,sp,560
    if(argc != 2) {
   e:	4789                	li	a5,2
  10:	02f50263          	beq	a0,a5,34 <main+0x34>
  14:	20913c23          	sd	s1,536(sp)
  18:	21213823          	sd	s2,528(sp)
  1c:	21313423          	sd	s3,520(sp)
        fprintf(2, "Usage: fifo_interactive <fifo_path>\n");
  20:	00001597          	auipc	a1,0x1
  24:	91058593          	addi	a1,a1,-1776 # 930 <malloc+0x106>
  28:	4509                	li	a0,2
  2a:	722000ef          	jal	74c <fprintf>
        exit(1);
  2e:	4505                	li	a0,1
  30:	316000ef          	jal	346 <exit>
  34:	20913c23          	sd	s1,536(sp)
  38:	21213823          	sd	s2,528(sp)
  3c:	84ae                	mv	s1,a1
    }

    int fd = open(argv[1], O_WRONLY);
  3e:	4585                	li	a1,1
  40:	6488                	ld	a0,8(s1)
  42:	344000ef          	jal	386 <open>
  46:	892a                	mv	s2,a0
    if(fd < 0) {
  48:	06054763          	bltz	a0,b6 <main+0xb6>
  4c:	21313423          	sd	s3,520(sp)
        fprintf(2, "fifo_interactive: cannot open %s\n", argv[1]);
        exit(1);
    }

    printf("Enter messages (one per line):\n");
  50:	00001517          	auipc	a0,0x1
  54:	93850513          	addi	a0,a0,-1736 # 988 <malloc+0x15e>
  58:	71e000ef          	jal	776 <printf>
    
    char buf[BUFSIZE];
    int n;

    while(1) {
        printf("> ");  // Prompt for input
  5c:	00001997          	auipc	s3,0x1
  60:	94c98993          	addi	s3,s3,-1716 # 9a8 <malloc+0x17e>
  64:	854e                	mv	a0,s3
  66:	710000ef          	jal	776 <printf>
        memset(buf, 0, BUFSIZE);  // Clear buffer
  6a:	20000613          	li	a2,512
  6e:	4581                	li	a1,0
  70:	dd040513          	addi	a0,s0,-560
  74:	0ec000ef          	jal	160 <memset>
        
        // Read from stdin (console)
        if((n = read(0, buf, BUFSIZE)) <= 0) {
  78:	20000613          	li	a2,512
  7c:	dd040593          	addi	a1,s0,-560
  80:	4501                	li	a0,0
  82:	2dc000ef          	jal	35e <read>
  86:	84aa                	mv	s1,a0
  88:	04a05463          	blez	a0,d0 <main+0xd0>
            break;
        }

        // Write to FIFO
        if(write(fd, buf, n) != n) {
  8c:	862a                	mv	a2,a0
  8e:	dd040593          	addi	a1,s0,-560
  92:	854a                	mv	a0,s2
  94:	2d2000ef          	jal	366 <write>
  98:	fc9506e3          	beq	a0,s1,64 <main+0x64>
            fprintf(2, "fifo_interactive: write error\n");
  9c:	00001597          	auipc	a1,0x1
  a0:	91458593          	addi	a1,a1,-1772 # 9b0 <malloc+0x186>
  a4:	4509                	li	a0,2
  a6:	6a6000ef          	jal	74c <fprintf>
            close(fd);
  aa:	854a                	mv	a0,s2
  ac:	2c2000ef          	jal	36e <close>
            exit(1);
  b0:	4505                	li	a0,1
  b2:	294000ef          	jal	346 <exit>
  b6:	21313423          	sd	s3,520(sp)
        fprintf(2, "fifo_interactive: cannot open %s\n", argv[1]);
  ba:	6490                	ld	a2,8(s1)
  bc:	00001597          	auipc	a1,0x1
  c0:	8a458593          	addi	a1,a1,-1884 # 960 <malloc+0x136>
  c4:	4509                	li	a0,2
  c6:	686000ef          	jal	74c <fprintf>
        exit(1);
  ca:	4505                	li	a0,1
  cc:	27a000ef          	jal	346 <exit>
        }
    }

    close(fd);
  d0:	854a                	mv	a0,s2
  d2:	29c000ef          	jal	36e <close>
    exit(0);
  d6:	4501                	li	a0,0
  d8:	26e000ef          	jal	346 <exit>

00000000000000dc <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  dc:	1141                	addi	sp,sp,-16
  de:	e406                	sd	ra,8(sp)
  e0:	e022                	sd	s0,0(sp)
  e2:	0800                	addi	s0,sp,16
  extern int main();
  main();
  e4:	f1dff0ef          	jal	0 <main>
  exit(0);
  e8:	4501                	li	a0,0
  ea:	25c000ef          	jal	346 <exit>

00000000000000ee <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  ee:	1141                	addi	sp,sp,-16
  f0:	e422                	sd	s0,8(sp)
  f2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f4:	87aa                	mv	a5,a0
  f6:	0585                	addi	a1,a1,1
  f8:	0785                	addi	a5,a5,1
  fa:	fff5c703          	lbu	a4,-1(a1)
  fe:	fee78fa3          	sb	a4,-1(a5)
 102:	fb75                	bnez	a4,f6 <strcpy+0x8>
    ;
  return os;
}
 104:	6422                	ld	s0,8(sp)
 106:	0141                	addi	sp,sp,16
 108:	8082                	ret

000000000000010a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 10a:	1141                	addi	sp,sp,-16
 10c:	e422                	sd	s0,8(sp)
 10e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 110:	00054783          	lbu	a5,0(a0)
 114:	cb91                	beqz	a5,128 <strcmp+0x1e>
 116:	0005c703          	lbu	a4,0(a1)
 11a:	00f71763          	bne	a4,a5,128 <strcmp+0x1e>
    p++, q++;
 11e:	0505                	addi	a0,a0,1
 120:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 122:	00054783          	lbu	a5,0(a0)
 126:	fbe5                	bnez	a5,116 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 128:	0005c503          	lbu	a0,0(a1)
}
 12c:	40a7853b          	subw	a0,a5,a0
 130:	6422                	ld	s0,8(sp)
 132:	0141                	addi	sp,sp,16
 134:	8082                	ret

0000000000000136 <strlen>:

uint
strlen(const char *s)
{
 136:	1141                	addi	sp,sp,-16
 138:	e422                	sd	s0,8(sp)
 13a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 13c:	00054783          	lbu	a5,0(a0)
 140:	cf91                	beqz	a5,15c <strlen+0x26>
 142:	0505                	addi	a0,a0,1
 144:	87aa                	mv	a5,a0
 146:	86be                	mv	a3,a5
 148:	0785                	addi	a5,a5,1
 14a:	fff7c703          	lbu	a4,-1(a5)
 14e:	ff65                	bnez	a4,146 <strlen+0x10>
 150:	40a6853b          	subw	a0,a3,a0
 154:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 156:	6422                	ld	s0,8(sp)
 158:	0141                	addi	sp,sp,16
 15a:	8082                	ret
  for(n = 0; s[n]; n++)
 15c:	4501                	li	a0,0
 15e:	bfe5                	j	156 <strlen+0x20>

0000000000000160 <memset>:

void*
memset(void *dst, int c, uint n)
{
 160:	1141                	addi	sp,sp,-16
 162:	e422                	sd	s0,8(sp)
 164:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 166:	ca19                	beqz	a2,17c <memset+0x1c>
 168:	87aa                	mv	a5,a0
 16a:	1602                	slli	a2,a2,0x20
 16c:	9201                	srli	a2,a2,0x20
 16e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 172:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 176:	0785                	addi	a5,a5,1
 178:	fee79de3          	bne	a5,a4,172 <memset+0x12>
  }
  return dst;
}
 17c:	6422                	ld	s0,8(sp)
 17e:	0141                	addi	sp,sp,16
 180:	8082                	ret

0000000000000182 <strchr>:

char*
strchr(const char *s, char c)
{
 182:	1141                	addi	sp,sp,-16
 184:	e422                	sd	s0,8(sp)
 186:	0800                	addi	s0,sp,16
  for(; *s; s++)
 188:	00054783          	lbu	a5,0(a0)
 18c:	cb99                	beqz	a5,1a2 <strchr+0x20>
    if(*s == c)
 18e:	00f58763          	beq	a1,a5,19c <strchr+0x1a>
  for(; *s; s++)
 192:	0505                	addi	a0,a0,1
 194:	00054783          	lbu	a5,0(a0)
 198:	fbfd                	bnez	a5,18e <strchr+0xc>
      return (char*)s;
  return 0;
 19a:	4501                	li	a0,0
}
 19c:	6422                	ld	s0,8(sp)
 19e:	0141                	addi	sp,sp,16
 1a0:	8082                	ret
  return 0;
 1a2:	4501                	li	a0,0
 1a4:	bfe5                	j	19c <strchr+0x1a>

00000000000001a6 <gets>:

char*
gets(char *buf, int max)
{
 1a6:	711d                	addi	sp,sp,-96
 1a8:	ec86                	sd	ra,88(sp)
 1aa:	e8a2                	sd	s0,80(sp)
 1ac:	e4a6                	sd	s1,72(sp)
 1ae:	e0ca                	sd	s2,64(sp)
 1b0:	fc4e                	sd	s3,56(sp)
 1b2:	f852                	sd	s4,48(sp)
 1b4:	f456                	sd	s5,40(sp)
 1b6:	f05a                	sd	s6,32(sp)
 1b8:	ec5e                	sd	s7,24(sp)
 1ba:	1080                	addi	s0,sp,96
 1bc:	8baa                	mv	s7,a0
 1be:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c0:	892a                	mv	s2,a0
 1c2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1c4:	4aa9                	li	s5,10
 1c6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1c8:	89a6                	mv	s3,s1
 1ca:	2485                	addiw	s1,s1,1
 1cc:	0344d663          	bge	s1,s4,1f8 <gets+0x52>
    cc = read(0, &c, 1);
 1d0:	4605                	li	a2,1
 1d2:	faf40593          	addi	a1,s0,-81
 1d6:	4501                	li	a0,0
 1d8:	186000ef          	jal	35e <read>
    if(cc < 1)
 1dc:	00a05e63          	blez	a0,1f8 <gets+0x52>
    buf[i++] = c;
 1e0:	faf44783          	lbu	a5,-81(s0)
 1e4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1e8:	01578763          	beq	a5,s5,1f6 <gets+0x50>
 1ec:	0905                	addi	s2,s2,1
 1ee:	fd679de3          	bne	a5,s6,1c8 <gets+0x22>
    buf[i++] = c;
 1f2:	89a6                	mv	s3,s1
 1f4:	a011                	j	1f8 <gets+0x52>
 1f6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1f8:	99de                	add	s3,s3,s7
 1fa:	00098023          	sb	zero,0(s3)
  return buf;
}
 1fe:	855e                	mv	a0,s7
 200:	60e6                	ld	ra,88(sp)
 202:	6446                	ld	s0,80(sp)
 204:	64a6                	ld	s1,72(sp)
 206:	6906                	ld	s2,64(sp)
 208:	79e2                	ld	s3,56(sp)
 20a:	7a42                	ld	s4,48(sp)
 20c:	7aa2                	ld	s5,40(sp)
 20e:	7b02                	ld	s6,32(sp)
 210:	6be2                	ld	s7,24(sp)
 212:	6125                	addi	sp,sp,96
 214:	8082                	ret

0000000000000216 <stat>:

int
stat(const char *n, struct stat *st)
{
 216:	1101                	addi	sp,sp,-32
 218:	ec06                	sd	ra,24(sp)
 21a:	e822                	sd	s0,16(sp)
 21c:	e04a                	sd	s2,0(sp)
 21e:	1000                	addi	s0,sp,32
 220:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 222:	4581                	li	a1,0
 224:	162000ef          	jal	386 <open>
  if(fd < 0)
 228:	02054263          	bltz	a0,24c <stat+0x36>
 22c:	e426                	sd	s1,8(sp)
 22e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 230:	85ca                	mv	a1,s2
 232:	16c000ef          	jal	39e <fstat>
 236:	892a                	mv	s2,a0
  close(fd);
 238:	8526                	mv	a0,s1
 23a:	134000ef          	jal	36e <close>
  return r;
 23e:	64a2                	ld	s1,8(sp)
}
 240:	854a                	mv	a0,s2
 242:	60e2                	ld	ra,24(sp)
 244:	6442                	ld	s0,16(sp)
 246:	6902                	ld	s2,0(sp)
 248:	6105                	addi	sp,sp,32
 24a:	8082                	ret
    return -1;
 24c:	597d                	li	s2,-1
 24e:	bfcd                	j	240 <stat+0x2a>

0000000000000250 <atoi>:

int
atoi(const char *s)
{
 250:	1141                	addi	sp,sp,-16
 252:	e422                	sd	s0,8(sp)
 254:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 256:	00054683          	lbu	a3,0(a0)
 25a:	fd06879b          	addiw	a5,a3,-48
 25e:	0ff7f793          	zext.b	a5,a5
 262:	4625                	li	a2,9
 264:	02f66863          	bltu	a2,a5,294 <atoi+0x44>
 268:	872a                	mv	a4,a0
  n = 0;
 26a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 26c:	0705                	addi	a4,a4,1
 26e:	0025179b          	slliw	a5,a0,0x2
 272:	9fa9                	addw	a5,a5,a0
 274:	0017979b          	slliw	a5,a5,0x1
 278:	9fb5                	addw	a5,a5,a3
 27a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 27e:	00074683          	lbu	a3,0(a4)
 282:	fd06879b          	addiw	a5,a3,-48
 286:	0ff7f793          	zext.b	a5,a5
 28a:	fef671e3          	bgeu	a2,a5,26c <atoi+0x1c>
  return n;
}
 28e:	6422                	ld	s0,8(sp)
 290:	0141                	addi	sp,sp,16
 292:	8082                	ret
  n = 0;
 294:	4501                	li	a0,0
 296:	bfe5                	j	28e <atoi+0x3e>

0000000000000298 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 298:	1141                	addi	sp,sp,-16
 29a:	e422                	sd	s0,8(sp)
 29c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 29e:	02b57463          	bgeu	a0,a1,2c6 <memmove+0x2e>
    while(n-- > 0)
 2a2:	00c05f63          	blez	a2,2c0 <memmove+0x28>
 2a6:	1602                	slli	a2,a2,0x20
 2a8:	9201                	srli	a2,a2,0x20
 2aa:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2ae:	872a                	mv	a4,a0
      *dst++ = *src++;
 2b0:	0585                	addi	a1,a1,1
 2b2:	0705                	addi	a4,a4,1
 2b4:	fff5c683          	lbu	a3,-1(a1)
 2b8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2bc:	fef71ae3          	bne	a4,a5,2b0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret
    dst += n;
 2c6:	00c50733          	add	a4,a0,a2
    src += n;
 2ca:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2cc:	fec05ae3          	blez	a2,2c0 <memmove+0x28>
 2d0:	fff6079b          	addiw	a5,a2,-1
 2d4:	1782                	slli	a5,a5,0x20
 2d6:	9381                	srli	a5,a5,0x20
 2d8:	fff7c793          	not	a5,a5
 2dc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2de:	15fd                	addi	a1,a1,-1
 2e0:	177d                	addi	a4,a4,-1
 2e2:	0005c683          	lbu	a3,0(a1)
 2e6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2ea:	fee79ae3          	bne	a5,a4,2de <memmove+0x46>
 2ee:	bfc9                	j	2c0 <memmove+0x28>

00000000000002f0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2f0:	1141                	addi	sp,sp,-16
 2f2:	e422                	sd	s0,8(sp)
 2f4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2f6:	ca05                	beqz	a2,326 <memcmp+0x36>
 2f8:	fff6069b          	addiw	a3,a2,-1
 2fc:	1682                	slli	a3,a3,0x20
 2fe:	9281                	srli	a3,a3,0x20
 300:	0685                	addi	a3,a3,1
 302:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 304:	00054783          	lbu	a5,0(a0)
 308:	0005c703          	lbu	a4,0(a1)
 30c:	00e79863          	bne	a5,a4,31c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 310:	0505                	addi	a0,a0,1
    p2++;
 312:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 314:	fed518e3          	bne	a0,a3,304 <memcmp+0x14>
  }
  return 0;
 318:	4501                	li	a0,0
 31a:	a019                	j	320 <memcmp+0x30>
      return *p1 - *p2;
 31c:	40e7853b          	subw	a0,a5,a4
}
 320:	6422                	ld	s0,8(sp)
 322:	0141                	addi	sp,sp,16
 324:	8082                	ret
  return 0;
 326:	4501                	li	a0,0
 328:	bfe5                	j	320 <memcmp+0x30>

000000000000032a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 32a:	1141                	addi	sp,sp,-16
 32c:	e406                	sd	ra,8(sp)
 32e:	e022                	sd	s0,0(sp)
 330:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 332:	f67ff0ef          	jal	298 <memmove>
}
 336:	60a2                	ld	ra,8(sp)
 338:	6402                	ld	s0,0(sp)
 33a:	0141                	addi	sp,sp,16
 33c:	8082                	ret

000000000000033e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 33e:	4885                	li	a7,1
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <exit>:
.global exit
exit:
 li a7, SYS_exit
 346:	4889                	li	a7,2
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <wait>:
.global wait
wait:
 li a7, SYS_wait
 34e:	488d                	li	a7,3
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 356:	4891                	li	a7,4
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <read>:
.global read
read:
 li a7, SYS_read
 35e:	4895                	li	a7,5
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <write>:
.global write
write:
 li a7, SYS_write
 366:	48c1                	li	a7,16
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <close>:
.global close
close:
 li a7, SYS_close
 36e:	48d5                	li	a7,21
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <kill>:
.global kill
kill:
 li a7, SYS_kill
 376:	4899                	li	a7,6
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <exec>:
.global exec
exec:
 li a7, SYS_exec
 37e:	489d                	li	a7,7
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <open>:
.global open
open:
 li a7, SYS_open
 386:	48bd                	li	a7,15
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 38e:	48c5                	li	a7,17
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 396:	48c9                	li	a7,18
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 39e:	48a1                	li	a7,8
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <link>:
.global link
link:
 li a7, SYS_link
 3a6:	48cd                	li	a7,19
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ae:	48d1                	li	a7,20
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3b6:	48a5                	li	a7,9
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <dup>:
.global dup
dup:
 li a7, SYS_dup
 3be:	48a9                	li	a7,10
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3c6:	48ad                	li	a7,11
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3ce:	48b1                	li	a7,12
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3d6:	48b5                	li	a7,13
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3de:	48b9                	li	a7,14
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <hello>:
.global hello
hello:
 li a7, SYS_hello
 3e6:	48d9                	li	a7,22
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <shutdown>:
.global shutdown
shutdown:
 li a7, SYS_shutdown
 3ee:	48dd                	li	a7,23
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <mkfifo>:
.global mkfifo
mkfifo:
 li a7, SYS_mkfifo
 3f6:	48e1                	li	a7,24
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3fe:	1101                	addi	sp,sp,-32
 400:	ec06                	sd	ra,24(sp)
 402:	e822                	sd	s0,16(sp)
 404:	1000                	addi	s0,sp,32
 406:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 40a:	4605                	li	a2,1
 40c:	fef40593          	addi	a1,s0,-17
 410:	f57ff0ef          	jal	366 <write>
}
 414:	60e2                	ld	ra,24(sp)
 416:	6442                	ld	s0,16(sp)
 418:	6105                	addi	sp,sp,32
 41a:	8082                	ret

000000000000041c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 41c:	7139                	addi	sp,sp,-64
 41e:	fc06                	sd	ra,56(sp)
 420:	f822                	sd	s0,48(sp)
 422:	f426                	sd	s1,40(sp)
 424:	0080                	addi	s0,sp,64
 426:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 428:	c299                	beqz	a3,42e <printint+0x12>
 42a:	0805c963          	bltz	a1,4bc <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 42e:	2581                	sext.w	a1,a1
  neg = 0;
 430:	4881                	li	a7,0
 432:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 436:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 438:	2601                	sext.w	a2,a2
 43a:	00000517          	auipc	a0,0x0
 43e:	59e50513          	addi	a0,a0,1438 # 9d8 <digits>
 442:	883a                	mv	a6,a4
 444:	2705                	addiw	a4,a4,1
 446:	02c5f7bb          	remuw	a5,a1,a2
 44a:	1782                	slli	a5,a5,0x20
 44c:	9381                	srli	a5,a5,0x20
 44e:	97aa                	add	a5,a5,a0
 450:	0007c783          	lbu	a5,0(a5)
 454:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 458:	0005879b          	sext.w	a5,a1
 45c:	02c5d5bb          	divuw	a1,a1,a2
 460:	0685                	addi	a3,a3,1
 462:	fec7f0e3          	bgeu	a5,a2,442 <printint+0x26>
  if(neg)
 466:	00088c63          	beqz	a7,47e <printint+0x62>
    buf[i++] = '-';
 46a:	fd070793          	addi	a5,a4,-48
 46e:	00878733          	add	a4,a5,s0
 472:	02d00793          	li	a5,45
 476:	fef70823          	sb	a5,-16(a4)
 47a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 47e:	02e05a63          	blez	a4,4b2 <printint+0x96>
 482:	f04a                	sd	s2,32(sp)
 484:	ec4e                	sd	s3,24(sp)
 486:	fc040793          	addi	a5,s0,-64
 48a:	00e78933          	add	s2,a5,a4
 48e:	fff78993          	addi	s3,a5,-1
 492:	99ba                	add	s3,s3,a4
 494:	377d                	addiw	a4,a4,-1
 496:	1702                	slli	a4,a4,0x20
 498:	9301                	srli	a4,a4,0x20
 49a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 49e:	fff94583          	lbu	a1,-1(s2)
 4a2:	8526                	mv	a0,s1
 4a4:	f5bff0ef          	jal	3fe <putc>
  while(--i >= 0)
 4a8:	197d                	addi	s2,s2,-1
 4aa:	ff391ae3          	bne	s2,s3,49e <printint+0x82>
 4ae:	7902                	ld	s2,32(sp)
 4b0:	69e2                	ld	s3,24(sp)
}
 4b2:	70e2                	ld	ra,56(sp)
 4b4:	7442                	ld	s0,48(sp)
 4b6:	74a2                	ld	s1,40(sp)
 4b8:	6121                	addi	sp,sp,64
 4ba:	8082                	ret
    x = -xx;
 4bc:	40b005bb          	negw	a1,a1
    neg = 1;
 4c0:	4885                	li	a7,1
    x = -xx;
 4c2:	bf85                	j	432 <printint+0x16>

00000000000004c4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4c4:	711d                	addi	sp,sp,-96
 4c6:	ec86                	sd	ra,88(sp)
 4c8:	e8a2                	sd	s0,80(sp)
 4ca:	e0ca                	sd	s2,64(sp)
 4cc:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4ce:	0005c903          	lbu	s2,0(a1)
 4d2:	26090863          	beqz	s2,742 <vprintf+0x27e>
 4d6:	e4a6                	sd	s1,72(sp)
 4d8:	fc4e                	sd	s3,56(sp)
 4da:	f852                	sd	s4,48(sp)
 4dc:	f456                	sd	s5,40(sp)
 4de:	f05a                	sd	s6,32(sp)
 4e0:	ec5e                	sd	s7,24(sp)
 4e2:	e862                	sd	s8,16(sp)
 4e4:	e466                	sd	s9,8(sp)
 4e6:	8b2a                	mv	s6,a0
 4e8:	8a2e                	mv	s4,a1
 4ea:	8bb2                	mv	s7,a2
  state = 0;
 4ec:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 4ee:	4481                	li	s1,0
 4f0:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 4f2:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4f6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4fa:	06c00c93          	li	s9,108
 4fe:	a005                	j	51e <vprintf+0x5a>
        putc(fd, c0);
 500:	85ca                	mv	a1,s2
 502:	855a                	mv	a0,s6
 504:	efbff0ef          	jal	3fe <putc>
 508:	a019                	j	50e <vprintf+0x4a>
    } else if(state == '%'){
 50a:	03598263          	beq	s3,s5,52e <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 50e:	2485                	addiw	s1,s1,1
 510:	8726                	mv	a4,s1
 512:	009a07b3          	add	a5,s4,s1
 516:	0007c903          	lbu	s2,0(a5)
 51a:	20090c63          	beqz	s2,732 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 51e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 522:	fe0994e3          	bnez	s3,50a <vprintf+0x46>
      if(c0 == '%'){
 526:	fd579de3          	bne	a5,s5,500 <vprintf+0x3c>
        state = '%';
 52a:	89be                	mv	s3,a5
 52c:	b7cd                	j	50e <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 52e:	00ea06b3          	add	a3,s4,a4
 532:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 536:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 538:	c681                	beqz	a3,540 <vprintf+0x7c>
 53a:	9752                	add	a4,a4,s4
 53c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 540:	03878f63          	beq	a5,s8,57e <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 544:	05978963          	beq	a5,s9,596 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 548:	07500713          	li	a4,117
 54c:	0ee78363          	beq	a5,a4,632 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 550:	07800713          	li	a4,120
 554:	12e78563          	beq	a5,a4,67e <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 558:	07000713          	li	a4,112
 55c:	14e78a63          	beq	a5,a4,6b0 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 560:	07300713          	li	a4,115
 564:	18e78a63          	beq	a5,a4,6f8 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 568:	02500713          	li	a4,37
 56c:	04e79563          	bne	a5,a4,5b6 <vprintf+0xf2>
        putc(fd, '%');
 570:	02500593          	li	a1,37
 574:	855a                	mv	a0,s6
 576:	e89ff0ef          	jal	3fe <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 57a:	4981                	li	s3,0
 57c:	bf49                	j	50e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 57e:	008b8913          	addi	s2,s7,8
 582:	4685                	li	a3,1
 584:	4629                	li	a2,10
 586:	000ba583          	lw	a1,0(s7)
 58a:	855a                	mv	a0,s6
 58c:	e91ff0ef          	jal	41c <printint>
 590:	8bca                	mv	s7,s2
      state = 0;
 592:	4981                	li	s3,0
 594:	bfad                	j	50e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 596:	06400793          	li	a5,100
 59a:	02f68963          	beq	a3,a5,5cc <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 59e:	06c00793          	li	a5,108
 5a2:	04f68263          	beq	a3,a5,5e6 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 5a6:	07500793          	li	a5,117
 5aa:	0af68063          	beq	a3,a5,64a <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 5ae:	07800793          	li	a5,120
 5b2:	0ef68263          	beq	a3,a5,696 <vprintf+0x1d2>
        putc(fd, '%');
 5b6:	02500593          	li	a1,37
 5ba:	855a                	mv	a0,s6
 5bc:	e43ff0ef          	jal	3fe <putc>
        putc(fd, c0);
 5c0:	85ca                	mv	a1,s2
 5c2:	855a                	mv	a0,s6
 5c4:	e3bff0ef          	jal	3fe <putc>
      state = 0;
 5c8:	4981                	li	s3,0
 5ca:	b791                	j	50e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5cc:	008b8913          	addi	s2,s7,8
 5d0:	4685                	li	a3,1
 5d2:	4629                	li	a2,10
 5d4:	000ba583          	lw	a1,0(s7)
 5d8:	855a                	mv	a0,s6
 5da:	e43ff0ef          	jal	41c <printint>
        i += 1;
 5de:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5e0:	8bca                	mv	s7,s2
      state = 0;
 5e2:	4981                	li	s3,0
        i += 1;
 5e4:	b72d                	j	50e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5e6:	06400793          	li	a5,100
 5ea:	02f60763          	beq	a2,a5,618 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 5ee:	07500793          	li	a5,117
 5f2:	06f60963          	beq	a2,a5,664 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5f6:	07800793          	li	a5,120
 5fa:	faf61ee3          	bne	a2,a5,5b6 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5fe:	008b8913          	addi	s2,s7,8
 602:	4681                	li	a3,0
 604:	4641                	li	a2,16
 606:	000ba583          	lw	a1,0(s7)
 60a:	855a                	mv	a0,s6
 60c:	e11ff0ef          	jal	41c <printint>
        i += 2;
 610:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 612:	8bca                	mv	s7,s2
      state = 0;
 614:	4981                	li	s3,0
        i += 2;
 616:	bde5                	j	50e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 618:	008b8913          	addi	s2,s7,8
 61c:	4685                	li	a3,1
 61e:	4629                	li	a2,10
 620:	000ba583          	lw	a1,0(s7)
 624:	855a                	mv	a0,s6
 626:	df7ff0ef          	jal	41c <printint>
        i += 2;
 62a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 62c:	8bca                	mv	s7,s2
      state = 0;
 62e:	4981                	li	s3,0
        i += 2;
 630:	bdf9                	j	50e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 632:	008b8913          	addi	s2,s7,8
 636:	4681                	li	a3,0
 638:	4629                	li	a2,10
 63a:	000ba583          	lw	a1,0(s7)
 63e:	855a                	mv	a0,s6
 640:	dddff0ef          	jal	41c <printint>
 644:	8bca                	mv	s7,s2
      state = 0;
 646:	4981                	li	s3,0
 648:	b5d9                	j	50e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 64a:	008b8913          	addi	s2,s7,8
 64e:	4681                	li	a3,0
 650:	4629                	li	a2,10
 652:	000ba583          	lw	a1,0(s7)
 656:	855a                	mv	a0,s6
 658:	dc5ff0ef          	jal	41c <printint>
        i += 1;
 65c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 65e:	8bca                	mv	s7,s2
      state = 0;
 660:	4981                	li	s3,0
        i += 1;
 662:	b575                	j	50e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 664:	008b8913          	addi	s2,s7,8
 668:	4681                	li	a3,0
 66a:	4629                	li	a2,10
 66c:	000ba583          	lw	a1,0(s7)
 670:	855a                	mv	a0,s6
 672:	dabff0ef          	jal	41c <printint>
        i += 2;
 676:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 678:	8bca                	mv	s7,s2
      state = 0;
 67a:	4981                	li	s3,0
        i += 2;
 67c:	bd49                	j	50e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 67e:	008b8913          	addi	s2,s7,8
 682:	4681                	li	a3,0
 684:	4641                	li	a2,16
 686:	000ba583          	lw	a1,0(s7)
 68a:	855a                	mv	a0,s6
 68c:	d91ff0ef          	jal	41c <printint>
 690:	8bca                	mv	s7,s2
      state = 0;
 692:	4981                	li	s3,0
 694:	bdad                	j	50e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 696:	008b8913          	addi	s2,s7,8
 69a:	4681                	li	a3,0
 69c:	4641                	li	a2,16
 69e:	000ba583          	lw	a1,0(s7)
 6a2:	855a                	mv	a0,s6
 6a4:	d79ff0ef          	jal	41c <printint>
        i += 1;
 6a8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6aa:	8bca                	mv	s7,s2
      state = 0;
 6ac:	4981                	li	s3,0
        i += 1;
 6ae:	b585                	j	50e <vprintf+0x4a>
 6b0:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6b2:	008b8d13          	addi	s10,s7,8
 6b6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6ba:	03000593          	li	a1,48
 6be:	855a                	mv	a0,s6
 6c0:	d3fff0ef          	jal	3fe <putc>
  putc(fd, 'x');
 6c4:	07800593          	li	a1,120
 6c8:	855a                	mv	a0,s6
 6ca:	d35ff0ef          	jal	3fe <putc>
 6ce:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6d0:	00000b97          	auipc	s7,0x0
 6d4:	308b8b93          	addi	s7,s7,776 # 9d8 <digits>
 6d8:	03c9d793          	srli	a5,s3,0x3c
 6dc:	97de                	add	a5,a5,s7
 6de:	0007c583          	lbu	a1,0(a5)
 6e2:	855a                	mv	a0,s6
 6e4:	d1bff0ef          	jal	3fe <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6e8:	0992                	slli	s3,s3,0x4
 6ea:	397d                	addiw	s2,s2,-1
 6ec:	fe0916e3          	bnez	s2,6d8 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 6f0:	8bea                	mv	s7,s10
      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	6d02                	ld	s10,0(sp)
 6f6:	bd21                	j	50e <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 6f8:	008b8993          	addi	s3,s7,8
 6fc:	000bb903          	ld	s2,0(s7)
 700:	00090f63          	beqz	s2,71e <vprintf+0x25a>
        for(; *s; s++)
 704:	00094583          	lbu	a1,0(s2)
 708:	c195                	beqz	a1,72c <vprintf+0x268>
          putc(fd, *s);
 70a:	855a                	mv	a0,s6
 70c:	cf3ff0ef          	jal	3fe <putc>
        for(; *s; s++)
 710:	0905                	addi	s2,s2,1
 712:	00094583          	lbu	a1,0(s2)
 716:	f9f5                	bnez	a1,70a <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 718:	8bce                	mv	s7,s3
      state = 0;
 71a:	4981                	li	s3,0
 71c:	bbcd                	j	50e <vprintf+0x4a>
          s = "(null)";
 71e:	00000917          	auipc	s2,0x0
 722:	2b290913          	addi	s2,s2,690 # 9d0 <malloc+0x1a6>
        for(; *s; s++)
 726:	02800593          	li	a1,40
 72a:	b7c5                	j	70a <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 72c:	8bce                	mv	s7,s3
      state = 0;
 72e:	4981                	li	s3,0
 730:	bbf9                	j	50e <vprintf+0x4a>
 732:	64a6                	ld	s1,72(sp)
 734:	79e2                	ld	s3,56(sp)
 736:	7a42                	ld	s4,48(sp)
 738:	7aa2                	ld	s5,40(sp)
 73a:	7b02                	ld	s6,32(sp)
 73c:	6be2                	ld	s7,24(sp)
 73e:	6c42                	ld	s8,16(sp)
 740:	6ca2                	ld	s9,8(sp)
    }
  }
}
 742:	60e6                	ld	ra,88(sp)
 744:	6446                	ld	s0,80(sp)
 746:	6906                	ld	s2,64(sp)
 748:	6125                	addi	sp,sp,96
 74a:	8082                	ret

000000000000074c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 74c:	715d                	addi	sp,sp,-80
 74e:	ec06                	sd	ra,24(sp)
 750:	e822                	sd	s0,16(sp)
 752:	1000                	addi	s0,sp,32
 754:	e010                	sd	a2,0(s0)
 756:	e414                	sd	a3,8(s0)
 758:	e818                	sd	a4,16(s0)
 75a:	ec1c                	sd	a5,24(s0)
 75c:	03043023          	sd	a6,32(s0)
 760:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 764:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 768:	8622                	mv	a2,s0
 76a:	d5bff0ef          	jal	4c4 <vprintf>
}
 76e:	60e2                	ld	ra,24(sp)
 770:	6442                	ld	s0,16(sp)
 772:	6161                	addi	sp,sp,80
 774:	8082                	ret

0000000000000776 <printf>:

void
printf(const char *fmt, ...)
{
 776:	711d                	addi	sp,sp,-96
 778:	ec06                	sd	ra,24(sp)
 77a:	e822                	sd	s0,16(sp)
 77c:	1000                	addi	s0,sp,32
 77e:	e40c                	sd	a1,8(s0)
 780:	e810                	sd	a2,16(s0)
 782:	ec14                	sd	a3,24(s0)
 784:	f018                	sd	a4,32(s0)
 786:	f41c                	sd	a5,40(s0)
 788:	03043823          	sd	a6,48(s0)
 78c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 790:	00840613          	addi	a2,s0,8
 794:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 798:	85aa                	mv	a1,a0
 79a:	4505                	li	a0,1
 79c:	d29ff0ef          	jal	4c4 <vprintf>
}
 7a0:	60e2                	ld	ra,24(sp)
 7a2:	6442                	ld	s0,16(sp)
 7a4:	6125                	addi	sp,sp,96
 7a6:	8082                	ret

00000000000007a8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a8:	1141                	addi	sp,sp,-16
 7aa:	e422                	sd	s0,8(sp)
 7ac:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ae:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b2:	00001797          	auipc	a5,0x1
 7b6:	84e7b783          	ld	a5,-1970(a5) # 1000 <freep>
 7ba:	a02d                	j	7e4 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7bc:	4618                	lw	a4,8(a2)
 7be:	9f2d                	addw	a4,a4,a1
 7c0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c4:	6398                	ld	a4,0(a5)
 7c6:	6310                	ld	a2,0(a4)
 7c8:	a83d                	j	806 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7ca:	ff852703          	lw	a4,-8(a0)
 7ce:	9f31                	addw	a4,a4,a2
 7d0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7d2:	ff053683          	ld	a3,-16(a0)
 7d6:	a091                	j	81a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d8:	6398                	ld	a4,0(a5)
 7da:	00e7e463          	bltu	a5,a4,7e2 <free+0x3a>
 7de:	00e6ea63          	bltu	a3,a4,7f2 <free+0x4a>
{
 7e2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e4:	fed7fae3          	bgeu	a5,a3,7d8 <free+0x30>
 7e8:	6398                	ld	a4,0(a5)
 7ea:	00e6e463          	bltu	a3,a4,7f2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ee:	fee7eae3          	bltu	a5,a4,7e2 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7f2:	ff852583          	lw	a1,-8(a0)
 7f6:	6390                	ld	a2,0(a5)
 7f8:	02059813          	slli	a6,a1,0x20
 7fc:	01c85713          	srli	a4,a6,0x1c
 800:	9736                	add	a4,a4,a3
 802:	fae60de3          	beq	a2,a4,7bc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 806:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 80a:	4790                	lw	a2,8(a5)
 80c:	02061593          	slli	a1,a2,0x20
 810:	01c5d713          	srli	a4,a1,0x1c
 814:	973e                	add	a4,a4,a5
 816:	fae68ae3          	beq	a3,a4,7ca <free+0x22>
    p->s.ptr = bp->s.ptr;
 81a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 81c:	00000717          	auipc	a4,0x0
 820:	7ef73223          	sd	a5,2020(a4) # 1000 <freep>
}
 824:	6422                	ld	s0,8(sp)
 826:	0141                	addi	sp,sp,16
 828:	8082                	ret

000000000000082a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 82a:	7139                	addi	sp,sp,-64
 82c:	fc06                	sd	ra,56(sp)
 82e:	f822                	sd	s0,48(sp)
 830:	f426                	sd	s1,40(sp)
 832:	ec4e                	sd	s3,24(sp)
 834:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 836:	02051493          	slli	s1,a0,0x20
 83a:	9081                	srli	s1,s1,0x20
 83c:	04bd                	addi	s1,s1,15
 83e:	8091                	srli	s1,s1,0x4
 840:	0014899b          	addiw	s3,s1,1
 844:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 846:	00000517          	auipc	a0,0x0
 84a:	7ba53503          	ld	a0,1978(a0) # 1000 <freep>
 84e:	c915                	beqz	a0,882 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 850:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 852:	4798                	lw	a4,8(a5)
 854:	08977a63          	bgeu	a4,s1,8e8 <malloc+0xbe>
 858:	f04a                	sd	s2,32(sp)
 85a:	e852                	sd	s4,16(sp)
 85c:	e456                	sd	s5,8(sp)
 85e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 860:	8a4e                	mv	s4,s3
 862:	0009871b          	sext.w	a4,s3
 866:	6685                	lui	a3,0x1
 868:	00d77363          	bgeu	a4,a3,86e <malloc+0x44>
 86c:	6a05                	lui	s4,0x1
 86e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 872:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 876:	00000917          	auipc	s2,0x0
 87a:	78a90913          	addi	s2,s2,1930 # 1000 <freep>
  if(p == (char*)-1)
 87e:	5afd                	li	s5,-1
 880:	a081                	j	8c0 <malloc+0x96>
 882:	f04a                	sd	s2,32(sp)
 884:	e852                	sd	s4,16(sp)
 886:	e456                	sd	s5,8(sp)
 888:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 88a:	00000797          	auipc	a5,0x0
 88e:	78678793          	addi	a5,a5,1926 # 1010 <base>
 892:	00000717          	auipc	a4,0x0
 896:	76f73723          	sd	a5,1902(a4) # 1000 <freep>
 89a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 89c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8a0:	b7c1                	j	860 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 8a2:	6398                	ld	a4,0(a5)
 8a4:	e118                	sd	a4,0(a0)
 8a6:	a8a9                	j	900 <malloc+0xd6>
  hp->s.size = nu;
 8a8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8ac:	0541                	addi	a0,a0,16
 8ae:	efbff0ef          	jal	7a8 <free>
  return freep;
 8b2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8b6:	c12d                	beqz	a0,918 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ba:	4798                	lw	a4,8(a5)
 8bc:	02977263          	bgeu	a4,s1,8e0 <malloc+0xb6>
    if(p == freep)
 8c0:	00093703          	ld	a4,0(s2)
 8c4:	853e                	mv	a0,a5
 8c6:	fef719e3          	bne	a4,a5,8b8 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 8ca:	8552                	mv	a0,s4
 8cc:	b03ff0ef          	jal	3ce <sbrk>
  if(p == (char*)-1)
 8d0:	fd551ce3          	bne	a0,s5,8a8 <malloc+0x7e>
        return 0;
 8d4:	4501                	li	a0,0
 8d6:	7902                	ld	s2,32(sp)
 8d8:	6a42                	ld	s4,16(sp)
 8da:	6aa2                	ld	s5,8(sp)
 8dc:	6b02                	ld	s6,0(sp)
 8de:	a03d                	j	90c <malloc+0xe2>
 8e0:	7902                	ld	s2,32(sp)
 8e2:	6a42                	ld	s4,16(sp)
 8e4:	6aa2                	ld	s5,8(sp)
 8e6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8e8:	fae48de3          	beq	s1,a4,8a2 <malloc+0x78>
        p->s.size -= nunits;
 8ec:	4137073b          	subw	a4,a4,s3
 8f0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8f2:	02071693          	slli	a3,a4,0x20
 8f6:	01c6d713          	srli	a4,a3,0x1c
 8fa:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8fc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 900:	00000717          	auipc	a4,0x0
 904:	70a73023          	sd	a0,1792(a4) # 1000 <freep>
      return (void*)(p + 1);
 908:	01078513          	addi	a0,a5,16
  }
}
 90c:	70e2                	ld	ra,56(sp)
 90e:	7442                	ld	s0,48(sp)
 910:	74a2                	ld	s1,40(sp)
 912:	69e2                	ld	s3,24(sp)
 914:	6121                	addi	sp,sp,64
 916:	8082                	ret
 918:	7902                	ld	s2,32(sp)
 91a:	6a42                	ld	s4,16(sp)
 91c:	6aa2                	ld	s5,8(sp)
 91e:	6b02                	ld	s6,0(sp)
 920:	b7f5                	j	90c <malloc+0xe2>
