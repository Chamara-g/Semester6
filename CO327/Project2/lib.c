#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "threadlib.h"
#include "threadimp.h"

#ifndef __x86_64__
#error "NOT 64bit" 
#endif


#define DEBUG
// #undef DEBUG /* uncomment when you are done! */

/* 
 * Idea here is that, if DEBUG is defined PRINT will be 
 * printf else it would be nothing. 
 * Use PRINT to print all your debug information and when you 
 * undefine DEBUG all that code will be gone :) 
 */ 
#ifdef DEBUG
 #define PRINT   printf
#else 
 #define PRINT(...)
#endif



////////////////////////////-----------------------------------------------
int thread_count = 1;

// Implementation for circular linked list



/* Track the current thread
 */ 
tcb_t __current_thread;

/* You might need other information about the 
 * thread system as well. 
 */
tcb_t current_thread(void)
{
  return __current_thread;
}

void set_current(tcb_t current)
{
  __current_thread = current;
}

/*Creates a new tcb*/
tcb_t newtcb(void)
{ 
  tcb_t dummy = (tcb_t) malloc(sizeof(struct tcb));
	
	/* might want to initialize the fields in the TCB */
	return dummy;
}

int append(tcb_t newguy)
{
	
	// PRINT("%d threads\n",numOfTCB);
	
	if (current_thread() == NULL){
	    newguy->next = newguy;
	    newguy->prev = newguy;
	    set_current(newguy);
  	}else{  		
	    tcb_t current = current_thread();  		
	    newguy->prev = current;  		
	    newguy->next = current->next;
	    current->next->prev = newguy;  		
	    current->next = newguy;
  	}
	return 0;
}



int delete_item (tcb_t thread)
{
	// if there exists only one thread, when deleted should return to delete_thread which will be asserted. if not this is a function that never
	// gets returned !!
	if (thread == thread->next){ 
    	free(thread);
    	__current_thread = NULL;
    	return 0;
    }
	// searchThread(thread->threadId);
	tcb_t new = schedule(thread);
  	
	thread->prev->next = thread->next;
	thread->next->prev = thread->prev;
	
	free(thread);
	
	struct timeval  tv1;
	gettimeofday(&tv1, NULL);

	new->time_stamp = tv1;

	set_current(new);


	int a=0;
  	switch_threads(current_thread(), (tcb_t)&a);

	return 0;
}


tcb_t schedule(tcb_t current)
{
  /* decide who should run next */
	// if(search_tcb == NULL){
	// 	search_tcb  = head_tcb;
	// 	return search_tcb;
	// }
	// search_tcb = search_tcb->next;
 //  	return search_tcb;
	// printf("%lld\n", (long long int)(*current->time));
// 	struct timeval tv;
// unsigned long time_in_micros = 1000000 * tv.tv_sec + tv.tv_usec;
// 	PRINT("now time %lu\n",time_in_micros);
	
	


	tcb_t temp = current->next;
	tcb_t next_thread = temp;
	double least_time = temp->cpu_time;
	PRINT("running thread id %d\n",current->threadId);
	while(temp->next != current){
		// PRINT("thread id %d\n",temp->threadId);
		if(least_time > temp->cpu_time){
			least_time = temp->cpu_time;
			next_thread = temp;
			PRINT("least_time %f\n",least_time);
		}
		temp = temp->next;
		
	}

	PRINT("switched to thread %d\n",next_thread->threadId);
	return next_thread;
}

void switch_threads(tcb_t newthread /* addr. of new TCB */,
		    tcb_t oldthread /* addr. of old TCB */) {

  /* This is basically a front end to the low-level assembly 
   * code to switch. */
  /* Might have store the SP values back to TCB */ 
	



	machine_switch(newthread,oldthread);

  /* When you do this call, you should return back to this 
   * point in a different thread. 
   * When you are eventually rescheduled, return through 
   * the calling stack 
   */ 
  return; 

}


/*********************************************************
 *                 Thread creation etc 
 *********************************************************/
int create_thread(void (*ip)(void))
{  
	

	long int  *stack; 
	stack = malloc_stack();
	if(!stack) return -1; /* cannot allocate memory for stack */

	// top most value should be ip
	*(stack) = (long int) ip;

	tcb_t newtcb = malloc(sizeof(struct tcb));
	newtcb->sp = (void *) stack-64;
	newtcb->threadId = thread_count;
	thread_count++;
	newtcb->cpu_time = 0.0;
	
	if (!append(newtcb))
	return 0;
	return -1;


}

void yield()
	{
	PRINT("came to yield\n");
	tcb_t cur = current_thread();
	tcb_t new = schedule(cur);
	set_current(new);


	struct timeval  tv1;
	gettimeofday(&tv1, NULL);

	cur->cpu_time =  (double) (tv1.tv_usec - cur->time_stamp.tv_usec) / 1000000 + (double) (tv1.tv_sec - cur->time_stamp.tv_sec);

	new->time_stamp = tv1;


	switch_threads(new, cur);
	return; 
}


void delete_thread(void)
{

  /* When a user-level thread calls this you should not 
   * let it run any more but let others run
   * make sure to exit when all user-level threads are dead */   
	if (!current_thread()){
	// no threads
		PRINT("no threads\n");
    	exit(0);
	
	} 
	tcb_t cur = current_thread();
 	delete_item(cur);
	if (!current_thread()){
	// no threads
		PRINT("no threads\n");
    	exit(0);
	
	} 

}

#include <assert.h>
void stop_main(void)
{ 
  /* Main function was not created by our thread management system. 
   * So we have no record of it. So hijack it. 
   * Do not put it into our ready queue, switch to something else.*/


	tcb_t new = current_thread();
	struct timeval  tv1;
	gettimeofday(&tv1, NULL);

	new->time_stamp = tv1;

	int a=0;
	switch_threads(new, (tcb_t)&a);
	assert(!printf("Should not be here %s",__func__));

}

#include <stdlib.h>


/*
 * allocate some space for thread stack.
 * malloc does not give size aligned memory 
 * this is some hack to fix that.
 * You can use the code as is. 
 */
void * malloc_stack() 
{
  /* allocate something aligned at 16
   */
   void *ptr = malloc(STACK_SIZE + 16);

   if (!ptr) return NULL;
   ptr = (void *)(((long int)ptr & (-1 << 4)) + STACK_SIZE);
   return ptr;
}

