shift:

	push 	rbp
	mov 	rbp, rsp
	sub 	rsp, 32
	
	;1. If all 4 numbers are 0, return, we are done
	test 	r10, r10	;Is it zero? 
	jne		shift_cont1	;If not, we are carry on
	test 	r11, r11	;Check every register
	jne		shift_cont1
	test 	r12, r12
	jne		shift_cont1
	test 	r13, r13
	jne		shift_cont1
	jmp		done		;And if all of them are - wer are done here...
shift_cont1:
	;2. If first one is non zero and the rest is zero, do nothing...
	test	r10, r10
	je		shift_cont2
	test 	r11, r11
	jne		shift_cont2
	test 	r12, r12
	jne		shift_cont2
	test 	r13, r13
	jne		shift_cont2
	jmp		done
shift_cont2:	;if the first 3 are zeroes
	test	r10, r10
	jne		shift_cont22
	test 	r11, r11
	jne		shift_cont22
	test 	r12, r12
	jne		shift_cont22
	test 	r13, r13
	je		shift_cont22
	mov		r10, r13
	mov		r13,0x0
	jmp		done




shift_cont22:

	;if the first 2 and the last one is a zero, just move it and we are done
	test	r10, r10
	jne		shift_cont22222
	test 	r11, r11
	jne		shift_cont22222
	test 	r12, r12
	je		shift_cont22222
	test 	r13, r13
	jne		shift_cont22222
	mov		r10, r12
	mov		r12,0x0
	jmp		done
shift_cont22222:


	;if the first 2 are zeroes
	test	r10, r10
	jne		shift_cont222
	test 	r11, r11
	jne		shift_cont222
	test 	r12, r12
	je		shift_cont222
	test 	r13, r13
	je		shift_cont222
	mov		r10, r12
	mov		r11, r13
	mov		r12,0x0
	mov		r13,0x0
	jmp		solve_left_2
shift_cont222:

	;if the pattern is xoxo
	test	r10, r10
	je		shift_cont2222
	test 	r11, r11
	jne		shift_cont2222
	test 	r12, r12
	je		shift_cont2222
	test 	r13, r13
	jne		shift_cont2222
	mov		r11, r12
	mov		r12,0x0
	jmp		solve_left_2
shift_cont2222:

	;Total rework of the algorythm. 
	;We have 4 items.
	;If the first or second are 0, remove it and solve the equation for first 3 items instead. 
	;If the first one equals second one, add them up and solve the equation for the second 3 items.
	;If the first one does not equal second one, solve the equation for the second 3 items. 
	;xxxx => yxx_
	;xxxo => yxo_
	;xxoo => yoo_
	;oxoo => xoo_
	;xoxx => xxx_


	;If the first or second are 0, remove it and solve the equation for first 3 items instead. 
	test	r10, r10	;first one is zero
	jne		shift_cont3
	mov		r10, r11
	mov 	r11, r12
	mov		r12, r13
	mov		r13, 0x0
	
	jmp solve_first_3

shift_cont3:
	;If the first or second are 0, remove it and solve the equation for first 3 items instead. 
	test	r11, r11	;second one is zero
	jne		shift_cont33
	mov 	r11, r12
	mov		r12, r13
	mov		r13, 0x0
	
	jmp solve_first_3

shift_cont33:
	;If the first one equals second one, add them up and solve the equation for the second 3 items.
	cmp		r10, r11	
	jne		shift_cont4
	inc		r10
	mov		r11, r12
	mov		r12, r13
	mov		r13, 0x0
	jmp solve_second_3
shift_cont4:	
	;If only the first and the last one are numbers, but the ones in the middle are empty
	test	r11, r11
	jne		shift_cont5
	test	r12, r12
	jne		shift_cont5
	test	r13, r13
	je		shift_cont5
	cmp		r10, r13	;If they are equal, add them up
	jne		shift_them
	inc		r10
	mov 	r13, 0x0
	jmp		done
shift_them:				;if not - put them together and you are done. 
	mov 	r11, r13
	mov		r13, 0x0
	jmp		done

shift_cont5:
	jmp solve_second_3
done:
	leave
	ret

	;solution for the first 3 and the second 3 is the same, just diferent registers are in use. 
solve_first_3:
	test 	r10, r10	;Is it zero? 
	jne		solve_first_3_cont1	;If not, we are carry on
	test 	r11, r11	;Check every register
	jne		solve_first_3_cont1
	test 	r12, r12
	jne		solve_first_3_cont1
	jmp		done

solve_first_3_cont1:

	test 	r10, r10	;If the first one is not zero, but the rest ones are zero
	je		solve_first_3_cont2	;If not, we are carry on
	test 	r11, r11	;Check every register
	jne		solve_first_3_cont2
	test 	r12, r12
	jne		solve_first_3_cont2
	jmp		done
solve_first_3_cont2:

	test	r11, r11	;If the middle one of them is zero, remove it and solve the first two 
	jne		solve_first_3_cont3
	mov		r11, r12
	mov		r12, 0x0
	jmp		solve_left_2
solve_first_3_cont3:

	test	r12, r12	;If the last one is zero, solve middle 2
	jne		solve_first_3_cont4
	jmp		solve_middle_2
solve_first_3_cont4:
	cmp		r10, r11
	jne		solve_first_3_cont5
	inc		r10
	mov		r11, r12
	mov		r12, 0x0
solve_first_3_cont5:
	cmp		r11, r12
	jne		solve_first_3_cont6
	inc		r11
	mov		r12, 0x0
solve_first_3_cont6:

	jmp 	done



solve_second_3: 
	test 	r11, r11	;Is it zero? 
	jne		solve_second_3_cont1	;If not, we are carry on
	test 	r12, r12	;Check every register
	jne		solve_second_3_cont1
	test 	r13, r13
	jne		solve_second_3_cont1
	jmp		done
solve_second_3_cont1:	

	test 	r11, r11	;Is the first one is not zero, but the rest are zero
	je		solve_second_3_cont2	;If not, we are carry on
	test 	r12, r12	;Check every register
	jne		solve_second_3_cont2
	test 	r13, r13
	jne		solve_second_3_cont2
	jmp		done
solve_second_3_cont2:	

	test 	r11, r11	;If there is only one in the middle, remove zero and be done with it. 
	jne		solve_second_3_cont22	;If not, we are carry on
	test 	r12, r12	;Check every register
	je		solve_second_3_cont22
	test 	r13, r13
	jne		solve_second_3_cont22
	mov		r11, r12
	mov		r12, 0x0
	jmp		done
solve_second_3_cont22:	

	test	r12, r12	;If the middle one of them is zero, remove it and solve the first two 
	jne		solve_second_3_cont3
	mov		r12, r13
	mov		r13, 0x0
	jmp		solve_middle_2
solve_second_3_cont3:
	test	r13, r13	;If the last one is zero, solve middle 2
	jne		solve_second_3_cont4
	jmp		solve_middle_2

;if all three of them are there:
	cmp		r11, r12
	jne	solve_second_3_cont4
	inc		r11
	mov		r12, r13
	mov		r13, 0x0
	jmp		done
solve_second_3_cont4:

	cmp		r12, r13
	jne	solve_second_3_cont5
	inc		r12
	mov		r13, 0x0
solve_second_3_cont5:
	cmp		r11, r12
	je		solve_middle_2
	
	jmp 	done	

solve_middle_2:
	cmp		r11, r12
	jne		done
	inc		r11
	mov		r12, 0x0
	jmp		done

solve_left_2:
	cmp		r10, r11
	jne		done
	inc		r10
	mov		r11, 0x0
	jmp		done	