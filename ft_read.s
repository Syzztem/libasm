global	ft_read
extern	__errno_location

ft_read:
	mov		rax, 0 ;read instrucion
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
