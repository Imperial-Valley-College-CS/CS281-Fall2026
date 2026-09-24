.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
	strOne byte "HaRBOR",0
	strTwo byte "haLo",0
	ans dword 0

.code
	main proc

		mov esi, offset strOne
		mov edi, offset strTwo
		call compareToIgnoreCase
		;mov ans, eax	
				
		INVOKE ExitProcess, 0
	main endp

	;Summary: compares two strings by subtracting the first pair of distinct, correspoding, characters
	;				when one string is a substring of the other, compareTo returns the difference in their lengths
	;				when subtracting, always subtract second string (EDI) from first string (ESI)
	;Receives: offset of stringOne (ESI), offset of stringTwo (EDI)
	;Returns: integer from subtraction in EAX
	compareToIgnoreCase proc
		call toLowerCase			;strOne is in ESI (strOne will be made lowercase)
		push esi						;save offset of strOne in stack
		mov esi, edi					;offset of strTwo is in ESI
		call toLowerCase			;make strTwo all lowercase
		pop esi							;restore ESI 

		ret
	compareToIgnoreCase endp

	;Summary: converts alpha-characters in String from upper case to lower case (in-place)
	;Receives: offset of the String (ESI)
	;Returns: nothing
	toLowerCase proc
		push eax				;save the data in EAX by pushing it onto the stack
		push esi				;save the datae in ESI by pushing it onto the stack		
		startTraversing:
			mov al, [esi]		;move next character in String int AL
			cmp al, 0			;check to see if you reached null
			je done
			cmp al, 65			;65 decimal is capital A
			jge checkLessThanZ
		reenterLoop:
			inc esi				;point to next characters in string
			jmp startTraversing

		checkLessThanZ:
			cmp al, 90			;90 decimal is capital Z
			jle makeLowerCase
			jmp reenterLoop

		makeLowerCase:
			add al, 32			;makes character lowecase
			mov [esi], al		;moves lowercase character back into memory
			jmp reenterLoop

		done:
			pop esi				;restores value in ESI
			pop eax				;restores value in EAX
			ret
	toLowerCase endp

END main