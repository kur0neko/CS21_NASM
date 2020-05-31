;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
 	
 	decString			db 		"###################################################################",0ah,0dh,0h
	welcomePrompt		db		"Welcome to Dynamic Memory File Copy with Encryption program", 00h
	goodbyePrompt		db		"Program ending, have a great day!", 00h


    ;String failure 

    dot 				db 		"||||||||||||||||||",00h
    

    enterKeyPrompt 		db 		"Enter an Encryption key: ",00h
    .len				equ($-enterKeyPrompt)

	errorAllocate 		db      "Error 401: unble to allocated memory",0h
	.len				equ($-errorAllocate)

	errorOpen           db      "Error  402: Unable to open the file!",0h
	.len                equ($-errorOpen)

	errorArgument		db		"Error 	404: number of argument must be two",0ah ,0dh, 0h
	.len 				equ($-errorArgument)

	errorCreate 		db       "Error 405: cannot create the file",0ah,0dh,0h
	.len 				equ($-errorCreate)

	errorRead 			db       "Error 405: cannot read the file",0ah,0dh,0h
	.len 				equ($-errorRead)



	Overwritten 		db 		"Found the same file name on the system, Would you like to overwrite the file?",0h

	strTotalCoppie      db 		"Total bytes copied: ",0h

	;key       			db 		 "3483958938958393",0h

	;count				dq		0


SECTION .bss
	
	inputFileDesc		resq 	1
	
	sourceFile 			resq  	1
	
	OutputFileDesc		resq 	1
	
	destinationFile  	resq 	1

	readBuffer 			resb	255 	
		.len	 		equ($-readBuffer)

	charUserKey 		resq	1
		.len            equ($-charUserKey) 

	oldBottomAddress 	resq 	1
	
	newBottomAddress 	resq 	1

	countReadByte 		resq 	1

	numberOfArgs        resq 	1

	totalBytes			resq	255

	count				resq	1






SECTION     .text
	global  _start
	
     
_start:
		nop

	;Print all welcome string

	push 	decString						 	
	call 	PrintString
	call 	Printendl

	push 	welcomePrompt
	call 	PrintString	
	call 	Printendl
	call 	Printendl

	push 	decString
	call 	PrintString
	call 	Printendl

	;Clear all register before use
	xor 	rax,rax
	xor 	rdi,rdi
	xor 	rcx,rcx

;############################## (Allocate memory)#################################################

	mov 	rax, 0ch 							;sys_brk call
	mov 	rdi, 0h 							;Return into rax the current bottom of the program
	syscall 									;poke the kernel
	mov 	[oldBottomAddress], rax 			;Save the old bottom

	;allocate 0ffff bytes
	mov 	rdi, rax 							;move the bottom address into rdi
	add 	rdi,0ffffh 							;Increase this by 0ffffh bytes
	mov 	rax,0ch								;sys_brk call
	syscall
	cmp 	rax,0 								;check if the re-allocation work?
	jl 		allocationError						;jump to this label if error
	mov 	[newBottomAddress], rax 		    ;Save the rax to new bottom


;#####################################(Get argument from user encryption prompt)##########################################
    ;Promp the user to enter the encryption
	pop 	rax									;get the number of argument  from user
	cmp 	rax, 3 								;if the number of argument is less than 3
	jne 	enterArgumentError  				;if it less than 3 or not equal 3 jump to terminate program

    mov 	[numberOfArgs], rax  			    ;Copied the numbe of argument from RAX and save the variable
    pop 	rax     							;pop the address of 1st argument 

    ;pop the 2nd of argument
    pop 	rax
    mov 	[sourceFile], 	rax 				;Pop the address of 2nd argument 

    pop 	rax									;Pop the addresss of 3th
    mov 	[destinationFile], rax 			




;##########################(GET USER KEY)###############################################################################
	
	;prompt the user input key

	push 	enterKeyPrompt
	push 	enterKeyPrompt.len
	call 	PrintText


	push 	readBuffer							;Get input from user
	push 	readBuffer.len						;lenght of read user input
	call 	ReadText							;

	dec 	rax									;reduce rax to avoid nulll terminate 
	mov 	[charUserKey],rax 					;reset in dex
	mov 	rsi, readBuffer                     ;move the address of readbuffer to RSI
    mov 	rcx, rax


 OpenTheSourceFile:

 	mov 	rax,2							;Open Source file for read
 	mov 	rdi, [sourceFile]				;Set rdi to contain the value of the source file
 	mov 	rsi,442h                          ;File security flag
 	mov 	rdx,2                           ;File access flag read/write
 	syscall                                 ;Poke the kernel

 	cmp 	rax, 0 							;File open correctly? 0 is determined not
 	jl 		failToOpen						;Unable to open jump to this label
 	mov 	[inputFileDesc], rax 			;Copie the file data to the input file destination 

 	;Clear register after user
 	xor rax,rax

 Create_Output_File:

	;create the file
	mov 	rax, 85								;create destinatio  file to write
    mov 	rdi, [destinationFile] 					;address of the file name
    mov 	rsi, 777o							;Octal 777 ;allow everyone access or execute
    mov 	rcx, 0  
    syscall 									;Call the Kernel
												;copy the file descriptor to a temporary variable

	cmp     rax, 0 							; Is it file open? 0 is represent not											
    jl 		failToCreate
    mov [OutputFileDesc],rax 					;Put our file details into eax
    											;file descriptor copy

 OpenDestinationFile1:

 		mov 	rax,2								;Open destination file for read, call value:2
 		mov 	rdi, [destinationFile]				;The name of file .. Pointer to a file name string
 		mov 	rsi, 0442h 							;File security flags
 		mov 	rdx,2 								;File access flags - read

 		;mov 	rcx,0 								
 		syscall
 		cmp 	rax,0h 								;check if fail to open or not
 		jl 		failToOpen							;if if fail to open, jump to external
 		mov 	[OutputFileDesc], rax 				;Copy file descriptor to the Temp variable

 		

