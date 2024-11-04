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
introduction ENDP

displayInstructions PROC
displayInstructions ENDP

getUserInput PROC
getUserInput ENDP

printPascalTriangle PROC
printPascalTriangle ENDP

farewell PROC
farewell ENDP


END main
