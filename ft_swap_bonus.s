global _ft_swap

_ft_swap:
	push	qword	[rsi]
	push	qword	[rdi]
	pop		qword	[rsi]
	pop		qword	[rdi]
	ret
