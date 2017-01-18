;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Vars and Constants
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
[BITS 16] ; 16-bits architecture
[ORG 0x7C00] ; Where the code will be in memory after it's loaded


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Instructions and Loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MOV SI, HelloString ; Send the string to SI
CALL PrintString ; Call print function
JMP $ ; Infinite Loop


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PrintCharacter: ; Function Name
	
	; Assume that ASCII value is in register AL
	MOV AH, 0x0E ; Tell BIOS that we need to print one charater on screen.
	MOV BH, 0x00 ; Page number
	MOV BL, 0x07 ; Text attribute 0x07 is lightgrey font on black background

	INT 0x10 ; Call video interrupt
	RET	; Return

PrintString: ; Function Name

	; Assume that string starting pointer is in register SI
	next_character:	; Function to fetch next character from string
		MOV AL, [SI] ; Get a byte from string and store in AL register
		INC SI ; Increment SI pointer
		OR AL, AL ; Check if value in AL is zero (end of string)
		JZ exit_function ; If end then return
		CALL PrintCharacter ; Else print the character which is in AL register
		JMP next_character	; Fetch next character from string
	exit_function: ; End next_character
	RET ; Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
HelloString db 'Hello LoS 16-bits', 0 ; HelloWorld string ending with 0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Filling the boot sector
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TIMES 510 - ($ - $$) db 0 ; Fill the rest of sector with 0
DW 0xAA55 ; Boot Signature at the end of the loader