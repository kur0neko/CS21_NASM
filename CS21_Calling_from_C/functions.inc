;
;Include file for the functions library
;
sys_exit	equ	1h
sys_read	equ	3h
sys_write	equ	4h
stdin		equ	0h
stdout		equ	1h
stderr		equ	3h

;Print a string which is not null terminated
;Stack contents:
;	The Address of the string to print
;	The length of the string to print
;Example Usage:
;	push	stringVariable
;	push	stringVariable.len
;	call	PrintText
;
extern		PrintText

;Clears the keyboard buffer until \n or null are encountered
;Stack contents:
;	None
;Example Usage:
;	call	ClearKBuffer
;
extern		ClearKBuffer

;Print a new line to the console
;Stack Contents:
;	None
;Example Usage:
;	call	Printendl
;
extern		Printendl

;Convert and then print a 32bit decimal number
;Stack contents:
;	Value to Convert to an Ascii String
;Example Usage:
;	push DWORD [dwordvariable]
;	call	Print32bitNumDecimal
;
extern		Print32bitNumDecimal

;Convert and then print a 32bit signed decimal number
;Stack contents:
;	Value to Convert to an Ascii String
;Example Usage:
;	push DWORD [dwordvariable]
;	call	Print32bitSNumDecimal
;
extern		Print32bitSNumDecimal

;Convert and then print a 32bit binary number
;Stack contents:
;	Value to Convert to an Ascii String
;Example Usage:
;	push DWORD [dwordvariable]
;	call	Print32bitNumBinary
;
extern		Print32bitNumBinary

;Print a full 32bit binary number including leading zeros
;Stack contents:
;	Value to Convert to an Ascii String
;Example Usage:
;	push DWORD [dwordvariable]
;	call	Print32bitFullBinary
;
extern		Print32bitFullBinary

;Print a full 32-bits binary number in Floating Point format.
;Stack contents:
;	Value to Print to an Ascii String
;Example Usage:
;	push	eax
;	call	Print32bitFloatBinary
extern		Print32bitFloatBinary

;Convert and then print a 32bit hex number
;Stack contents:
;	Value to Convert to an Ascii String
;Example Usage:
;	push	DWORD [dWordVariable]
;	call	Print32bitNumHex
;
extern		Print32bitNumHex

;Print all 32bit Registers to the screen
;Stack contents:
;	None
;Example Usage:
;	call	PrintRegisters
;
extern		PrintRegisters

;Print all of the floating point registers ST0 - ST7
;Stack Contents:
;	None
;Return: 	None
;Example Usage:
;	call	PrintFloatingRegisters
extern		PrintFloatingRegisters

;Print a string with an ending 00h delimiter to the console
;Arguments:	Address of the String (Stack)
;Example Usage:
;	push	stackVariable
;	call	PrintString
extern		PrintString

;Print a string with an ending 00h delimiter to the console Right Justified to a print area
;Arguments:	Address of the String (Stack)
;			Width of the print area to print into
;Example Usage:
;	push	stackVariable
;	push	20
;	call	PrintRight
extern		PrintRight

;Print a string with an ending 00h delimiter to the console Left Justified to a print area
;Arguments:	Address of the String (Stack)
;			Width of the print area to print into
;Example Usage:
;	push	stackVariable
;	push	20
;	call	PrintLeft
extern		PrintLeft

;Print a string with an ending 00h delimiter to the console Centered to a print area
;Arguments:	Address of the String (Stack)
;			Width of the print area to print into
;Example Usage:
;	push	stackVariable
;	push	20
;	call	PrintCenter
extern		PrintCenter

;Print a space to the console
;Arguments:	None
;Example Usage:
;	call	PrintSpace
extern		PrintSpace

;Print a comma followed by a space to the console
;Arguments:	None
;Example Usage:
;	call	PrintComma
extern		PrintComma

;Print all byte values found in an array in Hex format
;Arguments:	Address of the Array (Stack)
;			Number of items in the array
;Example Usage:
;	push	arrayLabel
;	push	20
;	call	PrintByteArray
extern		PrintByteArray

;Print all byte values found in an array in Decimal format
;Arguments:	Address of the Array (Stack)
;			Number of items in the array
;Example Usage:
;	push	arrayLabel
;	push	20
;	call	PrintByteArrayDec
extern		PrintByteArrayDec

;Print all signed byte values found in an array in Decimal format
;Arguments:	Address of the Array (Stack)
;			Number of items in the array
;Example Usage:
;	push	arrayLabel
;	push	20
;	call	PrintSByteArrayDec
extern		PrintSByteArrayDec

;Print all word values found in an array in Hex format
;Arguments:	Address of the Array (Stack)
;			Number of items in the array
;Example Usage:
;	push	arrayLabel
;	push	20
;	call	PrintWordArray
extern		PrintWordArray

