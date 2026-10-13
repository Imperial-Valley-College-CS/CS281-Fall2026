.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

.data
	num1 word 5
	num2 word 12
	ans dword 0
.code
	main proc
		movzx eax, num1
		movzx ebx, num2
		call shiftMultiply
		mov ans, edx					;product of two numbers returned in edx
		
		INVOKE ExitProcess, 0
	main endp

	;Summary: multiplies two integers and returns their product
	;Receives: integer one (EAX), integer two (EBX)
	;Returns: product of two nums (EDX)
	shiftMultiply proc
		mov edx, 0

		L1:
			cmp eax, 0
			je done
			shr eax, 1				;reduce num1 by halving it
			jc addMultiples	;jump if carry flag is set
		returnL1:
			shl ebx, 1				;double num2
			jmp L1

		addMultiples:
			add edx, ebx		;add multiple of num2 to edx
			jmp returnL1

		done:
		ret
	shiftMultiply endp
END main