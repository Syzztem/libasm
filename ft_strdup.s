global	_ft_strdup
extern	_ft_strlen
extern	_ft_strcpy
extern	_malloc

_ft_strdup:
	push	rdi
	call	_ft_strlen
	mov		rdi, rax
	inc		rdi
	call	_malloc
	cmp		rax, 0
	je		exit
	mov		rdi, rax
	pop 	rsi
	call	_ft_strcpy
exit:
	ret
