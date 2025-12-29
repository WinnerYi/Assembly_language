.data

.global     member_1_name
.global     member_2_name
.global     member_3_name
.global     team
title_1:    .asciz "*****Print Name*****\n"
team:       .asciz "Team 03\n"
member_1_name:   .asciz "Hung Yeh Chiang\n"
member_2_name:   .asciz "Yi Hsuan Chen\n"
member_3_name:   .asciz "Yi Hsun Tsai\n"
title_end:  .asciz "*****End Print*****\n"

            .text
            .globl  name

name:
            stmfd   sp!,    {lr}        @ push return address onto stack
            ldr     r0,     =title_1   @ load pointer to format string
            bl      printf
            ldr     r0,     =team
            bl      printf
            ldr     r0,     =member_1_name   @ load pointer to format string
            bl      printf
            ldr     r0,     =member_2_name   @ load pointer to format string
            bl      printf
            ldr     r0,     =member_3_name   @ load pointer to format string
            bl      printf
            ldr     r0,     =title_end
            bl      printf
            mov     r0,     #0
            ldmfd   sp!,    {lr}
            mov     pc,     lr

