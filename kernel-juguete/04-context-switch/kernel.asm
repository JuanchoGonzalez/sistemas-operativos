
kernel:     formato del fichero elf32-littleriscv


Desensamblado de la sección .text:

80000000 <boot>:
80000000:	f1402273          	csrr	tp,mhartid
80000004:	00003117          	auipc	sp,0x3
80000008:	bf410113          	addi	sp,sp,-1036 # 80002bf8 <__bss_end>
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
80000040:	7ffe0e13          	addi	t3,t3,2047 # ffffe7ff <__kernel_end+0x7ffdbc07>
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
80000070:	26c000ef          	jal	800002dc <kernel_main>

80000074 <cpuid>:
80000074:	00020513          	mv	a0,tp
80000078:	00008067          	ret

8000007c <disable_interrupts>:
8000007c:	10017073          	csrci	sstatus,2
80000080:	00008067          	ret

80000084 <enable_interrupts>:
80000084:	10016073          	csrsi	sstatus,2
80000088:	00008067          	ret

8000008c <context_switch>:
8000008c:	fcc10113          	addi	sp,sp,-52
80000090:	00112023          	sw	ra,0(sp)
80000094:	00812223          	sw	s0,4(sp)
80000098:	00912423          	sw	s1,8(sp)
8000009c:	01212623          	sw	s2,12(sp)
800000a0:	01312823          	sw	s3,16(sp)
800000a4:	01412a23          	sw	s4,20(sp)
800000a8:	01512c23          	sw	s5,24(sp)
800000ac:	01612e23          	sw	s6,28(sp)
800000b0:	03712023          	sw	s7,32(sp)
800000b4:	03812223          	sw	s8,36(sp)
800000b8:	03912423          	sw	s9,40(sp)
800000bc:	03a12623          	sw	s10,44(sp)
800000c0:	03b12823          	sw	s11,48(sp)
800000c4:	00252023          	sw	sp,0(a0)
800000c8:	0005a103          	lw	sp,0(a1)
800000cc:	00012083          	lw	ra,0(sp)
800000d0:	00412403          	lw	s0,4(sp)
800000d4:	00812483          	lw	s1,8(sp)
800000d8:	00c12903          	lw	s2,12(sp)
800000dc:	01012983          	lw	s3,16(sp)
800000e0:	01412a03          	lw	s4,20(sp)
800000e4:	01812a83          	lw	s5,24(sp)
800000e8:	01c12b03          	lw	s6,28(sp)
800000ec:	02012b83          	lw	s7,32(sp)
800000f0:	02412c03          	lw	s8,36(sp)
800000f4:	02812c83          	lw	s9,40(sp)
800000f8:	02c12d03          	lw	s10,44(sp)
800000fc:	03012d83          	lw	s11,48(sp)
80000100:	03410113          	addi	sp,sp,52
80000104:	00008067          	ret

80000108 <init_task_context>:
80000108:	ff010113          	addi	sp,sp,-16
8000010c:	00812623          	sw	s0,12(sp)
80000110:	01010413          	addi	s0,sp,16
80000114:	fe05ae23          	sw	zero,-4(a1)
80000118:	fe05ac23          	sw	zero,-8(a1)
8000011c:	fe05aa23          	sw	zero,-12(a1)
80000120:	fe05a823          	sw	zero,-16(a1)
80000124:	fe05a623          	sw	zero,-20(a1)
80000128:	fe05a423          	sw	zero,-24(a1)
8000012c:	fe05a223          	sw	zero,-28(a1)
80000130:	fe05a023          	sw	zero,-32(a1)
80000134:	fc05ae23          	sw	zero,-36(a1)
80000138:	fc05ac23          	sw	zero,-40(a1)
8000013c:	fc05aa23          	sw	zero,-44(a1)
80000140:	fc05a823          	sw	zero,-48(a1)
80000144:	fca5a623          	sw	a0,-52(a1)
80000148:	fcc58513          	addi	a0,a1,-52
8000014c:	00c12403          	lw	s0,12(sp)
80000150:	01010113          	addi	sp,sp,16
80000154:	00008067          	ret