;Print all word values found in an array in Decimal format
;Arguments:	Address of the Array (Stack)
;			Number of items in the array
;Example Usage:
;	push	arrayLabel
;	push	20
;	call	PrintWordArrayDec
extern		PrintWordArrayDec

;Print all signed word values found in an array in Decimal format
;Arguments:	Address of the Array (Stack)
;			Number of items in the array
;Example Usage:
;	push	arrayLabel
;	push	20
;	call	PrintSWordArrayDec
extern		PrintSWordArrayDec

;Print all Double Word values found in an array in Hex format
;Arguments:	Address of the Array (Stack)
;			Number of items in the array
;Example Usage:
;	push	arrayLabel
;	push	20
;	call	PrintDWordArray
extern		PrintDWordArray

;Print all Double Word values found in an array in Decimal format
;Arguments:	Address of the Array (Stack)
;			Number of items in the array
;Example Usage:
;	push	arrayLabel
;	push	20
;	call	PrintDWordArrayDec
extern		PrintDWordArrayDec

;Print all signed Double Word values found in an array in Decimal format
;Arguments:	Address of the Array (Stack)
;			Number of items in the array
;Example Usage:
;	push	arrayLabel
;	push	20
;	call	PrintSDWordArrayDec
extern		PrintSDWordArrayDec

;Print a Double-word floating point number
;This version uses the integer extraction power of the FPU instead of moving bits
;	around to extract the exponent and left/right mantissa's making this a
;	much easier and shorter algorithm
;Stack Contents:
;	The floating point number to print
;	The number of fractional Digits to print
;Return:
;	None
;Example Usage:
;	push	[numberToPrint]
;	push	[fractionalDigits]
;	call	PrintDWFloat
extern		PrintDWFloat

;Print a Double-word floating point number in scientific notation
;This version uses the integer extraction power of the FPU instead of moving bits
;	around to extract the exponent and left/right mantissa's making this a
;	much easier and shorter algorithm
;Stack Contents:
;	The floating point number to print
;	The number of fractional Digits to print
;Return:
;	None
;Example Usage:
;	push	[numberToPrint]
;	push	[fractionalDigits]
;	call	PrintDWFloatSN
extern		PrintDWFloatSN

;Get a random number from the CPU
;Stack contents:
;	The maximum value of the random number
;	Signed = 1, Unsigned = 0
;Return Value:
;	eax = Random number value
;Example Usage:
;	push 	DWORD 200			;Will create a random number no greater than 200
;	push	DWORD 1				;1 = signed, 0 = uinsigned
;	call	GetRandomInt
;
extern		GetRandomInt

;Return, in eax, an integer entered by the user
;Arguments: none
;Example Usage:
;	call	InputInt
extern		InputInt

;Call the necessary interrupt with the necessary register values to read data from the keyboard
;Stack Contents:
;	Address of keyboard buffer
;	Size of the keyboard buffer
;Return:
;	eax will contain the number of characters the user input
;Example Usage:
;	push	readbuffer
;	push	readbuffer.len
;	call	ReadText
extern		ReadText

;Call the necessary interrupt with the necessary register values to read data from the keyboard
;Stack Contents:
;	Address of the string to print
;	Address of keyboard buffer
;	Size of the keyboard buffer
;Return:
;	eax will contain the number of characters input
;Example Usage:
;	push	inputPromptVariable
;	push	keyboardBufferVariable
;	push	keyboardBufferVariable.len  ;This is the maximum size of the buffer
;	call	ReadTextWPrompt
extern		ReadTextWPrompt

;Call the necessary interrupt with the necessary register values to read the system time Hour
;Arguments: None
;Return:  eax:  The current hour
;Example Usage:
;	call	GetCurrentHour
extern		GetCurrentHour

;Call the necessary interrupt with the necessary register values to read the system time Minute
;Arguments: None
;Return:  eax:  The current minute
;Example Usage:
;	call	GetCurrentMinute
extern		GetCurrentMinute

;Call the necessary interrupt with the necessary register values to read the system time Second
;Arguments: None
;Return:  eax:  The current second
;Example Usage:
;	call	GetCurrentSecond
extern		GetCurrentSecond

;Call the function to get the system time and then print it
;Arguments: None
;Return:  None
;Example Usage:
;	call	PrintSystemTime
extern		PrintSystemTime

;Call the function to get the CPU's Time Stamp Counter
;Arguments: None
;Return:  eax
;Example Usage:
;	call	GetTSC
extern		GetTSC

;An Internal function used to get the system time hours, minutes, seconds
;Stack Contents:
; None
;Return: None
;Example Usage
;   call GetSystemTime
extern		GetSystemTime

