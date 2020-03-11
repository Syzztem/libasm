global _ft_strlen

_ft_strlen:
	xor		rax, rax
loop:
	mov		r12b, [rdi + rax*1]
	inc		rax
	cmp		r12b, 0
	jne		loop
	dec		rax
	ret