80000158 <console_putc>:
80000158:	ff010113          	addi	sp,sp,-16
8000015c:	00812623          	sw	s0,12(sp)
80000160:	01010413          	addi	s0,sp,16
80000164:	10000737          	lui	a4,0x10000
80000168:	00570713          	addi	a4,a4,5 # 10000005 <boot-0x6ffffffb>
8000016c:	00074783          	lbu	a5,0(a4)
80000170:	0207f793          	andi	a5,a5,32
80000174:	fe078ce3          	beqz	a5,8000016c <console_putc+0x14>
80000178:	100007b7          	lui	a5,0x10000
8000017c:	00a78023          	sb	a0,0(a5) # 10000000 <boot-0x70000000>
80000180:	00c12403          	lw	s0,12(sp)
80000184:	01010113          	addi	sp,sp,16
80000188:	00008067          	ret

8000018c <console_puts>:
8000018c:	ff010113          	addi	sp,sp,-16
80000190:	00112623          	sw	ra,12(sp)
80000194:	00812423          	sw	s0,8(sp)
80000198:	00912223          	sw	s1,4(sp)
8000019c:	01010413          	addi	s0,sp,16
800001a0:	00050493          	mv	s1,a0
800001a4:	00054503          	lbu	a0,0(a0)
800001a8:	00050a63          	beqz	a0,800001bc <console_puts+0x30>
800001ac:	00148493          	addi	s1,s1,1
800001b0:	fa9ff0ef          	jal	80000158 <console_putc>
800001b4:	0004c503          	lbu	a0,0(s1)
800001b8:	fe051ae3          	bnez	a0,800001ac <console_puts+0x20>
800001bc:	00c12083          	lw	ra,12(sp)
800001c0:	00812403          	lw	s0,8(sp)
800001c4:	00412483          	lw	s1,4(sp)
800001c8:	01010113          	addi	sp,sp,16
800001cc:	00008067          	ret

800001d0 <task_a>:
800001d0:	ff010113          	addi	sp,sp,-16
800001d4:	00112623          	sw	ra,12(sp)
800001d8:	00812423          	sw	s0,8(sp)
800001dc:	01010413          	addi	s0,sp,16
800001e0:	e95ff0ef          	jal	80000074 <cpuid>
800001e4:	00050593          	mv	a1,a0
800001e8:	00000517          	auipc	a0,0x0
800001ec:	53450513          	addi	a0,a0,1332 # 8000071c <release+0x30>
800001f0:	2b4000ef          	jal	800004a4 <printf>
800001f4:	00000517          	auipc	a0,0x0
800001f8:	53c50513          	addi	a0,a0,1340 # 80000730 <release+0x44>
800001fc:	2a8000ef          	jal	800004a4 <printf>
80000200:	00003597          	auipc	a1,0x3
80000204:	9f058593          	addi	a1,a1,-1552 # 80002bf0 <task_b_sp>
80000208:	00003517          	auipc	a0,0x3
8000020c:	9ec50513          	addi	a0,a0,-1556 # 80002bf4 <task_a_sp>
80000210:	e7dff0ef          	jal	8000008c <context_switch>
80000214:	00000517          	auipc	a0,0x0
80000218:	54c50513          	addi	a0,a0,1356 # 80000760 <release+0x74>
8000021c:	288000ef          	jal	800004a4 <printf>
80000220:	00003597          	auipc	a1,0x3
80000224:	9cc58593          	addi	a1,a1,-1588 # 80002bec <main_thread_sp>
80000228:	00003517          	auipc	a0,0x3
8000022c:	9cc50513          	addi	a0,a0,-1588 # 80002bf4 <task_a_sp>
80000230:	e5dff0ef          	jal	8000008c <context_switch>
80000234:	00c12083          	lw	ra,12(sp)
80000238:	00812403          	lw	s0,8(sp)
8000023c:	01010113          	addi	sp,sp,16
80000240:	00008067          	ret

