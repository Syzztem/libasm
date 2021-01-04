global	ft_list_push_front
extern	malloc

ft_list_push_front:
	push	rdi
	push	rsi
	push	rsi				;allign stack to 16 bytes duh
	mov		rdi, 16			;sizeof the struct
	call	malloc
	pop		rsi
	pop		rsi
	pop		rdi
	mov		r12, [rdi]
	mov		[rax], rsi		;first elem: data, received in param
	mov		[rax + 8], r12	;setting first elem as next
	mov		[rdi], rax		;and updating the start of the list
	ret

