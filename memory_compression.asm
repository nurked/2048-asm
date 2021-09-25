memtoreg:
	mov al, [rsi + rdi + 12]
	shl rax, cl
	mov al, [rsi + rdi + 8]
	shl rax, cl
	mov al, [rsi + rdi + 4]
	shl rax, cl
	mov al, [rsi + rdi]
	ret

regtomem:
	mov [rsi + rdi + 12], al
	shr rax, cl
	mov [rsi + rdi + 8], al
	shr rax, cl
	mov [rsi + rdi + 4], al
	shr rax, cl
	mov [rsi + rdi], al
	ret

down:
	xor	rdi, rdi
next_down:
	call	memtoreg
	call 	shift
	call 	regtomem
	inc	rdi
	cmp	rdi, 4
	jb	next_down
	ret
	
up:
	xor	rdi, rdi
next_up:
	call	memtoreg
	bswap	eax
	call 	shift
	bswap	eax
	call 	regtomem
	inc	rdi
	cmp	rdi, 4
	jb	next_up
	ret

left:
	mov 	rdi, rsi
	mov	bl, 4
next_left:
	lodsd
	bswap	eax
	call 	shift
	stosd
	dec	bl
	jnz	next_left
	sub	rsi, 16
	ret

right:
	mov 	rdi, rsi
	mov	bl, 4
next_right:
	lodsd
	call 	shift
	bswap	eax
	stosd
	dec	bl
	jnz	next_right
	sub	rsi, 16
	ret
