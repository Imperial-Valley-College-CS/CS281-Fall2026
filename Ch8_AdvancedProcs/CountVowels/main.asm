.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
	someStr byte "Happy Halloween",0
	ans dword 0

.code
	main proc
		
		push offset someStr
		call countVowels
		mov ans, eax				;number of vowels returned in EAX
		
		INVOKE ExitProcess, 0
	main endp

	countVowels proc
		push ebp				;save ebp
		mov ebp, esp			;make a copy of the stack pointer
		push esi				;save esi
		mov esi, [ebp+8]	;move offset of string into esi
		push ebx				;save ebx

		mov eax, 0			;zero out vowel counter
		L1:
			mov bl, [esi]		;move char from someStr into bl
			cmp bl, 0			;reached end of someStr
			je restoreRegs
			cmp bl, 97		;compare to letter "a"
			je foundVowel
			cmp bl, 101		;compare to letter "e"
			je foundVowel			
			cmp bl, 105		;compare to letter "i"
			je foundVowel
			cmp bl, 111		;compare to letter "o"
			je foundVowel
			cmp bl, 117		;compare to letter "u"
			je foundVowel
		returnToL1:
			inc esi				;point to next character in someStr
			jmp L1

		foundVowel:
			inc eax
			jmp returnToL1
		
		restoreRegs:
			pop ebx
			pop esi
			pop ebp		
		ret 4
	countVowels endp

END main