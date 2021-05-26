


down:
	push 	rbp
	mov 	rbp, rsp
	sub 	rsp, 32

	mov		r10b, byte [stor + 0xc];
	shl		r10, 8
	add		r10b, byte [stor + 0x8];
	shl		r10, 8
	add		r10b, byte [stor + 0x4];
	shl		r10, 8
	add		r10b, byte [stor + 0x0];

	call 	shift
	mov		[stor + 0x0], r10b
	shr		r10, 8
	mov		[stor + 0x4], r10b
	shr		r10, 8
	mov		[stor + 0x8], r10b
	shr		r10, 8
	mov		[stor + 0xc], r10b
	

	mov		r10b, byte [stor + 0xd];
	shl		r10, 8
	add		r10b, byte [stor + 0x9];
	shl		r10, 8
	add		r10b, byte [stor + 0x5];
	shl		r10, 8
	add		r10b, byte [stor + 0x1];

	call 	shift
	mov		[stor + 0x1], r10b
	shr		r10, 8
	mov		[stor + 0x5], r10b
	shr		r10, 8
	mov		[stor + 0x9], r10b
	shr		r10, 8
	mov		[stor + 0xd], r10b
	

	mov		r10b, byte [stor + 0xe];
	shl		r10, 8
	add		r10b, byte [stor + 0xa];
	shl		r10, 8
	add		r10b, byte [stor + 0x6];
	shl		r10, 8
	add		r10b, byte [stor + 0x2];

	call 	shift
	mov		[stor + 0x2], r10b
	shr		r10, 8
	mov		[stor + 0x6], r10b
	shr		r10, 8
	mov		[stor + 0xa], r10b
	shr		r10, 8
	mov		[stor + 0xe], r10b
	

	mov		r10b, byte [stor + 0xf];
	shl		r10, 8
	add		r10b, byte [stor + 0xb];
	shl		r10, 8
	add		r10b, byte [stor + 0x7];
	shl		r10, 8
	add		r10b, byte [stor + 0x3];

	call 	shift
	mov		[stor + 0x3], r10b
	shr		r10, 8
	mov		[stor + 0x7], r10b
	shr		r10, 8
	mov		[stor + 0xb], r10b
	shr		r10, 8
	mov		[stor + 0xf], r10b
	
	leave
	ret
	
up:
	push 	rbp
	mov 	rbp, rsp
	sub 	rsp, 32

	mov		r10b, byte [stor + 0x0];
	shl		r10, 8
	add		r10b, byte [stor + 0x4];
	shl		r10, 8
	add		r10b, byte [stor + 0x8];
	shl		r10, 8
	add		r10b, byte [stor + 0xc];

	call 	shift
	mov		[stor + 0xc], r10b
	shr		r10, 8
	mov		[stor + 0x8], r10b
	shr		r10, 8
	mov		[stor + 0x4], r10b
	shr		r10, 8
	mov		[stor + 0x0], r10b
	

	mov		r10b, byte [stor + 0x1];
	shl		r10, 8
	add		r10b, byte [stor + 0x5];
	shl		r10, 8
	add		r10b, byte [stor + 0x9];
	shl		r10, 8
	add		r10b, byte [stor + 0xd];

	call 	shift
	mov		[stor + 0xd], r10b
	shr		r10, 8
	mov		[stor + 0x9], r10b
	shr		r10, 8
	mov		[stor + 0x5], r10b
	shr		r10, 8
	mov		[stor + 0x1], r10b
	

	mov		r10b, byte [stor + 0x2];
	shl		r10, 8
	add		r10b, byte [stor + 0x6];
	shl		r10, 8
	add		r10b, byte [stor + 0xa];
	shl		r10, 8
	add		r10b, byte [stor + 0xe];

	call 	shift
	mov		[stor + 0xe], r10b
	shr		r10, 8
	mov		[stor + 0xa], r10b
	shr		r10, 8
	mov		[stor + 0x6], r10b
	shr		r10, 8
	mov		[stor + 0x2], r10b
	

	mov		r10b, byte [stor + 0x3];
	shl		r10, 8
	add		r10b, byte [stor + 0x7];
	shl		r10, 8
	add		r10b, byte [stor + 0xb];
	shl		r10, 8
	add		r10b, byte [stor + 0xf];

	call 	shift
	mov		[stor + 0xf], r10b
	shr		r10, 8
	mov		[stor + 0xb], r10b
	shr		r10, 8
	mov		[stor + 0x7], r10b
	shr		r10, 8
	mov		[stor + 0x3], r10b
	
	leave
	ret


