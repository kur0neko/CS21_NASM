;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data

Programname 	dd "This program will calulate and print the Variance of an Array of numbers",0h
endingProgram	dd "Have a nice day!, Program is ending....",0h

ValueOfArray 	dd "Here are the values in the Array",0h

varianceMsg 	dd "The Variance is:",0h

endingMsg 		dd "Program ending, have a nice day!",0h

;SampleArray		dq 	-999,878,776,-580,768,654

;SampleArray		dq 	-512,-3,245,800,-88
				
;SampleArray		dq	-365,-722,567,-876,-222
				
;SampleArray		dq	999,-878,-776,580,-768
					
;SampleArray		dq	-999,878,776,-580,768,10
					
;SampleArray		dq 	-999,878,776,-580
	
SampleArray		dq  878,-999



.len			equ ($-SampleArray)/8

 
SECTION .bss


arrayMean		resq 	SampleArray.len									;Reserve for the mean
								
meanDiff		resq 	SampleArray.len									;Reserve for the mean Different
	
	.len		equ 	($-meanDiff)/8									;Size of mean different arrray

SquaredArr		resq 	SampleArray.len									;This array will store the mean different array square by each index
	
	.len 		equ 	($-SquaredArr)/8								;Size of Square array

varianceValue	resq 	SquaredArr.len									;Total variable to hold to varian number


														
SECTION     .text
	global  _start														
	global 	DisplayArray												;Function print array
	global 	getMean														;Funtion find mean
	global 	getVariance													;Function calculate variance


     
_start:

push 		Programname													;Prompt program											
call 		PrintString													;Print prompt
call 		Printendl
call 		Printendl

call 		DisplayArray												;Print the array
call 		Printendl
call 		Printendl
call 		Printendl

call 		getMean														;Call function to calculate mean of the array will store in varianceValue variable
call 		Printendl
call 		findVariance

push 		QWORD[varianceValue]										;push value of variance that return and store in variance variable
call 		Print64bitNumDecimal										;Print it
call 		Printendl


;Setup the registers for exit and poke the kernel

exit:

	mov		rax, 60														;60 = system exit
	mov		rdi, 0														;0 = return code
	syscall																;Poke the kernel

;############################################################################################################

DisplayArray:															;Function print Array

	xor 	rdi,rdi														;Clear RDI
	xor 	rcx,rcx														;Clear RDI
	xor 	rax,rax														;Clear RDI

	push 	ValueOfArray												;Print string prompt "Here are the values in the Array
	call 	PrintString													;Print prompt 
	call 	Printendl


	mov 	rdi,SampleArray												;Move address or array to RDI
	mov 	rcx,SampleArray.len											;Set counter to size of Simple array 

	loopPrintContentArr:												;Loop through array and print out the index

	mov 	rax, QWORD[rdi]												;Move Simple array in ride to store in rax
	add 	rax, 0														;Add zero to rax to seperate the signed and unsinged number
	push 	rax	
	js 	 	numSigned													;Jump signed to print signed number if the find signed flag tiggered 

	call 	Print64bitNumDecimal										;Otherwise, print unsigned
	call 	PrintComma
	jmp  	continueTheLoop												;And continue the loop inc index
	
	numSigned:
	call 	Print64bitSNumDecimal										;Label signed number Print signed number
	call 	PrintComma													;Print comma

	continueTheLoop:
	add 	rdi,8														;Increment the index
	
		
loop loopPrintContentArr												;End of the displayArray function


ret

;############################################################################################################

getMean:																;Function finding mean by add all up and devide by array size
	
	xor 	rsi,rsi														;Clear RSI
	xor 	rcx,rcx														;Clear RCX
	xor 	rax,rax														;Clear RAX

	mov 	rsi, SampleArray											;Put address of Sample Array in RSI
	mov 	rcx, SampleArray.len										;Mov the size of Sample Array in RCX (Counter Regrister)
	xor 	rax,rax														;Clear RAX						

	l1Addition:															;Add loop,  adding all indexes inside array
	add 	rax, QWORD[rsi]												;use RSI as index
	add 	rsi, 8														;Increment index by 8 (QWORD)
	
	loop l1Addition	;end of loop					

	mov 	rbx, SampleArray.len										;Set RBX to the lenght of Sample Array for devide 
	add 	rbx, 0														;to seperate signed and unsigned  ; Turnoff overflow flags

	js divisionSignedNumb												;If it negative number go to label divisionSignedNumb
	div 	rbx
	jmp 	continue													;else jump to contunue label
	
	divisionSignedNumb:													;use signed division idiv command to division negative number
	cqo 																;Extend the size of regirster 
	idiv rbx

	continue:															;Store back to Array named arrayMean

	mov  [arrayMean],rax												;Store in array Mean

