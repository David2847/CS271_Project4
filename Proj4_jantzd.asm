TITLE Pascal Triangle Generator     (Proj4_jantzd.asm)

; Author: David Jantz
; Last Modified: 11/4/2024
; OSU email address: jantzd@oregonstate.edu
; Course number/section:   CS271
; Project Number: 4                Due Date: 11/17/2024
; Description: This program generates a Pascal triangle for a desired number of 
;				rows entered by the user up to 13 rows.

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

	introduction1		BYTE	"Pascal's Triangle Generator -- created by David Jantz",13,10,0
	introduction2		BYTE	"This program will generate a Pascal's Triangle at the row depth you specify!",13,10,0
	instructions		BYTE	"Enter an integer from 1 to 13, inclusive. Then sit back and watch the magic unfold.", 13,10,0
	goodbyeMessage		BYTE	"Thanks for playing! Have a fantabulous day.",13,10,0


.code
main PROC
	CALL	introduction
	CALL	displayInstructions
	CALL	getUserInput ; todo: sub-procedure -- validate user input with while loop
	CALL	printPascalTriangle ; nested procedures needed here!!
	CALL	farewell

	Invoke ExitProcess,0	; exit to operating system
main ENDP

introduction PROC
	MOV		EDX, OFFSET introduction1
	CALL	WriteString
	MOV		EDX, OFFSET introduction2
	CALL	WriteString
	CALL	CrLf
	RET
introduction ENDP

displayInstructions PROC
	MOV		EDX, OFFSET instructions
	CALL	WriteString
	RET
displayInstructions ENDP

getUserInput PROC
	; call readint
	; move that value into a variable
	; data validation -- check if value is in correct range. use sub-procedure???
	; loop if needed
	RET
getUserInput ENDP

printPascalTriangle PROC
	RET
printPascalTriangle ENDP

farewell PROC
	CALL	CrLf
	MOV		EDX, OFFSET goodbyeMessage
	CALL	WriteString
	RET
farewell ENDP


END main
