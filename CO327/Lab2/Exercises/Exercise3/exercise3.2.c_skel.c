#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdlib.h>

/**
 * Executes the command "cat fixtures | grep <search_term> | cut -b 1-9".
 */

#define INPUTFILE "fixtures"

void die(const char*);

int main(int argc, char **argv)
{
	int status;
	int i;

	if (argc < 2)
	{
		printf("%s: missing operand\n", argv[0]);
		printf("Usage: %s <search_term in %s>\n", argv[0],INPUTFILE);
		exit(EXIT_FAILURE);
	}

	// arguments for commands
	char *cat_args[] = {"cat", argv[1], NULL};
	char *grep_args[] = {"grep", "-i", argv[2], NULL};
	char *cut_args[] = {"cut", "-b", "1-9", NULL};

	// make 2 pipes (cat to grep and grep to cut); each has 2 fds

	int pipes[4];
	// sets up 1st pipe
	if(pipe(pipes)==-1)
		die("pipe()");

	// sets up 2nd pipe
	if(pipe(&pipes[2])==-1)
		die("pipe()");

	// we now have 4 fds:
	// pipes[0] = read end of cat->grep pipe (read by grep)
	// pipes[1] = write end of cat->grep pipe (written by cat)
	// pipes[2] = read end of grep->cut pipe (read by cut)
	// pipes[3] = write end of grep->cut pipe (written by grep)

	// fork the first child (to execute cat)

	if (fork() == 0)
	{
		// replace cat's stdout with write part of 1st pipe
		close(1);
	
		if(dup(pipes[1]) == -1)
			die("dup()");
		
		// close all pipes (very important!); end we're using was safely copied
		close(pipes[0]);
		close(pipes[2]);
		close(pipes[3]);

		// Execute the cat command
		if(execvp("cat", cat_args) == -1)
			die("execvp()_cat");

		exit(EXIT_SUCCESS);
	}
	else
	{
		// fork second child (to execute grep)

		if (fork() == 0)
		{
			// replace grep's stdin with read end of 1st pipe
			close(0);
			close(1);

			if(dup(pipes[0]) == -1)
				die("dup()");

			// replace grep's stdout with write end of 2nd pipe
			if(dup(pipes[3]) == -1)
				die("dup()");

			// close all ends of pipes
			close(pipes[1]);
			close(pipes[2]);

			// execute grep command
			if(execvp("grep", grep_args) == -1)
				die("execvp()_grep");

			exit(EXIT_SUCCESS);
		}
		else
		{
			// fork third child (to execute cut)

			if (fork() == 0)
			{
				// replace cut's stdin with input read of 2nd pipe
				close(0);

				if(dup(pipes[2]) == -1)
					die("dup()");

				// close all ends of pipes
				close(pipes[1]);
				close(pipes[3]);
				close(pipes[0]);

				// execute cut command
				if(execvp("cut", cut_args) == -1)
					die("execvp()_cut");

				exit(EXIT_SUCCESS);
			}
		}
	}

	// only the parent gets here and waits for 3 children to finish
	// It's a good idea to close all your pipes (the parent needs none!)
	// before waiting for your children! 

	close(pipes[0]);
	close(pipes[1]);
	close(pipes[2]);
	close(pipes[3]);
	close(0);
	close(1);

	wait(NULL);

	exit(EXIT_SUCCESS);
}

/* A better way to Die (exit) */
void die(const char *msg) {
	perror(msg);
	exit(EXIT_FAILURE);
}