ret

;##############################################################################################################

findVariance:															;This function will calculate to find variance

	xor 	rax,rax														;Clear RAX
	xor 	rdi,rdi														;Clear RDI
	xor 	rdx,rdx														;Clear RDX
	xor 	rcx,rcx														;Clear RCX
	xor 	rsi,rsi														;Clear RSI
	xor 	rbx,rbx														;Clear RBX


	push 	varianceMsg													;Prompt the message "The Variance is:"
	call 	PrintString													;Print it!

	mov 	rdi, SampleArray											;counter index
	mov 	rsi, meanDiff
	mov 	rcx, SampleArray.len										;Set size of samplearray as a counter of loop
	mov 	rbx, [arrayMean]											;Mean of Array

findDiffMean:															;Loop the find the variance

	mov 	rax, QWORD[rdi]												;move simmple array [Index]
	sub 	rax, rbx													;subtrack Sample array [index] with mean
	mov 	QWORD[rsi],rax												;store inside the meanDiff array
	add 	rdi,8														;Increment index Sample Array[index]
	add 	rsi,8														;Increment index meanDiff Array[index]

loop 	findDiffMean ;end of loop

	xor 	rax,rax														;Clear RAX
	xor 	rdi,rdi														;Clear RDI
	xor 	rdx,rdx														;Clear RDX
	xor 	rcx,rcx														;Clear RCX
	xor 	rsi,rsi														;Clear RSI
	xor 	rbx,rbx														;Clear RBX
	;push 	rbx

	mov 	rdi, SquaredArr												;Put address of SquaredArray to store  value after multiply by 2 
	mov 	rsi, meanDiff												;Put address of meanDifferent array to store value of simple array about subtract by mean
	mov 	rcx, meanDiff.len											;Set counter loop as size of meanDifferent array


loopsquaredIt:

	mov  	rax, QWORD[rsi]												;Move each index of meanDifferent array to RAX
	add 	rax, 0														;Add value zero to rax to be able to trigger the signed flag

	js 		mulSignedNumb												;just to multiply signed number if the value in index is negative
	mul 	rax															;otherwise, just mutiply if it positive
	jmp 	continueLoop												;jump to the end of the loop to increment the index
	
	mulSignedNumb:														;lable multiply signed number
	cqo 																;convert word to dword , extended the regrister to store all value as possible
	imul 	rax															;multiply signed number
	jmp 	continueLoop												;jump to continue the loop after multiply

	continueLoop:	
	mov 	QWORD[rdi],rax								 				;continue from above which move the value from rax store to SquareArray			
	add 	rsi,8														;increment to next index (meanDiff array)
	add 	rdi,8														;increment to next index (SquareArr array)

 loop 	loopsquaredIt ;end of loop

 	xor 	rax,rax														;Clear RAX
	xor 	rdi,rdi														;Clear RDI
	xor 	rdx,rdx														;Clear RDX
	xor 	rcx,rcx														;Clear RCX
	xor 	rsi,rsi														;Clear RSI
	xor 	rbx,rbx			
	
	mov 	rdi,SquaredArr												;put address of SqaureArr (meanDiff array that square )										
	mov 	rcx,SquaredArr.len											;set rcx as lenght of SquareArr

	getVarianceLoop:

	add rbx,[rdi]													 	;Add up every index and store the total inside rbx
	add rdi,8															;increment the index of array

	loop getVarianceLoop

	mov rax,rbx															;Transfer total value from rbx to rax
	mov rbx, SquaredArr.len												;set rbx to the size of array
	div rbx																;now devide rbx to rax

	mov [varianceValue], rax											;Store variance value in varianceValue variable

	

ret

;##############################################################################################################
	
	
