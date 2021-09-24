spawn:  ;Simple spawner for now. Going thru the memory and just drop 1 in any free cell we can find. 
	push 	rbp
	mov 	rbp, rsp
	sub 	rsp, 32

    
    mov     r14, 0
spawn_loop:
    mov     r15b, byte [stor+r14]

    cmp     r15, 0x0
    jne     spawn_continue
    mov     byte [stor+r14], 1
    jmp     spawn_done
spawn_continue:
    inc     r14
    cmp     r14, 15
    jne     spawn_loop
    
    call    lose
    
spawn_done:
    leave
	ret