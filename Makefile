# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lothieve <lothieve@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/08/08 11:37:59 by lothieve          #+#    #+#              #
#    Updated: 2020/03/03 11:34:15 by lothieve         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS = ft_atoi.s ft_read.s ft_strcmp.s ft_strcpy.s ft_strdup.s ft_strlen.s ft_write.s

BONUS = ${SRCS} ft_atoi_base_bonus.s ft_list_push_front_bonus.s ft_list_remove_if_bonus.s ft_list_size_bonus.s ft_list_sort_bonus.s ft_swap_bonus.s

OBJS = ${SRCS:.s=.o}

OBJB = ${OBJS} ${BONUS:.s=.o}

NAME = libasm.a

CFLAGS = -Wall -Wextra -Werror -g

ASM = nasm

ASFLAGS = -fmacho64

CC = clang

RM = rm -f

all:		${NAME}

bonus:		${OBJB}
				ar rcs ${NAME} ${OBJB}
.s.o:
			${ASM} ${ASFLAGS} $< -o ${<:.s=.o}

${NAME}:	${OBJS}
				ar rcs ${NAME} ${OBJS}

clean:
				${RM} ${OBJB}

fclean:		clean
				${RM} ${NAME}

re:			fclean all

.PHONY:		all clean fclean re
