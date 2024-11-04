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
MAX_ROWS = 13

.data

	introduction1		BYTE	"Pascal's Triangle Generator -- created by David Jantz",13,10,0
	introduction2		BYTE	"This program will generate a Pascal's Triangle at the row depth you specify!",13,10,0
	instructions		BYTE	"Enter an integer from 1 to 13, inclusive. Then sit back and watch the magic unfold.", 13,10,0
	goodbyeMessage		BYTE	"Thanks for playing! Have a fantabulous day.",13,10,0
	userInput			SDWORD	?
	isValidInput		BYTE	0	; starting assumption is that user input is not valid, flipped to 1 if it is valid


.code
main PROC
	CALL	introduction
	CALL	getUserInput			; todo: sub-procedure -- validate user input with while loop
	CALL	printPascalTriangle		; nested procedures needed here!!
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
	_InputLoop:
		CALL	displayInstructions
		CALL	ReadInt
		MOV		userInput, EAX
		CALL	validateInput
		CMP		isValidInput, 1
		JNE		_InputLoop
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
	CMP		userInput, MIN_ROWS		; compare to zero
	JL		_InvalidInput			; if less than zero, set isValid to zero, jump to end of this procedure and return
	CMP		userInput, MAX_ROWS		; compare to 13
	JG		_InvalidInput			; if greater than 13, set isValid to zero, jump to end of this procedure and return
	MOV		isValidInput, 1 		; set isvalid to 1, it has to be in valid range
	JMP		_End
	_InvalidInput:
		MOV		isValidInput, 0
	_End:
		POP EAX
		RET
validateInput ENDP

; ------------------------------------------------------------
; Name: 
; Purpose: 
; Preconditions: 
; Postconditions: 
; Receives: 
; Returns: 
; ------------------------------------------------------------
printPascalTriangle PROC
	RET
printPascalTriangle ENDP

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
