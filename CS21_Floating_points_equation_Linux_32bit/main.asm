;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 
SECTION .data
	   openPrompt	    db	"Welcome to my Program", 0dh, 0ah, 0h	                            ;Prompt String
		.size	        equ	$-openPrompt							                            ;Length of Prompt String
        promptA         db  "Please enter the first floating point: ",0h                        ;Prompt variable A
        .len            equ ($-promptA)
        promptB         db  "Please enter the second floating point: ",0h                       ;Prompt variable B
        .len            equ ($-promptB)
        promptC         db  "Please enter the integer input: ",0h                               ;Prompt variable C
        .len            equ ($-promptC)
        promptResult    db "Here is the result: ",0h                                            ;Prompt variable D or result
        .len            equ ($-promptResult)

     promptInvalidfnumb db "Invalid input, please input floating number!.",0h,0ah,0h            ;prompt validation floting number
 
     promptInvalidInteger db "Invalud input, please input valid integer!.",0h,0ah,0h            ;prompt validation integer number
       
 
SECTION .bss

		varA      resq    1                 ;reserve for variable A                                           

        varB      resq    1                 ;reserve for variable B

        varC      resq    1                 ;reserve for variable C 

        varD      resd    1                 ;reserve for variable D

 
SECTION     .text

	global      _start
     

_start:
	;
	;Display Program Header
    push	openPrompt			;The prompt address - argument #1
    push    openPrompt.size    
    call    PrintText           ;Print the prompt
    call    Printendl


loopPromptA: 
    xor      eax,eax             ;clear value inside eax
    push    promptA              ;Push Prompt user input to put variable A 
    push    promptA.len          ;Push the size of the string prompt to the stack
    call    PrintText            ;Print the prompt
    call    InputFloat           ;Call inputFlaot to take user input as floating number
    jnc     ValidFloatNumb       ;input validation if it floating number or not
    push    promptInvalidfnumb   ;push msg invalid input if the user didn't input a number
    call    PrintString          ;print the prompt above
    call    Printendl            ;Print new line
loop loopPromptA                 ;loop if the number is not floating

   ValidFloatNumb:               
    fstp  qword[varA]            ;store floating number in varA
   
   
loopPromptB:

   xor      eax,eax             ;clear value inside eax again before use
   push    promptB              ;Push prompt for user input for variable B
   push    promptB.len          ;Push the size of the string to the stack
   call    PrintText            ;Print the string
   call    InputFloat           ;Take the user input as floting point number
   jnc     ValidFloatNumb2      ;input validation if it floating number or not
   push    promptInvalidfnumb   ;push msg invalid input if the user didn't input a number
   call    PrintString          ;print the prompt above
   call    Printendl            ;Print new line
loop loopPromptB                ;loop if the number is not floating

   ValidFloatNumb2:
   fstp  qword [varB]           ;store floating number  in varB

loopPromptC:                    

   xor      eax,eax             ;clear value inside eax before use to get int value from user input
   push     promptC             ;Push prompt for user input for variable C
   push     promptC.len         ;Push the prompt size to the stack
   call     PrintText           ;Print prompt above
   call     InputUInt           ;call InputUInt <<<< this function will take unsigned number
   jnc      ValidInt            ;check if the input is unsigned or not
   push     promptInvalidInteger ;otherwise, print invalid input
   call     PrintString         ;Print it
   call     Printendl           ;Print new line
loop loopPromptC                ;loop if it not unsinged number

   ValidInt:
   ; mov [varC], eax

   ; fld      qword[varA]         ;load varA to stack
   ; fld      qword[varB]         ;load varA to stack 
   ; fadd                         ;(A+B) ;now it will ST0 + ST1 store in ST1
   
   ; fld      qword[varB]         ;load float varB to stack
   ; fild     qword[varC]         ;load int  varC to stack
   ; fwait                        ;wait for cpu
   ; fdiv                         ;Devide B/C
   ; fmul                         ;Multiply result from     (result A+B) *  (result B/C)
   ; fld       ST0
   ; fmul                         ;Multilpy itself for square

   ; fstp     dword[varD] 
   ;         ;pop and store in variable 

   ;A^2
   fld 		qword[varA]
   fld 		qword[varA]
   fmul

   fld 		qword[varB]
   fld 		qword[varB]
   fmul

   fadd

   fsqrt


   push     promptResult        ;Push the Stringprompt on the stack
   push     promptResult.len    ;Push the size as well
   call     PrintText           ;Print text

   push     dword[varD]         ;Push the value of D into the stack
   push      3                  ;3 floating point decimal
   call      PrintDWFloat       ;PrintDWFloat  << print the floating number
   call      Printendl          ;Prit new line



;Setup the registers for exit and poke the kernel
Exit: 
	mov		eax,sys_exit				;What are we going to do? Exit!
	mov		ebx,0						;Return code
	int		80h							;Poke the kernel
