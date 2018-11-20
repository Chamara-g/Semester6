#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

#define MAX_SIZE 1024 

void die(const char *msg);

int main() 
{ 	

	int fd, fd2; 

	char* fifo = "/tmp/fifo"; 
	char* fifo2 = "/tmp/fifo2";

	char buf[MAX_SIZE]; 

	// Get input from user
	char userString[MAX_SIZE];

    	printf("Input String: ");
    	scanf("%s", userString);

	// Make 2 named pipelines
	mkfifo(fifo, 0666);
	mkfifo(fifo2, 0666);

	// Send data to the other process
	printf("Sending to reader: %s\n", userString);
	
	fd = open(fifo, O_WRONLY);

	write(fd, userString, strlen(userString)); 
    	close(fd); 

	// Read data from pipe
	fd2 = open(fifo2, O_RDONLY);
    	read(fd2, buf, MAX_SIZE); 
    	printf("Capitalized String : %s\n", buf); 
    
	close(fd2); 

	// Distroy pipes
	unlink(fifo);
	unlink(fifo2);

    return 0; 
}

/* A better way to Die (exit) */
void die(const char *msg) {
	perror(msg);
	exit(EXIT_FAILURE);
}