global ft_list_sort

ft_list_sort:
	push		rdi				;stack allign
	mov			rdi, [rdi]
	cmp			rdi, 0
	je			end
	mov			r12, rsi
	xor			r13, r13
nest_loop:
	pop			rdi
	push		rdi
	mov			rdi, [rdi]		;reset rdi
	cmp			r13, 0
	jne			end
	inc			r13
loop:
	mov	qword	rsi, [rdi + 8]	;rdi = elem, rsi = next
	cmp			rsi, 0
	je			nest_loop
	push		rsi				;push the elems
	push		rdi
	mov			rsi, [rsi]		;parameters of function are data
	mov			rdi, [rdi]
	call		r12				;call function pointer
	pop			rsi				;swapping rsi and rdi, so it will be set
	pop			rdi				;properly for next loop
	cmp			rax, 0			;compare output
	jge			loop
	push qword	[rsi]			;output < 0, swapping
	push qword	[rdi]
	pop	 qword	[rsi]
	pop	 qword	[rdi]
	xor			r13, r13
	jmp			loop
end:
	pop			rdi
	ret
