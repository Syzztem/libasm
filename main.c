/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lothieve <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/02/21 13:33:31 by lothieve          #+#    #+#             */
/*   Updated: 2020/03/05 17:02:35 by lothieve         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#define S1 "basic input"
#define S2 "test"
#define S3 "another string which is longer but not that long actually, just to test stuff"
#define EMPTY_STR ""

typedef struct	s_list
{
	void *data;
	struct s_list*next;
}				t_list;
int ft_strlen(char *);
void ft_swap(int *a, int *b);
char *ft_strcpy(char *, char *);
int	ft_strcmp(char *, char *);
int ft_write(int, void *, int);
int ft_read(int, void *, int);
char *ft_strdup(char *);
int ft_atoi(char *);
int ft_atoi_base(char *, char *);
void ft_list_push_front(t_list **begin_list, void *data);
int	ft_list_size(t_list *head);
void ft_list_sort(t_list **begin_list, int(cmp)(void *,void *));
void *ft_list_remove_if(t_list **,void *,int(*cmp)(),void(*free_fct)(void*));

void	pheader(char *title)
{
	puts("\n--------------------------------");
	puts("|                               |");
	printf("|         %-*s|\n", -13 - ft_strlen(title), title);
	puts("|                               |");
	puts("--------------------------------\n");
}

void print_list_elem(t_list *elem)
{
	printf("elem:   address:      %p\n\tdata:         %s\n\tdata address: %p\n\tnext address: %p\n\n", elem, elem->data, elem->data, elem->next);
}

void print_list(t_list *list)
{
	while(list)
	{
		print_list_elem(list);
		list = list->next;
	}
}

char *elem_data()
{
	static int id = 0;
	char *data = malloc(7);
	sprintf(data, "elem %.2d",id);
	id++;
	return data;
}

int cmp(void *a, void *b)
{
	char *sa = a;
	char *sb = b;
	if (*sa == 'f' || *sb == 'l')
		return 1;
	if (*sa == 'l' || *sb == 'f')
		return -1;
	return (memcmp(a, b, 7));
}

int	ri_cmp(void *a, void *b)
{
	return (memcmp(a, b, 6));
}

int main(int ac, char **av)
{
	pheader("ft_strlen");
	printf("basic string :\"%s\" -> %d\n", S1, ft_strlen(S1));
	printf("basic string :\"%s\" -> %d\n", S2, ft_strlen(S2));
	printf("basic string :\"%s\" -> %d\n", S3, ft_strlen(S3));
	printf("empty string : %d", ft_strlen(EMPTY_STR));

	pheader("ft_strcpy");
	printf("basic string :\"%s\" -> %s\n", S1, ft_strcpy(malloc(ft_strlen(S1) + 1), S1));
	printf("basic string :\"%s\" -> %s\n", S2, ft_strcpy(malloc(ft_strlen(S2) + 1), S2));
	printf("basic string :\"%s\" -> %s\n", S3, ft_strcpy(malloc(ft_strlen(S3) + 1), S3));
	printf("empty string : \"%s\"", ft_strcpy(malloc(1), EMPTY_STR));

	pheader("ft_strcmp");
	printf("basic strings :\"%s\", \"%s\" -> %d\n", S1, S2, ft_strcmp(S1, S2));
	printf("expected: %d\n", strcmp(S1, S2));
	printf("basic strings :\"%s\", \"%s\" -> %d\n", "tesu", "test", ft_strcmp("tesu", "test"));
	printf("expected: %d\n", strcmp("tesu", "test"));
	printf("two empty strings : %d\n", ft_strcmp("", ""));

	pheader("ft_strdup");
	printf("basic string :\"%s\" -> \"%s\"\n", S1, ft_strdup(S1));
	printf("basic string :\"%s\" -> \"%s\"\n", S2, ft_strdup(S2));
	printf("basic string :\"%s\" -> \"%s\"\n", S3, ft_strdup(S3));
	printf("empty string : -> \"%s\"\n", ft_strdup(""));

	pheader("ft_write");
	printf("basic input : \"%s\" writes: \"", S1);
	printf("\", returns %d\n", ft_write(1, S1, ft_strlen(S1)));
	printf("basic input : \"%s\" writes: \"", S2);
	printf("\", returns %d\n", ft_write(1, S2, ft_strlen(S2)));
	printf("bad fd writes: \"");
	printf("\", returns %d\n", ft_write(5, S2, ft_strlen(S2)));
	printf("errno:%d\n", errno);
	
	pheader("ft_read");
	int fd = open("main.c", O_RDONLY);
	char buff[51];
	buff[50] = 0;
	int ret = ft_read(fd, buff, 50);
	printf("basic read(50 bytes) : \"%s\" \n\n\n returns: %d\n", buff, ret);
	ret = ft_read(42, buff, 50);
	printf("bad fd : returns %d, errno = %d\n", ret, errno);


#ifdef BONUS

	pheader("ft_swap");
	int a = 42;
	int b = 24;
	printf("before: %d, %d\n", a, b);
	ft_swap(&a, &b);
	printf("after: %d, %d\n", a, b);
	
	pheader("ft_atoi_base");
	puts("basic tests : binary");
	printf("\texpected: 42, input \"101010\" -> %d\n", ft_atoi_base("101010", "01"));
	printf("\texpected: 42, input \"  101010\" -> %d\n", ft_atoi_base("  101010", "01"));
	printf("\texpected: -42, input \"  -101010\" -> %d\n", ft_atoi_base("  -101010", "01"));
	printf("\texpected: 0, input \"0\" -> %d\n", ft_atoi_base("0", "01"));
	puts("basic tests : hex");
	printf("\texpected: 42, input \"2a\" -> %d\n", ft_atoi_base("2a", "0123456789abcdef"));
	printf("\texpected: 42, input \"+2a\" -> %d\n", ft_atoi_base("+2a", "0123456789abcdef"));
	printf("\texpected: 42, input \"2ax5\" -> %d\n", ft_atoi_base("2ax5", "0123456789abcdef"));
	printf("\texpected: -42, input \"  -2a  5\" -> %d\n", ft_atoi_base(" -2a  5", "0123456789abcdef"));
	printf("\texpected: 0, input \"  - 2a  5\" -> %d\n", ft_atoi_base("  - 2a  5", "0123456789abcdef"));
	puts("wrong bases");
	printf("\tinput \" base\" -> %d\n", ft_atoi_base("a", " base"));
	printf("\tinput \"b-ase\" -> %d\n", ft_atoi_base("a", " b-ase"));
	printf("\tinput \"a\" -> %d\n", ft_atoi_base("a", "a"));
	printf("\tinput \"bbase\" -> %d\n", ft_atoi_base("a", "bbase"));
	
	pheader("ft_list_push_front");
	t_list	*head = NULL;
	char *s1 = strdup("last elem");
	char *s2 = strdup("first elem");
	puts("starting first element at NULL");
	printf("inserting first element %s at adress %p\n", s1, s1);
	ft_list_push_front(&head, s1);
	t_list *tail = head;
	print_list_elem(head);
	for (int i = 0; i < 20; i++)
	{
		ft_list_push_front(&head, elem_data());;
		print_list_elem(head);
	}
	ft_list_push_front(&head, s2);
	print_list_elem(head);

	pheader("ft_list_size");
	printf("size of list: %d\n", ft_list_size(head));
	printf("1 elem: %d\n", ft_list_size(tail));
	printf("NULL: %d\n", ft_list_size(NULL));

	pheader("ft_list_sort");
	ft_list_sort(&head, cmp);
	print_list(head);

	pheader("ft_list_remove_if");
	char *data_cmp = "elem c";
	void *th = ft_list_remove_if(&head, data_cmp, ri_cmp, free);
	printf("%p\n", th);
	printf("%p\n", data_cmp);
	printf("%p\n", ri_cmp);
	printf("%p\n", free);
//	puts(th);
#endif
}