80000244 <task_b>:
80000244:	ff010113          	addi	sp,sp,-16
80000248:	00112623          	sw	ra,12(sp)
8000024c:	00812423          	sw	s0,8(sp)
80000250:	01010413          	addi	s0,sp,16
80000254:	e21ff0ef          	jal	80000074 <cpuid>
80000258:	00050593          	mv	a1,a0
8000025c:	00000517          	auipc	a0,0x0
80000260:	54050513          	addi	a0,a0,1344 # 8000079c <release+0xb0>
80000264:	240000ef          	jal	800004a4 <printf>
80000268:	00000517          	auipc	a0,0x0
8000026c:	54850513          	addi	a0,a0,1352 # 800007b0 <release+0xc4>
80000270:	234000ef          	jal	800004a4 <printf>
80000274:	00003597          	auipc	a1,0x3
80000278:	98058593          	addi	a1,a1,-1664 # 80002bf4 <task_a_sp>
8000027c:	00003517          	auipc	a0,0x3
80000280:	97450513          	addi	a0,a0,-1676 # 80002bf0 <task_b_sp>
80000284:	e09ff0ef          	jal	8000008c <context_switch>
80000288:	00000517          	auipc	a0,0x0
8000028c:	55850513          	addi	a0,a0,1368 # 800007e0 <release+0xf4>
80000290:	214000ef          	jal	800004a4 <printf>
80000294:	00003597          	auipc	a1,0x3
80000298:	95858593          	addi	a1,a1,-1704 # 80002bec <main_thread_sp>
8000029c:	00003517          	auipc	a0,0x3
800002a0:	95450513          	addi	a0,a0,-1708 # 80002bf0 <task_b_sp>
800002a4:	de9ff0ef          	jal	8000008c <context_switch>
800002a8:	00c12083          	lw	ra,12(sp)
800002ac:	00812403          	lw	s0,8(sp)
800002b0:	01010113          	addi	sp,sp,16
800002b4:	00008067          	ret

800002b8 <create_task>:
800002b8:	ff010113          	addi	sp,sp,-16
800002bc:	00112623          	sw	ra,12(sp)
800002c0:	00812423          	sw	s0,8(sp)
800002c4:	01010413          	addi	s0,sp,16
800002c8:	e41ff0ef          	jal	80000108 <init_task_context>
800002cc:	00c12083          	lw	ra,12(sp)
800002d0:	00812403          	lw	s0,8(sp)
800002d4:	01010113          	addi	sp,sp,16
800002d8:	00008067          	ret