repeatReadWrite:
	 
	 ReadTheFile:									;Read from the file

 		mov 	rax,0								
 		mov 	rdi,[inputFileDesc]
 		mov 	rsi,[oldBottomAddress]
 		mov 	rdx,0ffffh
 		syscall
 		inc 	rbx 	
 		;push 	dot
 		;call 	PrintString

		;Rax will contain the number bytes read
		mov 	r8,rax									;copied value in rax to R8
		cmp 	rax,0
		jl      failToRead								;fail to read the file jmp to this label
		mov     [countReadByte],rax
		add     [count],rax
		call 	encryptionFunc                          ;call encrption function to encryp/decryp each time
 		


	CopyingFile:
	
		mov 	rax,1
		mov 	rdi,[OutputFileDesc]					;mov the input file descriptor to the register rdi
		mov 	rsi,[oldBottomAddress]
		mov 	rdx, r8									;copied value to rdx 
		syscall



		TerminateIF:

			cmp r8, 0ffffh								;Check if R8 reach to maximum size that allocated
			;jl 	loopBreak
			jl OpenDestinationFile2

loop repeatReadWrite
	

OpenDestinationFile2:


    mov  rax, 2 								;open function
	mov  rdi, [destinationFile] 						;The name of the file- pointer to a file name string
	mov  rsi, 0
	mov  rdx, 2 								;Read and WriteFile
	mov  rcx, 0
	syscall 									;Poke the kernel

	cmp  rax,0h  								;Is the file open correctly? 0 represent fail
	jl 	 failToOpen								;if it fail jmp to exit
	mov  [OutputFileDesc], rax 					;copy file descriptor to temporary varaiable



												;Call the kernel

deAllocateMemory:

	mov 	rax, 0ch 							;sys_brk call
	mov 	rdi, [oldBottomAddress] 			;Return into rax the current bottom of the program
	syscall 									;poke the kernel
	




CloseFile:

	;Restore the original memory 

	;(Restore the memory tha just allocated)
	;close source file

	;Close input and output File
	mov 	rax,3								;Sys_brk call
	mov 	rdi, sourceFile 					;Source file have the old bottom memory
	syscall 									;poke the kernel
												;close Source file
	mov 	rax, 3
	mov     rdi, destinationFile
	syscall 									;close the destination file

	push 	strTotalCoppie
	call 	PrintString
	

	push qword[count]								;Print the total of copie file size
	call Print64bitNumDecimal
	

	nop


	
;#############################################################################################################################

;
;Setup the registers for exit and poke the kernel

Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel


;##############################################################################################################################
;jmp to this label if the allocation failed
allocationError:
	push 	errorAllocate
	call 	PrintString
	jmp 	CloseFile


;##############################################################################################################################
;jmp to this label if read file failed
failToRead:
	push 	errorRead
	call 	PrintString
	jmp 	CloseFile

;jump to this label when fail to open the file

failToCreate:
	push 	errorCreate
	call 	PrintString
	jmp 	CloseFile

;jump to this label when fail to open the file
failToOpen:
	push	errorOpen
	call 	PrintString
	jmp 	CloseFile
;##############################################################################################################################

;jump the this label if user input argument is invalid
enterArgumentError:
	push 	errorArgument
	call 	PrintString
	jmp 	CloseFile

;#############################################################################################################################
encryptionFunc:
	
	;Clear all the register before use
	xor rax, rax
	xor rbx,rbx
	xor rcx,rcx
 	xor rsi, rsi
	xor rdi, rdi


 	mov rsi,	readBuffer										;read from the key buffer
 	mov al, BYTE [charUserKey]									;Total character input
	mov rdi,	[oldBottomAddress]								;put addresss of old buttom to check the memory that just allocated
 	mov rcx,	[countReadByte]									;Set counter of the read encryp each time


 	loopEncrypt:
 		cmp rax, [charUserKey]									;compare user input each byte with the value in rax
 		jl   continue											
 		xor  rax,rax											;Clear rax each time
 		mov  rsi, readBuffer

 		continue:												;continue looping and xor the key 
 			mov  bl,[rdi]
 			xor  bl,[rsi]
 			mov  [rdi],bl

 			inc rsi												;increament the loop index
 			inc rax
 			inc rdi
 	loop 	loopEncrypt

 	ret 

 ;##########################################################################################################################






