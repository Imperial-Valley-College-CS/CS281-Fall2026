.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
	arr1 word 1011h, 2022h, 3033h, 4044h
	lenArr = ($-arr1)/2
	arr2 dword lenArr dup(0)
	arr3 byte lenArr dup(0)

.code
	main proc
		mov ecx, lenArr
		mov esi, offset arr1
		mov edi, offset arr2

		L1:
			movzx eax, word ptr [esi]
			mov [edi], eax
			add esi, type arr1
			add edi, type arr2
			loop L1

		
		INVOKE ExitProcess, 0
	main endp
END main