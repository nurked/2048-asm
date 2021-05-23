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

shift:
	;Shift happens only in one direction: From left to right. It's a matter of a viewpoint. 
	;What you are trying to handle is just 4 numbers...
	;	011f 001e 0011 0110 0ee1 1111 0000 1010 10e0 0101 010e 0001 1001 100e 1000
	;1. If all 4 numbers are 0, do nothing
	;	011e 001e 0011 0110 0ee1 1111 xxxx 1010 10e0 0101 010e 0001 1001 100e 1000
	;2. If first one is non zero and the rest is zero, do nothing...
	;	011e 001e 0011 0110 0ee1 1111 xxxx 1010 10e0 0101 010e 0001 1001 100e xxxx
	;3. If first byte is 0, Left Logical shift by 8 bits till it becomes something. 
	;	11e0 1e00 1100 1100 ee10 1111 xxxx 1010 10e0 1010 10e0 1000 1001 100e xxxx
	;4. Do the same for the bytes 2 and 3
	;	11e0 1e00 1100 1100 ee10 1111 xxxx 1100 1e00 1100 1e00 1000 1100 1e00 xxxx
	;5. If there are only 1 number in the row, return it, no changes
	;	11e0 1e00 1100 1100 ee10 1111 xxxx 1100 1e00 1100 1e00 xxxx 1100 1e00 xxxx
	;6. If the first two bytes are equal, inc first byte and remove the second byte
	;	2e00 1e00 2000 2000 f100 2110 xxxx 2000 1e00 2000 1e00 xxxx 2000 1e00 xxxx
	;7. Repeat steps 1, 5, 6 byes 2 and 3
	;	xxxx xxxx xxxx xxxx xxxx 2200 xxxx xxxx xxxx xxxx xxxx xxxx xxxx xxxx xxxx
	;PROFIT!
	