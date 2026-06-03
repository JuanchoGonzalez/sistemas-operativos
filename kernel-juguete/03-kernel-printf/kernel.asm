
kernel:     formato del fichero elf32-littleriscv


Desensamblado de la sección .text:

80000000 <boot>:
80000000:	f1402273          	csrr	tp,mhartid
80000004:	00000117          	auipc	sp,0x0
80000008:	76810113          	addi	sp,sp,1896 # 8000076c <__bss>
8000000c:	000012b7          	lui	t0,0x1
80000010:	00120313          	addi	t1,tp,1 # 1 <boot-0x7fffffff>
80000014:	026282b3          	mul	t0,t0,t1
80000018:	00510133          	add	sp,sp,t0
8000001c:	00000297          	auipc	t0,0x0
80000020:	05028293          	addi	t0,t0,80 # 8000006c <supervisor>
80000024:	34129073          	csrw	mepc,t0
80000028:	01f00f13          	li	t5,31
8000002c:	3a0f1073          	csrw	pmpcfg0,t5
80000030:	fff00f93          	li	t6,-1
80000034:	3b0f9073          	csrw	pmpaddr0,t6
80000038:	300023f3          	csrr	t2,mstatus
8000003c:	ffffee37          	lui	t3,0xffffe
80000040:	7ffe0e13          	addi	t3,t3,2047 # ffffe7ff <__kernel_end+0x7ffde093>
80000044:	01c3f3b3          	and	t2,t2,t3
80000048:	00001eb7          	lui	t4,0x1
8000004c:	800e8e93          	addi	t4,t4,-2048 # 800 <boot-0x7ffff800>
80000050:	01d3e3b3          	or	t2,t2,t4
80000054:	30039073          	csrw	mstatus,t2
80000058:	00010f37          	lui	t5,0x10
8000005c:	ffff0f13          	addi	t5,t5,-1 # ffff <boot-0x7fff0001>
80000060:	302f2073          	csrs	medeleg,t5
80000064:	303f2073          	csrs	mideleg,t5
80000068:	30200073          	mret

8000006c <supervisor>:
8000006c:	18001073          	csrw	satp,zero
80000070:	094000ef          	jal	80000104 <kernel_main>

80000074 <cpuid>:
80000074:	00020513          	mv	a0,tp
80000078:	00008067          	ret

8000007c <disable_interrupts>:
8000007c:	10017073          	csrci	sstatus,2
80000080:	00008067          	ret

80000084 <enable_interrupts>:
80000084:	10016073          	csrsi	sstatus,2
80000088:	00008067          	ret

8000008c <console_putc>:
8000008c:	ff010113          	addi	sp,sp,-16
80000090:	00812623          	sw	s0,12(sp)
80000094:	01010413          	addi	s0,sp,16
80000098:	10000737          	lui	a4,0x10000
8000009c:	00570713          	addi	a4,a4,5 # 10000005 <boot-0x6ffffffb>
800000a0:	00074783          	lbu	a5,0(a4)
800000a4:	0207f793          	andi	a5,a5,32
800000a8:	fe078ce3          	beqz	a5,800000a0 <console_putc+0x14>
800000ac:	100007b7          	lui	a5,0x10000
800000b0:	00a78023          	sb	a0,0(a5) # 10000000 <boot-0x70000000>
800000b4:	00c12403          	lw	s0,12(sp)
800000b8:	01010113          	addi	sp,sp,16
800000bc:	00008067          	ret