800002dc <kernel_main>:
800002dc:	ff010113          	addi	sp,sp,-16
800002e0:	00112623          	sw	ra,12(sp)
800002e4:	00812423          	sw	s0,8(sp)
800002e8:	01010413          	addi	s0,sp,16
800002ec:	d89ff0ef          	jal	80000074 <cpuid>
800002f0:	02050063          	beqz	a0,80000310 <kernel_main+0x34>
800002f4:	04800613          	li	a2,72
800002f8:	00000597          	auipc	a1,0x0
800002fc:	5b858593          	addi	a1,a1,1464 # 800008b0 <release+0x1c4>
80000300:	00000517          	auipc	a0,0x0
80000304:	5bc50513          	addi	a0,a0,1468 # 800008bc <release+0x1d0>
80000308:	19c000ef          	jal	800004a4 <printf>
8000030c:	0000006f          	j	8000030c <kernel_main+0x30>
80000310:	00912223          	sw	s1,4(sp)
80000314:	01212023          	sw	s2,0(sp)
80000318:	00003597          	auipc	a1,0x3
8000031c:	8d458593          	addi	a1,a1,-1836 # 80002bec <main_thread_sp>
80000320:	00000517          	auipc	a0,0x0
80000324:	eb050513          	addi	a0,a0,-336 # 800001d0 <task_a>
80000328:	de1ff0ef          	jal	80000108 <init_task_context>
8000032c:	00003917          	auipc	s2,0x3
80000330:	8c890913          	addi	s2,s2,-1848 # 80002bf4 <task_a_sp>
80000334:	00a92023          	sw	a0,0(s2)
80000338:	00002597          	auipc	a1,0x2
8000033c:	8b458593          	addi	a1,a1,-1868 # 80001bec <stack_task_a>
80000340:	00000517          	auipc	a0,0x0
80000344:	f0450513          	addi	a0,a0,-252 # 80000244 <task_b>
80000348:	dc1ff0ef          	jal	80000108 <init_task_context>
8000034c:	00003497          	auipc	s1,0x3
80000350:	8a448493          	addi	s1,s1,-1884 # 80002bf0 <task_b_sp>
80000354:	00a4a023          	sw	a0,0(s1)
80000358:	00000517          	auipc	a0,0x0
8000035c:	4c450513          	addi	a0,a0,1220 # 8000081c <release+0x130>
80000360:	144000ef          	jal	800004a4 <printf>
80000364:	00000517          	auipc	a0,0x0
80000368:	4d450513          	addi	a0,a0,1236 # 80000838 <release+0x14c>
8000036c:	138000ef          	jal	800004a4 <printf>
80000370:	00090593          	mv	a1,s2
80000374:	00003517          	auipc	a0,0x3
80000378:	87850513          	addi	a0,a0,-1928 # 80002bec <main_thread_sp>
8000037c:	d11ff0ef          	jal	8000008c <context_switch>
80000380:	00000517          	auipc	a0,0x0
80000384:	4c450513          	addi	a0,a0,1220 # 80000844 <release+0x158>
80000388:	11c000ef          	jal	800004a4 <printf>
8000038c:	00048593          	mv	a1,s1
80000390:	00003517          	auipc	a0,0x3
80000394:	85c50513          	addi	a0,a0,-1956 # 80002bec <main_thread_sp>
80000398:	cf5ff0ef          	jal	8000008c <context_switch>
8000039c:	00000517          	auipc	a0,0x0
800003a0:	4f050513          	addi	a0,a0,1264 # 8000088c <release+0x1a0>
800003a4:	100000ef          	jal	800004a4 <printf>
800003a8:	00412483          	lw	s1,4(sp)
800003ac:	00012903          	lw	s2,0(sp)
800003b0:	f45ff06f          	j	800002f4 <kernel_main+0x18>

800003b4 <memset>:
800003b4:	ff010113          	addi	sp,sp,-16
800003b8:	00812623          	sw	s0,12(sp)
800003bc:	01010413          	addi	s0,sp,16
800003c0:	00060c63          	beqz	a2,800003d8 <memset+0x24>
800003c4:	00c50633          	add	a2,a0,a2
800003c8:	00050793          	mv	a5,a0
800003cc:	00178793          	addi	a5,a5,1
800003d0:	feb78fa3          	sb	a1,-1(a5)
800003d4:	fef61ce3          	bne	a2,a5,800003cc <memset+0x18>
800003d8:	00c12403          	lw	s0,12(sp)
800003dc:	01010113          	addi	sp,sp,16
800003e0:	00008067          	ret

800003e4 <memcpy>:
800003e4:	ff010113          	addi	sp,sp,-16
800003e8:	00812623          	sw	s0,12(sp)
800003ec:	01010413          	addi	s0,sp,16
800003f0:	02060063          	beqz	a2,80000410 <memcpy+0x2c>
800003f4:	00c50633          	add	a2,a0,a2
800003f8:	00050793          	mv	a5,a0
800003fc:	00158593          	addi	a1,a1,1
80000400:	00178793          	addi	a5,a5,1
80000404:	fff5c703          	lbu	a4,-1(a1)
80000408:	fee78fa3          	sb	a4,-1(a5)
8000040c:	fef618e3          	bne	a2,a5,800003fc <memcpy+0x18>
80000410:	00c12403          	lw	s0,12(sp)
80000414:	01010113          	addi	sp,sp,16
80000418:	00008067          	ret

