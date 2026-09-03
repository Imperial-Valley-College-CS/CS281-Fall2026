.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
	str1 byte "stellar",0
	lenStr = $-str1
	str2 byte lenStr dup(0)

.code
	main proc
		mov esi, offset str1
		mov edi, offset str2
		add esi, lenStr-1
		mov ecx, lenStr

		L1:
			mov al, [esi]
			mov [edi], al
			dec esi
			inc edi
			loop L1
		
		INVOKE ExitProcess, 0
	main endp
END main