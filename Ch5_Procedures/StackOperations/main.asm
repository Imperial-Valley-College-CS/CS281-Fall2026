.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
	favGame byte "fortnite",0
	lenGame = $-favGame

.code
	main proc

		mov esi, offset favGame		;address to first byte in favGame
		mov ecx, lenGame					;number of bytes in favGame
		call reverseString			

		INVOKE ExitProcess, 0
	main endp

	reverseString proc
		mov ebx, esi
		mov edx, ecx

		L1:
			movzx ax, byte ptr [esi]
			push ax
			inc esi
			loop L1

		mov esi, ebx
		mov ecx, edx

		L2:
			pop ax
			mov [esi], al
			inc esi
			loop L2
		ret
	reverseString endp
END main