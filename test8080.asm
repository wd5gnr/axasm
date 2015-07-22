	ORG 0
top:	LDA memloc
	MOV B,A
	MVI A,1
	ADD B
	STA memloc
	NOP
	NOP
	NOP
	NOP
	JMP top
	REORG 0x80
memloc:	DB 0
	END
	