extern    GetTickCount ; our PRNG


spawn:
    mov     rcx, 16
    xor     r13, r13
count_loop:
    cmp     byte [rsi+rcx-1], 0
    jne     skip
    inc     r13
skip:
    loop    count_loop

    or      r13, r13
    jz      lose

    call    GetTickCount
    xor     rdx, rdx
    div     r13
    inc     rdx ; 1..r13

    mov     rcx, 16
spawn_loop:
    cmp     byte [rsi+rcx-1], 0
    jne     spawn_continue
    dec     rdx
    jnz     spawn_continue
    mov     byte [rsi+rcx-1], 1
    jmp     spawn_done
spawn_continue:
    loop    spawn_loop

    int3 ; unreachable
    
spawn_done:
    ret
