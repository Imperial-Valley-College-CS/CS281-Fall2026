.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data

.code
	main proc
		
		INVOKE ExitProcess, 0
	main endp
END main