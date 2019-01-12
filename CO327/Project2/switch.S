.text
.global machine_switch

machine_switch:
	# address of the new sp is arg1
	# address of the current sp is arg2
	# need to store all required registered for old tcb
	# restore all required registred from the new tcb
	# then when you return, you should get to the new thread 

	
	push    %rbx
	push	%rbp
	push	%r10
	push	%r11
	push	%r12
	push	%r13
	push	%r14
	push	%r15

	mov	%rsp, (%rsi)
		
	mov	(%rdi), %rsp
	
	pop	%r15	
	pop	%r14
	pop	%r13
	pop    	%r12
	pop	%r11
	pop    	%r10
	pop    	%rbp
	pop    	%rbx
	
	ret 
