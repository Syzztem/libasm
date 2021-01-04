global ft_write

ft_write:
	mov rax, 1 ;write instrucion
	syscall
	jb err
	ret

err:
	mov rax, -1
	ret
