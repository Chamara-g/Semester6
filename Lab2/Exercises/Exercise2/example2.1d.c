#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>

#define READ_END 0
#define WRITE_END 1


void capitalize(char * array, int size){
	int i;
	for (i = 0; i<size; i++){
		if (array[i] >= 'a' && array[i] <= 'z'){
			array[i] = array[i] - 'a' + 'A';
		}
	}
}

int main()
{
	int pipe_ends[2];
	int pipe_ends2[2];
	pid_t pid;
	// int status;
	char userString[100];

	// Create 2 pipes for two way communication
	if(pipe(pipe_ends)) 
	{
		perror("Pipe 1 creation");
		return -1;
	}

	if(pipe(pipe_ends2)) 
	{
		perror("Pipe 2 creation");
		return -1;
	}

	pid = fork();
	if(pid < 0) 
	{
		perror("Fork");
		return -1;
	}


	if(pid > 0) 
	{ /* parent */

		printf("[+]Parent Process\n");

		char buffer2[100];

		printf("[+]Enter your input : \n");
		scanf("%s", userString); /*take user input*/

		printf("[+]Parent send [%s] ---> Child \n", userString);

		close(pipe_ends[READ_END]);
		write(pipe_ends[WRITE_END], userString, (int)strlen(userString));/*send data to child using pipe one*/
		close(pipe_ends[WRITE_END]);

		printf("[+]Parent : Waiting[for reply from child]\n");

		close(pipe_ends2[WRITE_END]);
		sleep(5);

		int count = read(pipe_ends2[READ_END], buffer2, 100);
		buffer2[count] = '\0';

		printf("[+]Parent: received String: %s\n", buffer2);
		exit(EXIT_SUCCESS);

	}

	if(pid == 0) 
	{ /* child */
		printf("[+]Child Process\n");

		char buffer[100];

		close(pipe_ends[WRITE_END]);
		sleep(5);

		printf("[+]Child(listening...)\n");

		int count = read(pipe_ends[READ_END], buffer, 100);
		buffer[count] = '\0';

		printf("[+]Child: received String: %s\n", buffer);
		
		capitalize(buffer, (int)strlen(buffer));

		printf("[+]Child Send [%s] ---> Parent\n", buffer);

		close(pipe_ends2[READ_END]);
		write(pipe_ends2[WRITE_END], buffer, (int)strlen(buffer));
		close(pipe_ends2[WRITE_END]);

		exit(EXIT_SUCCESS);
	}

	return 0;
}