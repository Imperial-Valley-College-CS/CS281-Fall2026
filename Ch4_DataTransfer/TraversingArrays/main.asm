.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
	hero byte "spiderman",0
	lenHero = $-hero
	cpHero byte lenHero dup(?)			;an array of 10 byte elements uninitialized

.code
	main proc
		mov ecx, lenHero			;10 loops
		mov esi, offset hero		;move address of first character in hero into esi
		mov edi, offset cpHero	;move address of copy of hero into edi

		L1:
			mov al, [esi]
			mov [edi], al
			inc esi
			inc edi
			loop L1
		
		INVOKE ExitProcess, 0
	main endp
END main