.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
	arr word 10ah, 20bh, 30ch, 40dh
	lenArr = ($-arr)/2
	newArr word lenArr dup(?)
	numShifts = 2

.code
	main proc
		mov ecx, lenArr				;used for looping (number of iterations)
		mov esi, offset arr			;esi points to first element in arr
		mov edi, offset newArr	;edi points to first element in newArr
		dec ecx							;loop one less time
		add edi, type newArr		;move edi to point to second element in newArr

		L1:
			mov ax, [esi]				;grabs two bytes at address pointed to by esi
			mov [edi], ax				;places two bytes at address pointed to by edi
			add esi, type arr		;adds two bytes to address that esi points to
			add edi, type newArr	;adds two bytes to address that edi points to
			loop L1

		mov edi, offset newArr		;reset edi to point to first element in newArr
		mov ax, [esi]							;move last element in arr to AX
		mov [edi], ax							;move first element into newArr through AX
		
		INVOKE ExitProcess, 0
	main endp
END main