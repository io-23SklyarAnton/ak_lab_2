.global lab1
.syntax unified

#define A #3
#define B #7
#define C #4

lab1:
    push {lr}             @ Save return address (Link Register)

    mov r0, A             @ r0 = 3 (constant A)
    and r0, r0, B         @ r0 = 3 & 7 = 3 (bitwise AND with B)
    lsr r0, r0, #1        @ Logical shift right: r0 = r0 >> 1 = 1

    mov r1, C             @ r1 = 4 (constant C)
    bl factorial          @ Call factorial(r1), result will be in r2
    add r0, r0, r2        @ r0 = r0 + r2 = 1 + 24 = 25

    pop {pc}              @ Return to caller by popping PC from stack

factorial:
    push {lr, r1}         @ Save return address and argument r1
    mov r2, #1            @ Initialize result accumulator: r2 = 1

factorial_loop:
    cmp r1, #1            @ Compare r1 to 1
    ble factorial_done    @ If r1 <= 1, branch to factorial_done
    mul r2, r2, r1        @ Multiply: r2 = r2 * r1
    sub r1, r1, #1        @ Decrement r1
    b factorial_loop      @ Repeat loop

factorial_done:
    mov r1, r2            @ Move result to r1
    pop {r1, pc}          @ Restore r1 and return (set PC to return address)
