;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 
SECTION .data
	openPrompt		db	"Welcome to my Program", 0dh, 0ah, 0h	;Prompt String
		.size		equ	$-openPrompt			;Length of Prompt String

		fileName 	db "file1.txt",0h

		fileText	db "He he write first line",0h
			.len   equ($-fileText)


		fileText2	db "Hello Wassup DUDE",0h
			.len 	equ($-fileText2)

		endl 		db 0dh,0ah
		 .len 		equ ($-endl)

		 errorMsg 	dd "Eror 404, file cannot be open!",0dh,0ah,0h
		 .len 		equ $-errorMsg



 
SECTION .bss
	
	;reserved memory goes here

	outputFileD		resb	1
	intputFileD	 	resb 	1
	inputBuffer 	resb  	255
		.len	 	equ $-inputBuffer
 
SECTION     .text
	global      _start
     
_start:
	;
	;Display Program Header
    push	openPrompt			;The prompt address - argument #1
    push	openPrompt.size		;The size of the prompt string - argument #2\
    call    PrintText



    ;your program should go here 

    mov 	eax, 8h 			;open for write
    mov 	ebx, fileName 		;address of the file name
    mov 	ecx,01ffh 			;Octal 777 ;allow everyone access or execute
    int 	80h 				;Poke the kernel
    mov 	[outputFileD],eax 	;Put our file details into eax

    ;Process file here
    mov 	eax,4h				;write to the file
    mov 	ebx,[outputFileD]	;file anchor
    mov 	ecx,fileText		;the address of the data we want to write
    mov 	edx,fileText.len 	;The lenght of that data
    int 	80h 				;Poke the kernel

     ;Process file here
    mov 	eax,4h				;write to the file
    mov 	ebx,[outputFileD]	;file anchor
    mov 	ecx,endl		;the address of the data we want to write
    mov 	edx,endl.len 	;The lenght of that data
    int 	80h 				;Poke the kernel



    ;now close file
    mov 	eax,6h 				;close the file	
    mov 	ebx, [outputFileD]  ;File descriptor
    int 	80h 				;poke the kernel



    ;open the file for read
    mov 	eax,5h 				;OPen for read
    mov 	ebx,fileName		;The name of the file
    mov 	ecx,0h 				;Read Only
    int 	80h					;Poke the kernel
    cmp 	eax,0h 				;Did the file open, 9 mean it's NOT
    jl 		endit				;Itdidn't open. so end the program
    mov 	[intputFileD],eax 	;the file data

    ;Process read the file

    mov 	eax,3h 				;readFrom this file
    mov 	ebx,[intputFileD]	;the input file info
    mov 	ecx, inputBuffer			;where the data read goes
    mov 	edx, inputBuffer.len 		;the size of our input inputBuffer
    int 	80h 						;poke the kernel




       ;now close file
    mov 	eax,6h 				;close the file	
    mov 	ebx, [outputFileD]  ;File descriptor
    int 	80h 				;poke the kernel


    ;open file from what we just learn
    mov 	eax,5h				;open the file
    mov 	ebx,fileName 		;Our file name
    mov 	ecx,2h 				;OPen for read AND write
    int 	80h 				;Poke the kernel
    mov 	[outputFileD],eax 	;Save our file descriptor


   ;position the file pointer to the end

   mov 		eax, 13h 			;set position of file pointer
   mov 		ebx, [outputFileD]  ;our file descriptor
   mov 		edx, 2h 			;Starting at the end of file
   mov 		ecx, 0h 			;Move zero bytes
   int 		80h 				;poke the kernel


   ;append new data to the file

    mov 	eax,4h				;write to the file
    mov 	ebx,[outputFileD]	;file anchor
    mov 	ecx,fileText2		;the address of the data we want to write
    mov 	edx,fileText2.len 	;The lenght of that data
    int 	80h 				;Poke the kernel

     ;write a carriage return and line feed

    mov 	eax,4h				;write to the file
    mov 	ebx,[outputFileD]	;file anchor
    mov 	ecx,endl		;the address of the data we want to write
    mov 	edx,endl.len 	;The lenght of that data
    int 	80h 				;Poke the kernel


    ;now close file
    mov 	eax,6h 				;close the file	
    mov 	ebx, [outputFileD]  ;File descriptor
    int 	80h 				;poke the kernel





endit:
	push 	errorMsg
	push 	errorMsg.len
	call 	PrintText

;
;Setup the registers for exit and poke the kernel
Exit: 
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
