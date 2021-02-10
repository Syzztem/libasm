global	ft_strcmp

ft_strcmp:
	xor			rax, rax
	xor			r12, r12
loop:
	mov	byte	al, [rdi + r12]			;move byte to analyze
	cmp	byte	al, [rsi + r12]			;check if bytes are equal
	jne			end						;if not equal, done
	cmp	byte	al, 0					;return 0 if both strings are done
	je			equ						
	inc			r12						;go on to next byte
	jmp			loop
equ:
	xor			rax, rax				;return 0
	ret
end:
	mov	byte	cl, [rsi + r12]			;mov byte of s2 to analyze
	sub	byte	al, 128					;convert to unsigned char
	sub	byte	cl, 128
	cmp	byte	al, cl					;compare values
	jl			low
	mov			rax, 1					;return 1 if higher
	ret
low:
	mov			rax, -1					;return 2 if lower
	ret
