.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
	someNum word -24
	bigNum word 65512
	myName byte "Octavio",0
	grades dword 11111111h, 22222222h
	sumVal dword 0
	firstNumber =	5		;this is a symbolic constant (doesn't use memory)

.code
	main proc
		
		mov eax, firstNumber
		mov ebx, 6
		add eax, ebx
		mov sumVal, eax

		INVOKE ExitProcess, 0
	main endp
END main