global _ft_write

_ft_write:
	mov rax, 0x02000004 ;4th instruct on eax
	syscall
	jb err
	ret

err:
	mov rax, -1
	ret