;Input UnSigned Int
;This function will let the user input an integer returned into the EAX register
;Arguments: None
;Return: 	eax will contain the usigned ingeter
;			Carry flag will be set if invalid integer was input
;Example Usage:
;	call	InputInt
;	Note: eax will contain the value of the unsigned integer entered
;	jnc		validIntegerInput
;	Otherwise, an invalid integer was input
extern		InputUInt

;Input Signed Int
;This function will let the user input a signed integer and put the value
;into the EAX register.
;Arguments: None
;Return: 	eax will contain the usigned ingeter
;			Carry flag will be set if invalid integer was input
;Example Usage:
;	call	InputSInt
;	Note: eax will contain the value of the signed integer entered
;	jnc		validIntegerInput
;	Otherwise, an invalid integer was input
extern		InputSInt

;Input Binary Number
;This function will let the user input a string, then it will check it to make sure it
;is a binary string.  It will then convert the ASCII string into a DWORD and return
;that value in the EAX register.
;Arguments:
;	None
;Return: 	eax will contain the numeric binary value
;			Carry flag will be set if invalid binary number was input
;Example Usage:
;	call	InputBin
;	jnc		ValidBinLabel
;	otherwise, a problem occured - print an error message
extern		InputBin

;This function will let the user input a string, then it will check it to make sure it
;is a hexidecimal string.  It will then convert the ASCII string into a DWORD and return
;that value in the EAX register.
;Arguments:
;	None
;Return: 	eax will contain the numeric hexidecimal value
;			Carry flag will be set if invalid hex number was input
;Example Usage:
;	call	InputHex
;	jnc		ValidHexLabel
;	otherwise, a problem occured - print an error message
extern		InputHex

;Input a Floating Point Number
;This function will let the user input a string, then it will check it to make sure it
;is a valid floating point number.  It will then convert the ASCII string into a EWORD
;and return that value in the EAX register.
;Stack Contents:
;	None
;Return: 	EAX and ST(0) will contain the number
;			Carry flag will be set if invalid binary number was input
;Example Usage:
;	call	InputFloat
;	jnc		ValidFloatLabel
;	otherwise, a problem occured - print an error message
extern		InputFloat

;Calculate the Average in a Double Word Array
;Arguments:	ArrayAddress (Stack)
;			Number of Items in the Array (Stack)
;Return:	eax will contain the average
;Example Usage:
;	push	arrayLabel
;	push	20
;	call	DWArrayAverage
extern		DWArrayAverage

;Calculate the Average in a Word Array
;Arguments:	ArrayAddress (Stack)
;			Number of Items in the Array (Stack)
;Return:	eax will contain the average
;Example Usage:
;	push	arrayLabel
;	push	20
;	call	WArrayAverage
extern		WArrayAverage

;Calculate the Average in a Byte Array
;Arguments:	ArrayAddress (Stack)
;			Number of Items in the Array (Stack)
;Return:	eax will contain the average
;Example Usage:
;	push	arrayLabel
;	push	20
;	call	BArrayAverage
extern		BArrayAverage

;Allocate some memory (x bytes)	and return the high address to EAX
;Stack Contents:
;	Number of BYTES to add to memory
;Return: 	EAX will contain the new high memory address
;Example Usage:
;	push	DWORD 1024			;increase memory by 1024 bytes
;	call	AllocateBytes
extern		AllocateBytes

;Free some memory (x bytes)	and return the high address to EAX
;Stack Contents:
;	Number of BYTES to remove from memory
;Return: 	EAX will contain the new high memory address
;Example Usage:
;	push	DWORD 1024			;reduce memory by 1024 bytes
;	call	FreeBytes
extern		FreeBytes

;Allocate some memory as a-word array
;Arguments:	Number of DWORDS to allocate (Stack)
;Return:	eax will contain highest address of this memory
;Example Usage:
;	push	20
;	call	AllocateWORDArray
extern		AllocateWORDArray

;Allocate some memory as a double-word array
;Arguments:	Number of DWORDS to allocate (Stack)
;Return:	eax will contain highest address of this memory
;Example Usage:
;	push	20
;	call	AllocateDWORDArray
extern		AllocateDWORDArray

;Simple xor encryption/decryption of a string using a user entered key
;Arguments:	String address to encrypt/decrypt (Stack ebp + 24)
;			Length of the string to encrypt (Stack ebp + 20)
;			string address to be used as a key (Stack ebp + 16)
;			integer value indicating the length of the key (Stack ebp + 12)
;			string address where the encrypted/decrypted data should go (Stack ebp + 8)
;Return:	Total bytes encrypted in eax
;Example Usage:
;	push	stringToEncrypt
;	push	20
;	push	keyAddress
;	push	8
;	push	targetString
;	call	EncryptString
extern		EncryptString

