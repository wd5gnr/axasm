	;;  assume default stack is ok
	ORG 0
	CALL splash
top:	
	LDRIQ '?', FACC
	CALL uartsend
	LDRIQ ' ', FACC		; note that call clobbers FIMM
	CALL uartsend
	CALL uartrx
	MOV FACC,FIO_LED
	CALL uartsend
	MOV FACC,FIO_DISP
	MOV FACC,FIO_UART
	JMP top

	
crlf:
	PUSH	FACC
	LDRIQ	13,FACC
	CALL	uartsend
	LDRIQ	10,FACC
	CALL	uartsend
	POP	FACC
	RET


uartsend:
	PUSH	FACC
	CALL	uarttwait
	POP	FACC
	MOV	FACC, FIO_UART
	RET


uarttwait:
	MOV 	FIO_UART_TBE,FACC
	MOVP	FCON_neg1,FPC_ADD
	RET
	
uartrx:
	MOV	FIO_UART_DR,FACC
	MOVP	FCON_neg1,FPC_ADD
	MOV	FIO_UART,FACC
	RET



splash:	LDRIQ	0x20,FLOOP_IEND
	MOV	FCON_0,FLOOP_I
	MOV	FCON_1,FLOOP_IINC
	LDRI	0x01000001, FACC
	MOV	FIMMV,FACC2
	LDRIQ	splash0,FLOOP_IADD		;assume it will fit in a small constant

splash0:
	MOV	FACC,FIO_LED
	CALL	hexout8
	CALL	crlf
	MOV	FCON_1,FACC_SHL
	MOVC	FACC2,FACC
	MOV	FCON_ff0000,FIO_DELAY
	MOV	FIO_DELAY,FZERO
	MOV	FLOOP_IADD,FPC
	RET
	

hexout8:
	PUSH	FACC
	MOV	FBYTE_W1,FACC
	CALL	hexout4
	POP	FACC
	;; fall into hexout4
hexout4:
	PUSH	FACC
	MOV	FBYTE_1,FACC
	CALL	hexout2
	POP	FACC
	;; fall into hexout2

hexout2:
	PUSH	FACC
	MOV	FCON_4,FACC_SHR
	CALL	hexout1
	POP	FACC
	;; fall into hexout1

hexout1:
	PUSH	FACC
	PUSH	FACC2
	MOV	FCON_f,FACC_AND
	LDRIQ	'0',FACC2
	MOV	FACC,FACC2_ADD  ; 0 to 9 is now good, a-f needs +7
	MOV	FCON_a,FACC_SUB
	LDIQ	7
	MOVP	FIMMV,FACC2_ADD
	CALL	uarttwait
	MOV	FACC2,FIO_UART
	POP	FACC2
	POP	FACC
	RET
	
	
	

	END
	