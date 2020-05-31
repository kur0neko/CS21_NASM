;
;This program will test out the functions library
;
;
;Include our external functions library functions
%include "./functions.inc"
 


SECTION .data

	openPrompt			db	"Welcome to my Program", 0dh, 0ah, 0h	;Prompt String
		.size			equ	($-openPrompt)
	
		newLine			db	0dh, 0ah, 0h
		

	programMsg 			db	"Encryption/Decryption Program",0ah,0dh,0h
 
 	process_Msg			db	"1) Enter a String", 0dh,0ah                	;choice for userinput
						db	"2) Enter an Encryption Key", 0dh,0ah
						db	"3) Print the input String", 0dh,0ah
						db	"4) Print the input Key", 0dh,0ah
		 				db  "5) Encryption/Display the String",0dh,0ah
						db  "6) Decrypt/Display the String",0dh,0ah
						db	"x) Exit the program", 0dh,0ah
						db	"Please Enter one:",0ah,0dh,0h



	userMsg_1		db	"Please Enter a string: ",0h
	userMsg_2		db	"Please enter an Encryption key:",0h
	userMsg_3		db	"Here is the input String: ",0h
	userMsg_4		db	"Here is the input Key:",0h

	
	userMsg_5		db	"Here is your encrypted data: " ,0h
		.len		equ	($-userMsg_5)




	userMsg_6		db	"Here is your decrypted data:" ,0h
		.len		equ	($-userMsg_6)
	

	user_Msg_7		db	"Thank you and have a nice day!,program is ending..., ",0ah,0dh,0h

	default_ErorMsg db 	"Invalid input please try again!",0ah,0dh,0h

	CaseTable		db	'1'											;create Casetable
					dd  Case_A			
	.entrySize		equ	($-CaseTable)								;size of the case
					db	'2'
					dd	Case_B
					db	'3'
					dd	Case_C
					db	'4'
					dd 	Case_D
					db 	'5'
					dd 	Case_E
					db 	'6'
					dd 	Case_F
					db	'x'
					dd	Case_x

.numberOfEntries	equ ($-CaseTable)/CaseTable.entrySize



SECTION .bss

menuBuffer			resb	1										;reserve for menu userinput
	.len			equ($-menuBuffer)

readBuffer			resb 	0FFh									;read buffer from userinput
	.len			equ($-readBuffer)

stringBuffer		resb 	255										;reserve for string buffer
	.len			equ($-stringBuffer)

Key					resb	255										;reserve for key to decryption
	.len			equ($-Key)

enryptionArray		resb	255										;reserve for decryption 
	.len			equ($-enryptionArray)

decryptionArray		resb	255										;reserve for encryption
 	.len			equ($-decryptionArray)

	


SECTION  .text

	global      _start

     
_start:
	;
	;Display Program Header
    push	openPrompt												;The prompt address - argument #1
    push	openPrompt.size											;The size of the prompt string - argument #2
    call    PrintText			


  LoopMenu:

  																	;clear reset buffer

  	mov 	esi, 	CaseTable										;put address of the esi
  	mov 	ecx,	CaseTable.numberOfEntries						;put entry size of case table 

  	push 	newLine													;print new line for nicer format
    call 	PrintString												
  	push 	programMsg												;print message program name
  	call 	PrintString												
   	push 	newLine
    call 	PrintString

  	push 	process_Msg												;Print menu choice
  	call 	PrintString
  	push 	newLine
    call 	PrintString

  	push 	menuBuffer												;to use readText is required
  	push 	menuBuffer.len											;size of userInput
  	call 	ReadText
  	call 	ClearKBuffer											;Clear cin buffer


  	mov  eax, [menuBuffer]											;copy user input to eax

  	Switch1:
  	
  	cmp  al, 	[esi] 												;compare it to choice in case table
  	jne 	Switch1_GoAgain											;if not equal in the case loop again
  	call 	Near[esi+1]												;call near location of case in esi
  	jmp 	LoopMenu 												;re-loop menu


  	Switch1_GoAgain:												;to loop again

  		add esi, CaseTable.entrySize								;Needed to add esi with total entrysize

  	loop Switch1

  	Switch1_default:

  		call 	Case_default 										;invalid input will set to the default message 

  		jmp 	LoopMenu											;loop again


;
;Setup the registers for exit and poke the kernel
Exit: 
	mov		eax,sys_exit											;What are we going to do? Exit!
	mov		ebx,0													;Return code
	int		80h														;Poke the kernel

;###################################################################################################################
;Function clear buffer string
clearStringBuffer:													;Function reset and initalized String buffer
	mov 	ecx,0
	mov 	ecx, stringBuffer.len-1									;set couter to string buffer size
	mov 	esi,	0												;set index start from 0

	clearStrBuffer:													;loop clear buffer

		mov 	BYTE [stringBuffer+esi],0							;reset every byte in string
		inc 	esi

		loop clearStrBuffer                                       

		ret
;###################################################################################################################
;clear Key buffer
clearKeyBuffer:														;Function reset and initalized key buffer
	mov ecx,0
	mov ecx, Key.len-1												;set counter to size of key
	mov esi,	0													;set index = 0

	clearKey:														;loop key

		mov 	BYTE [Key+esi],0									;reset every byte inside the key one by one
		inc 	esi

		loop clearKey

		ret

