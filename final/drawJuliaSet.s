.data
         @ operand2: mov, add mul, sub!!!!
.text  
    .global drawJuliaSet
	.extern my_div
drawJuliaSet:
    stmfd sp!, {r4-r11, lr}     @ 存入 9 個暫存器，sp 位移 36 bytes
    ldr r7, [sp, #36]           @ 從 stack 讀取第 5 個參數 (frame buffer pointer)
    mov r4, r0                  @ 備份 cX 
    adds lr, sp, pc             @ must!!!!!!!!!!!
    mov r10, r1                 @ 備份 cy (r10 = cy)
    
    
    mov r5, #1
    cmp r5, #0
    movge r5, #0                  @ x = 0  not_branch_condition!!!!!   1st

loopwidth:
    cmp r5, #640
	movne r6, #0                  @ y = 0   not_branch_condition!!!!!   2nd
	moveq r6, #0   				   @    not_branch_condition!!!!!       3th
	blt loopheight
    bge endloopwidth
                  


loopheight:
    cmp r6, #480
    bge endloopheight

    @ 計算初始 zx, zy (使用位移代替除法) 
    mov r1, #640            @ width = 640
    mov r2, r1, asr #1			@(width>>1)
    sub r2, r5, r2          @ r2 = x - 320

    ldr r0, =1500       @ r0 = 1500
    mul r0, r0, r2          @ r0 = 1500 * (x - 320)

    mov r1, r1, asr #1			@r1 = shift right 1
    bl my_div        @ r0 = r0 / 320   self-made divide_function 
    mov r8, r0

    @ zy = (1000 * (y - 240)) / 256
   mov r1, #480            @ height = 480
   asr r2, r1, #1          @ r2 = 240
   sub r2, r6, r2          @ r2 = y - 240

   mov r0, #1000
   mul r0, r0, r2          @ r0 = 1000 * (y - 240)

   mov r1, r1, asr #1			@r1 = shift right 1
   bl my_div				@r0 = 1000 * (y - (height>>1)) / (height>>1)  

   mov r9, r0              @ zy
   
   @!!!!!!!!!
   mov r11, #255				@r11 = i   i = 255

   mul r0, r8, r8				@r0 = zx * zx
   mul r1, r9, r9				@r1 = zy * zy
   add r0, r0, r1				@r0 = zx * zx + zy * zy
   ldr r1, =4000000
   cmp r0, r1					@r0 compare 4000000
   bge endwhile				   @r0 >= 4000000
   cmplt r11, #0				@i <= 0
   ble endwhile

while:
	mul     r0, r8, r8          @ r0 = zx * zx
	mul     r1, r9, r9          @ r1 = zy * zy
	sub     r0, r0, r1          @ zx*zx - zy*zy

	mov     r1, #1000
	bl my_div         @ (zx*zx - zy*zy) / 1000
	sub     r4, r0, #700        @ tmp = ... - 700

	mul     r0, r8, r9          @ r0 = zx * zy
	add     r0, r0, r0          @ r0 = 2 * zx * zy
	mov     r1, #1000
	bl my_div         @ (2*zx*zy)/1000
	add     r9, r0, r10         @ zy = ... + cy

	mov     r8, r4              @ zx = tmp
	sub     r11, r11, #1        @ i--

	mul     r0, r8, r8          @ zx*zx
	mul     r1, r9, r9          @ zy*zy
	add     r0, r0, r1          @ zx*zx + zy*zy

	ldr     r1, =4000000
	cmp     r0, r1
	bge     endwhile            @ escape

	cmp     r11, #0
	ble     endwhile            @ iteration end

	b       while

endwhile:
    @  顏色處理與寫入 
    and r11, r11, #0xff
    mov r0, #8
    orr r11, r11, r11, lsl r0   @ 產生 16-bit 顏色格式 (RGB565 簡易灰階)
    ldr r0, =0xffff
    bic r11, r0, r11            @ 取反

    @ 計算像素位址: base + (y * 640 * 2) + (x * 2)
    mov r0, r7                  @ r0 = frame buffer base
    mov r1, #1280               @ 一列的 bytes (640 像素 * 2 bytes)
    mul r1, r1, r6              @ r1 = 1280 * y
    add r0, r0, r1              @ base + offset_y
    add r0, r0, r5, lsl #1      @ + (x * 2)
    strh r11, [r0]              @ 寫入像素

    add r6, r6, #1
    b loopheight

endloopheight:
    add r5, r5, #1
    b loopwidth

endloopwidth:
    mov r0, #0
    ldmfd sp!, {r4-r11, lr}     @ 回復暫存器
    mov pc, lr                  @ 返回