800000c0 <console_puts>:
800000c0:	ff010113          	addi	sp,sp,-16
800000c4:	00112623          	sw	ra,12(sp)
800000c8:	00812423          	sw	s0,8(sp)
800000cc:	00912223          	sw	s1,4(sp)
800000d0:	01010413          	addi	s0,sp,16
800000d4:	00050493          	mv	s1,a0
800000d8:	00054503          	lbu	a0,0(a0)
800000dc:	00050a63          	beqz	a0,800000f0 <console_puts+0x30>
800000e0:	00148493          	addi	s1,s1,1
800000e4:	fa9ff0ef          	jal	8000008c <console_putc>
800000e8:	0004c503          	lbu	a0,0(s1)
800000ec:	fe051ae3          	bnez	a0,800000e0 <console_puts+0x20>
800000f0:	00c12083          	lw	ra,12(sp)
800000f4:	00812403          	lw	s0,8(sp)
800000f8:	00412483          	lw	s1,4(sp)
800000fc:	01010113          	addi	sp,sp,16
80000100:	00008067          	ret

80000104 <kernel_main>:
80000104:	ff010113          	addi	sp,sp,-16
80000108:	00112623          	sw	ra,12(sp)
8000010c:	00812423          	sw	s0,8(sp)
80000110:	01010413          	addi	s0,sp,16
80000114:	f61ff0ef          	jal	80000074 <cpuid>
80000118:	02050063          	beqz	a0,80000138 <kernel_main+0x34>
8000011c:	00a00613          	li	a2,10
80000120:	00000597          	auipc	a1,0x0
80000124:	3d458593          	addi	a1,a1,980 # 800004f4 <release+0x54>
80000128:	00000517          	auipc	a0,0x0
8000012c:	3d850513          	addi	a0,a0,984 # 80000500 <release+0x60>
80000130:	128000ef          	jal	80000258 <printf>
80000134:	0000006f          	j	80000134 <kernel_main+0x30>
80000138:	00000597          	auipc	a1,0x0
8000013c:	39858593          	addi	a1,a1,920 # 800004d0 <release+0x30>
80000140:	00000517          	auipc	a0,0x0
80000144:	39850513          	addi	a0,a0,920 # 800004d8 <release+0x38>
80000148:	110000ef          	jal	80000258 <printf>
8000014c:	1234b637          	lui	a2,0x1234b
80000150:	bcd60613          	addi	a2,a2,-1075 # 1234abcd <boot-0x6dcb5433>
80000154:	00300593          	li	a1,3
80000158:	00000517          	auipc	a0,0x0
8000015c:	38c50513          	addi	a0,a0,908 # 800004e4 <release+0x44>
80000160:	0f8000ef          	jal	80000258 <printf>
80000164:	fb9ff06f          	j	8000011c <kernel_main+0x18>

80000168 <memset>:
80000168:	ff010113          	addi	sp,sp,-16
8000016c:	00812623          	sw	s0,12(sp)
80000170:	01010413          	addi	s0,sp,16
80000174:	00060c63          	beqz	a2,8000018c <memset+0x24>
80000178:	00c50633          	add	a2,a0,a2
8000017c:	00050793          	mv	a5,a0
80000180:	00178793          	addi	a5,a5,1
80000184:	feb78fa3          	sb	a1,-1(a5)
80000188:	fef61ce3          	bne	a2,a5,80000180 <memset+0x18>
8000018c:	00c12403          	lw	s0,12(sp)
80000190:	01010113          	addi	sp,sp,16
80000194:	00008067          	ret

80000198 <memcpy>:
80000198:	ff010113          	addi	sp,sp,-16
8000019c:	00812623          	sw	s0,12(sp)
800001a0:	01010413          	addi	s0,sp,16
800001a4:	02060063          	beqz	a2,800001c4 <memcpy+0x2c>
800001a8:	00c50633          	add	a2,a0,a2
800001ac:	00050793          	mv	a5,a0
800001b0:	00158593          	addi	a1,a1,1
800001b4:	00178793          	addi	a5,a5,1
800001b8:	fff5c703          	lbu	a4,-1(a1)
800001bc:	fee78fa3          	sb	a4,-1(a5)
800001c0:	fef618e3          	bne	a2,a5,800001b0 <memcpy+0x18>
800001c4:	00c12403          	lw	s0,12(sp)
800001c8:	01010113          	addi	sp,sp,16
800001cc:	00008067          	ret

