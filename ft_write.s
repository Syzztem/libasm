global	ft_write
extern	__errno_location

ft_write:
	mov		rax, 1 ;write instrucion
	syscall
	cmp		rax, 0
	jl		err
	ret
err:
	push	rax
	call	__errno_location
	pop		rsi
	neg		rsi
	mov		[rax], rsi
	mov		rax, -1
	ret
