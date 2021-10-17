shift:

	xor	rdx, rdx
shift_next:
	or	rax, rax
	jz	pass2

; pass 1: jump over zeroes
	or	al, al
	jz	shift_skip
	shl	rdx, cl
	mov	dl, al
shift_skip:
	shr	rax, cl
	jmp	shift_next

pass2: ; combine numbers
	bswap	rdx
combine_next:
	or	rdx, rdx
	jz	done
	or	dl, dl
	jnz	combine
	shr	rdx, cl
	jmp	combine_next
combine:
	cmp	dl, dh
	jne	copy
	shr	rdx, cl
	inc	dl
copy:
	shl	rax, cl
	mov	al, dl
	shr	rdx, cl
	jmp	combine_next
done:
	xor	r9, rax
	or	r8, r9
	ret
