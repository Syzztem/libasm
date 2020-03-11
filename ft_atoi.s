global	_ft_atoi

_ft_atoi:
	xor		rax, rax	;return
	xor		r12, r12	;index
	mov		r13, 1		;sign
	dec		rdi
while_space:
	inc			rdi
	mov	byte	r12b, [rdi]
	cmp	byte	r12b, 0
	je			exit
	cmp	byte	r12b, 32
	jle			while_space
sign:
	mov	byte	r12b, [rdi]
	cmp	byte	r12b, '-'
	je			neg
	cmp	byte	r12b, '+'
	je			pos
	jmp			number
neg:
	mov			r13, -1			;set sign to -1
pos:
	inc			rdi
number:
	mov	byte	r12b, [rdi]
	cmp	byte	r12b, 57		;0 <= byte <= 9?
	jg			exit
	cmp	byte	r12b, 48
	jl			exit
	sub			r12b, 48		;48 = '0'
	imul		rax, 10			;multiply output (rax) by 10
	add			rax, r12
	inc			rdi
	jmp			number
exit:
	imul		rax, r13
	ret
