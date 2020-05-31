;
;Example program to execute 64-bit functions in Linux
;
;Include our external functions library functions
%include "./functions64.inc"
%include "./stats.inc"


 
SECTION .data
 
welcomePrompt 	dd "This program will calulate and print the Variance of an Array of numbers",0h

varianceMsg 	dd "The Variance is:",0h
	.len 		equ ($-varianceMsg)

endingMsg 		dd "Program ending, have a nice day!",00h

;SampleArray		dq 	-999,878,776,-580,768,654

;SampleArray	dq 	-512,-3,245,800,-88
				
;SampleArray	dq	-365,-722,567,-876,-222
				
;SampleArray	dq	999,-878,-776,580,-768
					
;SampleArray	dq	-999,878,776,-580,768,10
					
;SampleArray	dq 	-999,878,776,-580
	
SampleArray	dq  878,-999
	
	.len			equ ($-SampleArray)/8

 
SECTION .bss

SECTION     .text
	global  _start



_start:

	push 	welcomePrompt
	call 	PrintString
	call 	Printendl

	push 	varianceMsg
	push 	varianceMsg.len
	call 	PrintText


	push 	SampleArray				;Put the address of our array onto the stack 16
	push 	SampleArray.len 		;Put the number of array item onto the stack 24
	call 	calcvariance

	push 	rax
	call    Print64bitNumDecimal
	call 	Printendl

	push  	endingMsg
	call 	PrintString
	call 	Printendl


;-------------------------------------------------------------------------------------------------


Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel







