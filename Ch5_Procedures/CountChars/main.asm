.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
	vid byte "God of War",0
	lenVid = $-vid
	let byte "o"

.code
	main proc
		mov esi, offset vid
		movzx ebx, let
		call countChars

		INVOKE ExitProcess, 0
	main endp

	;countChars counts the number of occurrences of a character in a String
	;RECEIVES: offset of the String (ESI), character to search for (EBX)
	;RETURNS: number of occurrences of character in String (EAX)
	countChars proc
		
		mov eax, 0		;counter for number of occurrences

		L1:
			mov dl, [esi]
			cmp dl, 0
			je reachedEndOfString
			cmp dl, bl
			je foundLetter
		returnToL1:
			inc esi
			jmp L1

		foundLetter:
			inc eax
			jmp returnToL1

		reachedEndOfString:
		ret
	countChars endp
END main