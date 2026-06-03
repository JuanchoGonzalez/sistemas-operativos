typedef unsigned char uint8;
typedef unsigned int  uint32;
typedef unsigned int  uint;
typedef unsigned long uint64;
typedef unsigned int  size_t;

/****************************************************************************
 * Universal Asynchronous Receiver-Transmitter (UART) device controller     *
 * UART_THR address port: Transmitter Holding Register
 * UART_LSR address port: Line Status Register
 * UART_STATUS_EMPTY: LSR bit 6 Transmitter empty
 ****************************************************************************/
#define UART        0x10000000
#define UART_THR    (uint8*)(UART+0x00)
#define UART_LSR    (uint8*)(UART+0x05)
#define UART_STATUS_EMPTY 0x40

// get mmio register address (byte)
#define mmio_reg_b(r) ((volatile unsigned char *)(r))

int console_putc(char ch) {
    // wait for UART transmitter register empty
	while ((*mmio_reg_b(UART_LSR) & UART_STATUS_EMPTY) == 0)
        ;
    // write character to UART THR to start transmission
	return *mmio_reg_b(UART_THR) = ch;
}

// write string to console
void console_puts(const char *s) {
	while (*s)
        console_putc(*s++);
}

// the trap handler (called from s_trap defined in start.s)
void trap(uint cause)
{
    console_puts("trap!!!\n\n");

    // miro el bit mas significativo de un registro de 32 bits (el 31) y me fijo si es 0 o 1
    // si es 0 es una excepcion, si es 1 es interrupcion.

    // (1 << 31) = 10000000000000000000000000000000, es para ver el bit 31
    if (!(cause & (1 << 31))) { // cause = 00000000000000000000000000000010 (2 ya que es ilegalInstruccion), esto da false/0 xq son todos 0, con el !, verdadero
        console_puts("exception\n");
    } else {
        console_puts("interrupt\n");
    }

    // en este caso entra por el then ya que es una exception, es una instruccion que da error
    // la causa viene de adentro, de una instruccion que no esta permitida en el modo M (machine).


    // si fuera una interrupcion el bit 31 estaria en 1 es decir:
    // 100000000000000000000000000000001 comparado con ver el bit 31: 10000000000000000000000000000010 daria verdadero, con el ! daria falso entraria por el else.

}

const char *hello = "Hello World from supervisor mode!\n";

// main kernel function. Here we have in supervisor (kernel) mode.
void kernel_main(void) {
    asm volatile("csrr a0, mhartid");
    console_puts(hello);
    for (;;) {
    }
}
