bits		64
default 	rel
	global    main                
	extern    printf              
	extern    GetStdHandle
	extern    ReadConsoleInputW
	extern    ExitProcess                

segment  .data
	stor	db	0x01, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01

	fmt 	db 	"%c %c %c %c", 0xd, 0xa,"%c %c %c %c", 0xd, 0xa,"%c %c %c %c", 0xd, 0xa,"%c %c %c %c", 0xd, 0xa, "-------",0xd, 0xa, 0
	lost 	db 	"You are done!",0xd, 0xa, 0

segment	.bss
	input	resw 2 ; 2nd word for padding
	bKeyDown resd 1
	wRepeatCount resw 1
	wVirtualKeyCode resw 1
	wVirtualScanCode resw 1
	uChar	resw 1
	dwControlKeyState resd 1
	read	resd 1
	hStdin 	resq 1

	;stor	db	   0,    1,    2,    0,    4,    5,    6,    7,    8,    9,    a,    b,    c,    d,    e,    f

	;				byte addressing
	; 00 00 00 00	[stor  ]	[stor+1]	[stor+2]	[stor+3]
	; 00 01 00 00	[stor+4]	[stor+5]	[stor+6]	[stor+7]
	; 00 01 00 00	[stor+8]	[stor+9]	[stor+a]	[stor+b]
	; 00 00 00 00	[stor+c]	[stor+d]	[stor+e]	[stor+f]
	;00 = nothing
	;01 = 2
	;02 = 4
	;03 = 8
	;04 = 16
	;05 = 32
	;06 = 64
	;07 = 128
	;08 = 256
	;09 = 512
	;0a = 1024
	;0b = 2048
	;0c = 4096
	;0d = 8192
	;0e = 16384
	;0f = 32768
	;01 = 65536 - maximum with the highest number is 2
	;02 = 131072 - maximum with the highest number 4
	;03 = 262144 - impossible



section .text
main:    
	push 	rbp
	mov 	rbp, rsp
	sub 	rsp, 32

	mov rcx, -10 ;STD_INPUT_HANDLE
	call GetStdHandle
	mov [hStdin], rax

	call 	showoff
mainloop:                             
	call 	readkey
	cmp dword [bKeyDown], 1
	jne	mainloop

	cmp	word [wVirtualKeyCode], 'S'
	je	shutdown

	cmp	word [wVirtualKeyCode], 0x28 ;VK_DOWN
	jne	cont_no_down
	call	down
	jmp	next

cont_no_down:
	cmp	word [wVirtualKeyCode], 0x26 ;VK_UP
	jne	cont_no_up
	call	up
	jmp	next

cont_no_up:
	cmp	word [wVirtualKeyCode], 0x25 ;VK_LEFT
	jne	cont_no_left
	call	left
	jmp	next

cont_no_left:
	cmp	word [wVirtualKeyCode], 0x27 ;VK_RIGHT
	jne	mainloop ; don't allow skipping a move!
	call	right

next:
	call	spawn
	call	showoff
	jmp	mainloop


shutdown:

	 
	xor 	rax, rax	
	call 	ExitProcess
	leave
	ret

convert:
	push 	rbp
	mov 	rbp, rsp
	sub 	rsp, 32
	;Put the memory in bx, receive the value in al
	add		r14, stor
	mov		r14b, byte [r14]
	cmp		r14b, 0x9
	jle		less
	add		r14b, 39
less:
	add		r14b, 48
	mov		al, r14b
	leave
	ret




readkey:
	mov rcx, [hStdin]
	lea rdx, [input]
	mov r8, 1
	lea r9, [read]
	call ReadConsoleInputW
	or rax, rax
	jz shutdown
	cmp dword [read], 1
	jne shutdown
	cmp word [input], 1 ;KEY_EVENT
	jne readkey
	ret

loose:
	push 	rbp
	mov 	rbp, rsp
	sub 	rsp, 32
	lea 	rcx, [lost]	;Load the format string into memory
	call 	printf
	jmp		shutdown
	leave
	ret	

%include "display.asm"

%include "spawn.asm"

%include "memory_compression.asm"


%include "shift.asm"