;###################################################################################################################

;Function clear buffer Encryption
clearEncryptionArr:													;clear and initalized array Encryption
	mov 	ecx,0
	mov 	ecx, enryptionArray.len-1								;set couter to string buffer size without 'null'
	mov 	esi,	0												;set index start from 0

	clearEncrptArrBuffer:											;loop clear buffer

		mov 	BYTE [enryptionArray+esi],0							;reset every byte in string
		inc 	esi

		loop clearEncrptArrBuffer                                       

		ret
;###################################################################################################################

;Function clear buffer Decryption
clearDecryptionArr:													;clear and initalized array Decryption
	mov 	ecx,0
	mov 	ecx, decryptionArray.len-1								;set couter to string buffer size without 'null'
	mov 	esi,	0												;set index start from 0

	clearDecrptArrBuffer:											;loop clear buffer

		mov 	BYTE [decryptionArray+esi],0						;reset every byte in string
		inc 	esi

		loop clearDecrptArrBuffer                                       

		ret
;###################################################################################################################

;#1
Case_A:
	

	call clearStringBuffer											;clear string butter to prevent left over data
	push newLine
	call PrintString
	push userMsg_1 													;asking user to input a string
	call PrintString												;print string
	
	mov 	ecx,	0												;clear counter
	mov 	eax,	0												;clear buffer

	push 	stringBuffer					
	push 	stringBuffer.len
	call 	ReadText												;now the input store in eax
	call 	ClearKBuffer											;clear input buffer
	push 	newLine
	call 	PrintString


ret

;###################################################################################################################
;#2
Case_B:

	call 	clearKeyBuffer											;clear Key butter to prevent left over data
	push 	newLine
	call 	PrintString

	push 	userMsg_2
	call 	PrintString
	push 	Key														;push key (required for readtext)
	push 	Key.len													;size of ket
	call 	ReadText												
	call 	ClearKBuffer											;clear cin buffer
	push 	newLine
	call 	PrintString

ret

;###################################################################################################################
;#3

Case_C:


push 	userMsg_3													;Print msg display what to pribt
call 	PrintString													;Print it
push 	stringBuffer												;Print the string user input
call 	PrintString													
push 	newLine
call 	PrintString




ret

;###################################################################################################################
;#4
Case_D:

push 	userMsg_4													;Print display about case 4
call 	PrintString													;Print it														
push 	Key															;Display key value
call 	PrintString
push 	newLine
call 	PrintString




ret

Case_E:
;####################################################################################################
;#5

call 	clearEncryptionArr											;Make sure to clear Encryption array (ensure it empty)


push 	userMsg_5
call 	PrintString
;startEncryption

mov 	ecx,	0													;clear the counter
mov 	eax, 	0	
mov		edx,	0
																	;clear the buffer
mov 	ecx, stringBuffer.len-1
mov 	edx, stringBuffer.len-1										;put string buffer size without null to edx and couter ecx						
mov 	esi,	0
mov 	edi, 	0


loopEncryp:
	
	cmp edi, edx													;compare counter = 0 to value of key
	je	reset														; if = jump to reset index of edui
	jne continue													; if!= continue loop

	reset:
	mov edi, 0														;reset index
	
	continue:

	mov al, [stringBuffer+esi]										;copy char in buffer to al
	mov dl, BYTE [Key+edi]											;copy the key value
	xor  al, dl														;Decryption
	mov [enryptionArray+esi],al										;move value after decryp to encryption array
	inc esi															;increment the index of Userstring 
	inc edi 														;increment index of key
	

LOOP loopEncryp

push 	enryptionArray
call 	PrintString
call 	Printendl
call 	Printendl



ret

;end case

Case_F:

;####################################################################################################
;#6
call 	clearDecryptionArr											;Make sure to clear Decryption array (ensure it empty)

push 	userMsg_6

call 	PrintString


mov 	ecx,	0													;clear the counter
mov 	eax, 	0	
mov 	edx,	0													;clear the buffer
mov 	ecx, Key.len-1	
mov 	edx, Key.len-1												;put string keyBuffer size without null to edx and couter ecx							
mov 	esi,	0													;reset index
mov 	edi, 	0


loopDecryp:
	
	cmp edi, edx													;compare counter = 0 to value of key
	je	resetToZero													; if = jump to reset index of edi
	jne continueToLoop												; if!= continue loop

	resetToZero:
	mov edi, 0														;reset index
	
	continueToLoop:

	mov al, [enryptionArray+esi]									;copy char in buffer to al
	mov dl, BYTE [Key+edi]											;copy the key value
	xor  al, dl														;Decryption
	mov [decryptionArray+esi],al									;move value after decryp to encryption array
	inc esi															;increment the index of Userstring 
	inc edi 														;increment index of key
	

LOOP loopDecryp

push 	decryptionArray

call 	PrintString

;print new line

call 	Printendl
call 	Printendl

ret

;end case

Case_x:																;Case_X exit from Program

push 	user_Msg_7
call 	PrintString
push 	newLine
call 	PrintString

jmp 	Exit														;After print good byte  message jump to terminate

ret

Case_default:														;Case Defualt socrery

push 	default_ErorMsg 											;print defaut  msg error from input 
call 	PrintString
push 	newLine
call 	PrintString

ret