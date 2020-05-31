
	global 		addTwo			;work!
	global 		addArray       	;Work!
	global		pow2			;#work
	global		addTwoArray		
	global		revArray
	global		multiplyTwo		;#
	
	
;#####################################################################################

addTwo:
	nop
	
	mov	eax,[esp+4]			;Copy first paremeter to eax
	mov	edx,[esp+8]			;Copy second parameter to edx
	add	eax,edx				;Add first and second parameters
	
	ret						;Return will, by default, be in the eax register
	
;######################################################################################

addArray: 
	nop
	mov		esi,[esp+4]		;Copy first parameter to esi: Pointer to array
	mov		ecx,[esp+8]		;Copy second paraneter to ecx: number of items in the array
    mov 	edi,0			;set counter   
    mov 	eax,0			;Set total to zero
    
    Loop1:
		mov edx,[esi+edi]	;Copy Value at array address+counter to edx
		add eax, edx		;Add the array value in edx to eax
		add edi, 4          ;Increment ebx by a double word size (4 bytes)		
	Loop  Loop1				;ecx contains the counter -decrement it and loop
	ret                     ;Return will, by defaultm, be in the eax register
	
;######################################################################################

pow2:
	nop						
	mov	eax,[esp+4]			;Copy first parameter to esi
	mul	eax					;Mul eax, eax
	
	ret						;return
	
;######################################################################################

multiplyTwo:
	nop           
	mov eax,[esp+4]			;Copy first number into eax and push it in the stack
	mov edx,[esp+8]			;Copy second number into eax and push it in the stack
	mul	edx					;Multiply with eax,edx
	
	ret						
;######################################################################################

revArray:
    
    
    mov		esi,[esp+4] 			; hold address of array1
    
    mov		edx,[esp+8] 			; hold address of empty array2  //hold the address
     
    mov		ecx,[esp+12]			; Array size
    
    mov		edi,0          			; clear register edi
		
    mov		eax,0					; counter
    
    ReverseArrLoop:
    
    mov edi,[esi+eax]				; move the first element of Array[0] put in edi
    
    mov [edx+(ecx-1)*4],edi         ; move the array first element from edi put in array2[last element]
    
	add eax,4	                    ;increament the counter
	
	loop ReverseArrLoop
	
	ret								
   
    
		
;######################################################################################

addTwoArray:

	;there are four arguments array1,array2,array3,size
	push 	ebx
	mov		esi, 	[esp+4]				;2 array1
	mov		ebx,	[esp+8]             ;3 array2
	mov		edx,	[esp+12]			;4 array3
	mov		ecx,    [esp+16]			;5 size
	mov		edi,	0					;counter
	mov		eax,	0					;scracth memory	
	
	AddtwoArrLoop:
	mov		eax,[esi+edi*4]				;move array1[counter] to empty register edi
	add		eax,[ebx+edi*4]				;add array2[counter] with edi
	mov		[edx+edi*4],eax				;mov result data to array3[index]
	inc		edi						;increment counter
	loop AddtwoArrLoop
	pop		ebx
	
	ret
	
;######################################################################################
	
	
	
 

	

	


