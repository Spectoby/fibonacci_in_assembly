.global _start
_start:
    mov r1, #7			@ set index parameter of Fibb sequence as F(7)
    bl fibbonaci
    b exit

fibbonaci:
    push {lr}			@ save return address on stack

    cmp r1, #0
    beq zeroCase		@ branches if equal to the comparison above (r1 = 0?)
    cmp r1, #1
    beq oneCase			@ branches if equal to the comparison above (r1 = 1?)

    push {r1}			@ save current n value on stack
    sub r1, r1, #1		@ this section represents F(n-1)
	bl fibbonaci		
    pop {r1}			@ restore original n value
    push {r0}			@ save F(n-1) result on stack

    sub r1, r1, #2		@ this section represents F(n-2)
	bl fibbonaci		
    pop {r1}			@ pop F(n-1) result into r1
    add r0, r0, r1 		@ combine F(n-1) + F(n-2) to get F(n)
	
    pop {lr}            @ restore return address
    mov pc, lr          @ return to caller
zeroCase:
    mov r0, #0			@ base case: F(0) = 0
    pop {lr}
    mov pc, lr

oneCase:
    mov r0, #1		@ base case: F(1) = 1
    pop {lr}
    mov pc, lr

exit:
    b exit