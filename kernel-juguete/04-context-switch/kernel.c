#include "klib.h"
#include "arch.h"

// task a stack and saved stack pointer
uint8   stack_task_a[PAGE_SIZE];
uint32* task_a_sp;

// stack de ram para tarea B y guardado de SP
uint8   stack_task_b[PAGE_SIZE];
uint32* task_b_sp;


// main thread (kernel_main() function) saved stack pointer on context switch
uint32* main_thread_sp;

// create a task with initial program counter and stack pointer.
// return top stack pointer
uint32* create_task(uint32 pc, uint32 *sp)
{
    return init_task_context(pc, sp);
}

// task entry function
void task_a(void)
{
    printf("Task A on cpu %d\n", cpuid());

    printf("entro a A por primera vez, ahora A pasa a B\n\n");
    // de A a B
    context_switch((uint32*) &task_a_sp, (uint32*) &task_b_sp); // (2)

    printf("entro a A por segunda vez, ahora A pasa a hilo principal\n\n");
    // resume main thread
    context_switch((uint32*) &task_a_sp, (uint32*) &main_thread_sp); // (4)
}

void task_b(void)
{
    printf("Task B on cpu %d\n", cpuid());

    printf("entro a B por primera vez, ahora B pasa a A\n\n");
    // de tarea B a A
    context_switch((uint32*) &task_b_sp, (uint32*) &task_a_sp); // (3)

    printf("entro a B por segunda vez, ahora B pasa a hilo principal\n\n");
    // ya termino todo vuelve al hilo principal
    context_switch((uint32*) &task_b_sp, (uint32*) &main_thread_sp); // (6)

}


// main kernel function. boot() in arch.c calls it
void kernel_main(void) {
    if (cpuid() == 0) {
        task_a_sp = create_task((uint32) task_a,
                                (uint32*) (stack_task_a + PAGE_SIZE));
            
        task_b_sp = create_task((uint32) task_b,
                                (uint32*) (stack_task_b + PAGE_SIZE));
        
        printf("In kernel_main() thread\n\n");

        printf("START:\n\n");
        // resume task_a
        context_switch((uint32*) &main_thread_sp, (uint32*) &task_a_sp); // (1)

        printf("entro a hilo principal por segunda vez, ahora hilo principal pasa a B\n\n");
        context_switch((uint32*) &main_thread_sp, (uint32*) &task_b_sp); // (5)

        printf("In kernel initial thread again!\n");
    }
    stop();
}
