global	_ft_list_remove_if
extern	_free

_ft_list_remove_if:
	mov			rdi, [rdi]		;set head to rdi
	cmp			rdi, 0			;is it null?
	je			end				;if so, yeet
	mov			r13, rcx		;stock free function in r13
	mov			r14, rdx		;stock cmp function in r14
	mov			r15, rsi
loop:
	mov	 qword	r12, [rdi + 8]	;rdi = elem, r12 = next
	cmp			r12, 0			;check if NULL
	je			end
	xchg		rdi, r12		;swap it
	push		rdi				;push next
	mov			rdi, [rdi]		;rdi = next->data
	call		rdx				;arg is already rsi
	cmp			rax, 0
	jne			lend
	call		r13				;free it
	pop			rdi				;rdi = next
	push qword	[rdi + 8]		;this is what we call a pro gamer move, I 
	call		_free			;allign stack and save pointer at the same time
	pop	 qword	[r12 + 8]		;and I smoothly pop it on the previous node
	jmp			loop
lend:
	pop			rdi
	jmp			loop
end:
	ret
