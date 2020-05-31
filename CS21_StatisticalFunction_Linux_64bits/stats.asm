
;Create a function called calcvariance. The function will take two arguments
;1. The address of the sample array (an array of quad words)
;2. The number of items in the array



 
SECTION     .text

	global calcvariance 
		

calcvariance:

;----------------------------------------------------------------------------------------------------	
	push	rbp									;Save the current rbp
	mov		rbp,rsp								;Set rbp address to be the same as rsp in the stack
	sub		rsp,24								;allocating space for local Variables
;------------------------------------------------------------------------------------------------------ 

	xor 	rdi,	rdi							;Clear rdi
	xor 	rsi,	rsi							;Clear rsi
	xor		rax,	rax							;clear acclumulator before use	
	xor 	r8,		r8							;clear r8

;NOTE Stack plate: 									
				;(rbp-24) AvgArray
				;(rbp-16) Sqaure-array
				;(rbp-8) for allocate array									
;------------------------------------------------------------------------------------------------------
				
	mov		rax,	QWORD[rbp + 16]				;SampleArray.len
	mov		rbx,	8							;To dynamic allocate size of array (8 bytes * size of array) 
	mul		rbx									;(8*size of array)

;Reserve memory
;--------------------------------------------------------------------------------------------------------	
	sub		rsp,		rax 					;Subtract with address that pointed by rsp PTR to allocate memory for array

	mov		QWORD	[rbp - 24], 0				;Clear the  AvgArray

;Important										;Save the location that allocate array
;--------------------------------------------------------------------------------------------------------
	mov 	QWORD[rbp - 8],	r8
	xor	    rax,rax								;Clear rax before use
	xor		rcx, rcx							;Clear rcx	

; 2 arguments passing
;-------------------------------------------------------------------------------------------------------- 		 
	mov		rdi,	QWORD	[rbp + 24]			;SampleArray address
	mov		rcx,	QWORD	[rbp + 16] 			;SampleArray Size
	
getMean:
		
		add		rax,	[rdi]					;array element
		add		rdi,	8 						;increment array index 

loop getMean

;---------------------------------------------------------------------------------------------------------							

	xor 	rdx,rdx								;Clear out RDX because there is left over of remainders
	mov		rbx,QWORD[rbp + 16]					;size of array for dividing 
	cqo											;Sign extends 
	idiv	rbx									
	jmp 	continue

continue:
	
	mov		QWORD[rbp - 24],rax					;Store the result from rax (MEAN) from to StackFrame
											
	mov		QWORD[rbp - 16],0					;Clear out the allocate memory that gonna use for square

	xor		rax,rax								;clear Accumulator

	xor		rcx,rcx								;clear the loop counter

	xor		rsi,rsi								;Clear rsi

	mov		rcx, QWORD[rbp + 16]				;Set the loop counter
	mov		rdi,[rbp - 24]						;Set Rdi to contain AvgArray 
	
	mov		rsi,QWORD	[rbp + 24]				;Array Addreess

	mov		r9,32 								;position where the rbp start from
	

subtractbyMean:
		mov		rbx,	[rsi]					;Move array index to rbx
		sub		rbx,	rdi						;Subtact caculate from the array element 	
		mov		rax,	rbx						
		imul	rbx								;multiply itself
		mov		QWORD	[rbp + r9],rax			;move Square sum to new array 
		add		QWORD	[rbp - 16],	rax			;Add together of square number in array indexs 
		add		rsi,	8						;increment index
		add		r9,		8 						;inrement stack position
loop subtractbyMean								
		
		
	mov		rax,	QWORD	[rbp - 16]			;Store the result to rax
	xor		rdx,	rdx							 
	mov		rbx,	rbx 							
	cqo											;sign extends 64 to 128
	mov		rbx,	QWORD	[rbp + 16]			;size of array 
	idiv	rbx									;Devide by # of total element
										

	mov		rsp,	rbp
	pop		rbp 

	ret 16 										;Pop out two argument 8 bits each

;------------------------------------------------------------------------------------------------------------------------------

;RAX contain variance
	