8000041c <strcpy>:
8000041c:	ff010113          	addi	sp,sp,-16
80000420:	00812623          	sw	s0,12(sp)
80000424:	01010413          	addi	s0,sp,16
80000428:	0005c783          	lbu	a5,0(a1)
8000042c:	02078663          	beqz	a5,80000458 <strcpy+0x3c>
80000430:	00050713          	mv	a4,a0
80000434:	00158593          	addi	a1,a1,1
80000438:	00170713          	addi	a4,a4,1
8000043c:	fef70fa3          	sb	a5,-1(a4)
80000440:	0005c783          	lbu	a5,0(a1)
80000444:	fe0798e3          	bnez	a5,80000434 <strcpy+0x18>
80000448:	00070023          	sb	zero,0(a4)
8000044c:	00c12403          	lw	s0,12(sp)
80000450:	01010113          	addi	sp,sp,16
80000454:	00008067          	ret
80000458:	00050713          	mv	a4,a0
8000045c:	fedff06f          	j	80000448 <strcpy+0x2c>

80000460 <strcmp>:
80000460:	ff010113          	addi	sp,sp,-16
80000464:	00812623          	sw	s0,12(sp)
80000468:	01010413          	addi	s0,sp,16
8000046c:	00054783          	lbu	a5,0(a0)
80000470:	02078063          	beqz	a5,80000490 <strcmp+0x30>
80000474:	0005c703          	lbu	a4,0(a1)
80000478:	00070c63          	beqz	a4,80000490 <strcmp+0x30>
8000047c:	00f71a63          	bne	a4,a5,80000490 <strcmp+0x30>
80000480:	00150513          	addi	a0,a0,1
80000484:	00158593          	addi	a1,a1,1
80000488:	00054783          	lbu	a5,0(a0)
8000048c:	fe0794e3          	bnez	a5,80000474 <strcmp+0x14>
80000490:	0005c503          	lbu	a0,0(a1)
80000494:	40a78533          	sub	a0,a5,a0
80000498:	00c12403          	lw	s0,12(sp)
8000049c:	01010113          	addi	sp,sp,16
800004a0:	00008067          	ret

