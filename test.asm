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
	;stor	dw	0x0001020300000000f,0x0000000000000000f
	stor	db	0x00, 0x01, 0x02, 0x03, 0x0c, 0x0d, 0x0e, 0x0f, 0x08, 0x09, 0x0a, 0x0b , 0x04, 0x05, 0x06, 0x07
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
	ret

convert:
	;Put the memory in bx, receive the value in al
	add		r14, stor
	mov		r14b, byte [r14]
	cmp		r14b, 0x9
	jle		less
	add		r14b, 39
less:
	add		r14b, 48
	
	mov		al, r14b
	ret


showoff:
	xor		rdx, rdx
	xor		r8, r8
	xor		r9, r9

	mov		r14, 00;
	call	convert
	mov		dl, al

	mov		r14, 01;
	call	convert
	mov		r8b, al
	
	mov		r14, 02;
	call	convert
	mov		r9b, al

	push 	rbp
	mov 	rbp, rsp

	mov		r14, 7
	call	convert
	push 	rax	

	mov		r14, 6
	call	convert
	push 	rax	

	mov		r14, 5
	call	convert
	push 	rax	

	mov		r14, 4
	call	convert
	push 	rax	


	mov		r14, 11
	call	convert
	push 	rax		

	mov		r14, 10
	call	convert
	push 	rax

	mov		r14, 9
	call	convert
	push 	rax	

	mov		r14, 8
	call	convert
	push 	rax	

	
	mov		r14, 15
	call	convert
	push 	rax

	mov		r14, 14
	call	convert
	push 	rax

	mov		r14, 13
	call	convert
	push 	rax	

	mov		r14, 12
	call	convert
	push 	rax

	mov		r14, 3
	call	convert
	push 	rax	

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
	
	;1. If all 4 numbers are 0, return, we are done
	;	011e 001e 0011 0110 0ee1 1111 xxxx 1010 10e0 0101 010e 0001 1001 100e 1000
	test 	r10w, r10w
	je		done

	;2. If first one is non zero and the rest is zero, do nothing...
	;	011e 001e 0011 0110 0ee1 1111 xxxx 1010 10e0 0101 010e 0001 1001 100e xxxx
	mov		r11w, r10w ;Check if we have only first digit
	shl		r11w, 8
	test	r11w, r11w
	ret

	;3. If first byte is 0, Left Logical shift by 8 bits till it becomes something. 
	;	11e0 1e00 1100 1100 ee10 1111 xxxx 1010 10e0 1010 10e0 1000 1001 100e xxxx
	mov		r11w, r10w
	shr		r11w, 24
	test	r11w, r11w
	je 	doneshift
	shl		r10w, 8 	;first symbol is not 0, so shift

	mov		r11w, r10w
	shr		r11w, 24
	test	r11w, r11w
	je 	doneshift
	shl		r10w, 8 	;second symbol is not 0, so shift
doneshift:	;There can't be other sits in this scenario, so we are happy with what we have now, carry on.
	
	;4. Do the same for the bytes 2 and 3
	;This is done by performing a rotaion and moving first byte to the end and checking leading zeroes.
	;The amount of moves is stored in r12 and than un-does itself.
	;	11e0 1e00 1100 1100 ee10 1111 xxxx 1100 1e00 1100 1e00 1000 1100 1e00 xxxx
	; mov		r12, 0 ;How much to circularshift back if we want to.
	; ror		r10w, 8	; moving the first digit to the end
	; add		r12, 8
	
	; mov		r11w, r10w ;check if the first digit is zero
	; shr		r11w, 24
	; test	r11w, r11w
	; je		done2shift
	; shl		r10w, 8 	;first symbol is not 0, so shift

	; ror		r10w, 8	; moving the first digit to the again
	; add		r12, 8
	
	; mov		r11w, r10w ;check if the first digit is zero
	; shr		r11w, 24
	; test	r11w, r11w
	; je		done2shift
	; shl		r10w, 8 

; done2shift:
; 	rol		r10w, r12	;Undo the damage of roling done on the previous step



	; ;5. If there are only 1 number in the row, return it, no changes, basically re-doing step #2 after we had moved leading zeroes
	; ;	11e0 1e00 1100 1100 ee10 1111 xxxx 1100 1e00 1100 1e00 xxxx 1100 1e00 xxxx
	; mov		r11w, r10w ;Check if we have only first digit
	; shl		r11w, 8
	; test	r11w, r11w
	; ret

	;6. If the first two bytes are equal, inc first byte and remove the second byte
	;	2e00 1e00 2000 2000 f100 2110 xxxx 2000 1e00 2000 1e00 xxxx 2000 1e00 xxxx

	

	;7. Repeat steps 1, 5, 6 byes 2 and 3
	;	xxxx xxxx xxxx xxxx xxxx 2200 xxxx xxxx xxxx xxxx xxxx xxxx xxxx xxxx xxxx
	;PROFIT!
	ret
done:
	ret