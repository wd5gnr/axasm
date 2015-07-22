	ORG 0


##define TTYREADY 0x10
##define TTY 0x11
	
cold:	MVI	A,'?'
	OUT	TTY
	MVI	A,' '
	OUT	TTY
	CALL getachar
	OUT	TTY
	MVI	A,13
	OUT	TTY
	MVI	A,10
	OUT	TTY
	JMP	cold


getachar:
	IN	TTYREADY
	RRC
	JNC	getachar
	IN	TTY
	RET
	END