TITLE Pascal Triangle Generator     (Proj4_jantzd.asm)

; Author: David Jantz
; Last Modified: 11/4/2024
; OSU email address: jantzd@oregonstate.edu
; Course number/section:   CS271
; Project Number: 4                Due Date: 11/17/2024
; Description: This program generates a Pascal triangle for a desired number of 
;				rows entered by the user up to 13 rows.

INCLUDE Irvine32.inc

MIN_ROWS = 1
MAX_ROWS = 20

.data

	introduction1		BYTE	"Pascal's Triangle Generator -- created by David Jantz",13,10,0
	introduction2		BYTE	"This program will generate a Pascal's Triangle at the row depth you specify!",13,10,0
	extraCredit2		BYTE	"**EC: This program prints up to 20 rows.",13,10,0
	instructions		BYTE	"Enter an integer from 1 to 20, inclusive. Then sit back and watch the magic unfold.", 13,10,0
	errorMessage		BYTE	"Dude. Pick an integer from 1 to 20. This is like kindergarten level difficulty.",13,10,0
	goodbyeMessage		BYTE	"Thanks for playing! Have a fantabulous day.",13,10,0
	userInput			SDWORD	?
	isValidInput		BYTE	0	; starting assumption is that user input is not valid, flipped to 1 if it is valid
	space				Byte	" ",0

.code
main PROC
	CALL	introduction
	CALL	getUserInput
	CALL	printPascalTriangle
	CALL	farewell

	Invoke ExitProcess,0			; exit to operating system
main ENDP

; ------------------------------------------------------------
; Name: introduction
; Purpose: To introduce the program and the programmer.
; Preconditions: None
; Postconditions: None
; Receives: None
; Returns: None
; ------------------------------------------------------------
introduction PROC
	MOV		EDX, OFFSET introduction1
	CALL	WriteString
	MOV		EDX, OFFSET introduction2
	CALL	WriteString
	MOV		EDX, OFFSET extraCredit2
	CALL	WriteString
	CALL	CrLf
	RET
introduction ENDP

; ------------------------------------------------------------
; Name: displayInstructions
; Purpose: To inform the user how to play the game.
; Preconditions: None
; Postconditions: None
; Receives: None
; Returns: None
; ------------------------------------------------------------
displayInstructions PROC
	MOV		EDX, OFFSET instructions
	CALL	WriteString
	RET
displayInstructions ENDP

; ------------------------------------------------------------
; Name: getUserInput
; Purpose: To get a valid integer input from the user, looping as necessary to achieve this.
; Preconditions: None
; Postconditions: None
; Receives: None
; Returns: userInput with an integer validated to be in the correct range.
; ------------------------------------------------------------
getUserInput PROC
	CALL	displayInstructions
	_InputLoop:
		CALL	ReadInt
		MOV		userInput, EAX
		CALL	validateInput
		CMP		isValidInput, 1
		JE		_EndInput
		MOV		EDX, OFFSET errorMessage	; display error message for bad input
		CALL	WriteString
		JMP		_InputLoop
	_EndInput:
		RET
getUserInput ENDP

; ------------------------------------------------------------
; Name: validateInput
; Purpose: To determine if the user input is within the valid range [1,13]
; Preconditions: None
; Postconditions: None
; Receives: userInput stored in memory as a signed integer 
; Returns: 0 or 1 value stored in isValidInput (0 for invalid, 1 for valid)
; ------------------------------------------------------------
validateInput PROC
	PUSH	EAX
	CMP		userInput, MIN_ROWS				; compare to zero
	JL		_InvalidInput					; if less than zero, set isValid to zero, jump to end of this procedure and return
	CMP		userInput, MAX_ROWS				; compare to 13
	JG		_InvalidInput					; if greater than 13, set isValid to zero, jump to end of this procedure and return
	MOV		isValidInput, 1 				; set isvalid to 1, it has to be in valid range
	JMP		_End
	_InvalidInput:
		MOV		isValidInput, 0
	_End:
		POP EAX
		RET
validateInput ENDP