800001d0 <strcpy>:
800001d0:	ff010113          	addi	sp,sp,-16
800001d4:	00812623          	sw	s0,12(sp)
800001d8:	01010413          	addi	s0,sp,16
800001dc:	0005c783          	lbu	a5,0(a1)
800001e0:	02078663          	beqz	a5,8000020c <strcpy+0x3c>
800001e4:	00050713          	mv	a4,a0
800001e8:	00158593          	addi	a1,a1,1
800001ec:	00170713          	addi	a4,a4,1
800001f0:	fef70fa3          	sb	a5,-1(a4)
800001f4:	0005c783          	lbu	a5,0(a1)
800001f8:	fe0798e3          	bnez	a5,800001e8 <strcpy+0x18>
800001fc:	00070023          	sb	zero,0(a4)
80000200:	00c12403          	lw	s0,12(sp)
80000204:	01010113          	addi	sp,sp,16
80000208:	00008067          	ret
8000020c:	00050713          	mv	a4,a0
80000210:	fedff06f          	j	800001fc <strcpy+0x2c>

80000214 <strcmp>:
80000214:	ff010113          	addi	sp,sp,-16
80000218:	00812623          	sw	s0,12(sp)
8000021c:	01010413          	addi	s0,sp,16
80000220:	00054783          	lbu	a5,0(a0)
80000224:	02078063          	beqz	a5,80000244 <strcmp+0x30>
80000228:	0005c703          	lbu	a4,0(a1)
8000022c:	00070c63          	beqz	a4,80000244 <strcmp+0x30>
80000230:	00f71a63          	bne	a4,a5,80000244 <strcmp+0x30>
80000234:	00150513          	addi	a0,a0,1
80000238:	00158593          	addi	a1,a1,1
8000023c:	00054783          	lbu	a5,0(a0)
80000240:	fe0794e3          	bnez	a5,80000228 <strcmp+0x14>
80000244:	0005c503          	lbu	a0,0(a1)
80000248:	40a78533          	sub	a0,a5,a0
8000024c:	00c12403          	lw	s0,12(sp)
80000250:	01010113          	addi	sp,sp,16
80000254:	00008067          	ret

