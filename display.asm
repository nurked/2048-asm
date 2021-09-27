showoff:
	xor		r14, r14
	xor		r13, r13

	loop1:
		mov	r13b, [stor + r14]
		call	color_wrap
		inc	r14
		test	r14, 3
		jnz	loop1
		lea	rdx, [newline]
		mov	r8, 2
		call	print
		cmp	r14, 16
		jb	loop1

	lea	rdx, [separ]
	mov	r8, lost-separ
	call	print
	lea	rdx, [newline]
	mov	r8, 2
	jmp	print ; tailcall

color_wrap:
	lea	rdx, [start_color]
	mov	r8, 2
	call	print
	lea	rdx, [colors + r13 + r13*2]
	mov	r8, 2
	call	print
	lea	rdx, [mid_color]
	mov	r8, 1
	call	print
	lea	rdx, [powers + r13 + r13*4]
	mov	r8, 5
	call	print
	lea	rdx, [end_color]
	mov	r8, 4
	call	print

print: ; rdx->buffer r8->len
	mov rcx, [hStdout]
	lea r9, [input]
	push 0 ;lpOverlapped
	sub rsp, 32 ; shadow space
	call WriteFile
	add rsp, 40
	ret