800004a4 <printf>:
800004a4:	fa010113          	addi	sp,sp,-96
800004a8:	02112e23          	sw	ra,60(sp)
800004ac:	02812c23          	sw	s0,56(sp)
800004b0:	02912a23          	sw	s1,52(sp)
800004b4:	04010413          	addi	s0,sp,64
800004b8:	00050493          	mv	s1,a0
800004bc:	00b42223          	sw	a1,4(s0)
800004c0:	00c42423          	sw	a2,8(s0)
800004c4:	00d42623          	sw	a3,12(s0)
800004c8:	00e42823          	sw	a4,16(s0)
800004cc:	00f42a23          	sw	a5,20(s0)
800004d0:	01042c23          	sw	a6,24(s0)
800004d4:	01142e23          	sw	a7,28(s0)
800004d8:	00440793          	addi	a5,s0,4
800004dc:	fcf42623          	sw	a5,-52(s0)
800004e0:	00054503          	lbu	a0,0(a0)
800004e4:	06050663          	beqz	a0,80000550 <printf+0xac>
800004e8:	03212823          	sw	s2,48(sp)
800004ec:	03312623          	sw	s3,44(sp)
800004f0:	03412423          	sw	s4,40(sp)
800004f4:	03512223          	sw	s5,36(sp)
800004f8:	03612023          	sw	s6,32(sp)
800004fc:	01712e23          	sw	s7,28(sp)
80000500:	01812c23          	sw	s8,24(sp)
80000504:	02500993          	li	s3,37
80000508:	06400a13          	li	s4,100
8000050c:	07300a93          	li	s5,115
80000510:	1180006f          	j	80000628 <printf+0x184>
80000514:	00078c63          	beqz	a5,8000052c <printf+0x88>
80000518:	02500713          	li	a4,37
8000051c:	10e79063          	bne	a5,a4,8000061c <printf+0x178>
80000520:	02500513          	li	a0,37
80000524:	c35ff0ef          	jal	80000158 <console_putc>
80000528:	0f40006f          	j	8000061c <printf+0x178>
8000052c:	02500513          	li	a0,37
80000530:	c29ff0ef          	jal	80000158 <console_putc>
80000534:	03012903          	lw	s2,48(sp)
80000538:	02c12983          	lw	s3,44(sp)
8000053c:	02812a03          	lw	s4,40(sp)
80000540:	02412a83          	lw	s5,36(sp)
80000544:	02012b03          	lw	s6,32(sp)
80000548:	01c12b83          	lw	s7,28(sp)
8000054c:	01812c03          	lw	s8,24(sp)
80000550:	03c12083          	lw	ra,60(sp)
80000554:	03812403          	lw	s0,56(sp)
80000558:	03412483          	lw	s1,52(sp)
8000055c:	06010113          	addi	sp,sp,96
80000560:	00008067          	ret
80000564:	fcc42783          	lw	a5,-52(s0)
80000568:	00478713          	addi	a4,a5,4
8000056c:	fce42623          	sw	a4,-52(s0)
80000570:	0007a483          	lw	s1,0(a5)
80000574:	0004c503          	lbu	a0,0(s1)
80000578:	0a050263          	beqz	a0,8000061c <printf+0x178>
8000057c:	bddff0ef          	jal	80000158 <console_putc>
80000580:	00148493          	addi	s1,s1,1
80000584:	0004c503          	lbu	a0,0(s1)
80000588:	fe051ae3          	bnez	a0,8000057c <printf+0xd8>
8000058c:	0900006f          	j	8000061c <printf+0x178>
80000590:	fcc42783          	lw	a5,-52(s0)
80000594:	00478713          	addi	a4,a5,4
80000598:	fce42623          	sw	a4,-52(s0)
8000059c:	0007ab03          	lw	s6,0(a5)
800005a0:	040b4e63          	bltz	s6,800005fc <printf+0x158>
800005a4:	00900793          	li	a5,9
800005a8:	0767d263          	bge	a5,s6,8000060c <printf+0x168>
800005ac:	00100493          	li	s1,1
800005b0:	00900713          	li	a4,9
800005b4:	00249793          	slli	a5,s1,0x2
800005b8:	009787b3          	add	a5,a5,s1
800005bc:	00179793          	slli	a5,a5,0x1
800005c0:	00078493          	mv	s1,a5
800005c4:	02fb47b3          	div	a5,s6,a5
800005c8:	fef746e3          	blt	a4,a5,800005b4 <printf+0x110>
800005cc:	04905863          	blez	s1,8000061c <printf+0x178>
800005d0:	00a00c13          	li	s8,10
800005d4:	00900b93          	li	s7,9
800005d8:	029b4533          	div	a0,s6,s1
800005dc:	03050513          	addi	a0,a0,48
800005e0:	0ff57513          	zext.b	a0,a0
800005e4:	b75ff0ef          	jal	80000158 <console_putc>
800005e8:	029b6b33          	rem	s6,s6,s1
800005ec:	00048793          	mv	a5,s1
800005f0:	0384c4b3          	div	s1,s1,s8
800005f4:	fefbc2e3          	blt	s7,a5,800005d8 <printf+0x134>
800005f8:	0240006f          	j	8000061c <printf+0x178>
800005fc:	02d00513          	li	a0,45
80000600:	b59ff0ef          	jal	80000158 <console_putc>
80000604:	41600b33          	neg	s6,s6
80000608:	f9dff06f          	j	800005a4 <printf+0x100>
8000060c:	00100493          	li	s1,1
80000610:	fc1ff06f          	j	800005d0 <printf+0x12c>
80000614:	b45ff0ef          	jal	80000158 <console_putc>
80000618:	00048913          	mv	s2,s1
8000061c:	00190493          	addi	s1,s2,1
80000620:	00194503          	lbu	a0,1(s2)
80000624:	06050263          	beqz	a0,80000688 <printf+0x1e4>
80000628:	ff3516e3          	bne	a0,s3,80000614 <printf+0x170>
8000062c:	00148913          	addi	s2,s1,1
80000630:	0014c783          	lbu	a5,1(s1)
80000634:	f5478ee3          	beq	a5,s4,80000590 <printf+0xec>
80000638:	ecfa7ee3          	bgeu	s4,a5,80000514 <printf+0x70>
8000063c:	f35784e3          	beq	a5,s5,80000564 <printf+0xc0>
80000640:	07800713          	li	a4,120
80000644:	fce79ce3          	bne	a5,a4,8000061c <printf+0x178>
80000648:	fcc42783          	lw	a5,-52(s0)
8000064c:	00478713          	addi	a4,a5,4
80000650:	fce42623          	sw	a4,-52(s0)
80000654:	0007ac03          	lw	s8,0(a5)
80000658:	01c00493          	li	s1,28
8000065c:	00000b97          	auipc	s7,0x0
80000660:	27cb8b93          	addi	s7,s7,636 # 800008d8 <release+0x1ec>
80000664:	ffc00b13          	li	s6,-4
80000668:	409c57b3          	sra	a5,s8,s1
8000066c:	00f7f793          	andi	a5,a5,15
80000670:	00fb87b3          	add	a5,s7,a5
80000674:	0007c503          	lbu	a0,0(a5)
80000678:	ae1ff0ef          	jal	80000158 <console_putc>
8000067c:	ffc48493          	addi	s1,s1,-4
80000680:	ff6494e3          	bne	s1,s6,80000668 <printf+0x1c4>
80000684:	f99ff06f          	j	8000061c <printf+0x178>
80000688:	03012903          	lw	s2,48(sp)
8000068c:	02c12983          	lw	s3,44(sp)
80000690:	02812a03          	lw	s4,40(sp)
80000694:	02412a83          	lw	s5,36(sp)
80000698:	02012b03          	lw	s6,32(sp)
8000069c:	01c12b83          	lw	s7,28(sp)
800006a0:	01812c03          	lw	s8,24(sp)
800006a4:	eadff06f          	j	80000550 <printf+0xac>