80000258 <printf>:
80000258:	fa010113          	addi	sp,sp,-96
8000025c:	02112e23          	sw	ra,60(sp)
80000260:	02812c23          	sw	s0,56(sp)
80000264:	02912a23          	sw	s1,52(sp)
80000268:	04010413          	addi	s0,sp,64
8000026c:	00050493          	mv	s1,a0
80000270:	00b42223          	sw	a1,4(s0)
80000274:	00c42423          	sw	a2,8(s0)
80000278:	00d42623          	sw	a3,12(s0)
8000027c:	00e42823          	sw	a4,16(s0)
80000280:	00f42a23          	sw	a5,20(s0)
80000284:	01042c23          	sw	a6,24(s0)
80000288:	01142e23          	sw	a7,28(s0)
8000028c:	00440793          	addi	a5,s0,4
80000290:	fcf42623          	sw	a5,-52(s0)
80000294:	00054503          	lbu	a0,0(a0)
80000298:	06050663          	beqz	a0,80000304 <printf+0xac>
8000029c:	03212823          	sw	s2,48(sp)
800002a0:	03312623          	sw	s3,44(sp)
800002a4:	03412423          	sw	s4,40(sp)
800002a8:	03512223          	sw	s5,36(sp)
800002ac:	03612023          	sw	s6,32(sp)
800002b0:	01712e23          	sw	s7,28(sp)
800002b4:	01812c23          	sw	s8,24(sp)
800002b8:	02500993          	li	s3,37
800002bc:	06400a13          	li	s4,100
800002c0:	07300a93          	li	s5,115
800002c4:	1180006f          	j	800003dc <printf+0x184>
800002c8:	00078c63          	beqz	a5,800002e0 <printf+0x88>
800002cc:	02500713          	li	a4,37
800002d0:	10e79063          	bne	a5,a4,800003d0 <printf+0x178>
800002d4:	02500513          	li	a0,37
800002d8:	db5ff0ef          	jal	8000008c <console_putc>
800002dc:	0f40006f          	j	800003d0 <printf+0x178>
800002e0:	02500513          	li	a0,37
800002e4:	da9ff0ef          	jal	8000008c <console_putc>
800002e8:	03012903          	lw	s2,48(sp)
800002ec:	02c12983          	lw	s3,44(sp)
800002f0:	02812a03          	lw	s4,40(sp)
800002f4:	02412a83          	lw	s5,36(sp)
800002f8:	02012b03          	lw	s6,32(sp)
800002fc:	01c12b83          	lw	s7,28(sp)
80000300:	01812c03          	lw	s8,24(sp)
80000304:	03c12083          	lw	ra,60(sp)
80000308:	03812403          	lw	s0,56(sp)
8000030c:	03412483          	lw	s1,52(sp)
80000310:	06010113          	addi	sp,sp,96
80000314:	00008067          	ret
80000318:	fcc42783          	lw	a5,-52(s0)
8000031c:	00478713          	addi	a4,a5,4
80000320:	fce42623          	sw	a4,-52(s0)
80000324:	0007a483          	lw	s1,0(a5)
80000328:	0004c503          	lbu	a0,0(s1)
8000032c:	0a050263          	beqz	a0,800003d0 <printf+0x178>
80000330:	d5dff0ef          	jal	8000008c <console_putc>
80000334:	00148493          	addi	s1,s1,1
80000338:	0004c503          	lbu	a0,0(s1)
8000033c:	fe051ae3          	bnez	a0,80000330 <printf+0xd8>
80000340:	0900006f          	j	800003d0 <printf+0x178>
80000344:	fcc42783          	lw	a5,-52(s0)
80000348:	00478713          	addi	a4,a5,4
8000034c:	fce42623          	sw	a4,-52(s0)
80000350:	0007ab03          	lw	s6,0(a5)
80000354:	040b4e63          	bltz	s6,800003b0 <printf+0x158>
80000358:	00900793          	li	a5,9
8000035c:	0767d263          	bge	a5,s6,800003c0 <printf+0x168>
80000360:	00100493          	li	s1,1
80000364:	00900713          	li	a4,9
80000368:	00249793          	slli	a5,s1,0x2
8000036c:	009787b3          	add	a5,a5,s1
80000370:	00179793          	slli	a5,a5,0x1
80000374:	00078493          	mv	s1,a5
80000378:	02fb47b3          	div	a5,s6,a5
8000037c:	fef746e3          	blt	a4,a5,80000368 <printf+0x110>
80000380:	04905863          	blez	s1,800003d0 <printf+0x178>
80000384:	00a00c13          	li	s8,10
80000388:	00900b93          	li	s7,9
8000038c:	029b4533          	div	a0,s6,s1
80000390:	03050513          	addi	a0,a0,48
80000394:	0ff57513          	zext.b	a0,a0
80000398:	cf5ff0ef          	jal	8000008c <console_putc>
8000039c:	029b6b33          	rem	s6,s6,s1
800003a0:	00048793          	mv	a5,s1
800003a4:	0384c4b3          	div	s1,s1,s8
800003a8:	fefbc2e3          	blt	s7,a5,8000038c <printf+0x134>
800003ac:	0240006f          	j	800003d0 <printf+0x178>
800003b0:	02d00513          	li	a0,45
800003b4:	cd9ff0ef          	jal	8000008c <console_putc>
800003b8:	41600b33          	neg	s6,s6
800003bc:	f9dff06f          	j	80000358 <printf+0x100>
800003c0:	00100493          	li	s1,1
800003c4:	fc1ff06f          	j	80000384 <printf+0x12c>
800003c8:	cc5ff0ef          	jal	8000008c <console_putc>
800003cc:	00048913          	mv	s2,s1
800003d0:	00190493          	addi	s1,s2,1
800003d4:	00194503          	lbu	a0,1(s2)
800003d8:	06050263          	beqz	a0,8000043c <printf+0x1e4>
800003dc:	ff3516e3          	bne	a0,s3,800003c8 <printf+0x170>
800003e0:	00148913          	addi	s2,s1,1
800003e4:	0014c783          	lbu	a5,1(s1)
800003e8:	f5478ee3          	beq	a5,s4,80000344 <printf+0xec>
800003ec:	ecfa7ee3          	bgeu	s4,a5,800002c8 <printf+0x70>
800003f0:	f35784e3          	beq	a5,s5,80000318 <printf+0xc0>
800003f4:	07800713          	li	a4,120
800003f8:	fce79ce3          	bne	a5,a4,800003d0 <printf+0x178>
800003fc:	fcc42783          	lw	a5,-52(s0)
80000400:	00478713          	addi	a4,a5,4
80000404:	fce42623          	sw	a4,-52(s0)
80000408:	0007ac03          	lw	s8,0(a5)
8000040c:	01c00493          	li	s1,28
80000410:	00000b97          	auipc	s7,0x0
80000414:	10cb8b93          	addi	s7,s7,268 # 8000051c <release+0x7c>
80000418:	ffc00b13          	li	s6,-4
8000041c:	409c57b3          	sra	a5,s8,s1
80000420:	00f7f793          	andi	a5,a5,15
80000424:	00fb87b3          	add	a5,s7,a5
80000428:	0007c503          	lbu	a0,0(a5)
8000042c:	c61ff0ef          	jal	8000008c <console_putc>
80000430:	ffc48493          	addi	s1,s1,-4
80000434:	ff6494e3          	bne	s1,s6,8000041c <printf+0x1c4>
80000438:	f99ff06f          	j	800003d0 <printf+0x178>
8000043c:	03012903          	lw	s2,48(sp)
80000440:	02c12983          	lw	s3,44(sp)
80000444:	02812a03          	lw	s4,40(sp)
80000448:	02412a83          	lw	s5,36(sp)
8000044c:	02012b03          	lw	s6,32(sp)
80000450:	01c12b83          	lw	s7,28(sp)
80000454:	01812c03          	lw	s8,24(sp)
80000458:	eadff06f          	j	80000304 <printf+0xac>

