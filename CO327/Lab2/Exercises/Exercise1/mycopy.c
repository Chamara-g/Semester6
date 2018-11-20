#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

int main(int argc, char *argv[]){
	
	
	int out,outWrite;
	size_t ret,size;

	out = open(argv[1], O_RDONLY); /*read file data*/
	outWrite = open(argv[2], O_WRONLY | O_APPEND | O_CREAT , S_IRUSR | S_IWUSR );

	size_t fileLength = lseek( out, 0, SEEK_END ); /*going curser beginning to end*/

	lseek( out, 0, SEEK_SET );/*again curser take to biginning*/

	size = fileLength;

	if(out == -1)
	{
		fprintf(stderr,"Couldn't open the file\n");
		return 1;
	} 

	char* buffer = malloc(size+1); /* size of a char is 1. This buffer holds the read back value. */

	ret = read(out,buffer,size);

	if(ret == -1)
	{
		fprintf(stderr,"Error reading from file\n");
		return 1;
	}
	buffer[ret] = '\0'; /* we have to null terminate the string ourselves. */

	ret = write(outWrite,buffer,size);
	
	if(ret == -1)
	{
		fprintf(stderr,"Error writing to file\n");
		return 1;
	}

	free(buffer);

	ret = close(out);

	if(ret == -1)
	{
		fprintf(stderr,"Error closing the file after reading.\n");
		return 1;
	}

	return 0;

}