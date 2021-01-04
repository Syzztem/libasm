global ft_swap

ft_swap:
	push	qword	[rsi]
	push	qword	[rdi]
	pop		qword	[rsi]
	pop		qword	[rdi]
	ret