800006a8 <acquire>:
800006a8:	ff010113          	addi	sp,sp,-16
800006ac:	00112623          	sw	ra,12(sp)
800006b0:	00812423          	sw	s0,8(sp)
800006b4:	00912223          	sw	s1,4(sp)
800006b8:	01010413          	addi	s0,sp,16
800006bc:	00050493          	mv	s1,a0
800006c0:	9bdff0ef          	jal	8000007c <disable_interrupts>
800006c4:	00100713          	li	a4,1
800006c8:	00070793          	mv	a5,a4
800006cc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
800006d0:	fe079ce3          	bnez	a5,800006c8 <acquire+0x20>
800006d4:	0330000f          	fence	rw,rw
800006d8:	00c12083          	lw	ra,12(sp)
800006dc:	00812403          	lw	s0,8(sp)
800006e0:	00412483          	lw	s1,4(sp)
800006e4:	01010113          	addi	sp,sp,16
800006e8:	00008067          	ret

800006ec <release>:
800006ec:	ff010113          	addi	sp,sp,-16
800006f0:	00112623          	sw	ra,12(sp)
800006f4:	00812423          	sw	s0,8(sp)
800006f8:	01010413          	addi	s0,sp,16
800006fc:	0330000f          	fence	rw,rw
80000700:	0310000f          	fence	rw,w
80000704:	00052023          	sw	zero,0(a0)
80000708:	97dff0ef          	jal	80000084 <enable_interrupts>
8000070c:	00c12083          	lw	ra,12(sp)
80000710:	00812403          	lw	s0,8(sp)
80000714:	01010113          	addi	sp,sp,16
80000718:	00008067          	ret
