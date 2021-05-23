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
	stor	dw	0x0000000000000000f,0x0000000000000000f
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