; ------------------------------------------------------------
; Name: printPascalTriangle
; Purpose: To print the entire pascal triangle to the depth specified by the user.
; Preconditions: user input must be collected and validated.
; Postconditions: None
; Receives: userInput
; Returns: None (output is displayed to screen)
; ------------------------------------------------------------
printPascalTriangle PROC
	CALL	CrLf
	MOV		ECX, userInput
	_PrintRowsLoop:
		CALL	printPascalRow
		LOOP	_printRowsLoop
	RET
printPascalTriangle ENDP

; ------------------------------------------------------------
; Name: printPascalRow
; Purpose: to display one row of pascal triangle to the console.
; Preconditions: must be called within the context of a larger for loop
;					that is decrementing ECX. That tells us which
;					row we are currently on and thus how many numbers
;					to calculate and print. userInput must also be available
;					to perform subtraction with ECX.
; Postconditions: None
; Receives: userInput, ECX
; Returns: None (output displayed to console)
; ------------------------------------------------------------
printPascalRow PROC
	PUSH	ECX								; preserve ECX value for outer loop to continue
	MOV		EAX, userInput
	SUB		EAX, ECX						; subtract outer loop value and userinput, then add one to get row number
	INC		EAX
	MOV		ECX, EAX						; EAX and ECX both now hold the number of pascal values to calculate (the row number)
	MOV		EBX, EAX
	DEC		EBX								; EBX holds "n" as an input parameter for nChooseK (the row number minus 1)
	SUB		EAX, ECX						; EAX used as input parameter "k". To calculate, subtracted ECX from the row number (still held in EAX)
	_printValuesLoop:
		CALL	nChooseK
		MOV		EDX, OFFSET space
		CALL	WriteString
		INC		EAX							; increment k in preparation for next loop
		LOOP	_printValuesLoop
	CALL	CrLf
	POP		ECX
	RET
printPascalRow ENDP

; ------------------------------------------------------------
; Name: nChooseK
; Purpose: To calculate the value at a given location in a Pascal triangle.
; Preconditions: None
; Postconditions: None
; Receives: EBX holds the value of "n" and EAX holds the value of "k"
;				according to the common parlance of "n choose k"
; Returns: None (displays value to console inside procedure)
; ------------------------------------------------------------
nChooseK PROC
	PUSH	EAX
	PUSH	EBX
	PUSH	ECX
	; --------------------------------------------------------
	; multiplicative formula: chop up the factorial into individual fractions. Example: 10 choose 4:
	;	1 * 10 / 1 = 10
	;	10 * 9 / 2 = 45
	;	45 * 8 / 3 = 120
	;	120 * 7 / 4 = 210
	; --------------------------------------------------------
	MOV		ESI, EAX						; move value of k from EAX into ESI so EAX can be the multiplier
	MOV		EAX, 1							; multiplier EAX gets value of 1 to start
	MOV		ECX, 1							; ECX gets value of 1 (will be divisor)
	; edge case: When k == 0, output is 1, so just skip the loop
	CMP		ESI, 0
	JE		_KIsZeroEdgeCase
	_NChooseKLoop:
		MUL		EBX							; multiplier (EAX) *= n (now stored in EDX:EAX)
		DIV		ECX							; multiplier /= divisor (now stored in EAX)
		DEC		EBX							; decrement n
		INC		ECX							; increment divisor
		CMP		ECX, ESI					; if divisor <= k, restart loop
		JLE		_NChooseKLoop
	_KIsZeroEdgeCase:

	CALL	WriteDec						; not specific to zero edge case, so it is not indented
	POP		ECX
	POP		EBX
	POP		EAX
	RET
nChooseK ENDP

; ------------------------------------------------------------
; Name: farewell
; Purpose: Say goodbye to user
; Preconditions: Gameplay has finished.
; Postconditions: None
; Receives: None
; Returns: None
; ------------------------------------------------------------
farewell PROC
	CALL	CrLf
	MOV		EDX, OFFSET goodbyeMessage
	CALL	WriteString
	RET
farewell ENDP

END main