left:
	push 	rbp
	mov 	rbp, rsp
	sub 	rsp, 32

	mov		r10b, byte [stor + 0x0];
	shl		r10, 8
	add		r10b, byte [stor + 0x1];
	shl		r10, 8
	add		r10b, byte [stor + 0x2];
	shl		r10, 8
	add		r10b, byte [stor + 0x3];

	call 	shift
	mov		[stor + 0x3], r10b
	shr		r10, 8
	mov		[stor + 0x2], r10b
	shr		r10, 8
	mov		[stor + 0x1], r10b
	shr		r10, 8
	mov		[stor + 0x0], r10b
	

	mov		r10b, byte [stor + 0x4];
	shl		r10, 8
	add		r10b, byte [stor + 0x5];
	shl		r10, 8
	add		r10b, byte [stor + 0x6];
	shl		r10, 8
	add		r10b, byte [stor + 0x7];

	call 	shift
	mov		[stor + 0x7], r10b
	shr		r10, 8
	mov		[stor + 0x6], r10b
	shr		r10, 8
	mov		[stor + 0x5], r10b
	shr		r10, 8
	mov		[stor + 0x4], r10b
	

	mov		r10b, byte [stor + 0x8];
	shl		r10, 8
	add		r10b, byte [stor + 0x9];
	shl		r10, 8
	add		r10b, byte [stor + 0xa];
	shl		r10, 8
	add		r10b, byte [stor + 0xb];

	call 	shift
	mov		[stor + 0xb], r10b
	shr		r10, 8
	mov		[stor + 0xa], r10b
	shr		r10, 8
	mov		[stor + 0x9], r10b
	shr		r10, 8
	mov		[stor + 0x8], r10b
	

	mov		r10b, byte [stor + 0xc];
	shl		r10, 8
	add		r10b, byte [stor + 0xd];
	shl		r10, 8
	add		r10b, byte [stor + 0xe];
	shl		r10, 8
	add		r10b, byte [stor + 0xf];

	call 	shift
	mov		[stor + 0xf], r10b
	shr		r10, 8
	mov		[stor + 0xe], r10b
	shr		r10, 8
	mov		[stor + 0xd], r10b
	shr		r10, 8
	mov		[stor + 0xc], r10b
	
	leave
	ret

right:
	push 	rbp
	mov 	rbp, rsp
	sub 	rsp, 32

	mov		r10b, byte [stor + 0x3];
	shl		r10, 8
	add		r10b, byte [stor + 0x2];
	shl		r10, 8
	add		r10b, byte [stor + 0x1];
	shl		r10, 8
	add		r10b, byte [stor + 0x0];

	call 	shift
	mov		[stor + 0x0], r10b
	shr		r10, 8
	mov		[stor + 0x1], r10b
	shr		r10, 8
	mov		[stor + 0x2], r10b
	shr		r10, 8
	mov		[stor + 0x3], r10b
	

	mov		r10b, byte [stor + 0x7];
	shl		r10, 8
	add		r10b, byte [stor + 0x6];
	shl		r10, 8
	add		r10b, byte [stor + 0x5];
	shl		r10, 8
	add		r10b, byte [stor + 0x4];

	call 	shift
	mov		[stor + 0x4], r10b
	shr		r10, 8
	mov		[stor + 0x5], r10b
	shr		r10, 8
	mov		[stor + 0x6], r10b
	shr		r10, 8
	mov		[stor + 0x7], r10b
	

	mov		r10b, byte [stor + 0xb];
	shl		r10, 8
	add		r10b, byte [stor + 0xa];
	shl		r10, 8
	add		r10b, byte [stor + 0x9];
	shl		r10, 8
	add		r10b, byte [stor + 0x8];

	call 	shift
	mov		[stor + 0x8], r10b
	shr		r10, 8
	mov		[stor + 0x9], r10b
	shr		r10, 8
	mov		[stor + 0xa], r10b
	shr		r10, 8
	mov		[stor + 0xb], r10b
	

	mov		r10b, byte [stor + 0xf];
	shl		r10, 8
	add		r10b, byte [stor + 0xe];
	shl		r10, 8
	add		r10b, byte [stor + 0xd];
	shl		r10, 8
	add		r10b, byte [stor + 0xc];

	call 	shift
	mov		[stor + 0xc], r10b
	shr		r10, 8
	mov		[stor + 0xd], r10b
	shr		r10, 8
	mov		[stor + 0xe], r10b
	shr		r10, 8
	mov		[stor + 0xf], r10b
	
	leave
	ret