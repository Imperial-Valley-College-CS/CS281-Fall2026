.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
	strOne byte "HaRBOR",0
	strTwo byte "halo",0
	ans dword 0

.code
	main proc

		mov esi, offset strOne
		call toLowerCase
		
		INVOKE ExitProcess, 0
	main endp

	compareToIgnoreCase proc
		ret
	compareToIgnoreCase endp

	;Summary: converts alpha-characters in String from upper case to lower case (in-place)
	;Receives: offset of the String (ESI)
	;Returns: nothing
	toLowerCase proc
			
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
		ret
	toLowerCase endp

END main