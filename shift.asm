shift:

	push 	rbp
	mov 	rbp, rsp
	sub 	rsp, 16
	;Shift happens only in one direction: From left to right. It's a matter of a viewpoint. 
	;What you are trying to handle is just 4 numbers...
	;	011f 001e 0011 0110 0ee1 1111 0000 1010 10e0 0101 010e 0001 1001 100e 1000
	
	;1. If all 4 numbers are 0, return, we are done
	;	011e 001e 0011 0110 0ee1 1111 xxxx 1010 10e0 0101 010e 0001 1001 100e 1000
	test 	r10d, r10d
	je		done

	;2. If first one is non zero and the rest is zero, do nothing...
	;	011e 001e 0011 0110 0ee1 1111 xxxx 1010 10e0 0101 010e 0001 1001 100e xxxx
	mov		r11d, r10d ;Check if we have only first digit
	shl		r11d, 8
	test	r11d, r11d
	je		done
	
	;3. If first byte is 0, Left Logical shift by 8 bits till it becomes something. 
	;	11e0 1e00 1100 1100 ee10 1111 xxxx 1010 10e0 1010 10e0 1000 1001 100e xxxx
	mov		r11d, r10d
	shr		r11d, 24
	test	r11d, r11d
	jne 	doneshift
	shl		r10d, 8 	;first symbol is not 0, so shift

	mov		r11d, r10d
	shr		r11d, 24
	test	r11d, r11d
	jne 	doneshift
	shl		r10d, 8 	;second symbol is not 0, so shift

	mov		r11d, r10d
	shr		r11d, 24
	test	r11d, r11d
	jne 	doneshift
	shl		r10d, 8 	;third symbol is not 0, so shift    
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

done:
	leave
	ret