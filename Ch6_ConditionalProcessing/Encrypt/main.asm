.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
	message byte "big bang",0
	lenMess = ($-message)-1
	key byte 12h, 34h, 56h, 78h, 9Ah, 0ABh, 0BCh
	lenKey = ($-key)
	encrypted byte lenMess DUP(0), 0
	decrypted byte lenMess DUP(0), 0

.code
	main proc
		;give encrypt three things
		mov esi, offset message
		mov edi, offset key
		mov ecx, lenKey
		mov edx, offset encrypted
		call encrypt
		
		INVOKE ExitProcess, 0
	main endp

	;Receives: string to encrypt (ESI), offset of key (EDI), length of key (ECX), offset of encrypted (EDX)
	encrypt proc
		
		push edi					;save key offset
		push ecx					;save length of key array

		L1:
			mov ah, [esi]			;move byte from message into ah
			cmp ah, 0				;check to see if you've reached null
			je done
			mov al, [edi]			;move key into al
			xor ah, al				;encrypt with xor
			mov [edx], ah		;move encrypted byte back to memory
			dec ecx				;to keep track of our keys
			inc esi					;point to next byte in message
			inc edi					;point to next key
			inc edx					;point to next byte in encrypted
			jecxz resetKey		;reset key if last key has been reached
			jmp L1

		resetKey:
			pop ecx					;reset length of key
			pop edi					;reset key offset
			push edi				;save key offset again
			push ecx				;save length of key again
			jmp L1

		done:
			pop ecx					;clear stack before return
			pop edi					;clear stack before return
			ret
	encrypt endp
END main