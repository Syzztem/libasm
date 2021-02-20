global	ft_list_remove_if
extern	free

ft_list_remove_if:					;rdi = begin, rsi = data_ref, rdx = cmp, rcx = free_fct
loop:
	mov		qword	r12, [rdi]		;set head to rdi
	cmp		qword	r12, 0			;is it null?
	je				end				;if so, yeet
	push	qword	rdi				;save args for later
	push	qword	rsi
	push	qword	rdx
	push	qword	rcx
	push	qword	rcx				;save free fct
	push	qword	rdi				;save begin address
check_head:							;stack : +16 |begin|free_fct| + 4 args
	pop		qword	r12				;get head
	mov		qword	rdi, [r12]		;*begin
	mov		qword	rdi, [rdi]		;begin->data
	push	qword	r12				;save registers
	push	qword	rsi				;stack : +24 |data_ref|begin|free_fct| + 4 args
	call			rdx				;call cmp function (begin->data, data_ref)
	pop				rsi				;data_ref, 
	cmp				rax, 0			;does it match?
	jne				next_node		;if not, done
	pop		qword	r12				;begin
	pop		qword	rcx				;free_fct, stack is empty
	mov		qword	rdi, [r12]		;*begin
	mov		qword	rdi, [rdi]		;begin->data
	push	qword	r12				;save begin
	call			rcx				;free begin->data
	pop				r12				;begin
	mov		qword	rdi, [r12]		;*begin
	mov		qword	rsi, [rdi + 8]	;begin->next
	sub				rsp, 8			;allign stack
	push	qword	rsi				;save begin and next
	push	qword	r12				;stack: +24 |begin|begin->next|begin->next| + 4 args
	call			free			;free(*begin)
	pop		qword	rdi				;begin
	pop		qword	rsi				;begin->next
	mov		qword	[rdi], rsi		;replace begin with next
	add				rsp, 8			;discard useless elem
	pop		qword	rcx				;get args back
	pop		qword	rdx
	pop		qword	rsi
	add				rsp, 8			;discard old address
	jmp				loop
	jmp				end
next_node:							;stack has rcx, rdi + 4 base args
	add				rsp, 16			;discard 2 elems
	pop		qword	rcx				;get args back
	pop		qword	rdx
	pop		qword	rsi
	pop		qword	rdi
	mov     qword   rdi, [rdi]      ;*begin
	lea		qword	rdi, [rdi + 8]	;load effective address of begin->next
	jmp				loop
end:								
	ret
