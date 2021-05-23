bits		64
default 	rel
	global    main                
	extern    printf              
	extern    getch               
	extern    ExitProcess         
	extern    scanf               

segment  .data
	fmt 	db 	"%c %c %c %c", 0xd, 0xa,"%c %c %c %c", 0xd, 0xa,"%c %c %c %c", 0xd, 0xa,"%c %c %c %c", 0xd, 0xa, 0
	field	db 	"0123000500a00f00"
	resp	db	"a"

section .text
main:                                 
	call 	readkey

	call	showoff
	jmp		main	


shutdown: 
	xor 	rax, rax	
	call 	ExitProcess
showoff:
		
	
	mov 	rdx, '1'	
	mov 	r8, '2'		
	mov 	r9, '3'		

	push 	rbp
	mov 	rbp, rsp
	

	push	'g';
	push	'f';
	push	'e';
	push	'd';

	push	'c';
	push	'b';
	push	'a';
	push	'9';

	push	'8';
	push	'7';
	push	'6';
	push	'5';

	push	'4';			

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
