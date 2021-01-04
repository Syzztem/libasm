global ft_strcpy

ft_strcpy:
	xor		r12, r12
loop:
	mov	byte	r13b, [rsi + r12]
	mov	byte	[rdi + r12], r13b
	inc			r12
	cmp byte	r13b, 0
	jne			loop
	mov			rax, rdi
	ret
