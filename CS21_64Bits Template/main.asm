;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
 
	welcomePrompt		db		"Hello, welcome to my program", 00h
	goodbyePrompt		db		"Program ending, have a great day!", 00h
	oldBotAddress 		dq 		0h
	newBotAddress		dq 		0h

SECTION .bss
	numArgument 		resq 	1
	programPath 		resq 	1
	argumentOne 		resq 	1
	argumentTwo 		resq 	1
	argumentThree 		resq 	1

	

SECTION     .text
	global  _start
     
_start:
		nop

	push	welcomePrompt						;Move welcome prompt
	call	PrintString
	call	Printendl
	call	Printendl

	pop 	rax									;get number of argument and put into rax
	mov 	[numArgument], rax					;Save the number of argument
	pop 	rax									;get address of  program path
	mov 	[programPath], rax					;Save  programPath st argument
	pop 	rax									;get address of first argument and put into rax
	mov 	[argumentOne], rax					;Save the first of argument
	pop 	rax									;get seccond argument put into rax
	mov 	[argumentTwo], rax					;Save  2 nd argument
	pop 	rax									;get address of third argument and put into rax
	mov 	[argumentThree], rax				;Save the third of argument

	mov 	rcx,rax

	arguLoop:
		call PrintString					 	;print string text arg
		call Printendl
	loop arguLoop	




	; ;obtain the curretn bottom of my program

	; mov 	rax, 0ch 							;sys_brk call
	; mov 	rdi, 0h 							;Return into rax the current bottom of the program
	; syscall 									;poke the kernel
	; mov 	[oldBotAddress], rax 				;Save the old bottom

	; ;allocate 100bytes
	; mov 	rdi, rcx 							;move the bottom address into rdi
	; add 	rdi,100h 							;Increase this by 100h bytes
	; mov 	rax,0ch								;sys_brk call
	; syscall
	; cmp 	rax,0 								;check if the re-allocation work?
	; ;jl 		allocationError						;jump to this label if error
	; mov 	[newBotAddress], rax 				;Save the rax to new bottom

	; mov 	rcx, 100h 							;Let's fil our newly allocated memory with 8ah
	; mov 	rsi, [oldBotAddress]				;address of the old last bytes which is the first new bytes of our
	; PhiLoop:									;allocate memory
	; 	mov 	 [rsi], BYTE 0ah			;put an a there
	; 	inc 	rsi								;Go to next memory location
	; loop PhiLoop								;loop it


	; ;restore our original memory area (delete the previousely allocated memory)

	; mov 	rax,0ch 							;sys_brk call
	; mov 	rdi,[oldBotAddress] 				;our original memory bottom
	; syscall 								

	; nop 		

	
	;allocationError:
		;Do something to tell the user that the allocation failed

	
	;Setup the registers for exit and poke the kernel

exit:

	mov		rax, 60														;60 = system exit
	mov		rdi, 0														;0 = return code
	syscall																;Poke the kernel

	
			
				
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
		
	

	
	
				
	
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
