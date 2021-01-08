global	ft_write
extern	__errno_location

ft_write:
	mov		rax, 1				;write instrucion
	syscall
	cmp		rax, 0				;error checking
	jl		err
	ret
err:
	push	rax					;save errno value for later and align stack, pro gamer move
	call	__errno_location	;returns a pointer to errno
	pop		rsi					;get errno value
	neg		rsi					;make it positive as write returned the opposite value
	mov		[rax], rsi			;shove it in errno
	mov		rax, -1				;return -1
	ret
