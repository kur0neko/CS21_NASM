;
;Example program to execute 64-bit functions in Linux
;

;
;Include our external functions library functions
%include "./functions64.inc"
 
SECTION .data
 
	welcomePrompt		db		"This Program will sum two arrays and then display thier contents", 00h
	goodbyePrompt		db		"Program ending, have a great day!", 00h
	promptSumArray3		db		"Contents of Array3 is: ",00h
	promptSumDandQword	db		"Contents of Array6 is: ",00h

	Array1			db		10h, 30h, 0F0h, 20h, 50h, 12h,              	 	;unsigned byte Array
	.len			equ 	($-Array1)                             				;Array1 lenghth
	
	Array2			db		0E0h, 40h, 22h,0E5h, 40h, 55h,          			;unsigned byte Array
	.len			equ 	($-Array2)
		
	Array4			dd	 	11BDh, 3453h, 2FF0h, 6370h, 3350h, 1025h	    	;unsigned double bytes Array
	.len			equ 	($-Array4)/4                           				;Array4 length
	
	Array5			dq		0FFFh, 0C3Fh, 22FFh, 0EF53h, 400h, 5555h			;unsigned quadwords Array
	.len			equ 	($-Array5)/8										;Array5 length
 
SECTION .bss

	Array3			resb 	Array1.len											;Reserve byte space depend on array1 beacuase if arrayone is greater than 6
	 .len			equ 	($-Array3)   										;Array3 length
	                          
	Array6			resq	Array5.len											;Reserve space   for Arrray6 6 indexs
	.len			equ 	($-Array6)/8
	

 
SECTION     .text
	global  _start
     
_start:
		nop

	push	welcomePrompt					;Move welcome prompt
	call	PrintString
	call	Printendl
	call	Printendl
	
	
	mov		rax,	0						;clear register RAX
	mov		rbx,	0						;clear register	RBX
	mov		rsi,	0						;clear register	RSI
	mov		rdx,	0                   	;clear register	RDX
	mov		rdi,	0                   	;clear register	RDI
	
	mov 	rsi,	Array1					;Array1 adrress copie to RSI 
	mov		rdx,	Array2					;Array2 adrress copie to RDX
	mov		rdi, 	Array3+Array3.len-1		;Array3+array3[lastindex]		
	mov		rcx, 	Array1.len				;Because they share the same lenght so, use Array1 lenght
	
	;########################################################################################
	
	;Array1[0]+Array2[0]-> sum move to Array3[5]
	
	AdditionLoop:
		mov		al,	BYTE	[rsi]			;copie Array1 	first index value in AL because it BYTE 
		mov		bl,	BYTE	[rdx]			;copie Array2	first index	value in BL becuase it BYTE
		add		eax,ebx						;Add both regrister together ( will store inside eax)
		mov		[rdi],al					;copie value from AL put in the last index of RDI which has address of Array3
		inc		rsi                         ;increment the position of the RSI register
		inc		rdx							;increment the position of the RDX register
		dec		rdi							;decrement the postion of the RDI (array3) 
	loop AdditionLoop 						;Addtion loop
	
	;########################################################################################
	
	push	promptSumArray3					;Print statement of array3 "Contents of Array3 is: "
	call	PrintString					    ;Print String
	
	mov		rax,	0						;Clear register RAX	
	inc		rdi								;Because current RDI is off position by -1, if I did not increment RDI by 
											;it will print : 0h,67,90h,5h,12h,70h,
											;to move up one position I need to increment RDI by 1.. 
											;So RDI now = Array3 [0]
											
	mov		rcx, 	Array3.len				;Array3 length
	
	PrintLoop:								;Start the loop
		mov 	al, [rdi]					;Move byte value of RID that
		push	rax							;Regrister RAX (that contain value in sub register AL)on the stack 
		call	Print64bitNumHex			;Print the HEX value
		inc		rdi							;increment counter ++
		call	PrintComma					;Print " , "
	loop	PrintLoop						;LOOP
	
	call	Printendl
	
	;##############################################################################
	
	;Array4[0]+Array5[0]-> move the sum to Array6[0]
	
	mov		rax,	0						;clear register	RAX
	mov		rbx,	0						;clear register	RBX
	mov		rsi, 	0						;clear register	RSI
	mov		rdi,	0                  		;clear register	RDI
	mov		rcx,  Array4.len				;RCX = lenght of Array4
	
	AddtionArray4and5Loop:
		mov		eax, DWORD [Array4+rsi*4]	;copy Dword Array4[0] to EAX
		mov		rbx, QWORD [Array5+rsi*8]	;copy QWord Array5[0] to RBX
		add		rax,rbx						;Add two  value Array4[RSI]+Array5[RSI] together
		mov		[Array6+rsi*8],rax          ;move value from RAX to Array6[RSI]
		inc		rsi                         ;increment index++
	loop AddtionArray4and5Loop
	call Printendl
	
	
	mov		rsi, 	0						;clear register	RSI
	mov		rcx,  Array6.len
	
	push	promptSumDandQword				;Put prompt "Contents of Array6 is: "
	call	PrintString					    ;print
	
	PrintSecondLoop:
		mov		rdi, QWORD [Array6+rsi*8]	;Travese Array6 by the loop
		push	rdi                         ;push the data to RDI register
		call	Print64bitNumHex            ;Print it
		call	PrintComma                  ;Print , 
		inc		rsi                         ;increment index
	loop	PrintSecondLoop
	call Printendl
	
	
			
				
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
		
	

	
	
				
	
;
;Setup the registers for exit and poke the kernel
;Exit: 
Exit:
	mov		rax, 60					;60 = system exit
	mov		rdi, 0					;0 = return code
	syscall							;Poke the kernel
