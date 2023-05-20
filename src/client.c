/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmnatsak <tmnatsak@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/05/14 18:15:55 by tmnatsak          #+#    #+#             */
/*   Updated: 2023/05/20 21:58:19 by tmnatsak         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <stdio.h>

int	g_expected_len = 0;

void	handler(int signum)
{
	if (signum == SIGUSR1)
		g_expected_len++;
}

int	send_bits(char c, int pid)
{
	int			i;
	static int	len;

	i = 0;
	while (i < 8)
	{
		if ((c & (0x01 << i)))
			kill(pid, SIGUSR1);
		else
			kill(pid, SIGUSR2);
		i++;
		usleep(1000);
	}
	len++;
	return (len);
}

int	main(int argc, char **argv)
{
	int					i;
	int					pid;
	struct sigaction	sa;
	int					len;

	len = 0;
	if (argc != 3)
		return (1);
	i = 0;
	pid = atoi(argv[1]);
	sigemptyset(&sa.sa_mask);
	sa.sa_flags = 0;
	sa.sa_handler = &handler;
	sigaction(SIGUSR1, &sa, NULL);
	while (argv[2][i])
		send_bits(argv[2][i++], pid);
	len = send_bits('\n', pid);
	if (g_expected_len == len)
		printf("Got an ack");
	else
		printf("Something went wrong");
	return (0);
}
