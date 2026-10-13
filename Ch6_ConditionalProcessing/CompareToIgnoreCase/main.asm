.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
	strTwo byte "thundercats",0
	strOne byte "Thunder",0
	ans dword 0

.code
	main proc

		mov esi, offset strOne
		mov edi, offset strTwo
		call compareToIgnoreCase
		mov ans, eax	
				
		INVOKE ExitProcess, 0
	main endp

	;Summary: compares two strings by subtracting the first pair of distinct, correspoding, characters
	;				when one string is a substring of the other, compareTo returns the difference in their lengths
	;				when subtracting, always subtract second string (EDI) from first string (ESI)
	;Receives: offset of stringOne (ESI), offset of stringTwo (EDI)
	;Returns: integer from subtraction in EAX
	compareToIgnoreCase proc
		
		push esi				;save offset of strOne
		push edi				;save offset of strTwo
		mov ebx, 0			;ebx will have chars to substract from each other
		mov eax, 0			;return value will be in eax

		L1:
			cmp byte ptr [esi], 0
			je reachedEndOfString
			cmp byte ptr [edi], 0
			je reachedEndOfString
			movzx eax, byte ptr [esi]			;move 1 byte from memory (ESI) into eax
			call makeLower
			mov bh, al									;char from strOne in bh
			movzx eax, byte ptr [edi]			;move 1 byte from memory (EDI) into eax
			call makeLower
			mov bl, al									;char from strTwo in bl
			cmp bh, bl
			jne foundDistinctChars
			inc esi
			inc edi
			jmp L1

		foundDistinctChars:
			sub bh, bl					;subtract char from strOne minus char from strTwo
			movzx eax, bh			;move return value to return register
			pop edi						;clear stack before returning
			pop esi						;clear stack before returning
			jmp done

		reachedEndOfString:
			pop edi						
			mov esi, edi
			call strLen						;get length of strTwo
			mov ebx, eax					;move length of strTwo into ebx
			pop esi
			call strLen						;get length of strOne
			sub eax, ebx						;subtract length of strOne minus length of StrTwo

		done:	
			ret
	compareToIgnoreCase endp

	;Summary: calculates and returns the length of a string
	;Receives: offset of the String (ESI)
	;Returns: length of String (EAX)
	strLen proc
		mov eax, 0
		push esi				;save ESI by pushing onto stack
		L1:
			cmp byte ptr [esi], 0
			je done
			inc esi
			inc eax				;increase counter (length of string)
			jmp L1
		done:
			pop esi				;restore ESI before returning
			ret
	strLen endp

	;Summary: converts single alpha-character to lowercase if necessary and returns it
	;Receives: character (EAX)
	;Returns: character (EAX)
	makeLower proc
		cmp al, 41h			;compare char to 'A'
		jge checkLessThanZ
		jmp done

		checkLessThanZ:
			cmp al, 5ah			;compare char to 'Z'
			jle changeCase
			jmp done

		changeCase:
			add al, 20h
		done:
			ret
	makeLower endp

END main