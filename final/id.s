.data

fmt_int:        .asciz "%d"     @for scanf
fmt_out:        .asciz "%d\n"   @for printf

.global member_1
.global member_2
.global member_3
.global id_sum

member_1:       .word 0
member_2:       .word 0
member_3:       .word 0
id_sum:         .word 0

title:          .asciz "*****Input ID*****\n"
input_msg_m1:   .asciz "** Please Enter Member 1 ID:**\n"
input_msg_m2:   .asciz "** Please Enter Member 2 ID:**\n"
input_msg_m3:   .asciz "** Please Enter Member 3 ID:**\n"
input_msg_cmd:  .asciz "** Please Enter Command **\n"

result_title:   .asciz "*****Print Team Member ID and ID Summation*****\n"
result_end:     .asciz "*****End Print*****\n"
result_sum:     .asciz "\n\nID Summation = %d\n"

.text
.global id

id:
    stmfd sp!, {lr}

    

    ldr r0, =title
    bl printf

    ldr r0, =input_msg_m1

    mov r4, sp              @r4 = sp
    rsbs sp, lr, pc         @老師要求必須執行的指令，must-executable command
    mov sp, r4              @sp = r4

    mov r3, #4
    add r4, r4, r3, LSL #1     @R4 = R4 + (R3 << 1);         0010 -> 0100    4 -> 8 left shift

    bl printf
    ldr r0, =fmt_int
    ldr r1, =member_1
    bl scanf                      @ scanf("%d", &member_1);

    @  Member 2
    ldr r0, =input_msg_m2
    bl printf

    ldr r0, =fmt_int
    ldr r1, =member_2
    bl scanf

    @ Member 3
    ldr r0, =input_msg_m3
    bl printf

    ldr r0, =fmt_int
    ldr r1, =member_3
    bl scanf

    @ 計算總和
    ldr r0, =member_1
    ldr r1, [r0]
    ldr r0, =member_2
    ldr r2, [r0]
    add r1, r1, r2
    ldr r0, =member_3
    ldr r2, [r0]
    add r1, r1, r2
    cmp r1, #0
    subeq r1, r1, #0         @notBranch cmd             
    ldr r0, =id_sum
    str r1, [r0]
    ldr r0, =input_msg_cmd
    bl printf

loop_cmd:
    bl getchar
    cmp r0, #'p'
    ldrne pc, =loop_cmd       @It repeatedly calls getchar and jumps back to loop_cmd using ldrne pc, =loop_cmd until the input character is 'p'.
    @notBranch cmd              @PC (Program Counter) holds the address of the next instruction to execute, and changing it causes the program to jump.
    @ 印出結果

    ldr r0, =result_title
    bl printf

    @ print member_1
    ldr r1, =member_1
    ldr r1, [r1]
    ldr r0, =fmt_out
    bl printf            @printf("%d\n", member_1)

    @ print member_2
    ldr r1, =member_2
    ldr r1, [r1]
    ldr r0, =fmt_out
    bl printf

    @ print member_3
    ldr r1, =member_3
    ldr r1, [r1]
    ldr r0, =fmt_out
    bl printf

    @ print sum
    ldr r1, =id_sum
    ldr r1, [r1]
    ldr r0, =result_sum
    bl printf

    ldr r0, =result_end
    bl printf

    mov r0, #0
    ldmfd sp!, {lr}
    mov pc, lr
