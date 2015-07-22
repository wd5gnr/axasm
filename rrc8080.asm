	ORG 0
top:	MVI A,0200
;nxt:	RRC
nxt:	RLC
	JMP nxt
	END