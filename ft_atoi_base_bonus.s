global ft_atoi_base

ft_atoi_base:
	xor			r12, r12		;base length
	xor			r13, r13		;char collecting
	mov			r14, 1			;sign
	xor			rax, rax
verify_base:
	mov			r13b, [rsi + r12]
	cmp	byte	r13b, '+'
	je			exit
	cmp	byte	r13b, '-'
	je			exit
	cmp	byte	r13b, 32
	jle			exit
	push		rsi				;save rsi before getting messy 
	add			rsi, r12
check_double:					;check if a char got a double
	inc			rsi
	cmp	byte	[rsi], r13b
	je			ex_pop
	cmp	byte	[rsi], 0
	jne			check_double	;end loop
	inc			r12
	pop			rsi
	cmp	byte	[rsi + r12], 0
	jne			verify_base		;if control gets past, base OK
	dec			rdi
jump_spaces:
	inc			rdi
	cmp	byte	[rdi], 0
	je			exit
	cmp	byte	[rdi], 32
	jle			jump_spaces
	cmp	byte	[rdi], '+'		;handling sign
	je			pos_inc
	cmp	byte	[rdi], '-'
	jne			number
	mov			r14, -1			;set to negative bc it's a -
pos_inc:
	inc			rdi
number:
	push		r12				;saving base length
	xor			r12, r12
	mov	byte	r13b, [rdi]
is_in_base:
	cmp	byte	r13b, [rsi + r12]
	je			base_indexed	;found char in base, index is r12
	cmp	byte	[rsi + r12], 0
	je			ex_pop			;not found, returning
	inc			r12
	jmp			is_in_base
base_indexed:
	pop			r13				;getting back base length
	imul		rax, r13
	add			rax, r12
	xchg		r12, r13		;reordering loop
	inc			rdi
	cmp	byte	[rdi], 0
	jne			number
exit:
	imul		rax, r14		;multiplying by sign
	ret
ex_pop:
	imul		rax, r14		;multiplying by sign
	pop			rsi
	ret