;Get the length of a string based on a null (00) delimeter
;Arguments: Address of the string
;Return:	Size of the string in eax
;Example Usage:
;	push	arrayLabel
;	call	StringSize
extern		StringSize

;Calculate the GCD of two numbers passed to this function
;Arguments: Integer #1 and Integer #2 in the stack
;Return:	GCD in eax
;Example Usage:
;	push	[number1]
;	push	[number2]
;	call	CalcGCD
extern		CalcGCD

;Calculate the factorial of a number passed to this function
;Arguments:	Integer number in the stack
;Return:	Factorial of x in eax
;Example Usage:
;	push	[number1]
;	call	CalcFactorial
extern		CalcFactorial

;Calculate the factorial of a number passed to this function
;Arguments:	Integer number in the stack
;Return:	Factorial of x in eax as a floating point value
;Example Usage:
;	push	[number1]
;	call	CalcFactorialFloat
extern		CalcFactorialFloat

;Set the carry flag if the floating poing number pushed onto the Stack
;is a +NAN, -NAN, +Infinity or -Infinity
;Stack Contents:
; DWORD Floating Point number (Stack)
;Return: Carry Flag Set if NAN, Clear if OK
;Example Usage
;   push  DWORD [floatingVariable]
;   call  IsNAN
extern    IsNAN

;Print the date in the format mm/dd/yyyy
;Stack Contents:
; None
;Return: None
;Example Usage
;   call PrintSystemDateEng
extern		PrintSystemDateEng

;Print the date in the format yyyy/mm/dd
;Stack Contents:
; None
;Return: None
;Example Usage
;   call PrintSystemDateEuro
extern		PrintSystemDateEuro

;Convert and then return in a byte array a64-but number in decimal format
;Stack contents:
;	Value to Convert to an Ascii String
;	Address of byte array to contain the result
;Return Value:
;	eax = Number of characters returned
;Example Usage:
;	push 	DWORD [doublewordvariable]
;	push 	stringbuffer
;	call	ToString32bitNumDecimal
;
extern		ToString32bitNumDecimal

;Convert and then return in a byte array a 64bit signed number in decimal format
;Stack contents:
;	Value to Convert to an Ascii String
;	Address of byte array to contain the result
;Return Value:
;	eax = Number of characters returned
;Example Usage:
;	push 	DWORD [doublewordvariable]
;	push 	stringbuffer
;	call	ToString32bitSNumDecimal
;
extern		ToString32bitSNumDecimal

;Get the system date in English format and return to the calling function in th array
;	provided
;Stack contents:
;	Address of byte array to contain the result
;Return Value:
;	eax = Number of characters returned
;Example Usage:
;	push 	stringbuffer
;	call	GetEngDateString
;
extern		GetEngDateString

;Get the system date in European format and return to the calling function in th array
;	provided
;Stack contents:
;	Address of byte array to contain the result
;Return Value:
;	eax = Number of characters returned
;Example Usage:
;	push 	stringbuffer
;	call	GetEuroDateString
;
extern		GetEuroDateString

;Get the system time and return to the calling function in th array
;	provided
;Stack contents:
;	Address of byte array to contain the result
;Return Value:
;	eax = Number of characters returned
;Example Usage:
;	push 	stringbuffer
;	call	GetTimeString
;
extern		GetTimeString

;Calculate the Variance from an array of numbers
;Stack contents:
;	Address of sample array of Double words
;	The number of samples to process
;Return Value:
;	eax = Calculated Variance
;Example Usage:
;	push 	sampleArray			;Address of the array of numeric samples
;	push	10					;process 10 of the numbers in the array
;	call	CalcVariance
;
extern		CalcVariance

;Calculate the Standard Deviation from an array of numbers
;Stack contents:
;	Address of sample array of Double words
;	The number of samples to process
;Return Value:
;	eax = Calculated Standard Deviation
;Example Usage:
;	push 	sampleArray			;Address of the array of numeric samples
;	push	10					;process 10 of the numbers in the array
;	call	CalcStdDev
;
extern		CalcStdDev

;Calculate the Mean from an array of numbers
;Stack contents:
;	Address of sample array of Double words
;	The number of samples to process
;Return Value:
;	eax = Calculated Mean
;Example Usage:
;	push 	sampleArray			;Address of the array of numeric samples
;	push	10					;process 10 of the numbers in the array
;	call	CalcMean
;
extern		CalcMean

;Fills an array with random double values
;Stack contents:
;	Address of array of Double words
;	The number of samples to process
;	Maximum value of the random number(s)
;	Signed = 1, Unsigned = 0
;Return Value:
;	Nothing
;Example Usage:
;	push 	sampleArray			;Address of the array of numeric samples
;	push	10					;process 10 of the numbers in the array
;	push	500					;The maximum random value should be 500
;	push	0					;Unsigned only
;	call	RandomArray
;
extern		RandomArray

