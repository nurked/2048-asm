bits		64
default 	rel
	global    main                
	extern    printf              
	extern    getch               
	extern    ExitProcess         
	extern    scanf               

segment  .data
	fmt 	db 	"%c %c %c %c", 0xd, 0xa,"%c %c %c %c", 0xd, 0xa,"%c %c %c %c", 0xd, 0xa,"%c %c %c %c", 0xd, 0xa, 0
	mem		db 	"0","1","2","3","4","5","6","7","8","9","a","b","c","d","f","z"
	resp	db	"a"

segment	.bbs
	stor	dw	0x0000000000000000f
section .text
main:                                 
	call 	readkey

	call	showoff
	jmp		main	


shutdown: 
	xor 	rax, rax	
	call 	ExitProcess
showoff:
	mov 	rdx, [mem]
	mov 	r8, [mem+1]
	mov 	r9, [mem+2]

	push 	rbp
	mov 	rbp, rsp
	
	xor		r10, r10
	mov		r10b,[mem+15] 
	push	r10
	mov		r10b,[mem+14] 
	push	r10
	mov		r10b,[mem+13] 
	push	r10
	mov		r10b,[mem+12] 
	push	r10
	mov		r10b,[mem+11] 
	push	r10
	mov		r10b,[mem+10] 
	push	r10
	mov		r10b,[mem+9] 
	push	r10
	mov		r10b,[mem+8] 
	push	r10
	mov		r10b,[mem+7] 
	push	r10
	mov		r10b,[mem+6] 
	push	r10
	mov		r10b,[mem+5] 
	push	r10
	mov		r10b,[mem+4] 
	push	r10
	mov		r10b,[mem+3] 
	push	r10

	sub 	rsp, 32
	
	 
	lea 	rcx, [fmt]


	call 	printf
	leave
	ret

readkey:
	push 	rbp
	mov 	rbp, rsp
	sub 	rsp, 32
	call	getch
	mov		[resp], rax
	cmp		dword [resp], 's'
	je		shutdown
	leave
	ret