8000045c <acquire>:
8000045c:	ff010113          	addi	sp,sp,-16
80000460:	00112623          	sw	ra,12(sp)
80000464:	00812423          	sw	s0,8(sp)
80000468:	00912223          	sw	s1,4(sp)
8000046c:	01010413          	addi	s0,sp,16
80000470:	00050493          	mv	s1,a0
80000474:	c09ff0ef          	jal	8000007c <disable_interrupts>
80000478:	00100713          	li	a4,1
8000047c:	00070793          	mv	a5,a4
80000480:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
80000484:	fe079ce3          	bnez	a5,8000047c <acquire+0x20>
80000488:	0330000f          	fence	rw,rw
8000048c:	00c12083          	lw	ra,12(sp)
80000490:	00812403          	lw	s0,8(sp)
80000494:	00412483          	lw	s1,4(sp)
80000498:	01010113          	addi	sp,sp,16
8000049c:	00008067          	ret

800004a0 <release>:
800004a0:	ff010113          	addi	sp,sp,-16
800004a4:	00112623          	sw	ra,12(sp)
800004a8:	00812423          	sw	s0,8(sp)
800004ac:	01010413          	addi	s0,sp,16
800004b0:	0330000f          	fence	rw,rw
800004b4:	0310000f          	fence	rw,w
800004b8:	00052023          	sw	zero,0(a0)
800004bc:	bc9ff0ef          	jal	80000084 <enable_interrupts>
800004c0:	00c12083          	lw	ra,12(sp)
800004c4:	00812403          	lw	s0,8(sp)
800004c8:	01010113          	addi	sp,sp,16
800004cc:	00008067          	ret
