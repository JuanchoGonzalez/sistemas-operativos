
kernel:     formato del fichero elf32-littleriscv


Desensamblado de la sección .text:

80000000 <__kernel_start>:
80000000:	f1402273          	csrr	tp,mhartid
80000004:	00001117          	auipc	sp,0x1
80000008:	ffc10113          	addi	sp,sp,-4 # 80001000 <__stack0>
8000000c:	000012b7          	lui	t0,0x1
80000010:	00120313          	addi	t1,tp,1 # 1 <__kernel_start-0x7fffffff>
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
80000040:	7ffe0e13          	addi	t3,t3,2047 # ffffe7ff <__kernel_end+0x7fff97ff>
80000044:	01c3f3b3          	and	t2,t2,t3
80000048:	00001eb7          	lui	t4,0x1
8000004c:	800e8e93          	addi	t4,t4,-2048 # 800 <__kernel_start-0x7ffff800>
80000050:	01d3e3b3          	or	t2,t2,t4
80000054:	30039073          	csrw	mstatus,t2
80000058:	00010f37          	lui	t5,0x10
8000005c:	ffff0f13          	addi	t5,t5,-1 # ffff <__kernel_start-0x7fff0001>
80000060:	302f2073          	csrs	medeleg,t5
80000064:	303f2073          	csrs	mideleg,t5
80000068:	30200073          	mret

8000006c <supervisor>:
8000006c:	18001073          	csrw	satp,zero
80000070:	0bc000ef          	jal	8000012c <kernel_main>

80000074 <loop>:
80000074:	0000006f          	j	80000074 <loop>

80000078 <cpuid>:
80000078:	00020513          	mv	a0,tp
8000007c:	00008067          	ret

80000080 <disable_interrupts>:
80000080:	10017073          	csrci	sstatus,2
80000084:	00008067          	ret

80000088 <enable_interrupts>:
80000088:	10016073          	csrsi	sstatus,2
8000008c:	00008067          	ret

80000090 <console_putc>:
80000090:	ff010113          	addi	sp,sp,-16
80000094:	00812623          	sw	s0,12(sp)
80000098:	01010413          	addi	s0,sp,16
8000009c:	10000737          	lui	a4,0x10000
800000a0:	00570713          	addi	a4,a4,5 # 10000005 <__kernel_start-0x6ffffffb>
800000a4:	00074783          	lbu	a5,0(a4)
800000a8:	0407f793          	andi	a5,a5,64
800000ac:	fe078ce3          	beqz	a5,800000a4 <console_putc+0x14>
800000b0:	100007b7          	lui	a5,0x10000
800000b4:	00a78023          	sb	a0,0(a5) # 10000000 <__kernel_start-0x70000000>
800000b8:	00c12403          	lw	s0,12(sp)
800000bc:	01010113          	addi	sp,sp,16
800000c0:	00008067          	ret

800000c4 <console_puts>:
800000c4:	ff010113          	addi	sp,sp,-16
800000c8:	00112623          	sw	ra,12(sp)
800000cc:	00812423          	sw	s0,8(sp)
800000d0:	01010413          	addi	s0,sp,16
800000d4:	00054783          	lbu	a5,0(a0)
800000d8:	02078863          	beqz	a5,80000108 <console_puts+0x44>
800000dc:	00912223          	sw	s1,4(sp)
800000e0:	01212023          	sw	s2,0(sp)
800000e4:	00050493          	mv	s1,a0
800000e8:	00000917          	auipc	s2,0x0
800000ec:	24490913          	addi	s2,s2,580 # 8000032c <lk>
800000f0:	00090513          	mv	a0,s2
800000f4:	07c000ef          	jal	80000170 <acquire>
800000f8:	0004c783          	lbu	a5,0(s1)
800000fc:	fe079ae3          	bnez	a5,800000f0 <console_puts+0x2c>
80000100:	00412483          	lw	s1,4(sp)
80000104:	00012903          	lw	s2,0(sp)
80000108:	00000513          	li	a0,0
8000010c:	f85ff0ef          	jal	80000090 <console_putc>
80000110:	00000517          	auipc	a0,0x0
80000114:	21c50513          	addi	a0,a0,540 # 8000032c <lk>
80000118:	09c000ef          	jal	800001b4 <release>
8000011c:	00c12083          	lw	ra,12(sp)
80000120:	00812403          	lw	s0,8(sp)
80000124:	01010113          	addi	sp,sp,16
80000128:	00008067          	ret

8000012c <kernel_main>:
8000012c:	ff010113          	addi	sp,sp,-16
80000130:	00112623          	sw	ra,12(sp)
80000134:	00812423          	sw	s0,8(sp)
80000138:	01010413          	addi	s0,sp,16
8000013c:	f3dff0ef          	jal	80000078 <cpuid>
80000140:	02051063          	bnez	a0,80000160 <kernel_main+0x34>
80000144:	00000517          	auipc	a0,0x0
80000148:	0a050513          	addi	a0,a0,160 # 800001e4 <release+0x30>
8000014c:	f79ff0ef          	jal	800000c4 <console_puts>
80000150:	00c12083          	lw	ra,12(sp)
80000154:	00812403          	lw	s0,8(sp)
80000158:	01010113          	addi	sp,sp,16
8000015c:	00008067          	ret
80000160:	00000517          	auipc	a0,0x0
80000164:	09850513          	addi	a0,a0,152 # 800001f8 <release+0x44>
80000168:	f5dff0ef          	jal	800000c4 <console_puts>
8000016c:	fe5ff06f          	j	80000150 <kernel_main+0x24>

80000170 <acquire>:
80000170:	ff010113          	addi	sp,sp,-16
80000174:	00112623          	sw	ra,12(sp)
80000178:	00812423          	sw	s0,8(sp)
8000017c:	00912223          	sw	s1,4(sp)
80000180:	01010413          	addi	s0,sp,16
80000184:	00050493          	mv	s1,a0
80000188:	ef9ff0ef          	jal	80000080 <disable_interrupts>
8000018c:	00100713          	li	a4,1
80000190:	00070793          	mv	a5,a4
80000194:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
80000198:	fe079ce3          	bnez	a5,80000190 <acquire+0x20>
8000019c:	0330000f          	fence	rw,rw
800001a0:	00c12083          	lw	ra,12(sp)
800001a4:	00812403          	lw	s0,8(sp)
800001a8:	00412483          	lw	s1,4(sp)
800001ac:	01010113          	addi	sp,sp,16
800001b0:	00008067          	ret

800001b4 <release>:
800001b4:	ff010113          	addi	sp,sp,-16
800001b8:	00112623          	sw	ra,12(sp)
800001bc:	00812423          	sw	s0,8(sp)
800001c0:	01010413          	addi	s0,sp,16
800001c4:	0330000f          	fence	rw,rw
800001c8:	0310000f          	fence	rw,w
800001cc:	00052023          	sw	zero,0(a0)
800001d0:	eb9ff0ef          	jal	80000088 <enable_interrupts>
800001d4:	00c12083          	lw	ra,12(sp)
800001d8:	00812403          	lw	s0,8(sp)
800001dc:	01010113          	addi	sp,sp,16
800001e0:	00008067          	ret
