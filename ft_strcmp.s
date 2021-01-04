global	ft_strcmp

ft_strcmp:
	xor			rax, rax
	xor			r12, r12
loop:
	mov	byte	al, [rdi + r12]
	cmp	byte	al, [rsi + r12]
	jne			end
	inc			r12
	cmp	byte	[rdi + r12], 0
	jne			loop
	xor			rax, rax
	ret
end:
	cmp	byte	al, [rsi + r12]
	jl			low
	mov			rax, 1
	ret
low:
	mov			rax, -1
	ret
