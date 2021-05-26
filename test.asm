bits		64
default 	rel
	global    main                
	extern    printf              
	extern    getch               
	extern    ExitProcess                

segment  .data
	stor	db	0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x0d, 0x00, 0x00

	fmt 	db 	"%c %c %c %c", 0xd, 0xa,"%c %c %c %c", 0xd, 0xa,"%c %c %c %c", 0xd, 0xa,"%c %c %c %c", 0xd, 0xa, 0
	resp	db	"a"

segment	.bbs
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
	call 	showoff
mainloop:                             
	call 	readkey

	cmp		dword [resp], 's'
	je		shutdown

	cmp		dword [resp], 'j'
	jne		cont_no_down
	call	down
cont_no_down:
	cmp		dword [resp], 'k'
	jne		cont_no_up
	call	up
cont_no_up:

	cmp		dword [resp], 'h'
	jne		cont_no_left
	call	left
cont_no_left:

	cmp		dword [resp], 'l'
	jne		cont_no_right
	call	right
cont_no_right:

	call	showoff
	jmp		mainloop	


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
	push 	rbp
	mov 	rbp, rsp
	sub 	rsp, 32
	call	getch
	mov		[resp], rax
	leave
	ret

%include "display.asm"

%include "memory_compression.asm"


%include "shift.asm"