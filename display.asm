showoff:
	push 	rbp
	mov 	rbp, rsp

	xor		rdx, rdx	;Clearing the registers we are going to use
	xor		r8, r8
	xor		r9, r9
	xor		r14, r14

	mov		r14, 00		;Loading the first byte of data as a second param. (First param will be the format string)
	call	convert		;converting digit to the letter
	mov		dl, al		;rdx - second param

	mov		r14, 01;
	call	convert
	mov		r8b, al		;r8 - third param
	
	mov		r14, 02;
	call	convert
	mov		r9b, al		;r9 - forth param

	; push 	rbp			;save the stack pointer
	; mov 	rbp, rsp
	
	
	mov		r13, 15		; run thru the rest of the data and push it via the stack
	loop1:

		mov		r14, r13
		call	convert
		push	rax
		dec		r13
		cmp		r13, 2
		jne		loop1

	sub	rsp, 32
	
	lea 	rcx, [fmt]	;Load the format string into memory
	call 	printf		;call printf


	leave				;we done for now, thank you!
	ret